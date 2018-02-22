from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField, TextAreaField, PasswordField, BooleanField
from wtforms.validators import DataRequired, Regexp, EqualTo


# 登录表单
class loginForm(FlaskForm):
    phone = StringField('电话号码', validators=[DataRequired()])
    password = PasswordField('密码', validators=[DataRequired()])
    remember_me = BooleanField('下次自动登陆（请不要在公用电脑勾选此项）')
    submit = SubmitField('登陆')


# 入库表单
class stock_trade_fields(FlaskForm):
    trade_name = StringField('订单名称：', validators=[DataRequired(message='为此次入库起个名字')])
    prod_id = SelectField('选择产品：', validators=[DataRequired(message='必须选择产品哦')])
    funding_pool_id = SelectField('选择本次资金流向：', validators=[DataRequired(message='选择对应资金池')])
    num = StringField('填写数量：', validators=[Regexp(r'^[0-9]*$', message='必须填写整数')])
    unit_price = StringField('进货单价：', validators=[Regexp(r'^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$|^-?[1-9]\d*$',
                                                         message='进货单价必须为数字')])
    remark = TextAreaField('订单备注：')
    submit = SubmitField('确定入库')


# 销售表单
class sale_trade_fields(FlaskForm):
    trade_name = StringField('订单名称：', validators=[DataRequired(message='为这笔销售起个名字')])
    prod_id = SelectField('选择产品：', validators=[DataRequired(message='必须选择产品哦')])
    funding_pool_id = SelectField('选择本次资金流向：', validators=[DataRequired(message='选择对应资金池')])
    num = StringField('填写数量：', validators=[Regexp(r'^[0-9]*$', message='必须填写整数')])
    unit_price = StringField('销售单价：', validators=[Regexp(r'^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$|^-?[1-9]\d*$',
                                                         message='销售单价必须为数字')])
    remark = TextAreaField('订单备注：')
    developer_info = TextAreaField('发展人信息：')
    submit = SubmitField('确定售出')


# 花费LIST
class expensive_trade_fields(FlaskForm):
    trade_name = StringField('订单名称：', validators=[DataRequired(message='为这笔花费起个名字')])
    fee = StringField('花费金额：', validators=[Regexp(r'^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$|^-?[1-9]\d*$',
                                                  message='花费金额必须为数字')])
    remark = TextAreaField('请填写详细备注信息')
    submit = SubmitField('提交')


# 产品类目增加表单
class add_prod_fields(FlaskForm):
    prod_name = StringField('产品名称：', validators=[DataRequired(message='必须填写产品名称')])
    jiuzhuang = StringField('酒庄：', validators=[DataRequired(message='必须填写酒庄')])
    xilie = StringField('系列：', validators=[DataRequired(message='必须填写系列')])
    remark = TextAreaField('订单备注：')
    submit = SubmitField('确定增加')


# 密码修改
class change_password_fields(FlaskForm):
    phone = StringField('电话号码', validators=[DataRequired()])
    passwordOld = PasswordField('原密码', validators=[DataRequired()])
    passwordNew = PasswordField('新密码', validators=[DataRequired()])
    passwordNewConfirm = PasswordField('确认新密码', validators=[EqualTo('passwordNew', message='两次输入密码不一致')])
    submit = SubmitField('确定修改')
