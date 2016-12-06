//
//  ScanPayViewController.m
//  CarWash
//
//  Created by xa on 16/7/26.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "ScanPayViewController.h"
#import "DefineConstant.h"
#import "PayPasswordCodeingVC.h"
@interface ScanPayViewController ()
@property (strong, nonatomic) IBOutlet UITextField *moneyTextFiled;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weChatSelected;
@property (weak, nonatomic) IBOutlet UIImageView *balanceSelected;


@end

@implementation ScanPayViewController
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
    self.title = @"扫描支付";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)weChatPayAction:(UIButton *)sender {
    self.weChatSelected.image =[UIImage imageNamed:@"形状-76"];
    self.balanceSelected.image = [UIImage imageNamed:@"形状-76-拷贝"];

//    self.weChatSelected.image =[UIImage imageNamed:@"形状-76-拷贝"];
//    self.balanceSelected.image = [UIImage imageNamed:@"形状-76"];
}
- (IBAction)balancePayAction:(UIButton *)sender {
    self.weChatSelected.image =[UIImage imageNamed:@"形状-76-拷贝"];
    self.balanceSelected.image = [UIImage imageNamed:@"形状-76"];
    
//    self.weChatSelected.image =[UIImage imageNamed:@"形状-76"];
//    self.balanceSelected.image = [UIImage imageNamed:@"形状-76-拷贝"];
}

#pragma mark ----- 立即支付按钮
- (IBAction)payButtonAction:(id)sender {
    
    if ([_tfPrice.text isEqualToString:@""]) {
        LCSUCCESS_ALSERT(@"输入的价格不能为空")
        return;
    }
    if ([_tfPrice.text isEqualToString:@"0"]) {
        LCSUCCESS_ALSERT(@"请输入正确的价格")
        return;
    }
    NSString *priceString = [_tfPrice.text substringToIndex:1] ;
    if ([priceString isEqualToString:@"0"]) {
        LCSUCCESS_ALSERT(@"请输入正确的价格")
        return;
    }
    PayPasswordCodeingVC *payPassword = [[PayPasswordCodeingVC alloc] init];
    payPassword.Accepter_userid = _Accepter_userid;
    payPassword.Amount = _moneyTextFiled.text;
    payPassword.interface = @"扫码支付";
    [self.navigationController pushViewController:payPassword animated:YES];
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
