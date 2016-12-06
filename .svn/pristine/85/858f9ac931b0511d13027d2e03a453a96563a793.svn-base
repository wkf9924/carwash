//
//  ConsumTicketDetailVC.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "ConsumTicketDetailVC.h"
#import "DefineConstant.h"
#import "ConsumeDetailModel.h"
#import "CarShopDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "QRCodeVC.h"
@interface ConsumTicketDetailVC () <BZEventCenterDelegate>
@property (weak, nonatomic) IBOutlet UIView *myHeaderView;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (nonatomic, strong)ConsumeDetailModel *consumeDetailModel;
@property (weak, nonatomic) IBOutlet UILabel *sellerName;//商家姓名
@property (weak, nonatomic) IBOutlet UILabel *sellerPhone;//商家电话

@end

@implementation ConsumTicketDetailVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeConsumeDetail callback:self];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeConsumeDetail callback:self];
    self.tabBarController.tabBar.hidden = NO;

}

#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    if([eventType isEqualToString:CWEventCenterTypeConsumeDetail]){
        NSLog(@"消费券详情%@",param);
        [self.consumeDetailModel setValuesForKeysWithDictionary:param];
        [self interfaceAssignmentOperation];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费券详情";
    [self setBackBarButton];
    [[CouponManager sharedManager] consumerDetail:@"" consumer:self.consumeModel.ID];
    
}
- (void)interfaceAssignmentOperation{
    self.sellerName.text = self.consumeDetailModel.sellername;
    self.sellerPhone.text = self.consumeDetailModel.servicetel;
    self.consumeName.text = self.consumeDetailModel.name;
    self.payAmount.text = [NSString stringWithFormat:@"¥ %.0f",round(self.consumeDetailModel.pay_amount)];
    self.originalPrice.text = [NSString stringWithFormat:@"¥ %.0f",round(self.consumeDetailModel.money)];
    self.couponMoney.text = [NSString stringWithFormat:@"¥ %.0f",[self.consumeDetailModel.couponmoney floatValue]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (ConsumeDetailModel *)consumeDetailModel{
    if (!_consumeDetailModel) {
        _consumeDetailModel = [[ConsumeDetailModel alloc]init];
    }
    return _consumeDetailModel;
}
- (IBAction)phoneButtonAction:(UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.sellerPhone.text];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (IBAction)showCodeButton:(UIButton *)sender {
    UIStoryboard *setingStoryBoard = [UIStoryboard storyboardWithName:@"QRCodeVC" bundle:nil];
    QRCodeVC *setingVC = [setingStoryBoard instantiateViewControllerWithIdentifier:@"QRCodeVC"];
    setingVC.orderID = self.consumeDetailModel.orderid;
    [self.navigationController pushViewController:setingVC animated:YES];

}
@end
