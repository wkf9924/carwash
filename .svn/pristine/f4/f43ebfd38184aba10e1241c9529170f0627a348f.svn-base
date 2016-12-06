//
//  TrafficListVC.m
//  CarWash
//
//  Created by xa on 2016/10/27.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "TrafficListVC.h"
#import "DefineConstant.h"
#import "TrafficListCell.h"
#import "TrafficDetailModel.h"
#import "CarBrandManager.h"
#import "TrafficDetailVC.h"

@interface TrafficListVC ()<UITableViewDelegate,UITableViewDataSource,BZEventCenterDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *datasource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewheight;

@end

@implementation TrafficListVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeQueryViolation callback:self];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeQueryViolation callback:self];
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeQueryViolation]) {
        NSLog(@"查询违章结果:%@",param);
        for (NSDictionary *dic in param) {
            TrafficDetailModel *model = [[TrafficDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.datasource addObject:model];
        }
        self.tableViewheight.constant = self.datasource.count * 63;
        [self.tableView reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [COM getCarPlate];
    [self setBackBarButton];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[CarBrandManager sharedManager] QueryViolationWithCityCode:[COM cityCode] carFrameNum:[COM getCarFrameNum] carNumber:[COM getCarPlate] engine_number:[COM getCarEngineNum]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TrafficListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrafficListCell" forIndexPath:indexPath];
    TrafficDetailModel *model = self.datasource[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TrafficViolation" bundle:nil];
    TrafficDetailVC *trafficDetail = [storyboard instantiateViewControllerWithIdentifier:@"TrafficDetailVC"];
    trafficDetail.model = self.datasource[indexPath.row];
    [self.navigationController pushViewController:trafficDetail animated:YES];
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
