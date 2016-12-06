//
//  BindBankCardUserDelegateVC.m
//  CarWash
//
//  Created by xa on 2016/10/31.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "BindBankCardUserDelegateVC.h"
#import "DefineConstant.h"

@interface BindBankCardUserDelegateVC ()

@end

@implementation BindBankCardUserDelegateVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.title = @"用户服务协议";
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
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
