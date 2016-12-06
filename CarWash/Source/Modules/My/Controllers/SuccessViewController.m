//
//  GetCashSuccessViewController.m
//  CarWash
//
//  Created by xa on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SuccessViewController.h"
#import "MyWalletViewController.h"
#import "DefineConstant.h"
@interface SuccessViewController ()

@end

@implementation SuccessViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (IBAction)successButton:(UIButton *)sender {
    
    POP_NAVIGATION_NUM(4)
}

- (void)popViewController {
     POP_NAVIGATION_NUM(4)
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBackBarButton];
    if ([self.successtitle isEqualToString:@"提现成功"]) {
        self.successTitle.text = self.successtitle;
        self.moneyTransferCount.text = [NSString stringWithFormat:@"%.2f", [self.getCashCount floatValue]];
    }else if ([self.successtitle isEqualToString:@"充值成功"]){
        self.successTitle.text = self.successtitle;
        self.moneyTransferCount.text = [NSString stringWithFormat:@"%.2f", [self.getCashCount floatValue]];
    }
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
