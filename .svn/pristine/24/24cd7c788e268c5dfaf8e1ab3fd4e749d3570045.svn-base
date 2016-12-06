//
//  SmsManager.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/19.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SmsManager.h"
@interface SmsManager()<BZHttpManagerDelegate>
@end
@implementation SmsManager
+(SmsManager *)sharedManager
{
    static SmsManager *sharedInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
        [[BZHttpManager sharedHttpManager]registerHttpManagerDelegate:sharedInstance];
    });
    return sharedInstance;
}

-(void)sms:(NSString *)phone  smsTypeCode:(NSString *)smsType
{
    SmscodeParam *param = [[SmscodeParam alloc]init];
    param.phone = phone;
    param.smsCodeType = smsType;
    [CWHTTP smsCodeWithUrl:API_SMSCODE andParam:param];
}


#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    switch (httpReponse.requestType) {
        case HttpApiRequestTypeSmsCode:
            LC_HIDEN
            if (httpReponse.error.code == 0) {
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSmscode param:token mainTread:YES];
            }else {
                LC_SHOW_FAIL(httpReponse.json[@"message"])
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSmscodeFail param:httpReponse.error mainTread:YES];
            }
            break;
        default:
            break;
    }
}
@end
