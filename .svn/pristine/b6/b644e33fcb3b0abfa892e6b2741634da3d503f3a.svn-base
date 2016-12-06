//
//  GetToken.m
//  CarWash
//
//  Created by xa on 16/8/23.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CDVGetData.h"
#import "DefineConstant.h"
#import "SharedHelper.h"
#import "CWMallViewController.h"
#import "CWLoginViewController.h"
@implementation CDVGetData
- (void)GetTokenAction:(CDVInvokedUrlCommand *)command{
    if (![COM respondsToSelector:@selector(getLoginToken)]) {
        
    }else{
    NSString *token = [COM getLoginToken];
        if (token.length == 0) {
            //跳转登陆界面
            
            CWMallViewController *viewControllre = (CWMallViewController *)[self getCurrentVC];
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
            CWLoginViewController *commonPayViewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
            UINavigationController *navigationController =
            [[UINavigationController alloc] initWithRootViewController:commonPayViewController];
            [viewControllre presentViewController:navigationController animated:YES completion:^{
                
            }];
        }else{
            CDVPluginResult* pluginResult = nil;
            
            if ([command.className isEqualToString:@"GetData"]) {
                if ([command.methodName isEqualToString:@"GetTokenAction"]) {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:token];
                    //[UIAlertView showSimpleAlert:@"获取token成功"];
                    NSLog(@"获取token测试%@",token);
                }
                
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }
}



#pragma mark ----- 获取当前的viewController
- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
        //        <span style="font-family: Arial, Helvetica, sans-serif;">//  这方法下面有详解    </span>
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        //        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        UINavigationController * nav = tabbar.selectedViewController; //上下两种写法都行
        
        result = nav;
        
        //                result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

@end
