//
//  TrafficDetailVC.m
//  CarWash
//
//  Created by xa on 2016/10/27.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "TrafficDetailVC.h"
#import "DefineConstant.h"

@interface TrafficDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *trafficContent;
@property (weak, nonatomic) IBOutlet UILabel *trafficAddress;
@property (weak, nonatomic) IBOutlet UILabel *trafficDate;
@property (weak, nonatomic) IBOutlet UILabel *trafficFen;
@property (weak, nonatomic) IBOutlet UILabel *trafficStatus;
@property (weak, nonatomic) IBOutlet UILabel *trafficMoney;

@end

@implementation TrafficDetailVC
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
    self.title = [COM getCarPlate];
    self.trafficFen.text = [NSString stringWithFormat:@"%@ 分", self.model.fen];
    self.trafficDate.text = self.model.date;
    self.trafficMoney.text = [NSString stringWithFormat:@"%@ 元", self.model.money];
    if ([self.model.handled isEqualToString:@"0"]) {
        self.trafficStatus.text = @"未处理";
    }else{
        self.trafficStatus.text = @"已处理";
    }
    
    self.trafficAddress.text = self.model.area;
    self.trafficContent.text = self.model.act;
    
    
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
