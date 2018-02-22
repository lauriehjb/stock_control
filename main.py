from flask import Flask, render_template, flash, request, redirect, url_for
from flask_bootstrap import Bootstrap
from flask_login import UserMixin, LoginManager, login_required, login_user, logout_user, current_user
import time

app = Flask(__name__)
bootstrap = Bootstrap(app)
app.config['SECRET_KEY'] = 'hello RobbiJiu'
login_manager = LoginManager()
login_manager.init_app(app)


# 构建登陆逻辑
class User(UserMixin):
    pass


@login_manager.user_loader
def user_loader(username):
    from toDB import get_user_list
    user_list = get_user_list()
    if username not in user_list:
        return None
    user = User()
    user.id = username
    return user


@login_manager.request_loader
def request_loader(request):
    from hashlib import md5
    from toDB import get_user_list, get_user_passwd
    user_list = get_user_list()
    username = request.form.get('loginname')
    if username not in user_list:
        return None
    user = User()
    user.id = username
    user.is_authenticated = md5(request.form['password'].encode()).hexdigest() == get_user_passwd(username)
    return user


@login_manager.unauthorized_handler
def unauthorized_handler():
    print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + '未登录错误访问，跳转到登陆界面')
    flash('未登录，请登录后操作')
    return redirect(url_for('login'))


@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('您已安全退出')
    return redirect(url_for('login'))


# 登录界面
@app.route('/login', methods=['GET', 'POST'])
def login():
    from form import loginForm
    from toDB import get_user_list, get_user_passwd
    from hashlib import md5
    form = loginForm()
    if form.validate_on_submit():
        phone = form.phone.data
        user_list = get_user_list()
        if phone not in user_list:
            flash('用户不存在')
            print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + '用户' + phone + '尝试登陆：错误的用户名')
        else:
            passwd = md5(form.password.data.encode()).hexdigest()
            ck_passwd = get_user_passwd(phone)
            if passwd == ck_passwd:
                auto_login = form.remember_me.data
                user = User()
                user.id = phone
                login_user(user, auto_login)
                print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + '用户' + phone + '登陆成功')
                return redirect(url_for('index'))
            print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + '用户' + phone + '尝试登陆：密码错误')
            flash('密码错误')
    return render_template('login.html', Form=form)


# 根目录
@app.route('/')
def root():
    print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + 'root节点，跳转到login')
    return redirect(url_for('login'))


# 主页
@app.route('/index')
@login_required
def index():
    from toDB import getProdStock, getFundingBalance
    prodStock = getProdStock()
    fundingPoolBalance = getFundingBalance()
    return render_template('index.html', prodStock=prodStock, fundingPoolBalance=fundingPoolBalance)


# 商品入库
@app.route('/stock_trade', methods=['GET', 'POST'])
@login_required
def stock_trade():
    from form import stock_trade_fields
    from toDB import getProd, getFundingPool, prodInStock
    form = stock_trade_fields()
    form.prod_id.choices = getProd()
    form.funding_pool_id.choices = getFundingPool()
    if form.validate_on_submit():
        print('入库订单提交到后端')
        userId = current_user.get_id()
        print('获取到登录用户为%s' % userId)
        try:
            t = prodInStock(form.trade_name.data, form.prod_id.data, form.num.data, form.unit_price.data,
                            form.remark.data,
                            form.funding_pool_id.data, userId)
            print(t)
        except BaseException:
            print('入库执行失败，请联系霍佳宾 18647106104处理')
            flash('入库执行失败')
        flash_data = '入库成功，本次增加库存%s瓶，进货成本增加%s元。' \
                     % (form.num.data, int(form.num.data) * float(form.unit_price.data))
        flash(flash_data)
        form.num.data = ''
        form.unit_price.data = ''
    return render_template('stock_trade.html', Form=form)


# 商品销售
@app.route('/sale_trade', methods=['GET', 'POST'])
@login_required
def sale_trade():
    from form import sale_trade_fields
    from toDB import getFundingPool, getProdSale, getProdNum, prodSaleStock
    form = sale_trade_fields()
    form.prod_id.choices = getProdSale()
    form.funding_pool_id.choices = getFundingPool()
    if form.validate_on_submit():
        print('销售订单提交到后端')
        userId = current_user.get_id()
        print('获取到登录用户为%s' % userId)
        # 如果销售数量大于库存量则继续，否则flash提示
        print(form.num.data, getProdNum(form.prod_id.data), form.prod_id.data)
        if int(form.num.data) <= int(getProdNum(form.prod_id.data)):
            try:
                t = prodSaleStock(form.trade_name.data, form.prod_id.data, form.num.data, form.unit_price.data,
                                  form.remark.data, form.funding_pool_id.data, form.developer_info.data, userId)
                print(t)
                flash_data = '销售成功，本次减少库存%s瓶，收入增加%s元。' \
                             % (form.num.data, int(form.num.data) * float(form.unit_price.data))
                flash(flash_data)
                form.num.data = ''
                form.unit_price.data = ''
            except BaseException:
                print('销售执行失败，请联系霍佳宾 18647106104处理')
                flash('入库执行失败')
        else:
            flash('库存量小于销售量，请先入库再销售')
    return render_template('sale_trade.html', Form=form)


# 花费LIST
@app.route('/expenTrade', methods=['GET', 'POST'])
@login_required
def expenTrade():
    from form import expensive_trade_fields
    from toDB import expenTrade
    form = expensive_trade_fields()
    if form.validate_on_submit():
        # 花费list提交到后端
        userId = current_user.get_id()
        # 执行入库逻辑并重新核算资金
        t = expenTrade(form.trade_name.data, form.remark.data, form.fee.data, userId)
        print(t)
        flash(t)
    return render_template('expenTrade.html', Form=form)


# 库存盘点
@app.route('/stockTaking', methods=['GET', 'POST'])
@login_required
def stock_taking():
    from toDB import getProdStock, getStockChangDetail
    prodStock = getProdStock()
    stockChangeDetail = getStockChangDetail()
    return render_template('stockTaking.html', prodStock=prodStock,
                           stockChangeDetail=stockChangeDetail)


# 账务盘点
@app.route('/fundTaking', methods=['GET', 'POST'])
@login_required
def fund_taking():
    from toDB import getFundingBalance, getFundChangDetail
    fundingPoolBalance = getFundingBalance()
    fundChangeDetail = getFundChangDetail()
    return render_template('fundTaking.html', fundingPoolBalance=fundingPoolBalance,
                           fundChangeDetail=fundChangeDetail)


# 产品类目维护
@app.route('/prod_manage', methods=['GET', 'POST'])
@login_required
def prod_manage():
    from toDB import getProdManage, getProdNum, delProd
    prodManageList = getProdManage()
    if request.method == 'POST':
        t = request.form['blankRadio']
        checkNum = getProdNum(t)
        # 如果库存大于零则不允许删除
        if checkNum > 0:
            flash('所选产品库存大于0，不允许删除，请先清空库存')
            return render_template('prod_manage.html', prodManageList=prodManageList)
        else:
            info = delProd(t)
        flash(info)
    return render_template('prod_manage.html', prodManageList=prodManageList)


# 产品增加
@app.route('/addProd', methods=['GET', 'POST'])
@login_required
def addProd():
    from form import add_prod_fields
    from toDB import addProd
    form = add_prod_fields()
    if form.validate_on_submit():
        # 开始增加产品逻辑
        t = addProd(form.prod_name.data, form.jiuzhuang.data, form.xilie.data, form.remark.data)
        print(t)
        flash(t)
    return render_template('addProd.html', Form=form)


# 密码修改
@app.route('/changePassword', methods=['GET', 'POST'])
@login_required
def changePassword():
    from form import change_password_fields
    from toDB import get_user_list, get_user_passwd, changePassWord
    from hashlib import md5
    form = change_password_fields()
    form.phone.data = current_user.get_id()
    if form.validate_on_submit():
        # 校验旧密码
        phone = form.phone.data
        user_list = get_user_list()
        if phone not in user_list:
            flash('用户不存在')
        else:
            passwordOld = md5(form.passwordOld.data.encode()).hexdigest()
            ck_passwd = get_user_passwd(phone)
            if passwordOld == ck_passwd:
                passwd = md5(form.passwordNew.data.encode()).hexdigest()
                t = changePassWord(phone, passwd)
                flash(t)
            flash('密码错误')

    return render_template('changePassword.html', Form=form)


if __name__ == '__main__':
    app.run(debug=True)
