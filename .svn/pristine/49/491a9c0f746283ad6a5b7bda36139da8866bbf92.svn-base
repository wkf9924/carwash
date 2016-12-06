//
//  CarShopDetailsViewController.m
//  CarWash
//
//  Created by xa on 16/7/23.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CarShopDetailsViewController.h"
#import "SeviceDetailViewController.h"
#import "SeviceCell.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"
#import "CarBrandManager.h"

#import "SeviceListModel.h"
#import "CarShopDetailModel.h"
#import "UIImageView+WebCache.h"
#import "MyCouponsViewController.h"
#import "SharedHelper.h"
#import "UIImage+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "VIPSellerCell.h"

@interface CarShopDetailsViewController ()<UITableViewDelegate, UITableViewDataSource,BZEventCenterDelegate,MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *CarShopImage;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumber;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;//地址
@property (strong, nonatomic) IBOutlet MKMapView *shopLocationMapView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *SuperTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHight;
@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UIView *myView;
@property (nonatomic, strong)CLGeocoder *geocoder;
@property (nonatomic, strong)UITapGestureRecognizer *tap;

@property BOOL isHidde;
@property (nonatomic, strong) NSMutableArray *seviceListData;
@property (nonatomic, strong) CarShopDetailModel *carShopDetailModel;


@end

@implementation CarShopDetailsViewController
//回首页按钮回调
- (IBAction)goHomeButtonAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//我的券按钮回调
- (IBAction)myTicketButtonAction:(UIButton *)sender {
    UIStoryboard *setingStoryBoard = [UIStoryboard storyboardWithName:@"MyCoupons" bundle:nil];
    MyCouponsViewController* setingVC = [setingStoryBoard instantiateViewControllerWithIdentifier:@"MyCoupons"];
    [self.navigationController pushViewController:setingVC animated:YES];

}
//分享按钮回调
- (IBAction)sharedButtonAction:(UIButton *)sender {
    NSArray *imageArray = @[[UIImage imageNamed:@"二维码"]];
//    NSArray *imageArray_1 = @[@""];
    [[SharedHelper sharedHelper] sharedImageArray:imageArray Text:@"" url:[NSURL URLWithString:@""] title:@""];
}
//打电话按钮回调(右上角菜单)
- (IBAction)callButtonAction:(UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.carShopDetailModel.tel];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}
//地图按钮回调
- (IBAction)mapButtonAction:(UIButton *)sender {
    [self turnByTurn];
    
}
//打电话按钮回调
- (IBAction)callButton:(UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.carShopDetailModel.tel];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)interfaceAssignmentOperation{
    NSString *url = [NSString stringWithFormat:@"http://%@/%@",API_SERVER_HOST,self.carShopDetailModel.img_url];
    [self.CarShopImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"3.jpg"]];
    self.phoneNumber.text = self.carShopDetailModel.tel;
    self.locationLabel.text = self.carShopDetailModel.address;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeSellerInfo callback:self];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeSellerServiceList callback:self];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect rect = self.menuView.frame;
    rect = CGRectMake(self.view.bounds.size.width-10-128, 44, 0, 0);
    self.menuView.frame = rect;
    [self.view addSubview:self.menuView];
    _isHidde = YES;
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeSellerInfo callback:self];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeSellerServiceList callback:self];
    self.tabBarController.tabBar.hidden = YES;
    
}
#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeSellerInfo]) {
        NSLog(@"商家基本信息返回数据:%@",param);
        
        [self.carShopDetailModel setValuesForKeysWithDictionary:param];
        [[CarBrandManager sharedManager] sellerServiceList:param[@"id"]];
    }else if ([eventType isEqualToString:CWEventCenterTypeSellerServiceList]){
        NSLog(@"商家服务列表返回数据:%@",param);
        for (NSDictionary *dic in param) {
            SeviceListModel *model = [[SeviceListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.seviceListData addObject:model];
        }
        if (self.seviceListData.count != 0) {
            self.tableViewHight.constant = self.seviceListData.count * 40;
        }else{
            self.tableViewHight.constant = 0;
        }
    }
    if (self.carShopDetailModel.lag.length != 0 || self.carShopDetailModel.lng != 0) {
        [self locationMethod:self.carShopDetailModel.lag longitude:self.carShopDetailModel.lng];
    }else{
        //调用根据经纬度在地图上显示位置的方法
        [self locationMethod:[COM getLatitude] longitude:[COM getLongtude]];
    }

    [self.tableView reloadData];
    [self interfaceAssignmentOperation];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
//    _SuperTableView.hidden = YES;
    self.title = self.sellerName;
    UIColor *color = [UIColor lightGrayColor];
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage imageNamed:@"更多icon"]
                                     highlightedImage:nil
                                               titles:nil
                                                alpha:0.3f
                                                color:color
                                               target:self
                                               action:@selector(moreAction:)
                                     forControlEvents:UIControlEventTouchUpInside];
    
    [[CarBrandManager sharedManager] sellerInfo:self.sellerInfoId];
    
    
}
#pragma  mark--此方法需要传入经纬度
//根据经纬度在地图上显示位置
- (void)locationMethod:(NSString *)latitude longitude:(NSString *)longitude{
    self.shopLocationMapView.delegate = self;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([longitude doubleValue], [latitude doubleValue]);
    if (coordinate.longitude >180 || coordinate.longitude < 0 ||coordinate.latitude < 0 || coordinate.latitude > 90) {
        NSLog(@"经度范围应在 0~180%f----纬度范围应在 0~90%f",coordinate.longitude,coordinate.latitude);
    }else{
    MapAnnotation *annotation = [[MapAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"西安市";
    [self.shopLocationMapView addAnnotation:annotation];
    [self.shopLocationMapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000)];
    }
}
#pragma mark--地图代理方法实现
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapSample"];
    annotationView.canShowCallout = YES;
    return annotationView;
}
- (void)moreAction:(UIBarButtonItem *)sender{
    if (_isHidde == YES) {
        _isHidde = NO;
        self.menuView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.menuView.frame;
        rect = CGRectMake(self.view.bounds.size.width-10-128, 64, 128, 180);
        self.menuView.frame = rect;
        }];
        
        self.tap = [[UITapGestureRecognizer alloc] init];
        
        self.tap.numberOfTapsRequired = 1;
        self.tap.numberOfTapsRequired = 1;
        [self.tap addTarget:self action:@selector(hiddenTap:)];
        [self.view addGestureRecognizer:self.tap];
        
        
    } else {
        self.menuView.hidden = YES;
        CGRect rect = self.menuView.frame;
        rect = CGRectMake(self.view.bounds.size.width-10-128, 64, 128, 0);
        self.menuView.frame = rect;
        _isHidde = YES;
    }
}
- (void)hiddenTap:(UIGestureRecognizer *)tap{
    self.menuView.hidden = YES;
    CGRect rect = self.menuView.frame;
    rect = CGRectMake(self.view.bounds.size.width-10-128, 64, 128, 0);
    self.menuView.frame = rect;
    _isHidde = YES;
    [self.view removeGestureRecognizer:self.tap];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.seviceListData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeviceCell" forIndexPath:indexPath];

    
    SeviceListModel *model = self.seviceListData[indexPath.row];
    cell.seviceName.text = model.name;
    cell.sevicePrice.text = [NSString stringWithFormat:@"¥ %@",model.price];
    if ([model.servicetypeid isEqualToString:@"1"]) {//洗车
        cell.seviceImage.image = [UIImage imageNamed:@"order_洗车icon"];
    }else if ([model.servicetypeid isEqualToString:@"2"]){//四轮定位
        cell.seviceImage.image = [UIImage imageNamed:@"order_四轮定位icon"];
    }else if ([model.servicetypeid isEqualToString:@"3"]){//全车打蜡
        cell.seviceImage.image = [UIImage imageNamed:@"order_打蜡icon"];
    }else if ([model.servicetypeid isEqualToString:@"4"]){//大保养
        cell.seviceImage.image = [UIImage imageNamed:@"order_大保icon"];
    }else if ([model.servicetypeid isEqualToString:@"5"]){//小保养
        cell.seviceImage.image = [UIImage imageNamed:@"order_小保icon"];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SeviceDetailViewController *sevicedetailVC = [[UIStoryboard storyboardWithName:@"BindSucceed" bundle:nil] instantiateViewControllerWithIdentifier:@"SeviceDetailViewController"];
    SeviceListModel *model = self.seviceListData[indexPath.row];
    sevicedetailVC.serviceId = model.ID;
    sevicedetailVC.sellerID = self.sellerInfoId;
    [self.navigationController pushViewController:sevicedetailVC animated:YES];
}
- (NSMutableArray *)seviceListData{
    if (!_seviceListData) {
        _seviceListData = [[NSMutableArray alloc] init];
    }
    return _seviceListData;
}
- (CarShopDetailModel *)carShopDetailModel{
    if (!_carShopDetailModel) {
        _carShopDetailModel = [[CarShopDetailModel alloc] init];
    }
    return _carShopDetailModel;
}



- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
- (void)turnByTurn{
    NSString *myAddress = [[NSUserDefaults standardUserDefaults] objectForKey:@"ADDRESS"];
    NSString *toAddress = [self.carShopDetailModel.address stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (toAddress && myAddress) {
        [self.geocoder geocodeAddressString:myAddress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placeMark_1 = placemarks.firstObject;
            MKPlacemark *mkPlaceMark_1 = [[MKPlacemark alloc] initWithPlacemark:placeMark_1];
            [self.geocoder geocodeAddressString:toAddress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                CLPlacemark *placeMark_2 = placemarks.firstObject;
                MKPlacemark *mkPlaceMark_2 = [[MKPlacemark alloc] initWithPlacemark:placeMark_2];
                NSDictionary *options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
                MKMapItem *mapItem1=[[MKMapItem alloc]initWithPlacemark:mkPlaceMark_1];
                MKMapItem *mapItem2=[[MKMapItem alloc]initWithPlacemark:mkPlaceMark_2];
                [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
            }];
        }]; 
    }
    
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
