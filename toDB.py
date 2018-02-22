from sqlalchemy import create_engine
import os

os.environ['NLS_LANG'] = 'SIMPLIFIED CHINESE_CHINA.UTF8'
engine = create_engine('mysql+pymysql://huojiabin:huojb123@47.93.61.35/hjb?charset=utf8', convert_unicode=True)


# 用户登录相关函数
def get_user_list():
    user_list = []
    try:
        t = engine.execute("SELECT A.LOGIN_NAME FROM sys_users A")
        for i in t:
            user_list.append(i[0])
        return user_list
    except BaseException:
        print('用户列表拉取异常')


def get_user_passwd(login_name):
    try:
        t = engine.execute("SELECT A.PASSWORD FROM sys_users A WHERE A.LOGIN_NAME = %s" % login_name)
        for i in t:
            r = i
        return r[0]
    except BaseException:
        print('密码调用异常')


# 获取库存情况（用于首页）
def getProdStock():
    sql = "select a.prod_name,a.jiuzhuang,a.xilie,b.num " \
          "from prod a,stock b where a.prod_id = b.product_id and b.num>0"
    t = engine.execute(sql)
    prodStockDict = []
    for i in t:
        prodStockDict.append([i[0], i[1], i[2], i[3]])
    print('获取库存情况成功')
    print(prodStockDict)
    return prodStockDict


# 获取资金情况（用于首页）
def getFundingBalance():
    sql = "select a.pool_name,a.pool_type,a.rev,a.exp,a.balance " \
          "from funding_pool a where a.sts='A' union all " \
          "select '合计' pool_name,'' pool_type,sum(b.rev),sum(b.exp),sum(b.balance) " \
          "from funding_pool b where b.sts='A'"
    t = engine.execute(sql)
    fundingPoolBalance = []
    for i in t:
        fundingPoolBalance.append([i[0], i[1], i[2], i[3], i[4]])
        print('获取资金余额成功')
        print(fundingPoolBalance)
    return fundingPoolBalance


# 获取产品列表
def getProd():
    try:
        t = engine.execute(
            "select a.prod_id,concat(a.prod_name,'|酒庄：',a.jiuzhuang,'|系列：',a.xilie) from prod a order by a.prod_name")
        prod_dict = []
        for i in t:
            prod_dict.append((str(i[0]), i[1]))
        print('成功获取到产品列表：')
        print(prod_dict)
        return prod_dict
    except BaseException:
        print('产品列表获取异常')
        return [0, 0]


# 获取产品列表（销售列表，库存数量必须大于0）
def getProdSale():
    try:
        sql = "select a.prod_id,concat(a.prod_name,'|酒庄：',a.jiuzhuang,'|剩余库存：',b.num) " \
              "from prod a,stock b where a.prod_id = b.product_id and b.num>0 order by a.prod_name"
        t = engine.execute(sql)
        prod_dict = []
        for i in t:
            prod_dict.append((str(i[0]), i[1]))
        print('成功获取到销售产品列表')
        print(prod_dict)
        return prod_dict
    except BaseException:
        print('销售产品列表获取异常')
        return [0, 0]


# 获取产品库存量
def getProdNum(prod_id):
    try:
        sql = "select a.num from stock a where a.product_id=%s" % (prod_id)
        t = engine.execute(sql)
        num = t.fetchone()[0]
        print('当前产品剩余' + str(num))
        return num
    except BaseException:
        print('产品剩余库存获取异常')
        return 0


# 获取资金池列表
def getFundingPool():
    try:
        t = engine.execute(
            "select a.fund_pool_id,concat(a.pool_name,'|当前余额：',a.balance) "
            "from funding_pool a order by a.pool_name desc")
        pool_dict = []
        for i in t:
            pool_dict.append((str(i[0]), i[1]))
        print('成功获取到资金池列表：')
        print(pool_dict)
        return pool_dict
    except BaseException:
        print('资金池列表获取异常')
        return [0, 0]


# 入库处理函数
def prodInStock(trade_name, prod_id, num, unit_price, remark, funding_pool_id, userId):
    print('开始入库订单逻辑', 'step1 入stock_trade')
    sql = ("insert into stock_trade(trade_name,remark,trade_time,prod_id,num,unit_price,trade_user_id) "
           "values ('%s','%s',sysdate(),%s,%s,%s,'%s')" % (trade_name, remark, prod_id, num, unit_price, userId))
    print(sql)
    engine.execute(sql)
    engine.execute('commit')
    print('step2 增加库存')
    # 判断是否存在原库存
    t = engine.execute("select count(1) from stock a where a.product_id = %s" % (prod_id))
    v_if_exists = t.fetchone()[0]
    if v_if_exists == 0:
        print('库存不存在，创建库存')
        sql = "insert into stock(product_id,num,remark,create_date) " \
              "values (%s,%s,'%s',sysdate())" % (prod_id, num, remark)
        engine.execute(sql)
        engine.execute('commit')
    else:
        print('库存存在，在原有库存上增减')
        sql = "update stock a set a.num=a.num+%s where a.product_id=%s" % (num, prod_id)
        engine.execute(sql)
        engine.execute('commit')
    print(v_if_exists)
    print('step3 库存变化记录日志')
    sql = "insert into stock_change_log(prod_id,change_num,change_type,remark,change_user_id,change_time) " \
          "values (%s,%s,'商品入库','%s','%s',sysdate())" % (prod_id, num, remark, userId)
    engine.execute(sql)
    engine.execute('commit')
    print('setp4 资金核减')
    sql = "update funding_pool a set a.exp=a.exp+%s where a.fund_pool_id=%s" % (
        float(unit_price) * int(num), funding_pool_id)
    engine.execute(sql)
    engine.execute('commit')
    print('step5 重新计算资金池余额')
    sql = "update funding_pool a set a.balance=(a.rev-a.exp) where a.fund_pool_id=%s" % (funding_pool_id)
    engine.execute(sql)
    engine.execute('commit')
    print('step6 资金变化记录日志')
    sql = "insert into funding_change_log(funding_pool_id,change_price," \
          "change_type,remark,change_user_id,change_time) " \
          "values (%s,%s,'进货扣减资金','%s','%s',sysdate())" \
          % (funding_pool_id, (- float(unit_price) * int(num)), remark, userId)
    print(sql)
    engine.execute(sql)
    engine.execute('commit')
    return '入库处理成功完成'


# 销售处理函数
def prodSaleStock(trade_name, prod_id, num, unit_price, remark, funding_pool_id, developer_info, userId):
    print('开始销售订单逻辑：step1 订单入库')
    sql = "insert into sale_trade(trade_name,remark,trade_time,prod_id," \
          "num,unit_price,trade_user_id,developer_info) values ('%s','%s',sysdate(),%s,%s,%s,'%s','%s')" \
          % (trade_name, remark, prod_id, num, unit_price, userId, developer_info)
    engine.execute(sql)
    engine.execute('commit')
    print('step2 核减库存并记录日志')
    sql = "update stock a set a.num=a.num-%s where a.product_id=%s" % (num, prod_id)
    engine.execute(sql)
    engine.execute('commit')
    sql = "insert into stock_change_log(prod_id,change_num,change_type,remark,change_user_id,change_time) " \
          "values (%s,%s,'商品销售','%s','%s',sysdate())" % (prod_id, (0 - int(num)), remark, userId)
    engine.execute(sql)
    engine.execute('commit')
    print('setp3 资金增加')
    sql = "update funding_pool a set a.rev=a.rev+%s where a.fund_pool_id=%s" % (
        float(unit_price) * int(num), funding_pool_id)
    engine.execute(sql)
    engine.execute('commit')
    print('step4 重新计算资金池余额')
    sql = "update funding_pool a set a.balance=(a.rev-a.exp) where a.fund_pool_id=%s" % (funding_pool_id)
    engine.execute(sql)
    engine.execute('commit')
    print('step5 资金变化记录日志')
    sql = "insert into funding_change_log(funding_pool_id,change_price," \
          "change_type,remark,change_user_id,change_time) " \
          "values (%s,%s,'销售增加资金','%s','%s',sysdate())" \
          % (funding_pool_id, (float(unit_price) * int(num)), remark, userId)
    print(sql)
    engine.execute(sql)
    engine.execute('commit')
    return '销售处理成功完成'


# 花费LIST，入库逻辑
def expenTrade(trade_name, remark, fee, userId):
    # 直接扣减花费资金并记录日志
    print('step1 花费订单入库')
    sql = "insert into expense_trade(name,remark,fee,trade_time,expense_user_id) " \
          "values ('%s','%s',%s,sysdate(),'%s')" % (trade_name, remark, float(fee), userId)
    engine.execute(sql)
    engine.execute('commit')
    print('step2 资金增加')
    sql = "update funding_pool a set a.exp=a.exp+%s where a.fund_pool_id=3" % (float(fee))
    engine.execute(sql)
    engine.execute('commit')
    print('step3 重新计算资金池余额')
    sql = "update funding_pool a set a.balance=(a.rev-a.exp) where a.fund_pool_id=3"
    engine.execute(sql)
    engine.execute('commit')
    print('step3 资金变化记录日志')
    sql = "insert into funding_change_log(funding_pool_id,change_price," \
          "change_type,remark,change_user_id,change_time) " \
          "values (%s,%s,'花费LIST扣减资金','%s','%s',sysdate())" \
          % (3, float(fee), remark, userId)
    print(sql)
    engine.execute(sql)
    engine.execute('commit')
    return '花费记录成功'


# 获取库存变更明细（库存盘点）
def getStockChangDetail():
    sql = "select t.* from (select a.trade_time,'商品入库' type,b.user_name," \
          "c.prod_name,a.num,a.unit_price,(0-a.num*a.unit_price) funding_change," \
          "a.remark,'' developer_info " \
          "from stock_trade a,sys_users b,prod c " \
          "where a.trade_user_id = b.login_name " \
          "and a.prod_id = c.prod_id " \
          "union all " \
          "select a.trade_time,'商品销售' type,b.user_name,c.prod_name,a.num,a.unit_price," \
          "(a.num*a.unit_price) funding_change,a.remark,a.developer_info " \
          "from sale_trade a,sys_users b,prod c " \
          "where a.trade_user_id = b.login_name and a.prod_id = c.prod_id) t " \
          "order by t.trade_time desc"
    t = engine.execute(sql)
    stockChangeDetail = []
    for i in t:
        stockChangeDetail.append([i[0], i[1], i[2], i[3], i[4], i[5], i[6], i[7], i[8]])
        print('获取库存变更明细成功')
        print(stockChangeDetail)
    return stockChangeDetail


# 获取资金总览（账务盘点）
def getFundChangDetail():
    sql = "select a.change_time,a.change_type,c.user_name,b.pool_name,a.change_price,a.remark " \
          "from funding_change_log a,funding_pool b,sys_users c " \
          "where a.funding_pool_id = b.fund_pool_id and a.change_user_id = c.login_name " \
          "order by a.change_time desc"
    t = engine.execute(sql)
    fundChangeDetail = []
    for i in t:
        fundChangeDetail.append([i[0], i[1], i[2], i[3], i[4], i[5]])
        print('获取资金变更明细成功')
        print(fundChangeDetail)
    return fundChangeDetail


# 获取产品列表（产品管理）
def getProdManage():
    sql = "select a.prod_id,prod_name,a.jiuzhuang,a.xilie,a.remark,b.num " \
          "from prod a left join stock b on a.prod_id = b.product_id"
    t = engine.execute(sql)
    prodManageList = []
    for i in t:
        prodManageList.append([i[0], i[1], i[2], i[3], i[4], i[5]])
    print('获取产品列表成功')
    print(prodManageList)
    return prodManageList


# 产品类型删除（产品管理）
def delProd(prod_id):
    # 先迁移倒备份表，然后删除
    sql1 = "insert into prod_his(prod_id,prod_name,jiuzhuang,xilie,remark,create_date,del_date) " \
           "select a.*,sysdate() from prod a where a.prod_id=%s" % prod_id
    sql2 = "delete from prod where prod_id=%s" % prod_id
    print(sql1, sql2)
    engine.execute(sql1)
    engine.execute(sql2)
    engine.execute('commit')
    return '成功删除产品并迁移倒备份表'


# 产品类型增加（产品管理）
def addProd(prod_name, jiuzhuang, xilie, remark):
    sql = "insert into prod(prod_name,jiuzhuang,xilie,remark,create_date) " \
          "values('%s','%s','%s','%s',sysdate())" % (prod_name, jiuzhuang, xilie, remark)
    engine.execute(sql)
    engine.execute('commit')
    return '产品%s增加成功' % prod_name


# 密码修改
def changePassWord(phone, passwd):
    sql = "update sys_users a set a.password = '%s' where a.login_name = '%s'" % (passwd, phone)
    engine.execute(sql)
    engine.execute('commit')
    return '密码修改成功'
