//
//  CDVShared.m
//  CarWash
//
//  Created by xa on 16/9/18.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CDVShared.h"
#import "DefineConstant.h"
#import "SharedHelper.h"
@implementation CDVShared
- (void)sharedAction:(CDVInvokedUrlCommand *)command{
    
    CDVPluginResult* pluginResult = nil;
    NSString *imageurl = [command.arguments objectAtIndex:0];
    NSString *title = [command.arguments objectAtIndex:1];
    NSString *url = [command.arguments objectAtIndex:2];
    
    NSArray *imageArray = @[[UIImage imageNamed:@"二维码"]];//本地图片
    if (imageurl != nil && title != nil && url != nil) {
        [[SharedHelper sharedHelper] sharedImageArray:imageArray Text:@"" url:[NSURL URLWithString:@"www.baidu.com"] title:title];
    } else {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end
