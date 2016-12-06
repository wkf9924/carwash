//
//  CommonPayViewController.m
//  CarWash
//
//  Created by xa on 16/7/26.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CommonPayViewController.h"
#import "DefineConstant.h"

#import "WXApi.h"



@interface CommonPayViewController ()<BZEventCenterDelegate>

@end

@implementation CommonPayViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeOrdersDetail callback:self];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeOrdersDetail callback:self];
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeOrdersDetail]) {
        NSLog(@"%@",param);
        self.weShouldPayLabel.text = [NSString stringWithFormat:@"%@ %.2f", @"¥",[param[@"service_price"] floatValue]];
        self.goodsPrice.text = [NSString stringWithFormat:@"%@ %.2f",@"¥", [param[@"service_price"] floatValue]];
    }
}

- (void)dismissViewController {
    [super dismissViewController];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.title = @"支付中心";
    self.payMethodString = 100;
    self.orderName.text = self.orderNameString;
    self.weShouldPayLabel.text = [NSString stringWithFormat:@"%@ %.2f", @"¥",[self.money floatValue]];
    self.goodsPrice.text = [NSString stringWithFormat:@"%@ %.2f",@"¥", [self.money floatValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)weChatPayAction:(UIButton *)sender {
    self.payMethodString = 100;
    self.weChatSelected.image =[UIImage imageNamed:@"形状-76"];
    self.balanceSelected.image = [UIImage imageNamed:@"形状-76-拷贝"];
}
- (IBAction)balancePayAction:(UIButton *)sender {
    self.payMethodString = 101;
    self.weChatSelected.image =[UIImage imageNamed:@"形状-76-拷贝"];
    self.balanceSelected.image = [UIImage imageNamed:@"形状-76"];
}
//支付按钮回调
- (IBAction)payButtonAction:(UIButton *)sender {
    if (self.payMethodString == 100) {
#pragma mark==//微信支付
        PayReq *request = [[PayReq alloc] init];
        /** 商家向财付通申请的商家id */
        request.partnerId = @"1220277201";
        /** 预支付订单 */
        request.prepayId= @"82010380001603250865be9c4c063c30";
        /** 商家根据财付通文档填写的数据和签名 */
        request.package = @"Sign=WXPay";
        /** 随机串，防重发 */
        request.nonceStr= @"lUu5qloVJV7rrJlr";
        /** 时间戳，防重发 */
        request.timeStamp= 1458893985;
        /** 商家根据微信开放平台文档对数据做的签名 */
        request.sign= @"b640c1a4565b476db096f4d34b8a9e71960b0123";
        [WXApi sendReq:request];
        LCSUCCESS_ALSERT(@"微信支付待集成");
    }else if (self.payMethodString == 101){
            PayPasswordCodeingVC *payPassword = [[PayPasswordCodeingVC alloc] init];
            payPassword.interface = self.interface;
            payPassword.Amount = [self.weShouldPayLabel.text substringFromIndex:2];
            payPassword.ordersId = self.ordersID;
//            payPassword.money = _money;
            [self.navigationController pushViewController:payPassword animated:YES];
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
