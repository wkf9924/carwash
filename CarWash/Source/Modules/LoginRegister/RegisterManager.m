//
//  RegisterManager.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/7.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "RegisterManager.h"


@interface RegisterManager()<BZHttpManagerDelegate>
@end

@implementation RegisterManager

+(RegisterManager *)sharedManager
{
    static RegisterManager *sharedInstance;
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


#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    switch (httpReponse.requestType) {
        case HttpApiRequestTypeRegister:
            if (httpReponse.error.code == 0) {
               LC_HIDEN
                NSString *token = httpReponse.json[@"result"][@"token"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeRegister param:token mainTread:YES];
            }else {
                LC_SHOW_FAIL(LOAD_FAIL)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeRegisterFail param:httpReponse.error mainTread:YES];
            }
            break;
        default:
            break;
    }
}


@end
