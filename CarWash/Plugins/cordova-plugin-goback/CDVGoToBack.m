//
//  CDVGoToBack.m
//  CarWash
//
//  Created by WangKaifeng on 2016/10/27.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CDVGoToBack.h"
#import "DefineConstant.h"
#import "SharedHelper.h"
#import "TodaySpecialViewController.h"
#import "CWWebViewController.h"
@implementation CDVGoToBack
- (void)GoToBackAction:(CDVInvokedUrlCommand*)command {
//    CWWebViewController *viewController = (CWWebViewController *)self.viewController;
//    TodaySpecialViewController *today = viewController.superclass;
//    [today.navigationController popViewControllerAnimated:YES];
    NSLog(@"back测试");
    
    
    TodaySpecialViewController *today = (TodaySpecialViewController *)[self getCurrentVC];
    today.navigationController.navigationBar.hidden = NO;
    [today.navigationController popViewControllerAnimated:YES];
}

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
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

@end
