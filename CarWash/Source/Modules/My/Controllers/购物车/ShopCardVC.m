//
//  ShopCardVC.m
//  CarWash
//
//  Created by WangKaifeng on 2016/10/11.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "ShopCardVC.h"
#import "CWWebViewController.h"
#import "DefineConstant.h"
#import "Definition.h"
#import "ShopWebVC.h"
@interface ShopCardVC ()
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property(strong,nonatomic) ShopWebVC* webViewController;
@end

@implementation ShopCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
    _webViewController = [[ShopWebVC alloc]init];
    _webViewController.tabBar = self.tabBarController.tabBar;
    _webViewController.rootView = _rootView;
    _webViewController.wwwFolderName = @"www";
    _webViewController.startPage = @"index.html#/my-car";
    _webViewController.view.frame = self.rootView.frame;
    [_rootView addSubview:_webViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
