//
//  PreferentialCarWashVC.m
//  CarWash
//
//  Created by xa on 2016/10/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "PreferentialDetailCarWashVC.h"
#import "DefineConstant.h"
#import "ConsumeDetailModel.h"
#import "nearlySellerListModel.h"
#import "CarShopDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "ConsumTicketCell.h"
#import "QRCodeVC.h"

@interface PreferentialDetailCarWashVC ()<UITableViewDelegate, UITableViewDataSource, BZEventCenterDelegate>
@property (weak, nonatomic) IBOutlet UILabel *sellerNameLabel;//店铺名称
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;//价格
@property (weak, nonatomic) IBOutlet UIView *tableHeadeView;
@property (weak, nonatomic) IBOutlet UITableView *tableView_1;

@property (nonatomic, strong)ConsumeDetailModel *consumeDetailModel;
@property (nonatomic, strong)NSMutableArray *nearlySellerData;

@end

@implementation PreferentialDetailCarWashVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeConsumeDetail callback:self];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeNearBusiness callback:self];
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeConsumeDetail callback:self];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeNearBusiness callback:self];
    self.tabBarController.tabBar.hidden = NO;
    
}
#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    if([eventType isEqualToString:CWEventCenterTypeConsumeDetail]){
        NSLog(@"消费券详情::%@",param);
        [self.consumeDetailModel setValuesForKeysWithDictionary:param];
        
    } else if([eventType isEqualToString:CWEventCenterTypeNearBusiness]){
        NSLog(@"附近商家%@",param);
        for (NSDictionary *dic in param) {
            nearlySellerListModel *model = [[nearlySellerListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.nearlySellerData addObject:model];
        }
        [self.tableView_1 reloadData];
    }
    
    [self interfaceAssignmentOperation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费券详情";
    [self setBackBarButton];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView_1.tableHeaderView = self.tableHeadeView;
    
    
    self.sellerNameLabel.text = @"洗洋洋";

    [self nearBusinessLoading];
}
- (void)interfaceAssignmentOperation{
    self.moneyLabel.text = [NSString stringWithFormat:@"¥ %.0f",round(self.consumeDetailModel.pay_amount)];
}
#pragma mark -- 附近商家
- (void)nearBusinessLoading {
    
    [[CouponManager sharedManager]  nearbyBusinesses:@"" longitude:@"" latitude:@"" count:@(10) page:@(1)];
    [[CouponManager sharedManager] consumerDetail:@"" consumer:self.consumeModel.ID];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nearlySellerData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConsumTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsumTicketCell" forIndexPath:indexPath];
    nearlySellerListModel *model = self.nearlySellerData[indexPath.row];
    NSString *imageURL = [NSString stringWithFormat:@"%@%@/%@",@"http://",API_SERVER_HOST,model.img_url];
    [cell.imagev sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"洗车店门头"]];
    cell.titLabel.text =model.name;
    cell.addressLabel.text = model.address;
    if (model.distance.length == 0) {
        cell.lbKil.text = model.distance;
    }else{
        cell.lbKil.text = [NSString stringWithFormat:@"%@ 公里", model.distance];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BindSucceed" bundle:nil];
    CarShopDetailsViewController *carShopDetailsVC = [storyboard instantiateViewControllerWithIdentifier:@"CarShopDetailsVC"]
    ;
    nearlySellerListModel *model = self.nearlySellerData[indexPath.row];
    carShopDetailsVC.sellerInfoId = model.ID;
    [self.navigationController pushViewController:carShopDetailsVC animated:YES];
}
- (ConsumeDetailModel *)consumeDetailModel{
    if (!_consumeDetailModel) {
        _consumeDetailModel = [[ConsumeDetailModel alloc]init];
    }
    return _consumeDetailModel;
}
- (NSMutableArray *)nearlySellerData{
    if (!_nearlySellerData) {
        _nearlySellerData = [[NSMutableArray alloc] init];
    }
    return _nearlySellerData;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showCodeButton:(UIButton *)sender {
    UIStoryboard *setingStoryBoard = [UIStoryboard storyboardWithName:@"QRCodeVC" bundle:nil];
    QRCodeVC *setingVC = [setingStoryBoard instantiateViewControllerWithIdentifier:@"QRCodeVC"];
    setingVC.orderID = self.consumeDetailModel.orderid;
    setingVC.startTime = self.consumeDetailModel.createdate;
    setingVC.endTime = self.consumeDetailModel.enddate;
    [self.navigationController pushViewController:setingVC animated:YES];
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
