//
//  CWMallViewController.m
//  CarWash
//
//  Created by 赵林 on 16/7/11.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CWMallViewController.h"

#import "DefineConstant.h"
#import "Definition.h"

@interface CWMallViewController ()

@end

@implementation CWMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webViewController = [[CWWebViewController alloc]init];
    _webViewController.tabBar = self.tabBarController.tabBar;
    _webViewController.rootView = _rootView;
    _webViewController.wwwFolderName = @"www";
    _webViewController.startPage = @"index.html";
    _webViewController.view.frame = self.rootView.frame;
    [_rootView addSubview:_webViewController.view];
    
}
@end
