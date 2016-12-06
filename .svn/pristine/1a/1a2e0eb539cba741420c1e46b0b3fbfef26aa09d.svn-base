//
//  SelectCarViewController.m
//  CarWash
//
//  Created by xa on 16/7/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SelectCarViewController.h"
#import "SelectCarTableCell.h"
#import "SelectCarCollectionCell.h"
#import "DefineConstant.h"
#import "SelectCarSubViewController.h"
#import "NetWorkingHelper.h"

#import "SelectModel.h"
#import "SelectCarModel.h"
#import "UIImageView+WebCache.h"

@interface SelectCarViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,BZEventCenterDelegate>
{
    NSMutableArray *_carArray;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) UILabel *sectionTitle;

@property (nonatomic, strong)NSMutableArray *datasource;


@end

@implementation SelectCarViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeCarBrand callback:self];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeCarBrandFail callback:self];
    self.tabBarController.tabBar.hidden = NO;
    
}

- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc]init];
    }
    return _datasource;
}

- (void)requestData{
    
    [NetWorkingHelper requestWithUrl:@"http://mi.xcar.com.cn/interface/xcarapp/getBrands.php" requestType:GET requestParameters:nil success:^(id responseObject) {
        NSArray *array = responseObject[@"letters"];
        for (NSDictionary *dic in array) {
            SelectModel *model = [[SelectModel alloc] init];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    _carArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setBackBarButton];
    self.title = @"爱车品牌";
    [self collectionviewFlowLayout];
    self.tableView.tableHeaderView = self.headerView;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self requestData];
    
    
//    大众 http://img3.xcarimg.com/PicLib/logo/pl4_160s.png?t=20161009
//    福特 http://img4.xcarimg.com/PicLib/logo/pl10_160s.png?t=20161009
//    本田 http://img2.xcarimg.com/PicLib/logo/pl17_160s.png?t=20161009
//    丰田 http://img4.xcarimg.com/PicLib/logo/pl18_160s.png?t=20161009
//    别克 http://img4.xcarimg.com/PicLib/logo/pl13_160s.png?t=20161009
//    奥迪 http://img2.xcarimg.com/PicLib/logo/pl1_160s.png?t=20161009
//    现代 http://img2.xcarimg.com/PicLib/logo/pl23_160s.png?t=20161009
//    雪佛兰 http://img5.xcarimg.com/PicLib/logo/pl16_160s.png?t=20161009
//    奔驰 http://img1.xcarimg.com/PicLib/logo/pl3_160s.png?t=20161009
//    宝马 http://img4.xcarimg.com/PicLib/logo/pl2_160s.png?t=20161009
    
    
    NSArray *array = @[
                       @"http://img3.xcarimg.com/PicLib/logo/pl4_160s.png?t=20161009",
                       @"http://img4.xcarimg.com/PicLib/logo/pl10_160s.png?t=20161009",
                       @"http://img2.xcarimg.com/PicLib/logo/pl17_160s.png?t=20161009",
                       @"http://img4.xcarimg.com/PicLib/logo/pl18_160s.png?t=20161009",
                       @"http://img4.xcarimg.com/PicLib/logo/pl13_160s.png?t=20161009",
                       @"http://img2.xcarimg.com/PicLib/logo/pl1_160s.png?t=20161009",
                       @"http://img2.xcarimg.com/PicLib/logo/pl23_160s.png?t=20161009",
                       @"http://img5.xcarimg.com/PicLib/logo/pl16_160s.png?t=20161009",
                       @"http://img1.xcarimg.com/PicLib/logo/pl3_160s.png?t=20161009",
                       @"http://img4.xcarimg.com/PicLib/logo/pl2_160s.png?t=20161009"];
    _carArray = [NSMutableArray arrayWithArray:array];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//布局collectionview热门车辆
- (void)collectionviewFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((self.view.bounds.size.width-10)/5, 76);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.collectionViewLayout = flowLayout;
    
}

#pragma mark--collection代理方法实现
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    SelectCarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectCarCollectionCell" forIndexPath:indexPath];
    cell.carLogo.image = [UIImage imageNamed:@"宝马"];
    NSString *urlSring = [NSString stringWithFormat:@"%@",_carArray[row]];
    [cell.carLogo sd_setImageWithURL:[NSURL URLWithString:urlSring] placeholderImage:nil];
//    cell.carName.text = @"BMW-i8";
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Binding" bundle:nil];
    SelectCarSubViewController *selectCarSubVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectCarSubVC"];
    [self.navigationController pushViewController:selectCarSubVC animated:YES];
}
#pragma mark--tableview代理方法实现
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCarTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCarTableCell" forIndexPath:indexPath];
    
    SelectModel *model = self.datasource[indexPath.section];
    
    SelectCarModel *carModel = model.rcp_brands[indexPath.row];
    
    cell.carName.text = carModel.name;
    [cell.carLogo sd_setImageWithURL:[NSURL URLWithString:carModel.icon]];

    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SelectModel *model = self.datasource[section];
    return model.rcp_brands.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasource.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerViewForSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    headerViewForSection.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    self.sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 20, 30)];
    SelectModel *model = self.datasource[section];
    
    NSString *string = [model.letter uppercaseString];
    self.sectionTitle.text = string;
    
    [headerViewForSection addSubview:self.sectionTitle];
    return headerViewForSection;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED{
    return [NSArray arrayWithObjects:@"🔍",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Binding" bundle:nil];
    SelectCarSubViewController *selectCarSubVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectCarSubVC"];
    SelectModel *model = self.datasource[indexPath.section];
    SelectCarModel *carModel = model.rcp_brands[indexPath.row];
    selectCarSubVC.car_id = carModel.car_id;
    selectCarSubVC.brandName = carModel.name;
    selectCarSubVC.logoIcon = carModel.icon;

    COM.logoIconStr = carModel.icon;
    COM.brandName = carModel.name;
    [self.navigationController pushViewController:selectCarSubVC animated:YES];
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    NSDictionary *jsonDic = (NSDictionary *)param;
    NSString *str = jsonDic[@"phone"];
    
    NSDictionary *jsondic = jsonDic[@"result"];
    NSString *token = jsondic[@"token"];
    [COM saveLoginToken:token];
    
    CWLoginParam *loginParam = [[CWLoginParam alloc] init];
    loginParam.phone = str;
    NSLog(@"login%@",  loginParam.phone);
    if([eventType isEqualToString:CWEventCenterTypeCarBrand]){
    }else {
    }
}

@end
