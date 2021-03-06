//
//  WashServiceList.m
//  CarWash
//
//  Created by WangKaifeng on 2016/11/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//
#import "WashServiceList.h"
#import "WashCarCell.h"
#import "Definition.h"
#import "DefineConstant.h"
#import "WashServiceModel.h"
#import "AFNetworking.h"
#import "WashServiceVIPCell.h"
#import "UIImageView+AFNetworking.h"
#import "VIPCarVC.h"
@interface WashServiceList () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation WashServiceList

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc]init];
    }
    return _datasource;
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
    [self setBackBarButton];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.tableHeaderView = _titleView;
    _myTableView.backgroundColor = [UIColor clearColor];
    self.title = @"我要洗车";
    [self loaddata];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loaddata {
    NSString *token = [COM getLoginToken];
    if ([token isEqualToString:@""] || token == nil) {
        return;
    }
    
    NSString *lng = [COM getLongtude]; //经度
    NSString *lag = [COM getLatitude];//纬度
    
    NSString *urlStirng = [NSString stringWithFormat:@"http://%@%@",API_SERVER_HOST, API_MY_VIPSSLLERLIST];
    
    NSDictionary *dic = @{
                          @"count" : @"10",
                          @"lag" : lag,
                          @"lng" : lng,
                          @"page" : @"1",
                          @"token" : token
                          };
    
    
    [TSEHttpTool post:urlStirng params:dic success:^(id json) {
        NSDictionary *jsondic = json;
        NSString *numberCode = [NSString stringWithFormat:@"%@",jsondic[@"code"]];
        NSArray *resultArray = jsondic[@"result"];
        if (![numberCode isEqualToString:@"0"]) {
            LCSUCCESS_ALSERT(@"加载失败")
            return;
        }
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in resultArray) {
            WashServiceModel *wash = [[WashServiceModel alloc] init];
            [wash setValuesForKeysWithDictionary:dic];
            [array addObject:wash];
        }
        self.datasource = array;
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    

}

#pragma mark--tableView代理方法实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WashServiceModel *model = self.datasource[indexPath.row];
    NSString *imageURL = [NSString stringWithFormat:@"http://%@/%@", API_SERVER_HOST,model.img_url];
    WashServiceVIPCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"WashServiceVIPCell" forIndexPath:indexPath];
    NSString *distance = [NSString stringWithFormat:@"%@", model.distance];
    NSString *carStoreDistance = [NSString stringWithFormat:@"%@", model.address];
    NSString *carStoreName = [NSString stringWithFormat:@"%@", model.name];
    cell.lbName.text = carStoreName;
    cell.lbAddress.text = carStoreDistance;
    cell.lbLoction.text = distance;
    [cell.washImage setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"默认图"]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WashServiceModel *model = self.datasource[indexPath.row];
    NSString *ID = model.ID;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BindSucceed" bundle:nil];
    VIPCarVC *carShopDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"VIPCarVC"];
    carShopDetailVC.sellerInfoId= ID;
    [self.navigationController pushViewController:carShopDetailVC animated:YES];
    
}

@end
