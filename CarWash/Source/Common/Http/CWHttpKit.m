//
//  HttpKit.m
//  IOSDemo
//
//  Created by behring on 15/8/29.
//  Copyright (c) 2015年 behring. All rights reserved.
//
#import "SQRHttpApi.h"
#import "CWHttpKit.h"
#import "BZHttpManager.h"
#import "BZHttpRequest.h"
#import "CWLoginParam.h"
#import "SQRUploadParam.h"
#import "SQRDownloadParam.h"
#import "DefineConstant.h"
#import "CWComment.h"
#import "SecretHelper.h"
#import "rechargeParam.h"
@interface CWHttpKit()
@property(nonatomic,strong) BZHttpManager *httpManager;
@end

@implementation CWHttpKit

+ (CWHttpKit *)sharedHttpKit
{
    static CWHttpKit *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.httpManager = [BZHttpManager sharedHttpManager];
    }
    
    return self;
}

/**
 *  创建requestId，用来区分各个网络请求
 *
 *  @return 以时间戳毫秒+2位随机数
 */
-(NSString *)createRequestId
{
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval=[date timeIntervalSince1970]*1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", timeInterval]; //转为字符型
    
    int random = arc4random() % 100;
    NSString *radomString = [NSString stringWithFormat:@"%02d", random]; //转为2位整数，不足2位前面补0
    
    return [NSString stringWithFormat:@"%@%@", timeString,radomString];
}

#pragma mark -- 获取token；
- (NSString *)getToken {
    NSString *tokenSting = [COM getLoginToken];
    if ([tokenSting isEqualToString:@""] || tokenSting == nil) {
        
        return @"";
        
    }
    return tokenSting;
}

#pragma mark - 上传下载接口

-(NSString *)downloadFileWithUrl:(NSString *)requestUrl andParam:(SQRDownloadParam *)param
{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeDownload;
    httpRequest.filePath = param.filePath;
    [self.httpManager downloadFileRequest:httpRequest];
    return requestId;
}

-(NSString *)uploadFileWithUrl:(NSString *)requestUrl andParam:(SQRUploadParam *)param
{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeUpload;
    httpRequest.filePath = param.filePathArray[0];
    httpRequest.imageData = param.imageData;
    httpRequest.pictureList = param.imageArray;
    NSDictionary *dict = @{
                           @"head_img" : @"",
                           @"token" : [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager uploadFileRequest:httpRequest];
    return requestId;
}

#pragma mark - 绑定车辆

-(NSString *)carBrandWithUrl:(NSString *)requestUrl andParam:(CarBrandParam *)param
{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
     NSString *toke = [self getToken];
    // 请求类型
    httpRequest.requestType = HttpApiRequestTypeBindingMyCar;

    NSDictionary *dict = @{
                           @"carBrand" : param.carBrand,
                           @"carNumber" : param.carNumber,
                           @"carType" : param.carType,
                           @"carLogo" : param.carLogo,
                           @"carmodel" : param.carmodel,
                           @"carFrameNum":param.carFrameNum,
                           @"engine_number":param.engine_number,
                           @"city":param.city,
                           @"token" :toke,
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 自动登录
- (NSString *)autoLoginWithUrl:(NSString *)requestUrl token:(NSString *)loginToken {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeAutoLogin;
    NSDictionary *dict = @{
                           @"Appid" :APPID,
                           @"token" : loginToken
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;

}

#pragma mark - 登录

-(NSString *)loginWithUrl:(NSString *)requestUrl andParam:(CWLoginParam *)param
{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeLogin;
    NSDictionary *dict = @{@"Appid" :APPID,
                           @"phone" : param.phone,
                           @"password" : param.password
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 忘记密码 修改密码
-(NSString *)forgetPasswordWithUrl:(NSString *)requestUrl password:(NSString *)password phone:(NSString *)phone smsCode:(NSString *)code token:(NSString *)tokenString {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeForgetPassword;
    NSString *tokenStr = [self getToken];
    NSDictionary *dict;
//    忘记密码
    if (tokenString.length == 0) {
        dict = @{
                 @"phone" : phone,
                 @"password" :password,
                 @"sms_code" :code
                 };
    }
//    修改密码
    else {
        dict = @{
                 @"phone" : phone,
                 @"password" :password,
                 @"sms_code" :code,
                 @"token" : tokenStr
                 };
    }
   
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 注册接口
-(NSString *)registerWithUrl:(NSString *)requestUrl andParam:(RegisterParam *)param {
    
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeRegister;
    NSDictionary *dict = @{
                           @"phone":param.phone,
                           @"password":param.password,
                           @"sms_code":param.vercode,
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 获取验证码

-(NSString *)smsCodeWithUrl:(NSString *)requestUrl andParam:(SmscodeParam *)param {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSmsCode; //提交时那个请求
    NSDictionary *dict = @{
                           @"phone":param.phone,
                           @"sms_code_type":param.smsCodeType,
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 获取今日特惠列表

-(NSString *)discountWithUrl:(NSString *)requestUrl andParam:(DiscountParam *)param {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeDiscount; //提交时那个请求
     NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"count":param.count,
                           @"page":param.page,
                           @"token":toke
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 消费劵列表
-(NSString *)consumeListWithUrl:(NSString *)requestUrl andParam:( ConsumeParam *)param {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeConsumeList; //提交时那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{@"token" : toke};
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
    
    
}

#pragma mark -- 优惠劵列表
-(NSString *)couponListWithUrl:(NSString *)requestUrl andParam:(CouponParam *)param  {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeCouponList; //提交时那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{@"token" : toke};
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
    
    
}

#pragma mark --  消费劵详情

-(NSString *)consumDatilWithUrl:(NSString *)requestUrl consumID:(NSString *)consumID {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeConsumeDetail; //提交时那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{@"token" : toke, @"id" : consumID};
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 附近商家
-(NSString *)nearBusinessWithUrl:(NSString *)requestUrl andParam:(NearbyBusinessesParam *)param {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeNearbyBusinesses; //提交时那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"count" : param.count,
                           @"lag" : param.latitude,
                           @"lng" : param.longitude,
                           @"page" : param.page
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 我的爱车
-(NSString *)myLoveCarWithUrl:(NSString *)requestUrl {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeMyLoveCar; //提交时那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{@"token" : toke};
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
    
}

#pragma mark -- 点击附近商家后的商家详情
-(NSString *)sellerInfoWithUrl:(NSString *)requestUrl sellInfoId:(NSString *)infoId {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeMySellerInfo; //提交时那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"id" : infoId
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 附近商家列表（我的爱车）
-(NSString *)sellerListWithUrl:(NSString *)requestUrl andParam:(SellerListParam *)param {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSellerList; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"count" : param.count,
                           @"lag" : param.latitude,
                           @"lng" : param.longitude,
                           @"page" : param.page
                           };
    
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 商家服务列表（打蜡，洗车）
-(NSString *)sellerServiceListWithUrl:(NSString *)requestUrl andParam:(NSString *)sid {
    
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSellerServiceList; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"id" : sid,
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
    
}

#pragma mark -- 商家服务详情，比如打蜡洗车详情
-(NSString *)sellerServiceInfotWithUrl:(NSString *)requestUrl andParam:(NSString *)sid {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSellerServiceLInfo; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"id" : sid
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
    
}

#pragma mark --  按地区获取商家信息
-(NSString *)washAreaSellerListWithUrl:(NSString *)requestUrl andParam:(AreaWashParam *)areaWash;
{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeAreaWashSellerlist; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"area" : areaWash.area,
                           @"count" : areaWash.count,
                           @"lag" : areaWash.latitude,
                           @"lng" : areaWash.longtude,
                           @"page" : areaWash.page
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma mark -- 编辑个人资料
-(NSString *)editAccountWithUrl:(NSString *)requestUrl name:(NSString *)name sex:(NSString *)sex {
    
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypePersonalInfo; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"name" : name,
                           @"sex" : sex
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
    
}

#pragma mark -- 商家服务城市列表
-(NSString *)sellerServiceCityListWithUrl:(NSString *)requestUrl  city:(NSString *)city {
    
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSellerServiceCityList; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"city" : city
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

/**
 *  编辑车辆信息
 */
-(NSString *)editCarInfoWithUrl:(NSString *)requestUrl  carinfo:(MyLoveCarParam *)carInfo {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeEditCarInfo; //提交是那个请求
    NSString *toke = [self getToken];
    /*
     @property (nonatomic, copy) NSString *carType; //车牌型号
     @property (nonatomic, copy) NSString *carFrameNum; //查询城市
     @property (nonatomic, copy) NSString *carmodel; //车辆唯一标识
     */
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"carBrand" : carInfo.carBrand,
                           @"carLogo" : carInfo.carLogo,
                           @"carNumber" : carInfo.carNumber,
                           @"carType" : carInfo.carType,
                           @"engine_number" : carInfo.engine_number,
                           @"carmodel" : carInfo.carmodel,
                           @"carFrameNum" : carInfo.carFrameNum
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
/**
 *  查询城市编码
 */
-(NSString *)searchCityCodeWithUrl:(NSString *)requestUrl city:(NSString *)city province_code:(NSString *)province_code{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeCityCode; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"province_code" : province_code,
                           @"city" : city
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

/**
 *  查询违章
 */
-(NSString *)QueryViolationWithUrl:(NSString *)requestUrl cityCode:(NSString *)cityCode carFrameNum:(NSString *)carFrameNum carNumber:(NSString *)carNumber engine_number:(NSString *)engine_number{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeQueryViolation; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"carFrameNum" : carFrameNum,
                           @"carNumber" : carNumber,
                           @"city_code" : cityCode,
                           @"engine_number" : engine_number
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
/**
 *  车辆详情
 */
-(NSString *)carInfoWithUrl:(NSString *)requestUrl  carId:(NSString *)carId {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeCarInfo; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"id": carId
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;

}
/**
 *  我的收藏
 */
- (NSString *)myColectListWithUrl:(NSString *)requestUrl count:(NSString *)count page:(NSString *)page{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeMyCollectList; //提交是那个请求
    NSString *toke = [self getToken];
    NSDictionary *dict = @{
                           @"token" : toke,
                           @"count": count,
                           @"page":page
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}


#pragma mark - 发现模块
//获取文章列表
-(NSString *)getArticleListWithUrl:(NSString *)requestUrl page:(int)page count:(int)count {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeGetArticleList;
    NSDictionary *dict = @{
                           @"page" : @(page),
                           @"count": @(count)
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    
    return requestId;
}
//获取文章详情
-(NSString *)getArticleDetailWithUrl:(NSString *)requestUrl articleId:(NSString *)articleId {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeGetArticleDetail;
    NSDictionary *dict = @{
                           @"id" : articleId,
                           @"token": [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

//获取文章评论列表
-(NSString *)getArticleCommentsWithUrl:(NSString *)requestUrl articleId:(NSString *)articleId page:(int)page count:(int)count {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeGetArticleComments;
    NSDictionary *dict = @{
                           @"id" : articleId,
                           @"page" : @(page),
                           @"count": @(count)
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

//评论文章
-(NSString *)sendCommentWithUrl:(NSString *)requestUrl comment:(CWComment *)comment {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSendComment;
    NSDictionary *dict = @{
                           @"id" : comment.articleId,
                           @"eva_content": comment.content,
                           @"token": [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
//收藏或取消收藏
-(NSString *)sendCollectStatusWithUrl:(NSString *)requestUrl articleId:(NSString *)articleId isCollect:(Boolean)isCollect {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSendCollectStatus;
    NSDictionary *dict = @{
                           @"id" : articleId,
                           @"collection_type": isCollect?@(1):@(2),
                           @"token": [self getToken]
                           };
    httpRequest.paramsDict = dict;
    httpRequest.transParamsDict = @{@"is_collect":@(isCollect)};
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
//收藏或取消收藏
-(NSString *)sendLikeStatusWithUrl:(NSString *)requestUrl articleId:(NSString *)articleId isLike:(Boolean)isLike{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSendLikeStatus;
    NSDictionary *dict = @{
                           @"id" : articleId,
                           @"like_type": isLike?@(1):@(2),
                           @"token": [self getToken]
                           };
    httpRequest.paramsDict = dict;
    httpRequest.transParamsDict = @{@"is_like":@(isLike)};
    [self.httpManager postRequest:httpRequest];
    return requestId;
}


//更改支付密码
-(NSString *)replacepaypasswordWithUrl:(NSString *)requestUrl
                      ancient_password:(NSString *)ancient_password
                                 appid:(NSString *)appid
                              password:(NSString *)password
                       confirmPassword:(NSString *)confirmPassword
                                userid:(NSString *)userid
                             verifyKey:(NSString *)verifyKey {
    
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeReplacepaypassword;
    
    NSString *dicStirng = [NSString stringWithFormat:@"Ancient_password=%@&Appid=%@&Password=%@&confirmPassword=%@&userid=%@",ancient_password,APPID,password,confirmPassword,userid];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    NSDictionary *dict = @{
                           @"Ancient_password" : ancient_password,
                           @"Appid": appid,
                           @"Password": password,
                           @"confirmPassword": confirmPassword,
                           @"userid": userid,
                           @"verifyKey": mdString,
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;

}


//支付交易
-(NSString *)paymentWithUrl:(NSString *)requestUrl param:(PaymentParam *)param {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypePayment;
    NSString *dicStirng = [NSString stringWithFormat:@"Accepter_userid=%@&Amount=%@&Appid=%@&CardNo=%@&description=%@&Password=%@&PaymentType=%@&userid=%@",param.accepter_userid,param.amount,APPID,param.cardNo,param.descriptions,param.password,param.paymentType,param.userid];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    NSDictionary *dict = @{
                           @"Accepter_userid" : param.accepter_userid,
                           @"Amount": param.amount,
                           @"Appid": param.appid,
                           @"CardNo": param.cardNo,
                           @"Password": param.password,
                           @"PaymentType": param.paymentType,
                           @"description": param.descriptions,
                           @"userid": param.userid,
                           @"verifyKes": mdString,
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

//查询余额
-(NSString *)getAmountWithUrl:(NSString *)requestUrl appid:(NSString *)appid
                       userid:(NSString *)userid
                    verifyKey:(NSString *)verifyKey {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeGetAmount;
    
    NSString *dicStirng = [NSString stringWithFormat:@"Appid=%@&userid=%@",APPID,userid];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    NSDictionary *dict = @{
                           @"Appid" : appid,
                           @"userid": userid,
                           @"verifyKey": mdString
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
//注册
-(NSString *)accountAccessWithUrl:(NSString *)requestUrl appid:(NSString *)appid
                     customerType:(NSString *)customerType
                           userid:(NSString *)userid
                        verifyKey:(NSString *)verifyKey {
    
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeAccountAccess;
    //wkf
    NSString *dicStirng = [NSString stringWithFormat:@"Appid=%@&CustomerType=0&userid=%@",APPID,userid];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    NSDictionary *dict = @{
                           @"Appid": appid,
                           @"CustomerType": customerType,
                           @"userid" : userid,
                           @"verifyKey": mdString
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
    
}

//绑定银行卡
-(NSString *)bindCardWithUrl:(NSString *)requestUrl param:(BindCard *)param {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeBindCard;
    //wkf
    NSString *dicStirng = [NSString stringWithFormat:@"Appid=%@&Bank_cellphone=%@&CardNo=%@&IdName=%@&IdNo=%@&Password=%@&userid=%@",APPID,param.Bank_cellphone, param.CardNo, param.IdName, param.IdNo, param.password, param.userid];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    NSDictionary *dict = @{@"Appid":param.Appid,
                           @"Bank_cellphone":param.Bank_cellphone,
                           @"CardNo":param.CardNo,
                           @"IdName":param.IdName,
                           @"IdNo":param.IdNo,
                           @"Password":param.password,
                           @"userid" :param.userid,
                           @"verifyKey":mdString};
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
//充值
-(NSString *)rechargeWithUrl:(NSString *)requestUrl rechargeMode:(rechargeParam *)param{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeRecharge;
    //wkf
    NSString *dicStirng = [NSString stringWithFormat:@"Amount=%@&Appid=%@&CardNo=%@&Password=%@&userid=%@", param.Amount,APPID, param.CardNo, param.Password, param.userid];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    NSDictionary *dict = @{@"Appid":param.Appid,
                           @"Amount":param.Amount,
                           @"CardNo":param.CardNo,
                           @"Password":param.Password,
                           @"userid" :param.userid,
                           @"verifyKey":mdString};
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
//提现
-(NSString *)withdrawWithUrl:(NSString *)requestUrl rechargeMode:(WithdrawParam *)param{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeWithdraw;
    //wkf
    NSString *dicStirng = [NSString stringWithFormat:@"Amount=%@&Appid=%@&CardNo=%@&Password=%@&userid=%@",param.Amount,APPID, param.CardNo, param.Password, param.userid];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString]lowercaseString];
    NSDictionary *dict = @{
                           @"Appid":param.Appid,
                           @"Amount":param.Amount,
                           @"CardNo":param.CardNo,
                           @"Password":param.Password,
                           @"userid" :param.userid,
                           @"verifyKey":mdString
                           };
    
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
//绑定银行卡查询
-(NSString *)bindCardListWithUrl:(NSString *)requestUrl
                           appid:(NSString *)appid
                          userId:(NSString *)userId
                       verifyKey:(NSString *)verifyKey {
    
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeBindCardList;
    NSString *dicStirng = [NSString stringWithFormat:@"Appid=%@&userid=%@",APPID,userId];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    NSDictionary *dict = @{
                           @"Appid" : appid,
                           @"userid": userId,
                           @"verifyKey": mdString,
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

//解绑银行卡
-(NSString *)unbundlingCardWithUrl:(NSString *)requestUrl
                           appid:(NSString *)appid
                          userId:(NSString *)userId
                       verifyKey:(NSString *)verifyKey
                          CardNo:(NSString *)CardNo
                        Password:(NSString *)Password {
    
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeunBundlingCard;
    NSString *dicStirng = [NSString stringWithFormat:@"Appid=%@&CardNo=%@&Password=%@&userid=%@",APPID,CardNo,Password, userId];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    
    NSDictionary *dict = @{
                           @"Appid" : APPID,
                           @"userid": userId,
                           @"verifyKes": mdString,
                           @"CardNo": CardNo,
                           @"Password": Password,
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

//设置支付密码
-(NSString *)payPasswordWithUrl:(NSString *)requestUrl
                          appid:(NSString *)appid
                         userId:(NSString *)userId
                      verifyKey:(NSString *)verifyKey
                confirmPassword:(NSString *)confirmPassword
                       Password:(NSString *)Password;{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypepayPassword;
    NSString *dicStirng = [NSString stringWithFormat:@"Appid=%@&Password=%@&confirmPassword=%@&userid=%@",APPID,Password,confirmPassword,userId];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    NSDictionary *dict = @{
                           @"Appid" : appid,
                           @"confirmPassword": confirmPassword,
                           @"Password": Password,
                           @"userid": userId,
                           @"verifyKey": mdString,
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}


//Appid	客户系统在支付平台申请所得的身份标识	string
//EndTime	结束时间	string
//Password	支付密码	string
//StartTime	开始时间	string
//TradeType	交易类型	string	0：支付:1：退款:2：提现:3：充值
//count	一次请求返回的记录条数	string	非必填，默认返回10条
//page	返回结果的页码，默认为1	string	非必填
//userid	客户系统用户标识	string
//verifyKey

//交易记录查询
-(NSString *)transactionRecordWithUrl:(NSString *)requestUrl
                                param:(TransactionRecordParam *)param {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeTransactionRecord;
    NSDictionary *dict = @{
                           @"Appid" : param.Appid,
                           @"userid": param.userid,
                           @"verifyKes": param.verifyKey,
                           @"EndTime": param.EndTime,
                           @"StartTime": param.StartTime,
                           @"count": param.count,
                           @"page": param.page,
                           @"TradeType" : param.TradeType,
                           @"Password": param.Password,
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}


//验证手机号 银行卡绑定的手机号
-(NSString *)validationWithUrl:(NSString *)requestUrl
                         phone:(NSString *)phone
                       smsCode:(NSString *)smsCode {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSendValidation;
    NSDictionary *dict = @{@"phone" : phone,@"sms_code": smsCode};
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
    
}

//验证手机号 银行卡绑定的手机号
-(NSString *)authCodeWithUrl:(NSString *)requestUrl
                       phone:(NSString *)phone {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeSendAuthCode;
    NSDictionary *dict = @{@"phone" : phone};
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;

}

/**
 *  特惠立即支付
 *  sys_price 系统优惠价格
 */

//RCP
-(NSString *)couponPayWithUrl:(NSString *)requestUrl
                    sys_price:(NSString *)sys_price password:(NSString *)password {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeCouponPay;
    NSDictionary *dict = @{@"sys_price" : sys_price,
                           @"password" : password,
                           @"appid" : APPID,
                           @"token" : [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
/**
 *
 *服务订单列表
 */
-(NSString *)ordersListWithUrl:(NSString *)requestUrl count:(NSNumber *)count page:(NSNumber *)page sellerid:(NSString *)sellerId status:(NSString *)status {
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeOrdersList;
    NSDictionary *dict = @{@"count" : count,
                           @"page" : page,
                           @"sellerid" : sellerId,
                           @"status" : status,
                           @"token" : [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
/**
 *
 *  服务订单详情
 */
- (NSString *)ordersListWithUrl:(NSString *)requestUrl ordersId:(NSString *)ordersId{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeOrdersDetail;
    NSDictionary *dict = @{@"id" : ordersId,
                           @"token" : [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

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
                         price:(NSString *)price
{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeServicePay;
    NSDictionary *dict = @{@"coupon_id" : coupon_id,
                           @"service_id" : service_id,
                           @"accepter_appid" : APPID,
                           @"accepter_userid" : accepter_userid,
                           @"appid" : APPID,
                           @"password" : password,
                           @"price" : price,
                           @"token" : [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
/**
 *我的订单服务立即支付
 */
- (NSString *)ordersPayWithUrl:(NSString *)requestUrl ordersId:(NSString *)ordersId accepter_appid:(NSString *)accepter_appid accepter_userid:(NSString *)accepter_userid coupon_id:(NSString *)coupon_id password:(NSString *)password service_id:(NSString *)service_id type:(NSString *)type price:(NSString *)price{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeOrdersPay;
    NSDictionary *dict = @{@"id" : ordersId,
                           @"accepter_appid" : accepter_appid,
                           @"accepter_userid" : accepter_userid,
                           @"appid" : APPID,
                           @"coupon_id" : coupon_id,
                           @"password" : password,
                           @"price" : price,
                           @"service_id" : service_id,
                           @"type" : type,
                           @"token" : [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

/**
 * 用户扫描商家二维码付款
 *
 */
-(NSString *)rcodePayWithUrl:(NSString *)requestUrl
              Accepter_Appid:(NSString *)Accepter_Appid
             Accepter_userid:(NSString *)Accepter_userid
                      Amount:(NSString *)Amount
                       Appid:(NSString *)Appid
                    Password:(NSString *)Password {
    
    
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeRcodePay;
    NSDictionary *dict = @{@"Accepter_Appid" : Accepter_Appid,
                           @"Accepter_userid" : Accepter_userid,
                           @"Amount" : Amount,
                           @"Appid" : Appid,
                           @"Password" : Password,
                           @"token" : [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
/**
 * 查询用户余额和银行卡数量
 *
 */
-(NSString *)quaryBankCardCountAndBalanceWithUrl:(NSString *)requestUrl{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeQuaryBankCarCuontAndBalance;
    NSDictionary *dict = @{
                           @"Appid" : APPID,
                           @"token" : [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}
/**
 * 查询消费券数量
 *
 */
-(NSString *)quaryCouponCountWithUrl:(NSString *)requestUrl{
    NSString *requestId = [self createRequestId];
    BZHttpRequest *httpRequest = [BZHttpRequest httpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeQuaryCouponCount;
    NSDictionary *dict = @{
                           @"token" : [self getToken]
                           };
    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

#pragma --mark 用户账单查询
-(NSString *)transactionListWithUrl:(NSString *)requestUrl
                              count:(NSString *)count
                               page:(NSString *)page {
    
    NSString *userID = [COM getUserId];
    NSString *requestId = [self createRequestId];
    //支付
    BZHttpRequest *httpRequest = [BZHttpRequest payHttpRequestWithPartUrl:requestUrl];
    httpRequest.requestId = requestId;
    httpRequest.requestType = HttpApiRequestTypeTransactionList;
    NSString *dicStirng = [NSString stringWithFormat:@"Appid=%@&count=%@&page=%@&type=%@&userid=%@",APPID,@"10", @"1",@"0",userID];
    
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    NSDictionary *dict = @{@"Appid" : APPID,
                          @"count" : @"10",
                          @"page" : @"1",
                          @"type" : @"0",
                          @"userid" : userID,
                          @"verifyKey" : mdString
                          };

    httpRequest.paramsDict = dict;
    [self.httpManager postRequest:httpRequest];
    return requestId;
}

@end
