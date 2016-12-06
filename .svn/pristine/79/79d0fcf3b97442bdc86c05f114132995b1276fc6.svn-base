//
//  GetToken.m
//  CarWash
//
//  Created by xa on 16/8/23.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "GetData.h"
#import "DefineConstant.h"

@implementation GetData
- (void)GetTokenAction:(CDVInvokedUrlCommand *)command token:(NSString *)token{
    CDVPluginResult* pluginResult = nil;
    token = [COM getLoginToken];
    NSLog(@"获取token测试");
        if ([command.className isEqualToString:@"GetData"]) {
            if ([command.methodName isEqualToString:@"GetToken"]) {
                 pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:token];
                 [UIAlertView showSimpleAlert:@"获取token成功"];
            }
           
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end
