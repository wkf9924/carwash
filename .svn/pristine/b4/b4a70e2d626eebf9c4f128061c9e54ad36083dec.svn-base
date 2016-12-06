//
//  SpecialManager.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/8.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SpecialManager.h"
#import "BZHttpManager.h"
#import "BZEventCenter.h"
#import "CWEventCenterType.h"
#import "SpecialParam.h"
#import "CWHttpKit.h"
@interface SpecialManager()<BZHttpManagerDelegate>
@end
@implementation SpecialManager

+(SpecialManager *)sharedManager
{
    static SpecialManager *sharedInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
        [[BZHttpManager sharedHttpManager]registerHttpManagerDelegate:sharedInstance];
    });
    return sharedInstance;
}

-(void)login:(NSString *)phone password:(NSString *)password
{
   SpecialParam  *param = [[SpecialParam alloc]init];
    //param.phone = phone;
    //param.password = password;
    //[[CWHttpKit sharedHttpKit]loginWithUrl:API_LOGIN andParam:param];
}


#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    switch (httpReponse.requestType) {
        case HttpApiRequestTypeLogin:
            if (!httpReponse.error) {
                NSString *token = httpReponse.json[@"result"][@"token"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSpecial param:token mainTread:YES];
            }else {
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSpecialFail param:httpReponse.error mainTread:YES];
            }
            break;
        default:
            break;
    }
}


@end
