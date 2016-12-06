//
//  MyAddressViewController.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/18.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyAddressViewController.h"
#import "CWWebViewController.h"
#import "DefineConstant.h"
#import "Definition.h"
#import "MyAddressVC.h"
@interface MyAddressViewController ()
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property(strong,nonatomic) MyAddressVC* webViewController;
@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
    _webViewController = [[MyAddressVC alloc]init];
    _webViewController.tabBar = self.tabBarController.tabBar;
    _webViewController.rootView = _rootView;
    _webViewController.wwwFolderName = @"www";
    _webViewController.startPage = @"index.html#/address-my";
    _webViewController.view.frame = self.rootView.frame;
    [_rootView addSubview:_webViewController.view];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
