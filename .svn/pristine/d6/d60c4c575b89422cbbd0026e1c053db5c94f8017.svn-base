//
//  HttpKit.h
//  IOSDemo
//
//  Created by behring on 15/8/29.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CarBrandParam.h"
#import "SQRShopInfo.h"

@class CWLoginParam,SQRDownloadParam,SQRUploadParam,NearbyBusinessesParam;
#import "SmscodeParam.h"
#import "RegisterParam.h"
#import "DiscountParam.h"
#import "CarBrandParam.h"
#import "CouponParam.h"
#import "ConsumDetailParam.h"
#import "ConsumeParam.h"
#import "NearbyBusinessesParam.h"
#import "SellerListParam.h"
#import "AreaWashParam.h"
#import "MyLoveCarParam.h"
#import "WithdrawParam.h"
#import "PaymentParam.h"
#import "BindCard.h"
#import "TransactionRecordParam.h"
#import "rechargeParam.h"

#define CWHTTP [CWHttpKit sharedHttpKit]
@class CWComment;
@interface CWHttpKit : NSObject
+ (CWHttpKit *)sharedHttpKit;

#pragma mark - 上传下载相关接口
-(NSString *)downloadFileWithUrl:(NSString *)requestUrl andParam:(SQRDownloadParam *)param;
-(NSString *)uploadFileWithUrl:(NSString *)requestUrl andParam:(SQRUploadParam *)param;

#pragma mark - 登录
-(NSString *)loginWithUrl:(NSString *)requestUrl andParam:(CWLoginParam *)param;

/**
 *  忘记密码
 */
-(NSString *)forgetPasswordWithUrl:(NSString *)requestUrl password:(NSString *)password phone:(NSString *)phone smsCode:(NSString *)code token:(NSString *)tokenString;

/**
 *  注册
 */
-(NSString *)registerWithUrl:(NSString *)requestUrl andParam:(RegisterParam *)param;

/**
 *  自动登录
 */
- (NSString *)autoLoginWithUrl:(NSString *)requestUrl token:(NSString *)loginToken;



/**
 *  获取验证码
 */
-(NSString *)smsCodeWithUrl:(NSString *)requestUrl andParam:(SmscodeParam *)param;
/**
 *  今日特惠
 */
-(NSString *)discountWithUrl:(NSString *)requestUrl andParam:(DiscountParam *)param;
/**
 *  绑定车辆
 */
-(NSString *)carBrandWithUrl:(NSString *)requestUrl andParam:(CarBrandParam *)param;

/**
 *   消费劵列表
 */
-(NSString *)consumeListWithUrl:(NSString *)requestUrl andParam:( ConsumeParam *)param;

/**
 *   优惠劵列表
 */
-(NSString *)couponListWithUrl:(NSString *)requestUrl andParam:(CouponParam *)param;

/**
 *   消费劵详情
 */
-(NSString *)consumDatilWithUrl:(NSString *)requestUrl consumID:(NSString *)consumID;

/**
 *  附近商家
 */
-(NSString *)nearBusinessWithUrl:(NSString *)requestUrl andParam:(NearbyBusinessesParam *)param;
/**
 *  我的爱车
 */
-(NSString *)myLoveCarWithUrl:(NSString *)requestUrl;

/**
 *  点击附近商家后显示的详情
 */
-(NSString *)sellerInfoWithUrl:(NSString *)requestUrl sellInfoId:(NSString *)infoId;

/**
 *  附近商家列表
 */
-(NSString *)sellerListWithUrl:(NSString *)requestUrl andParam:(SellerListParam *)param;
/**
 *  商家的服务列表（比如洗车打蜡等服务）
 */
-(NSString *)sellerServiceListWithUrl:(NSString *)requestUrl andParam:(NSString *)sid;

/**
 *  商家的服务详情  比如洗车详情，打蜡详情
 */
-(NSString *)sellerServiceInfotWithUrl:(NSString *)requestUrl andParam:(NSString *)sid;

/**
 *  按地区获取商家信息
 */
-(NSString *)washAreaSellerListWithUrl:(NSString *)requestUrl andParam:(AreaWashParam *)areaWash;

/**
 *  编辑个人资料
 */
-(NSString *)editAccountWithUrl:(NSString *)requestUrl name:(NSString *)name sex:(NSString *)sex;

/**
 *  商家服务的城市
 */
-(NSString *)sellerServiceCityListWithUrl:(NSString *)requestUrl  city:(NSString *)city;


/**
 *  编辑车辆信息
 */
-(NSString *)editCarInfoWithUrl:(NSString *)requestUrl  carinfo:(MyLoveCarParam *)carInfo;

/**
 *  车辆详情
 */
-(NSString *)carInfoWithUrl:(NSString *)requestUrl  carId:(NSString *)carId;

/**
 *  提现
 */
-(NSString *)withdrawWithUrl:(NSString *)requestUrl rechargeMode:(WithdrawParam *)param;

/**
 *  充值
 */
-(NSString *)rechargeWithUrl:(NSString *)requestUrl rechargeMode:(rechargeParam *)param;

#pragma mark - 发现模块
//获取文章列表
-(NSString *)getArticleListWithUrl:(NSString *)requestUrl page:(int)page count:(int)count;
//获取文章详情
-(NSString *)getArticleDetailWithUrl:(NSString *)requestUrl articleId:(NSString *)articleId;
//获取文章评论列表
-(NSString *)getArticleCommentsWithUrl:(NSString *)requestUrl articleId:(NSString *)articleId page:(int)page count:(int)count;
//评论文章
-(NSString *)sendCommentWithUrl:(NSString *)requestUrl comment:(CWComment *)comment;
//收藏或取消收藏
-(NSString *)sendCollectStatusWithUrl:(NSString *)requestUrl articleId:(NSString *)articleId isCollect:(Boolean)isCollect;
-(NSString *)sendLikeStatusWithUrl:(NSString *)requestUrl articleId:(NSString *)articleId isLike:(Boolean)isLike;
//我的收藏列表
- (NSString *)myColectListWithUrl:(NSString *)requestUrl count:(NSString *)count page:(NSString *)page;

#pragma mark - 支付模块
//更改支付密码
-(NSString *)replacepaypasswordWithUrl:(NSString *)requestUrl
                      ancient_password:(NSString *)ancient_password
                                 appid:(NSString *)appid
                              password:(NSString *)password
                       confirmPassword:(NSString *)confirmPassword
                                userid:(NSString *)userid
                             verifyKey:(NSString *)verifyKey;


//支付交易
-(NSString *)paymentWithUrl:(NSString *)requestUrl param:(PaymentParam *)param;
//余额查询
-(NSString *)getAmountWithUrl:(NSString *)requestUrl appid:(NSString *)appid
                       userid:(NSString *)userid
                    verifyKey:(NSString *)verifyKey;

//注册
-(NSString *)accountAccessWithUrl:(NSString *)requestUrl appid:(NSString *)appid
                     customerType:(NSString *)customerType
                           userid:(NSString *)userid
                        verifyKey:(NSString *)verifyKey;

//绑定银行卡
-(NSString *)bindCardWithUrl:(NSString *)requestUrl param:(BindCard *)param;
//绑定银行卡查询
-(NSString *)bindCardListWithUrl:(NSString *)requestUrl
                           appid:(NSString *)appid
                          userId:(NSString *)userId
                       verifyKey:(NSString *)verifyKey;
//解绑银行卡
-(NSString *)unbundlingCardWithUrl:(NSString *)requestUrl
                           appid:(NSString *)appid
                          userId:(NSString *)userId
                       verifyKey:(NSString *)verifyKey
                          CardNo:(NSString *)CardNo
                        Password:(NSString *)Password;


//设置支付密码
-(NSString *)payPasswordWithUrl:(NSString *)requestUrl
                          appid:(NSString *)appid
                         userId:(NSString *)userId
                      verifyKey:(NSString *)verifyKey
                confirmPassword:(NSString *)confirmPassword
                       Password:(NSString *)Password;

//交易记录查询
-(NSString *)transactionRecordWithUrl:(NSString *)requestUrl
                                param:(TransactionRecordParam *)param;

//验证手机号 银行卡绑定的手机号
-(NSString *)validationWithUrl:(NSString *)requestUrl
                         phone:(NSString *)phone
                       smsCode:(NSString *)smsCode;

//验证手机号 银行卡绑定的手机号
-(NSString *)authCodeWithUrl:(NSString *)requestUrl
                       phone:(NSString *)phone;
/**
 *  特惠立即支付
 *  sys_price 系统优惠价格
 */

//RCP
-(NSString *)couponPayWithUrl:(NSString *)requestUrl
                    sys_price:(NSString *)sys_price
                     password:(NSString *)password;

/**
 *  购买服务立即支付
 *  coupon_id	优惠劵唯一标示
 *  service_id 服务唯一标示
 */
-(NSString *)servicePayWithUrl:(NSString *)requestUrl
                     coupon_id:(NSString *)coupon_id
                    service_id:(NSString *)service_id
               accepter_userid:(NSString *)accepter_userid
                      password:(NSString *)password
                         price:(NSString *)price;

/**
 * 用户扫描商家二维码付款
 *  
 */
-(NSString *)rcodePayWithUrl:(NSString *)requestUrl
               Accepter_Appid:(NSString *)Accepter_Appid
              Accepter_userid:(NSString *)Accepter_userid
                       Amount:(NSString *)Amount
                        Appid:(NSString *)Appid
                     Password:(NSString *)Password;

/**
 * 查询城市编码
 *
 */
-(NSString *)searchCityCodeWithUrl:(NSString *)requestUrl city:(NSString *)city province_code:(NSString *)province_code;

/**
 *  查询违章
 */
-(NSString *)QueryViolationWithUrl:(NSString *)requestUrl cityCode:(NSString *)cityCode carFrameNum:(NSString *)carFrameNum carNumber:(NSString *)carNumber engine_number:(NSString *)engine_number;
/**
 *  服务订单列表
 */
-(NSString *)ordersListWithUrl:(NSString *)requestUrl count:(NSNumber *)count page:(NSNumber *)page sellerid:(NSString *)sellerId status:(NSString *)status;
/**
 *  服务订单详情
 */
-(NSString *)ordersListWithUrl:(NSString *)requestUrl ordersId:(NSString *)ordersId;

/**
 *我的订单服务立即支付
 */
- (NSString *)ordersPayWithUrl:(NSString *)requestUrl ordersId:(NSString *)ordersId accepter_appid:(NSString *)accepter_appid accepter_userid:(NSString *)accepter_userid coupon_id:(NSString *)coupon_id password:(NSString *)password service_id:(NSString *)service_id type:(NSString *)type price:(NSString *)price;
/**
 *查询银行卡数量和账户余额
 */
-(NSString *)quaryBankCardCountAndBalanceWithUrl:(NSString *)requestUrl;
/**
 *查询消费券数量
 */
-(NSString *)quaryCouponCountWithUrl:(NSString *)requestUrl;


/**
 *查询用户账单详情
 */
-(NSString *)transactionListWithUrl:(NSString *)requestUrl
                              count:(NSString *)count
                               page:(NSString *)page;



@end
