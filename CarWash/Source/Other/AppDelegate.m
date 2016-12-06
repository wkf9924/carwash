//
//  AppDelegate.m
//  CarWash
//
//  Created by 赵林 on 16/7/2.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "AppDelegate.h"
#import "Definition.h"
#import "DefineConstant.h"
#import "CCLocationManager.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "MyDelegate.h"

#import "hDisplayView.h"
#import "Common.h"

#define MainScreen_width  [UIScreen mainScreen].bounds.size.width//宽
#define MainScreen_height [UIScreen mainScreen].bounds.size.height//高

@interface AppDelegate () <CLLocationManagerDelegate,WXApiDelegate>
{
    CCLocationManager *_locationManager;
    
}

@property (assign, nonatomic) id<MyDelegate> delegate;
@end

@implementation AppDelegate
- (void)sharedSDKWork{
    /** 123fec92c8198  796dd89ed49dd5cc9e0f445620dae959
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    
    
    [ShareSDK registerApp:@"123fec92c8198" activePlatforms:@[@(SSDKPlatformTypeSMS),@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline),
        @(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
                 
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"3844208367" appSecret:@"a21073f24752f9e53a91bc1bfdf7cb7e" redirectUri:@"http://www.baidu.com" authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx65d5b5579fc01470" appSecret:@"9c1c5113434817805d320bd5ce70e313"];
                 break;
             default:
                 break;
         }
     }];
    
    [WXApi registerApp:@"wx65d5b5579fc01470"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    /**
     可以在这里进行一个判断的设置，如果是app第一次启动就加载启动页，如果不是，则直接进入首页
     **/
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次
        
        hDisplayView *hvc = [[hDisplayView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)];
        
        [self.window.rootViewController.view addSubview:hvc];
        
        [UIView animateWithDuration:0.25 animations:^{
            hvc.frame = CGRectMake(0, 0, MainScreen_width, MainScreen_height);
            
        }];
        
    }
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self sharedSDKWork];
    if (IS_IOS8) {
        [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            CGFloat longtude = locationCorrrdinate.longitude;
            CGFloat lat = locationCorrrdinate.latitude;
            NSString *lonString = [NSString stringWithFormat:@"%f",longtude];
            NSString *latString = [NSString stringWithFormat:@"%f",lat];
            [COM  saveLongtude:lonString];
            [COM saveLatitude:latString];
            NSLog(@"纬度%f  经度%f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
            
        }];
    } 
    return YES;
}


- (NSString *)firstCharacterWithString:(NSString *)string{
    NSMutableString * str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString * pingyin = [str capitalizedString];
    return [pingyin substringFromIndex:1];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}
#pragma mark==微信支付返回结果
- (void)onResp:(BaseResp *)resp{
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg = [NSString stringWithFormat:@"支付结果"];
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            break;
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)test {
    
}
@end
