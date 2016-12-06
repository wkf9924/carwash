//
//  WashTheCarViewController.m
//  CarWash
//
//  Created by xa on 16/7/25.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "WashTheCarViewController.h"
#import "DefineConstant.h"
#import "WashCarCell.h"
#import "CarBrandManager.h"

#import "WashTheCarModel.h"
#import "CarShopDetailsViewController.h"
#import "CityCountModel.h"
#import "VIPCarVC.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface WashTheCarViewController ()<BZEventCenterDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BOOL _isSort; //是否根据距离排序
}
@property (nonatomic, assign)BOOL buttonType;
@property (nonatomic, strong)NSMutableArray *datasource;
@property (nonatomic, strong)NSMutableArray *cityDatasource;
@property (nonatomic, assign)BOOL isSortFirstClick;
@property (nonatomic, assign)BOOL isLocationFirstClick;
@end

@implementation WashTheCarViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeAreaWashSellerList callback:self];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeSellerServiceCityList callback:self];

    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeSellerList callback:self];
    
    _isSort = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeAreaWashSellerList callback:self];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeSellerServiceCityList callback:self];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeSellerList callback:self];
}

#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param {
    NSLog(@"地区列表:%@",param);
    if([eventType isEqualToString:CWEventCenterTypeAreaWashSellerList]){
        
//        [self.datasource removeAllObjects];
        
        self.datasource = param;
//        for (NSDictionary *dic in param) {
//            WashTheCarModel *model = [[WashTheCarModel alloc]init];
//            [model setValuesForKeysWithDictionary:dic];
//            [self.datasource addObject:model];
//        }
        [self.mainTableview reloadData];
    }else if ([eventType isEqualToString:CWEventCenterTypeSellerServiceCityList]){
        [self.cityDatasource removeAllObjects];
        NSLog(@"取列表%@",param);
        for (NSDictionary *dic in param) {
            CityCountModel *model = [[CityCountModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.cityDatasource addObject:model];
        }
        [self.subTableView reloadData];
    }
    
    //初始化数据查询的是西安市全部数据
    if([eventType isEqualToString:CWEventCenterTypeSellerList]){
        self.datasource = param;
        
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
        
        [self.mainTableview reloadData];
    }
}
#pragma mark -- 排序按钮回调(离我最近)
- (IBAction)sortButtonAction:(UIButton *)sender {
    
    if (self.isSortFirstClick == YES) {
        [self sortAnimationDisplay];
        [self locationAnimationDidEnd];
        [self subTableViewDisPlay];
        self.isSortFirstClick = NO;
    }else{
        [self sortAnimationDidEnd];
        [self subTableViewEnd];
        self.isSortFirstClick = YES;
    }
    self.buttonType = YES;
    [self.subTableView reloadData];
}
#pragma mark -- 定位按钮回调(西安市)
- (IBAction)locationButtonAction:(UIButton *)sender {
    
    if (self.isLocationFirstClick == YES) {
        [self locationAnimationDisplay];
        [self sortAnimationDidEnd];
        [self subTableViewDisPlay];
        [[CarBrandManager sharedManager] sellerServiceCityList:@"西安市"];

        self.isLocationFirstClick = NO;
    }else{
        [self locationAnimationDidEnd];
        [self subTableViewEnd];
        self.isLocationFirstClick = YES;
        
        NSString *lontude = [COM getLongtude];
        NSString *lat = [COM getLatitude];
        if ([lontude isEqualToString:@""] || [lat isEqualToString:@""] || lat == nil || lontude == nil) {
            return;
        }
        
        LC_LOADING
        [[CarBrandManager sharedManager] nearSellerInfolongitude:lontude latitude:lat count:@(1000) page:@(1)];
    }
    
    self.buttonType = NO;
    //刷新UI
    [self.subTableView reloadData];
    
    
}

#pragma mark -- 加载全部店铺数据
- (void)loadData:(BOOL)sort {
    _isSort = sort;
    NSString *lontude = [COM getLongtude];
    NSString *lat = [COM getLatitude];
    if ([lontude isEqualToString:@""] || [lat isEqualToString:@""] || lat == nil || lontude == nil) {
        return;
    }
    LC_LOADING
    [[CarBrandManager sharedManager] nearSellerInfolongitude:lontude latitude:lat count:@(1000) page:@(1)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"洗车";
    [self setBackBarButton];
    
    self.isSortFirstClick = YES;
    self.isLocationFirstClick = YES;
    
    [self.subTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"subCell"];
    [self loadData:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 101) {
        return self.datasource.count;
    }else{
        if (self.buttonType == YES) {
            return 1;
        }else {
            return self.cityDatasource.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (tableView.tag == 101) {
        WashCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WashCarCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *address = self.datasource[row][@"address"];
        NSString *newAddress = [address stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSString *dis = [NSString stringWithFormat:@"%@",self.datasource[row][@"distance"]];
        cell.carStoreDistance.text = [NSString stringWithFormat:@"%@公里", dis];
        cell.carStoreLocation.text = newAddress;
        cell.carStoreName.text = self.datasource[row][@"name"];
        NSString *imgString = [NSString stringWithFormat:@"http://%@/%@", API_SERVER_HOST,self.datasource[row][@"img_url"]];
        NSURL *imgURL = [NSURL URLWithString:imgString];
        [cell.carStoreImage sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"默认图"]];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subCell" forIndexPath:indexPath];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.buttonType == YES) {
            cell.textLabel.text = @"离我最近";
            return cell;
        }else{
            
            CityCountModel *model = self.cityDatasource[indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@(%ld)",model.area,(long)model.count];
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 101) {
        return 100;
    }else{
        return 40;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 101) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BindSucceed" bundle:nil];
        CarShopDetailsViewController *carShopDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"CarShopDetailsVC"];
        carShopDetailVC.sellerInfoId= self.datasource[indexPath.row][@"id"];
        [self.navigationController pushViewController:carShopDetailVC animated:YES];
        
    }else{
        if (self.buttonType == NO) {
            [self locationAnimationDidEnd];
            [self subTableViewEnd];
            CityCountModel *model = self.cityDatasource[indexPath.row];
            //            NSNumber *count = [[NSNumber alloc] initWithDouble:model.count];
            NSString *count = [NSString stringWithFormat:@"%ld", model.count];
            NSString *longtude = [NSString stringWithFormat:@"%@",[COM getLongtude]];
            NSString *latitude = [NSString stringWithFormat:@"%@",[COM getLatitude]];
            [[CarBrandManager sharedManager] areaWashSellerList:model.area longtude:longtude latitude:latitude count:count page:@"1"];

            NSLog(@"测试");
        } else {
            [self sortAnimationDidEnd];
            [self subTableViewEnd];
            //设置离我最近按钮点击状态
            self.isSortFirstClick = YES;
            self.isLocationFirstClick = YES;
            [self loadData:YES];
        }
    }
}

//排序的字体颜色转变
- (void)sortAnimationDisplay{
    if (self.superSortView.backgroundColor != [UIColor colorWithRed:1.00 green:0.96 blue:0.90 alpha:1.00]) {
        self.superSortView.backgroundColor = [UIColor colorWithRed:1.00 green:0.96 blue:0.90 alpha:1.00];
        self.sortLabel.textColor = [UIColor colorWithRed:0.99 green:0.61 blue:0.16 alpha:1.00];
        self.sortImage.image = [UIImage imageNamed:@"下拉箭头-被选中"];
    }
}
//展示列表
- (void)subTableViewDisPlay{
    self.blackView.hidden = NO;
    self.subTableView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.subTableView.frame;
        rect.origin = CGPointMake(0, 41+64);
        self.subTableView.frame = rect;
    }];
}
//收回列表
- (void)subTableViewEnd{
    self.blackView.hidden = YES;
    self.subTableView.hidden = YES;
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self.subTableView.frame;
        rect.origin = CGPointMake(0, -self.blackView.frame.size.height);
        self.subTableView.frame = rect;
    }];
}
- (void)sortAnimationDidEnd{
    if (self.superSortView.backgroundColor != [UIColor clearColor]) {
        self.superSortView.backgroundColor = [UIColor clearColor];
        self.sortLabel.textColor = [UIColor blackColor];
        self.sortImage.image = [UIImage imageNamed:@"下拉箭头-常态"];
    }
}
#pragma mark--定位UI操作
- (void)locationAnimationDisplay{
    
    if (self.superLocationView.backgroundColor != [UIColor colorWithRed:1.00 green:0.96 blue:0.90 alpha:1.00]) {
        self.superLocationView.backgroundColor = [UIColor colorWithRed:1.00 green:0.96 blue:0.90 alpha:1.00];
        self.locationImage.image = [UIImage imageNamed:@"下拉箭头-被选中"];
        self.locationLabel.textColor = [UIColor colorWithRed:0.99 green:0.61 blue:0.16 alpha:1.00];
    }
}
- (void)locationAnimationDidEnd{
    if (self.superLocationView.backgroundColor != [UIColor clearColor]) {
        self.superLocationView.backgroundColor = [UIColor clearColor];
        self.locationImage.image = [UIImage imageNamed:@"下拉箭头-常态"];
        self.locationLabel.textColor = [UIColor blackColor];
    }
}
- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc] init];
    }
    return _datasource;
}
- (NSMutableArray *)cityDatasource{
    if (!_cityDatasource) {
        _cityDatasource = [[NSMutableArray alloc] init];
    }
    return _cityDatasource;
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
