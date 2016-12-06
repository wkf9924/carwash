//
//  PayManager.h
//  CarWash
//
//  Created by WangKaifeng on 2016/9/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineConstant.h"
#import "rechargeParam.h"
#import "WithdrawParam.h"
@interface PayManager : NSObject
+(PayManager *)sharedManager;

//更改支付密码
-(void)ancient_password:(NSString *)ancient_password
                  appid:(NSString *)appid
               password:(NSString *)password
        confirmPassword:(NSString *)confirmPassword
                 userid:(NSString *)userid
              verifyKey:(NSString *)verifyKey;
//支付交易
-(void)payment:(PaymentParam *)param;

//查询余额
-(void)getAmount:(NSString *)appid
                userid:(NSString *)userid
             verifyKey:(NSString *)verifyKey;

//注册
-(void)accountAccess:(NSString *)appid
              customerType:(NSString *)customerType
                    userid:(NSString *)userid
                 verifyKey:(NSString *)verifyKey;
//绑定银行卡
-(void)bindCarparam:(BindCard *)param;
//绑定银行卡查询
-(void)bindCardLisappid:(NSString *)appid
                 userId:(NSString *)userId
              verifyKey:(NSString *)verifyKey;

//解绑银行卡
-(void)unbundlingCardAppid:(NSString *)appid
                    userId:(NSString *)userId
                 verifyKey:(NSString *)verifyKey
                    CardNo:(NSString *)CardNo
                  Password:(NSString *)Password;


//设置支付密码
-(void)payPasswordAppid:(NSString *)appid
                       userId:(NSString *)userId
                    verifyKey:(NSString *)verifyKey
              confirmPassword:(NSString *)confirmPassword
                     Password:(NSString *)Password;
//交易记录查询
-(void)transactionRecordParam:(TransactionRecordParam *)param;

//验证手机号 银行卡绑定的手机号
-(void)validationPhone:(NSString *)phone smsCode:(NSString *)smsCode;

//验证手机号 银行卡绑定的手机号
-(void)authCodePhone:(NSString *)phone;
//充值
- (void)rechargeWithparam:(rechargeParam *)param;
//提现
- (void)withdrawWithParam:(WithdrawParam *)param;

/**
 *  特惠立即支付
 *  sys_price 系统优惠价格
 */
//RCP
-(void)couponPay:(NSString *)sys_price password:(NSString *)password;

/**
 *  购买服务立即支付
 *  coupon_id	优惠劵唯一标示
 *  service_id 服务唯一标示
 */
-(void)servicePayCoupon_id:(NSString *)coupon_id
           accepter_userid:(NSString *)accepter_userid
                  password:(NSString *)password
                     price:(NSString *)price
                service_id:(NSString *)service_id;


/**
 * 用户扫描商家二维码付款
 *
 */
-(void)rcodeAccepter_Appid:(NSString *)Accepter_Appid
           Accepter_userid:(NSString *)Accepter_userid
                    Amount:(NSString *)Amount
                     Appid:(NSString *)Appid
                  Password:(NSString *)Password;
/**
 *服务订单列表
 */
- (void)ordersListWithCount:(NSNumber *)count page:(NSNumber *)page sellerid:(NSString *)sellerId status:(NSString *)status;
/**
 *服务订单详情
 *
 */
- (void)ordersDetailWithId:(NSString *)ordersId;

/**
 *我的订单服务立即支付
 *
 */
- (void)ordersPayWithId:(NSString *)ordersId accepter_appid:(NSString *)accepter_appid accepter_userid:(NSString *)accepter_userid coupon_id:(NSString *)coupon_id password:(NSString *)password service_id:(NSString *)service_id type:(NSString *)type price:(NSString *)price;


/**
 *我的查询银行卡数量以及账户余额
 */
- (void)quarybankCardCountAndBalance;
/**
 *查询消费券数量
 */
- (void)quaryCouponCount;

/**
 *查询用户账单详情
 */
-(void)transactionListcount:(NSString *)count
                       page:(NSString *)page
                       tpye:(NSString *)type;


@end
