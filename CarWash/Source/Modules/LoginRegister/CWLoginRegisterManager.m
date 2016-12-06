//
//  CWLoginRegisterManager.m
//  CarWash
//
//  Created by 赵林 on 16/7/2.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CWLoginRegisterManager.h"
#import "BZHttpManager.h"
#import "BZEventCenter.h"
#import "CWEventCenterType.h"
#import "CWLoginParam.h"
#import "CWHttpKit.h"
#import "DefineConstant.h"

@interface CWLoginRegisterManager()<BZHttpManagerDelegate>
@end
@implementation CWLoginRegisterManager
+(CWLoginRegisterManager *)sharedManager
{
    static CWLoginRegisterManager *sharedInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
        [[BZHttpManager sharedHttpManager]registerHttpManagerDelegate:sharedInstance];
    });
    return sharedInstance;
}

-(void)login:(NSString *)phone password:(NSString *)password
{
    CWLoginParam *param = [[CWLoginParam alloc]init];
    param.phone = phone;
    param.password = password;
    [[CWHttpKit sharedHttpKit]loginWithUrl:API_LOGIN andParam:param];
}

#pragma mark -- 自动登录
- (void)autoLogin:(NSString *)token {
    [CWHTTP autoLoginWithUrl:API_autoLogin token:token];
}

#pragma mark --忘记密码
-(void)forgetPassword:(NSString *)password
                phone:(NSString *)phone
              smsCode:(NSString *)code
                token:(NSString *)tokenString
{
//    忘记密码
    if (tokenString.length == 0) {
        [CWHTTP forgetPasswordWithUrl:API_forgetPassword password:password phone:phone smsCode:code token:@""];
    }
//    修改密码
    else {
        [CWHTTP forgetPasswordWithUrl:API_editPassword password:password phone:phone smsCode:code token:tokenString];
    }
    
    
   
}

#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    
    LC_HIDEN
    NSString *message = httpReponse.json[@"message"];
    switch (httpReponse.requestType) {
        //自动登录  message
        case HttpApiRequestTypeAutoLogin:
            
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeAutoLogin param:token mainTread:YES];
            }else {
               LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeAutoLoginFail param:httpReponse.error mainTread:YES];
            }
            break;
            
        //登录
        case HttpApiRequestTypeLogin:

            if (httpReponse.error.code == 0) {
//                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeLogin param:token mainTread:YES];
            }else {
               LCFAIL_ALERT(@"登录失败")

                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeLoginFail param:httpReponse.error mainTread:YES];
            }
            break;
        //忘记密码
        case HttpApiRequestTypeForgetPassword:
            
            if (httpReponse.error.code == 0) {
                LCSUCCESS_ALSERT(@"修改成功")
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeForgetPassword param:token mainTread:YES];
            }else {
                 LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeForgetPasswordFail param:httpReponse.error mainTread:YES];
            }
            break;
        default:
            break;
    }
}
@end
