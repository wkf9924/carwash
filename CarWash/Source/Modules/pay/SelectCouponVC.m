//
//  SelectCouponVC.m
//  CarWash
//
//  Created by xa on 2016/10/19.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SelectCouponVC.h"
#import "CouponsCell.h"
#import "DefineConstant.h"
#import "CouponListModel.h"
#import "CouponManager.h"


typedef enum : NSUInteger {
    coupon = 100,
    invalidCoupon,
} CouponButton;


@interface SelectCouponVC ()<UITableViewDelegate,UITableViewDataSource,BZEventCenterDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *couponButton;
@property (weak, nonatomic) IBOutlet UIButton *invalidCouponButton;
@property (weak, nonatomic) IBOutlet UIView *tableHeardView;
@property (weak, nonatomic) IBOutlet UIView *emptyStatusView;
@property (nonatomic, strong)NSMutableArray *datasource;
@property (nonatomic, strong) NSMutableArray *datasource_2;
@property (nonatomic, assign) CouponButton couponBtn;

@end

@implementation SelectCouponVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCouponList callback:self];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCouponList callback:self];
}
- (int)currentTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return  [dateString intValue];
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeCouponList]) {
        NSLog(@"%@",param);
        for (NSDictionary *dic in param) {
            NSString *dateString = [dic[@"end_time"] substringToIndex:10];
            NSLog(@"时间  年月日::%@",dateString);
            int date = [[dateString stringByReplacingOccurrencesOfString:@"" withString:@"-"] intValue];;
            int currentTime = [self currentTime];
            CouponListModel *model = [[CouponListModel alloc] init];
            if (date >= currentTime) {
                [model setValuesForKeysWithDictionary:dic];
                [self.datasource_2 addObject:model];
            }else{
                [model setValuesForKeysWithDictionary:dic];
                [self.datasource addObject:model];
            }
        
            
        }
        NSLog(@"数组中的元素个数::%ld    %ld",self.datasource_2.count,self.datasource.count);
        [self.tableView reloadData];
    }else{
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.title = @"选择优惠劵";
    self.couponBtn = 100;
    self.tableView.tableHeaderView = self.tableHeardView;
    [[CouponManager sharedManager] couponList:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--tableView代理方法实现
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponsCell" forIndexPath:indexPath];
    if (self.couponBtn == 100) {
        CouponListModel *model = self.datasource[indexPath.row];
        [cell setDataWithModel:model];
        return cell;
    }else{
        CouponListModel *model = self.datasource_2[indexPath.row];
        [cell setDataWithModel:model];
        return cell;
    }
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.couponBtn ==  100) {
        return self.datasource.count;
    }else{
        return self.datasource_2.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.view.frame.size.width - 20) * 193 / 584 + 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.couponBtn == 100) {
        CouponListModel *model = self.datasource[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(sendValue:money:ID:)]) {
            [self.delegate sendValue:model.name money:model.money ID:model.ID];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    }
    
    
}
- (IBAction)couponButtonAction:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"券类型被选中底色"] forState:UIControlStateNormal];
    [self.invalidCouponButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.couponBtn = 100;
    [self.tableView reloadData];
    
}
- (IBAction)invalidCouponButtonAction:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"券类型被选中底色"] forState:UIControlStateNormal];
    [self.couponButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.couponBtn = 101;
    [self.tableView reloadData];
}
- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}
- (NSMutableArray *)datasource_2{
    if (!_datasource_2) {
        _datasource_2 = [NSMutableArray array];
    }
    return _datasource_2;
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
