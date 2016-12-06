//
//  SelectCarSubViewController.m
//  CarWash
//
//  Created by xa on 16/7/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SelectCarSubViewController.h"
#import "SelectCarSubCell.h"
#import "DefineConstant.h"
#import "BindingVC.h"
#import "NetWorkingHelper.h"
#import "CarStyleModel.h"
#import "CarStyleSubModel.h"
#import "UIImageView+WebCache.h"


@interface SelectCarSubViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UILabel *sectionTitle;
@property (nonatomic, strong)NSMutableArray *datasource;
@end

@implementation SelectCarSubViewController

- (void)requestDate{
    NSString *url = [NSString stringWithFormat:@"http://mi.xcar.com.cn/interface/xcarapp/getSeriesByBrandId.php?brandId=%@",self.car_id];
    [NetWorkingHelper requestWithUrl:url requestType:GET requestParameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *array = responseObject[@"subBrands"];
        for (NSDictionary *dic in array) {
            CarStyleModel *model =[[CarStyleModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.datasource addObject:model];
        }
        NSLog(@"%@",self.datasource);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } error:^(id error) {
        
    } requestHeader:nil];
}
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
    self.title = self.brandName;
    [self setBackBarButton];
    [self requestDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--tableView 代理方法实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CarStyleModel *model = self.datasource[section];
    return model.seriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCarSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCarSubCell" forIndexPath:indexPath];
    
    CarStyleModel *model = self.datasource[indexPath.section];
    CarStyleSubModel *model_1 = model.seriesArray[indexPath.row];
    [cell.carImage sd_setImageWithURL:[NSURL URLWithString:model_1.seriesIcon]];
    cell.carStyle.text = model_1.seriesName;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerViewForSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    headerViewForSection.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    self.sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 30)];
    CarStyleModel *model = self.datasource[section];
    self.sectionTitle.text = model.subBrandName;
    [headerViewForSection addSubview:self.sectionTitle];
    return headerViewForSection;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CarStyleModel *model = self.datasource[indexPath.section];
    CarStyleSubModel *model_1 = model.seriesArray[indexPath.row];
    COM.seriesNameStr = model_1.seriesName;
    COM.seriesIcon = model_1.seriesIcon;
    [COM saveCarType:model_1.seriesName];
    POP_NAVIGATION_NUM(3);
}
- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource  = [[NSMutableArray alloc] init];
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
