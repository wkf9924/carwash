//
//  PreferentialCarWashVC.m
//  CarWash
//
//  Created by xa on 2016/10/13.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "PreferentialCarWashVC.h"
#import "BindSucceedCell.h"
#import "DefineConstant.h"
#import "CarBrandManager.h"
#import "UIImageView+WebCache.h"
#import "nearlySellerListModel.h"
#import "UILabel+FlickerNumber.h"
#import "CarShopDetailsViewController.h"
#import "CommonPayViewController.h"
#import "PayManager.h"
#import "OrdersListModel.h"

@interface PreferentialCarWashVC ()<UITableViewDelegate,UITableViewDataSource,BZEventCenterDelegate>
@property (strong, nonatomic) IBOutlet UIView *tableVIewHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIImageView *carLogo;
@property (weak, nonatomic) IBOutlet UILabel *carType;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation PreferentialCarWashVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeSellerList callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeSellerList_Fail callback:self];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeMyLoveCar callback:self];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeSellerList callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeSellerList_Fail callback:self];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeMyLoveCar callback:self];
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeMyLoveCar]) {
        NSLog(@"我的爱车详情数据:%@",param);
        NSString *mo = [NSString stringWithFormat:@"%.0f",[param[@"sys_price"] floatValue]];
        NSNumber *money = [NSNumber numberWithFloat:mo.floatValue];
        [self.money fn_setNumber:money formatter:nil];
        self.carType.text = param[@"car_plate"];
        [self.carLogo sd_setImageWithURL:[NSURL URLWithString:param[@"brand_logo"]] placeholderImage:[UIImage imageNamed:@"preferential_logo_bg_icon"]];
    }
    if ([eventType isEqualToString:CWEventCenterTypeSellerList]) {
        NSLog(@"%@",param);
        for (NSDictionary *dic in param) {
            nearlySellerListModel *model = [[nearlySellerListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.datasource addObject:model];
        }
        
        // 1、对数组按GroupTag排序
        NSMutableArray *dictArr = [NSMutableArray array];
        NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES]];
        NSArray *sortedArr = [self.datasource sortedArrayUsingDescriptors:sortDesc];
        NSLog(@"11排序后的数组:%@",sortedArr);
        
        for (int i = 0; i < sortedArr.count; i++) {
            NSDictionary *dict = sortedArr[i];
            [dictArr addObject:dict];
        }
        
        self.datasource = dictArr;

        
        [self.tableView reloadData];
    }else if ([eventType isEqualToString:CWEventCenterTypeSellerList_Fail]){
    }
    

}

- (void)alertControllerWith{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"去支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [action_1 setValue:[UIColor orangeColor] forKey:@"titleTextColor"];
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [action_2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alert addAction:action_1];
    [alert addAction:action_2];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.money.text = @"0";
    self.carType.text = @"陕A*****";
    self.carLogo.image = [UIImage imageNamed:@"绑定爱车图标"];
    self.tableView.tableHeaderView = self.tableVIewHeaderView;
    self.title = @"特惠洗车";
    
    [[CarBrandManager sharedManager] myLoveCar];
    
    //附近商家列表(我的爱车) longitude   latitude
    NSString *longitude = [COM getLongtude];
    NSString *latitude = [COM getLatitude];
    if ([longitude isEqualToString:@""] || longitude == nil || [latitude isEqualToString:@""] || latitude == nil) {
        longitude = @"";
        latitude = @"";
    }
#pragma mark--根据经纬度获取附近商家列表
    LC_LOADING
    [[CarBrandManager sharedManager] nearSellerInfolongitude:longitude latitude:latitude count:@10 page:@1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)payButtonAction:(UIButton *)sender {
    
    CommonPayViewController *commonPay = [[UIStoryboard storyboardWithName:@"Pay" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonPayVC"];
    commonPay.money = self.money.text;
    commonPay.interface = @"特惠立即支付";
    commonPay.orderNameString = self.title;
    [self.navigationController pushViewController:commonPay animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BindSucceedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BindSucceedCell" forIndexPath:indexPath];
    nearlySellerListModel *model = self.datasource[indexPath.row];
    cell.carStoreName.text = model.name;
    [cell.carStoreImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",API_SERVER_HOST,model.img_url]] placeholderImage:[UIImage imageNamed:@"默认图"]];
    cell.carStoreLocation.text = model.address;
    cell.carStoreDistance.text = [NSString stringWithFormat:@"%@公里",model.distance];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BindSucceed" bundle:nil];
    CarShopDetailsViewController *carShopDetailsVC = [storyboard instantiateViewControllerWithIdentifier:@"CarShopDetailsVC"]
    ;
    nearlySellerListModel *model = self.datasource[indexPath.row];
    carShopDetailsVC.sellerInfoId = model.ID;
    carShopDetailsVC.sellerName = model.name;
     
    [self.navigationController pushViewController:carShopDetailsVC animated:YES];
}
- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
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