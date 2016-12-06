//
//  MyBankCardDetailViewController.m
//  CarWash
//
//  Created by xa on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyBankCardDetailViewController.h"
#import "DefineConstant.h"
#import "PayManager.h"
#import "PasswordViewController.h"
@interface MyBankCardDetailViewController ()

@end

@implementation MyBankCardDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    UIColor *color = [UIColor lightGrayColor];
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage imageNamed:@"更多icon"]
                                     highlightedImage:nil
                                               titles:nil
                                                alpha:0.3f
                                                color:color
                                               target:self
                                               action:@selector(addaddressAction:)
                                     forControlEvents:UIControlEventTouchUpInside];
}
- (void)addaddressAction:(UIBarButtonItem *)sender{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"解除绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { 
        PasswordViewController *pass = [[PasswordViewController alloc] init];
        pass.interface = @"解绑";
        pass.cardNum = self.cardNumber;
        [self.navigationController pushViewController:pass animated:YES];
        
    }];
    [action_1 setValue:[UIColor redColor] forKey:@"titleTextColor"];
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertcontroller addAction:action_1];
    [alertcontroller addAction:action_2];
    [self presentViewController:alertcontroller animated:YES completion:nil];
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
