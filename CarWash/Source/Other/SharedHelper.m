//
//  SharedHelper.m
//  CarWash
//
//  Created by xa on 16/9/18.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SharedHelper.h"

@implementation SharedHelper
+ (SharedHelper *)sharedHelper{
    static SharedHelper *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SharedHelper alloc] init];
    });
    return shared;
}
- (void)sharedImageArray: (NSArray *)imageArray Text:(NSString *)text url:(NSURL *)url title:(NSString *)title{
//    imageArray = @[[UIImage imageNamed:@"二维码"]];//本地图片
//    imageArray = @[@"http://mob.com/Assets/images/logo.png?v=20150320"];//网络图片
    if (imageArray) {
        NSMutableDictionary *sharedParams = [NSMutableDictionary dictionary];
        [sharedParams SSDKSetupShareParamsByText:text images:imageArray url:url title:title type:SSDKContentTypeAuto];
        //设置简单分享菜单样式
        [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
        [ShareSDK showShareActionSheet:nil items:@[@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeSMS)] shareParams:sharedParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                    
                default:
                    break;
            }
        }];
    }
    
}
@end
