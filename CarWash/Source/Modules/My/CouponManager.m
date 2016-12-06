//
//  CouponManager.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CouponManager.h"
#import "DefineConstant.h"
@interface CouponManager()<BZHttpManagerDelegate>
@end
@implementation CouponManager
+(CouponManager *)sharedManager
{
    static CouponManager *sharedInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
        [[BZHttpManager sharedHttpManager]registerHttpManagerDelegate:sharedInstance];
    });
    return sharedInstance;
}
#pragma mark -- 优惠劵列表
-(void)couponList:(NSString *)token;
{
    //SmscodeParam *param = [[SmscodeParam alloc]init];
    //param.phone = phone;
    //param.smsCodeType = smsType;
    [CWHTTP couponListWithUrl:API_COUPON_LIST andParam:nil];
}

#pragma mark -- 消费劵详情
- (void)consumerDetail:(NSString *)token consumer:(NSString *)conId {
    [CWHTTP consumDatilWithUrl:API_CONSUME_DETAIL consumID:conId];
}

#pragma mark -- 消费劵列表
-(void)consumeList:(NSString *)token {
    
    [CWHTTP consumeListWithUrl:API_CONSUME_LIST andParam:nil];
    
}

#pragma mark -- 附近商家
- (void)nearbyBusinesses:(NSString *)token longitude:(NSString *)lon latitude:(NSString *)lat count:(NSNumber *)countNumber page:(NSNumber *)page {
    
    NearbyBusinessesParam *nb = [[NearbyBusinessesParam alloc] init];
    nb.count = countNumber;
    nb.page = page;
    nb.longitude = lon;
    nb.latitude = lat;
    [CWHTTP nearBusinessWithUrl:API_NearbyBusinesses andParam:nb];
}

#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    switch (httpReponse.requestType) {
            //消费劵列表
        case HttpApiRequestTypeConsumeList:
           
            if (httpReponse.error.code == 0) {
                 LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeConsumeList param:token mainTread:YES];
            }else {
                LC_SHOW_FAIL(LOAD_FAIL)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeConsumeList_Fail param:httpReponse.error mainTread:YES];
            }
            break;
            
             //优惠劵列表
        case HttpApiRequestTypeCouponList:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCouponList param:token mainTread:YES];
            }else {
                LC_SHOW_FAIL(LOAD_FAIL)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCouponList_Fail param:httpReponse.error mainTread:YES];
            }
            break;
        
            //消费劵详情
        case HttpApiRequestTypeConsumeDetail:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeConsumeDetail param:token mainTread:YES];
            }else {
                LC_SHOW_FAIL(LOAD_FAIL)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeConsumeDetail_Fail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //附近商家
        case HttpApiRequestTypeNearbyBusinesses:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeNearBusiness param:token mainTread:YES];
            }else {
                LC_SHOW_FAIL(LOAD_FAIL)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeNearBusiness_Fail param:httpReponse.error mainTread:YES];
            }
            break;

        default:
            break;
    }
}
@end
