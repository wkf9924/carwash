//
//  TodaySpecialViewController.m
//  CarWash
//
//  Created by WangKaifeng on 2016/10/27.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "TodaySpecialViewController.h"
#import "CWWebViewController.h"
#import "DefineConstant.h"
#import "Definition.h"
#import "TodaySpecialWebVC.h"

@interface TodaySpecialViewController ()
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property(strong,nonatomic) TodaySpecialWebVC *webViewController;
@end
@implementation TodaySpecialViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = [NSString stringWithFormat:@"index.html#/detail?id=%@", _ID];
    self.navigationController.navigationBar.hidden = YES;
    _webViewController = [[TodaySpecialWebVC alloc]init];
    _webViewController.tabBar = self.tabBarController.tabBar;
    _webViewController.rootView = _rootView;
    _webViewController.wwwFolderName = @"www";
    _webViewController.startPage = url;
    _webViewController.view.frame = self.rootView.frame;
    [_rootView addSubview:_webViewController.view];
    
}

@end
