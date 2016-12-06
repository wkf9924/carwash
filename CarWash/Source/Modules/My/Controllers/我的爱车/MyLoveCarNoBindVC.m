//
//  MyLoveCarNoBindVC.m
//  CarWash
//
//  Created by xa on 2016/10/15.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyLoveCarNoBindVC.h"
#import "DefineConstant.h"
#import "BindingVC.h"
#import "EditMyCarViewController.h"
#import "TrafficListVC.h"
#import "CWLoginViewController.h"
#import "TrafficViolationViewController.h"
@interface MyLoveCarNoBindVC ()

@end

@implementation MyLoveCarNoBindVC
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//绑定爱车按钮回调
- (IBAction)bindCarButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"EditMyLoveCar" bundle:nil];
    EditMyCarViewController *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditMyCarViewController"];
    [self.navigationController pushViewController:editVC animated:YES];
}
#pragma mark  查询违章
- (IBAction)trafficViolation:(UIButton *)sender {
    if ([COM getLoginToken]) {
        if ([COM getCarID]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TrafficViolation" bundle:nil];
            if ([COM cityCode]) {
                TrafficListVC *traffic = [storyboard instantiateViewControllerWithIdentifier:@"TrafficListVC"];
                [self.navigationController pushViewController:traffic animated:YES];
            }else{
                TrafficViolationViewController *trafficViolationVC = [storyboard instantiateViewControllerWithIdentifier:@"TrafficViolationViewController"];
                [self.navigationController pushViewController:trafficViolationVC animated:YES];
            }
        }else{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"EditMyLoveCar" bundle:nil];
            EditMyCarViewController *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditMyCarViewController"];
            [self.navigationController pushViewController:editVC animated:YES];
        }
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"login"]
        ;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
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
