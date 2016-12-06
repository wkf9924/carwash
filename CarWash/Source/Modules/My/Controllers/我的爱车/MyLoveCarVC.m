//
//  MyLoveCarVC.m
//  CarWash
//
//  Created by xa on 2016/10/14.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyLoveCarVC.h"
#import "DefineConstant.h"
#import "EditMyCarViewController.h"
#import "CarBrandManager.h"
#import "MyLoveCarModel.h"
#import "UIImageView+WebCache.h"
#import "TrafficListVC.h"
#import "CWLoginViewController.h"
#import "TrafficViolationViewController.h"

@interface MyLoveCarVC ()
@property (weak, nonatomic) IBOutlet UIImageView *carLogo;
@property (weak, nonatomic) IBOutlet UILabel *carBrand;
@property (weak, nonatomic) IBOutlet UILabel *carDetailType;
@property (weak, nonatomic) IBOutlet UILabel *carPlate;
@property (nonatomic, strong) MyLoveCarModel *myloveCarModel;
@property (nonatomic, strong) NSString *car_id;
@end

@implementation MyLoveCarVC
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
    self.title = @"我的爱车";
    [self.carLogo sd_setImageWithURL:[NSURL URLWithString:[COM getCarImage]] placeholderImage:nil];
    self.carBrand.text = [COM getCarsName];
    self.carPlate.text = [COM getCarPlate];
    self.carDetailType.text = [COM getCarModel];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0], NSFontAttributeName,[UIColor blackColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
}
- (void)rightBarButtonItemAction{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"EditMyLoveCar" bundle:nil];
    EditMyCarViewController *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditMyCarViewController"];
    [self.navigationController pushViewController:editVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark  我的爱车 查询违章;
- (IBAction)trafficViolation:(UIButton *)sender {
    if ([COM getLoginToken]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TrafficViolation" bundle:nil];
        if ([COM cityCode]) {
            TrafficListVC *traffic = [storyboard instantiateViewControllerWithIdentifier:@"TrafficListVC"];
            [self.navigationController pushViewController:traffic animated:YES];
        }else{
            TrafficViolationViewController *trafficViolationVC = [storyboard instantiateViewControllerWithIdentifier:@"TrafficViolationViewController"];
            [self.navigationController pushViewController:trafficViolationVC animated:YES];
        }
        
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"login"]
        ;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
    
    
}
-(MyLoveCarModel *)myLoveCarModel{
    if (!_myloveCarModel) {
        _myloveCarModel = [[MyLoveCarModel alloc] init];
    }
    
    return _myloveCarModel;
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
