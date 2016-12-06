//
//  VIPTopUpVC.m
//  CarWash
//
//  Created by xa on 2016/11/10.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "VIPTopUpVC.h"
#import "VIPPayPasswordVC.h"
#import "DefineConstant.h"
@interface VIPTopUpVC ()
@property (weak, nonatomic) IBOutlet UILabel *VIPTopUpTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *VIPTopUpLabel;//会员充值类型 例如1年包
@property (weak, nonatomic) IBOutlet UILabel *money;//充值金额
@property (weak, nonatomic) IBOutlet UIImageView *weCahtPay;
@property (weak, nonatomic) IBOutlet UIImageView *blancePay;
@property (weak, nonatomic) IBOutlet UIImageView *topupSucceedView;
@property (weak, nonatomic) IBOutlet UIImageView *succeedView;
@property (weak, nonatomic) IBOutlet UIButton *suceedButton;

@end

@implementation VIPTopUpVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden= YES;
    if ([COM.VIPTopUpSucceed isEqualToString:@"充值成功"]) {
        self.topupSucceedView.hidden = NO;
        self.succeedView.hidden = NO;
        self.suceedButton.hidden = NO;
        COM.VIPTopUpSucceed = @"";
    }else{
        self.topupSucceedView.hidden = YES;
        self.succeedView.hidden = YES;
        self.suceedButton.hidden = YES;
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.money.text = [NSString stringWithFormat:@"¥ %.2f",self.price.floatValue];
    self.VIPTopUpLabel.text = self.VIPType;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//微信支付
- (IBAction)weChatPay:(id)sender {
    self.weCahtPay.image =[UIImage imageNamed:@"形状-76"];
    self.blancePay.image = [UIImage imageNamed:@"形状-76-拷贝"];
}
//余额支付
- (IBAction)blancePay:(id)sender {
    self.weCahtPay.image =[UIImage imageNamed:@"形状-76-拷贝"];
    self.blancePay.image = [UIImage imageNamed:@"形状-76"];
}
//立即支付
- (IBAction)pay:(id)sender {
    VIPPayPasswordVC *VIPPassword = [[VIPPayPasswordVC alloc] init];
    VIPPassword.price = self.price;
    VIPPassword.VIPType = self.VIPType;
    [self.navigationController pushViewController:VIPPassword animated:YES];
}
- (IBAction)backToVIPCenter:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    self.topupSucceedView.hidden = YES;
    COM.VIPTopUpSucceed = @"";
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
