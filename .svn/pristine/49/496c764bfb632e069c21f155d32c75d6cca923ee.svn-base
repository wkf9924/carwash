//
//  PaySucceedVC.m
//  CarWash
//
//  Created by xa on 2016/10/17.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "PaySucceedVC.h"
#import "DefineConstant.h"
#import "MyCouponsViewController.h"

@interface PaySucceedVC ()

@end

@implementation PaySucceedVC
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
    [self.navigationItem setHidesBackButton:YES];
    self.title = @"支付成功";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//订单详情
- (IBAction)orderDetailButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyCoupons" bundle:nil];
    MyCouponsViewController *myCoupons = [storyboard instantiateViewControllerWithIdentifier:@"MyCoupons"];
    [self.navigationController pushViewController:myCoupons animated:YES];
}
//返回首页
- (IBAction)backToFirstInterface:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
