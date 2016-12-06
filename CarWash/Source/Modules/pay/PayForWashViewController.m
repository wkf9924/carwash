//
//  PayForWashViewController.m
//  CarWash
//
//  Created by xa on 16/7/26.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "PayForWashViewController.h"
#import "DefineConstant.h"
#import "PayManager.h"
#import "SelectCouponVC.h"
#import "PayPasswordCodeingVC.h"
#import "WXApi.h"

typedef enum : NSUInteger {
    weChatPay = 100,
    balancePay,
} payMethod;


@interface PayForWashViewController ()<SelectCouponVCDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *weChatSelected;
@property (weak, nonatomic) IBOutlet UIImageView *balanceSelected;
@property (strong, nonatomic) IBOutlet UILabel *originalPriceLabel;//原价
@property (strong, nonatomic) IBOutlet UILabel *afterDiscountLabel;//现价
@property (strong, nonatomic) IBOutlet UILabel *discountMoney;//抵用券价格
@property (weak, nonatomic) IBOutlet UIButton *selectCouponButton;//选择消费券按钮
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (nonatomic, assign)payMethod payMethodString;

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *ID;
@property (nonatomic, assign)NSInteger money;

@end

@implementation PayForWashViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden  = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    
    self.payMethodString = 100;
    self.title = @"支付中心";
    self.serviceNameLabel.text = self.serviceModel.name;
    self.originalPriceLabel.text = [NSString stringWithFormat:@"¥ %@",self.serviceModel.price];
    
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

- (IBAction)selectPrivilegeAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Pay" bundle:nil];
    SelectCouponVC *selectCoupon = [storyboard instantiateViewControllerWithIdentifier:@"SelectCouponVC"];
    
    [self.navigationController pushViewController:selectCoupon animated:YES];
    selectCoupon.delegate = self;
}
- (void)sendValue:(NSString *)name money:(NSInteger)money ID:(NSString *)ID{
    NSLog(@"代理传回带来的值:%@%ld%@",name,money,ID);
    self.name = name;
    self.money = money;
    self.ID = ID;
    
    
    self.discountMoney.text = [NSString stringWithFormat:@"¥ %ld",(long)self.money];
    [self.selectCouponButton setTitle:self.name forState:UIControlStateNormal];
    
}
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
//        LCSUCCESS_ALSERT(@"微信支付待集成");
    }else if (self.payMethodString == 101){
        PayPasswordCodeingVC *payPassword = [[PayPasswordCodeingVC alloc] init];
        payPassword.interface = self.interface;
        payPassword.couponID = self.ID;//优惠券ID
        payPassword.serviceID = self.serviceModel.ID;//服务ID
        payPassword.sellerID = self.sellerID;//商家ID
        payPassword.money = [NSString stringWithFormat:@"%d",([[self.originalPriceLabel.text substringFromIndex:2] intValue] - [[self.discountMoney.text substringFromIndex:2] intValue])];
        
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
