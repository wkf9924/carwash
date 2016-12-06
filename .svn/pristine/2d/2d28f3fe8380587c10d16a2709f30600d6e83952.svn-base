//
//  HttpApi.h
//  IOSDemo
//
//  Created by behring on 15/8/29.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#ifndef IOSDemo_HttpApi_h
#define IOSDemo_HttpApi_h




typedef enum {
    NoPay,
    YesPay
}PayType;

typedef enum{
    HttpApiRequestTypeUpload = 0,//上传下载相关
    HttpApiRequestTypeDownload,
    HttpApiRequestTypeForgetPassword,  //忘记密码
    HttpApiRequestTypeUpdatePassword,   //修改密码
    HttpApiRequestTypeLogin,                     //登录注册相关
    HttpApiRequestTypeAutoLogin,                     //自动登录
    HttpApiRequestTypeRegister,                  //注册
    HttpApiRequestTypeSmsCode,               //验证码
    HttpApiRequestTypeDiscount,                //今日特惠
    HttpApiRequestTypeCarBrand,               //车品牌
    HttpApiRequestTypeCarType,                  //车型
    HttpApiRequestTypeCouponList,            //优惠劵列表
    HttpApiRequestTypeConsumeList,          //消费劵列表
    HttpApiRequestTypeConsumeDetail,       //消费券详情
    HttpApiRequestTypeNearbyBusinesses,        //附近商家
    HttpApiRequestTypeMyLoveCar,       //我的爱车
    HttpApiRequestTypeMySellerInfo,        //商家信息详情
    HttpApiRequestTypeSellerList,        //商家列表
    HttpApiRequestTypeSellerServiceList,        //商家的服务列表
    HttpApiRequestTypeSellerServiceLInfo,        //商家的服务详情
    HttpApiRequestTypeAreaWashSellerlist,        //点击洗车按钮出现的洗车列表
    HttpApiRequestTypePersonalInfo,        //个人信息
    HttpApiRequestTypeSellerServiceCityList,        //商家服务城市列表
    HttpApiRequestTypeBindingMyCar,     //绑定车辆;
    
    HttpApiRequestTypeEditCarInfo,    //编辑车辆信息
    HttpApiRequestTypeCarInfo,    //车辆详情
    HttpApiRequestTypeCityCode,//城市编码
    
    HttpApiRequestTypeQueryViolation,//查询违章

    //支付
    HttpApiRequestTypeRecharge,  //充值
    HttpApiRequestTypeWithdraw,  //提现
    HttpApiRequestTypeTransactionRecord,  //交易记录查询
    HttpApiRequestTypeGetAmount,  //查询余额
    HttpApiRequestTypePayment,  //支付交易
    HttpApiRequestTypeReplacepaypassword,  //更换支付密码
    HttpApiRequestTypeAccountAccess,  //注册账户
    HttpApiRequestTypeStatistics,  //按用户类型平台查询交易记录查询统计
    HttpApiRequestTypeBindCard,  //绑定银行卡
    HttpApiRequestTypeBindCardList,  //绑定银行卡查询
    HttpApiRequestTypeunBundlingCard,  //解绑银行卡
    HttpApiRequestTypepayPassword,  //设置支付密码
    
    //发现模块
    HttpApiRequestTypeGetArticleList, //获取文章列表
    HttpApiRequestTypeGetArticleDetail,//获取文章详情
    HttpApiRequestTypeGetArticleComments,//获取评论列表
    HttpApiRequestTypeSendComment,//评论文章
    HttpApiRequestTypeSendCollectStatus,//收藏或取消收藏
    HttpApiRequestTypeSendLikeStatus,//点赞或取消点赞
    
    HttpApiRequestTypeSendValidation,//验证手机号是否是银行卡注册的手机号
    HttpApiRequestTypeSendAuthCode,//获取短信验证码
    
    
    HttpApiRequestTypeMyCollectList,//收藏列表
    
    HttpApiRequestTypeCouponPay, //特惠立即支付
    HttpApiRequestTypeServicePay, //购买服务立即支付
    HttpApiRequestTypeOrdersList, //服务订单列表
    HttpApiRequestTypeOrdersDetail, //服务订单详情
    
    HttpApiRequestTypeOrdersPay,//我的订单服务立即支付
    
    
    HttpApiRequestTypeRcodePay, //用户扫描商家
    
    HttpApiRequestTypeQuaryBankCarCuontAndBalance,//查询账户余额和银行卡数量
    HttpApiRequestTypeQuaryCouponCount,//查询消费券数量
    
    HttpApiRequestTypeTransactionList//查询用户账单查询
    
}HttpApiRequestType;

//叶保全
//#define API_SERVER_HOST @"192.168.2.216:8080/carwash"

//RAP调试使用
//#define API_SERVER_HOST @"192.168.2.249:8080/mockjs/1"
//正式接口
#define API_SERVER_HOST @"192.168.2.249:8081/carwash"
//支付接口
#define API_SERVER_HOST_PAY @"192.168.2.9:8080/wop/v1"
//刘斌辉
//#define API_SERVER_HOST @"192.168.2.135:8080/carwash"
//#define API_SERVER_HOST @"192.168.2.32:8080/carwash"
//#define API_SERVER_HOST @"mi.xcar.com.cn"

#define car_Image @"/car/imageUploa"

//上传下载相关接口
#define API_DOWNLOAD @"/index.php/api/app/download"
#define API_UPLOAD @"/index.php/api/app/seller__upload"
//获取注册验证码 /user/sms_code
#define API_SMSCODE @"/user/sms_code"
//登录注册相关接口 /user/auto_login
//#define API_REGISTER @"/CarWashServer/login.php"

#define API_COLLECT_LIST @"/my/newsList"

//查询券数量
#define API_QUARY_COUPONS_COUNT @"/user/volumeNumber"
//查询账户余额和银行卡数量
#define API_QUARY_BANK_CARD_COUNT_AND_BALANCE @"/user/demand"
//修改密码
#define API_editPassword @"/my/editpassword"
//忘记密码
#define API_forgetPassword @"/user/forgetpassword"

#define API_LOGIN @"/user/login"
#define API_REGISTER @"/user/register"
//自动登录
#define API_autoLogin @"/user/auto_login"
//今日特惠
#define API_TODAY_DISCOUNT_GOODS @"/goods/today_discount_goods"
//车辆品牌 "
//http://mi.xcar.com.cn/interface/xcarapp/getBrands.php
#define API_CAR_BRAND @"/car/carBinding"

//消费劵详情
#define API_CONSUME_DETAIL @"/my/couponInfo"

//优惠劵列表
#define API_COUPON_LIST @"/my/couponList"

//消费劵列表  /my/consumptionList
#define API_CONSUME_LIST @"/my/consumptionList"

//附近商家
#define API_NearbyBusinesses @"/my/sellerList"

//我的爱车 /my/carManager
#define API_myLoveCar @"/my/carManager"

//我的爱车点击附近商家后的商家详情/my/sellerInfo
#define API_mySellerInfo @"/my/sellerInfo"

//附近商家列表（我的爱车模块）
#define API_sellerList @"/my/sellerList"


//商家服务列表 比如，洗车打蜡等服务
#define API_sellerServiceList @"/my/serviceList"

//商家服务详情 比如洗车详情
#define API_sellerServiceInfo @"/my/serviceInfo"

// 按地区获取商家信息
#define API_goodSellerList @"/goods/sellerList"

//个人信息 /my/editAcount
#define API_editAcount @"/my/editAcount"

//上传用户头像
#define API_editAvatar @"/my/editAvatar"

//获取地区商家统计信息
#define API_sellerCount @"/goods/sellerCount"

//绑定车辆
#define API_BindingMyCar @"/car/carBinding"

//完善车辆信息
#define API_carCompleteCarInfo @"car/completeCarInfo"

//车辆详情  /my/carInfo
#define API_carInfo @"/my/carInfo"
//城市编码  /car/cityQuery
#define API_CITYCODE @"/car/cityQuery"

//查询违章  /car/carViolation
#define API_QUERYVIOLATION @"/car/carViolation"

/******************交易********************/
//交易记录查询 trade/transactionRecord
#define API_trade_transactionRecord @"trade/transactionRecord"

//按用户类型平台查询交易记录查询统计 trade/statistics
#define API_trade_statistics @"/trade/statistics"

//支付交易  trade/payment
#define API_trade_payment @"/trade/payment"

//充值 trade/recharge
#define API_trade_recharge @"/trade/recharge"

//提现 trade/withdraw
#define API_trade_withdraw @"/trade/withdraw"


/******************交易信息设置********************/
//更换支付密码 account/replacepaypassword
#define API_account_replacepaypassword @"/account/replacepaypassword"

//查询余额account/getAmount
#define API_account_getAmount @"/account/getAmount"

//注册account/accountAccess
#define API_account_accountAccess @"/account/accountAccess"

//绑定银行卡 account/bindCard
#define API_account_bindCard @"/account/bindCard"

//绑定银行卡查询 account/bindCardList
#define API_account_bindCardList @"/account/bindCardList"

//解绑银行卡 account/unbundlingCard
#define API_account_unbundlingCard @"/account/unbundlingCard"

//设置支付密码 account/payPassword
#define API_accountpayPassword @"/account/payPassword"


#pragma mark - 发现模块
/**
 * 发现列表
 */
#define API_ARTICLE_LIST_URL  @"/news/list"

/**
 * 发现详情
 */
#define API_ARTICLE_DETAIL_URL  @"/news/info"

/**
 * 文章评论列表
 */
#define API_ARTICLE_COMMENTS_URL  @"/news/evaluate"
/**
 * 发送评论
 */
#define API_SEND_COMMENT_URL  @"/news/saveEva"
/**
 * 设置收藏状态
 */
#define API_COLLECT_URL  @"/news/article"
/**
 * 设置点赞状态
 */
#define API_LIKE_URL  @"/news/likes"


/**
 * 验证手机号 银行卡绑定的手机号  /user/auth_code
 */
#define API_Validation  @"/user/validation"
/**
 *  获取验证码  /user/auth_code
 */
#define API_Auth_code  @"/user/auth_code"



//特惠立即支付（不管支付成功失败都在订单表中生成订单）
#define API_PAYMENT_COUPONPAY @"/payment/couponPay"
//服务订单列表
#define API_ORDERSLIST @"/my/serviceOrderList"
//服务订单详情
#define API_ORDERSDETAIL @"/my/serviceOrderInfo"
//购买服务立即支付（不管支付成功失败都在订单表中生成订单）
#define API_PAYMENT_SERVICEPAY @"/payment/servicePay"
//我的订单服务立即支付
#define API_ORDERS_PAY @"/payment/orderPay"

//二维码扫码
////商家扫描用户二维码消费支付 /payment/qrcodePay
//#define API_QRCODEPAY @"/payment/qrcodePay"

//用户扫描商家二维码付款
#define API_RCODEPAY @"/payment/orderPay"


//车商城支付 /good/orderpay
#define API_GOOD_BRDERPAY @"/good/orderpay"

//用户账单详情  http://192.168.2.9:8080/wop/v1/trade/purchaseHistory
#define API_TRADE_PURCHASEHISTORY @"/trade/purchaseHistory"

//会员支付 /payment/vipPay
#define API_PAYMENT_VIPPAY @"/payment/vipPay"


//会员洗车列表  /my/vipsSllerList
#define API_MY_VIPSSLLERLIST @"/my/vipsSllerList"

//支付密码验证 /wop/v1/account/verifyPin
#define API_ACCOUNT_VERIFYPIN @"/account/verifyPin"



#endif

