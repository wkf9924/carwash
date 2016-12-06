//
//  CWWebViewController.h
//  CarWash
//
//  Created by 赵林 on 16/7/13.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVViewController.h>
@interface CWWebViewController : CDVViewController
@property(strong,nonatomic) UITabBar *tabBar;
@property(strong,nonatomic) UIView *rootView;
@end
