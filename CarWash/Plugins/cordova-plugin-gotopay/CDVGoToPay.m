//
//  CDVGoToPay.m
//  CarWash
//
//  Created by WangKaifeng on 2016/10/28.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CDVGoToPay.h"
#import "CommonPayViewController.h"
#import "Common.h"
#import "TodaySpecialViewController.h"
#import "CWMallViewController.h"
@implementation CDVGoToPay
- (void)GoToPayAction:(CDVInvokedUrlCommand*)command {

    
    NSString *orderid = [NSString stringWithFormat:@"%@", [command.arguments objectAtIndex:0]]; //商家id
    NSString *Amount = [NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:1]]; //价格
    if ([orderid isEqualToString:@"<null>"] || [Amount isEqualToString:@"<null>"]) {
        return;
    }
    
    CWMallViewController *viewControllre = (CWMallViewController *)[self getCurrentVC];
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Pay" bundle:nil];
    CommonPayViewController *commonPayViewController = [storyboard instantiateViewControllerWithIdentifier:@"CommonPayVC"];
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:commonPayViewController];
    commonPayViewController.ordersID = orderid;
    commonPayViewController.money = Amount;
    
    commonPayViewController.interface = @"车商城";
    commonPayViewController.orderNameString = @"商品金额";
    COM.popView = @"carShop";
    [viewControllre presentViewController:navigationController animated:YES completion:^{
        
    }];
    
//    [viewControllre.navigationController pushViewController:navigationController animated:YES];
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
