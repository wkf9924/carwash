
//  PayManager.m
//  CarWash
//
//  Created by WangKaifeng on 2016/9/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "PayManager.h"
#import "JXTAlertTools.h"
@interface PayManager()<BZHttpManagerDelegate>
@end
@implementation PayManager

+(PayManager *)sharedManager
{
    static PayManager *sharedInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
        [[BZHttpManager sharedHttpManager]registerHttpManagerDelegate:sharedInstance];
    });
    return sharedInstance;
}

-(void)reg:(NSString *)phone  verzxwification:(NSString *)vercode password:(NSString *)password
{
    RegisterParam  *param = [[RegisterParam alloc]init];
    param.phone = phone;
    param.password = password;
    param.vercode = vercode;
    LC_LOADING
    [[CWHttpKit sharedHttpKit] registerWithUrl:API_REGISTER andParam: param];
}


//更改支付密码
-(void)ancient_password:(NSString *)ancient_password
                  appid:(NSString *)appid
               password:(NSString *)password
        confirmPassword:(NSString *)confirmPassword
                 userid:(NSString *)userid
              verifyKey:(NSString *)verifyKey {
    [CWHTTP replacepaypasswordWithUrl:API_account_replacepaypassword ancient_password:password appid:appid password:password confirmPassword:confirmPassword userid:userid verifyKey:verifyKey];
}
//支付交易
-(void)payment:(PaymentParam *)param {
    [CWHTTP paymentWithUrl:API_trade_payment param:param];
}

//查询余额
-(void)getAmount:(NSString *)appid
          userid:(NSString *)userid
       verifyKey:(NSString *)verifyKey {
    [CWHTTP getAmountWithUrl:API_account_getAmount appid:appid userid:userid verifyKey:verifyKey];
}
//注册
-(void)accountAccess:(NSString *)appid
        customerType:(NSString *)customerType
              userid:(NSString *)userid
           verifyKey:(NSString *)verifyKey {
    
    [CWHTTP accountAccessWithUrl:API_account_accountAccess appid:appid customerType:customerType userid:userid verifyKey:verifyKey];
}
//绑定银行卡
-(void)bindCarparam:(BindCard *)param {
    [CWHTTP bindCardWithUrl:API_account_bindCard param:param];
}
//绑定银行卡查询
-(void)bindCardLisappid:(NSString *)appid
                 userId:(NSString *)userId
              verifyKey:(NSString *)verifyKey {
    [CWHTTP bindCardListWithUrl:API_account_bindCardList appid:appid userId:userId verifyKey:verifyKey];
}

//解绑银行卡
-(void)unbundlingCardAppid:(NSString *)appid
                  userId:(NSString *)userId
               verifyKey:(NSString *)verifyKey
                  CardNo:(NSString *)CardNo
                Password:(NSString *)Password {
    [CWHTTP unbundlingCardWithUrl:API_account_unbundlingCard appid:appid userId:userId verifyKey:verifyKey CardNo:CardNo Password:Password];
}


//设置支付密码
-(void)payPasswordAppid:(NSString *)appid
                       userId:(NSString *)userId
                    verifyKey:(NSString *)verifyKey
              confirmPassword:(NSString *)confirmPassword
               Password:(NSString *)Password {
    [CWHTTP payPasswordWithUrl:API_accountpayPassword appid:appid userId:userId verifyKey:verifyKey confirmPassword:confirmPassword Password:Password];
}

//交易记录查询
-(void)transactionRecordParam:(TransactionRecordParam *)param {
    [CWHTTP transactionRecordWithUrl:API_trade_transactionRecord param:param];
}


//验证手机号 银行卡绑定的手机号
-(void)validationPhone:(NSString *)phone smsCode:(NSString *)smsCode {
    [CWHTTP validationWithUrl:API_Validation phone:phone smsCode:smsCode];
}

//验证手机号 银行卡绑定的手机号
-(void)authCodePhone:(NSString *)phone {
    [CWHTTP authCodeWithUrl:API_Auth_code phone:phone];
}
//充值
- (void)rechargeWithparam:(rechargeParam *)param{
    [CWHTTP rechargeWithUrl:API_trade_recharge rechargeMode:param];
    
}
- (void)withdrawWithParam:(WithdrawParam *)param{
    [CWHTTP withdrawWithUrl:API_trade_withdraw rechargeMode:param];
}


/**
 *  特惠立即支付
 *  sys_price 系统优惠价格
 */
//RCP
-(void)couponPay:(NSString *)sys_price password:(NSString *)password{
    [CWHTTP couponPayWithUrl:API_PAYMENT_COUPONPAY sys_price:sys_price password:password];
}
/**
 *  服务订单列表
 */
- (void)ordersListWithCount:(NSNumber *)count page:(NSNumber *)page sellerid:(NSString *)sellerId status:(NSString *)status{
    [CWHTTP ordersListWithUrl:API_ORDERSLIST count:count page:page sellerid:sellerId status:status];
}
/**
 *  - (void)viewWillAppear:(BOOL)animated{
 [super viewWillAppear:animated];
 self.tabBarController.tabBar.hidden = YES;
 }
 - (void)viewWillDisappear:(BOOL)animated{
 [super viewWillDisappear:animated];
 self.tabBarController.tabBar.hidden = NO;
 }
 */
//我的订单服务订单详情
- (void)ordersDetailWithId:(NSString *)ordersId{
    [CWHTTP ordersListWithUrl:API_ORDERSDETAIL ordersId:ordersId];
}
/**
 *  购买服务立即支付
 *  coupon_id	优惠劵唯一标示
 *  service_id 服务唯一标示
 */
-(void)servicePayCoupon_id:(NSString *)coupon_id
           accepter_userid:(NSString *)accepter_userid
                  password:(NSString *)password
                     price:(NSString *)price
                service_id:(NSString *)service_id
{
    
    [CWHTTP servicePayWithUrl:API_PAYMENT_SERVICEPAY coupon_id:coupon_id service_id:service_id accepter_userid:accepter_userid password:password price:price];
    
}
/**
 *我的订单服务立即支付
 *
 */
- (void)ordersPayWithId:(NSString *)ordersId accepter_appid:(NSString *)accepter_appid accepter_userid:(NSString *)accepter_userid coupon_id:(NSString *)coupon_id password:(NSString *)password service_id:(NSString *)service_id type:(NSString *)type price:(NSString *)price{
    [CWHTTP ordersPayWithUrl:API_ORDERS_PAY ordersId:ordersId accepter_appid:accepter_appid accepter_userid:accepter_userid coupon_id:coupon_id password:password service_id:service_id type:type price:price];
}

//用户扫描商家
-(void)rcodeAccepter_Appid:(NSString *)Accepter_Appid
            Accepter_userid:(NSString *)Accepter_userid
                     Amount:(NSString *)Amount
                      Appid:(NSString *)Appid
                   Password:(NSString *)Password {
    [CWHTTP rcodePayWithUrl:API_RCODEPAY Accepter_Appid:Accepter_Appid Accepter_userid:Accepter_userid Amount:Amount Appid:Appid Password:Password];
}
/**
 *我的查询银行卡数量以及账户余额
 */
- (void)quarybankCardCountAndBalance{
    [CWHTTP quaryBankCardCountAndBalanceWithUrl:API_QUARY_BANK_CARD_COUNT_AND_BALANCE];
}
/**
 *查询消费券数量
 */
- (void)quaryCouponCount{
    [CWHTTP quaryCouponCountWithUrl:API_QUARY_COUPONS_COUNT];
}

-(void)transactionListcount:(NSString *)count
                       page:(NSString *)page
                       tpye:(NSString *)type {
    
    [CWHTTP transactionListWithUrl:API_TRADE_PURCHASEHISTORY count:count page:page];
}

#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    
    LC_HIDEN
    NSString *message = httpReponse.json[@"message"];
    switch (httpReponse.requestType) {
            
            //用户扫商家
        case HttpApiRequestTypeTransactionList:
            if (httpReponse.error.code == 0) {
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeTransaction param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeTransactionFail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //用户扫商家
        case HttpApiRequestTypeRcodePay:
            if (httpReponse.error.code == 0) {
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeRcodePay param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeRcodePayFail param:httpReponse.error mainTread:YES];
            }
            break;

            
            //特惠立即支付
        case HttpApiRequestTypeCouponPay:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCouponPay param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCouponPayFail param:httpReponse.error mainTread:YES];
            }
            break;
            
            
            //购买服务立即支付
        case HttpApiRequestTypeServicePay:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeServicePay param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeServicePayFail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //验证手机号是否银行卡中绑定的一样
        case HttpApiRequestTypeSendValidation:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeValidataion param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeValidataionFail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //获取验证码
        case HttpApiRequestTypeSendAuthCode:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeAuthCode param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeAuthCodeFail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //交易记录查询
        case HttpApiRequestTypeTransactionRecord:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeTransactionRecord param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeTransactionRecordFail param:httpReponse.error mainTread:YES];
            }
            break;
            //设置支付密码
        case HttpApiRequestTypepayPassword:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypepayPassword param:token mainTread:YES];
            }else {
                
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeReplacepaypasswordFail param:httpReponse.error mainTread:YES];
            }
            break;

            //解绑银行卡
        case HttpApiRequestTypeunBundlingCard:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeBundlingCard param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeBundlingCardFail param:httpReponse.error mainTread:YES];
            }
            break;
            //绑定银行卡查询
        case HttpApiRequestTypeBindCardList:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeBindCardList param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeBindCardListFail param:httpReponse.error mainTread:YES];
            }
            break;
            //绑定银行卡
        case HttpApiRequestTypeBindCard:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeBindCard param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeBindCardFail param:httpReponse.error mainTread:YES];
            }
            break;
            //注册
        case HttpApiRequestTypeAccountAccess:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeAccountAccess param:token mainTread:YES];
            }else {
//                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeAccountAccessFail param:httpReponse.error mainTread:YES];
            }
            break;
            //查询余额
        case HttpApiRequestTypeGetAmount:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeGetAmount param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeGetAmountFail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //支付交易
        case HttpApiRequestTypePayment:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypePayment param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypePaymentFail param:httpReponse.error mainTread:YES];
            }
            break;

            //充值
        case HttpApiRequestTypeRecharge:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeRecharge param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeRechargeFail param:httpReponse.error mainTread:YES];
            }
            break;
            //提现
        case HttpApiRequestTypeWithdraw:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeWithdraw param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeWithdrawFail param:httpReponse.error mainTread:YES];
            }
            break;
            //更换支付密码
        case HttpApiRequestTypeReplacepaypassword:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeReplacepaypassword param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeReplacepaypasswordFail param:httpReponse.error mainTread:YES];
            }
            break;
            //服务订单列表
        case HttpApiRequestTypeOrdersList:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeOrdersList param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeOrdersListFail param:httpReponse.error mainTread:YES];
            }
            break;
            //服务订单详情
        case HttpApiRequestTypeOrdersDetail:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeOrdersDetail param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeOrdersDetailFail param:httpReponse.error mainTread:YES];
            }
            break;
            //我的订单服务立即支付
        case HttpApiRequestTypeOrdersPay:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeOrdersPay param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeOrdersPayFail param:httpReponse.error mainTread:YES];
            }
            break;
            //我的查询银行卡数量以及账户余额
        case HttpApiRequestTypeQuaryBankCarCuontAndBalance:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCardcountAndBalance param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCardcountAndBalanceFail param:httpReponse.error mainTread:YES];
            }
            break;
            //查询我的消费券数量
        case HttpApiRequestTypeQuaryCouponCount:
            if (httpReponse.error.code == 0) {
                
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCouponCount param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCouponCountFail param:httpReponse.error mainTread:YES];
            }
            break;
        default:
            break;
    }
}

@end
