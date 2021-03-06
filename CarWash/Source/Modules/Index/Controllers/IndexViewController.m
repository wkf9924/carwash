//
//  IndexViewController.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/12.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "IndexViewController.h"
#import "DefineConstant.h"
#import "PreferentialCell.h"
#import "SelectCarViewController.h"
#import "Common.h"
#import "DiscountManager.h"
#import "CarBrandManager.h"
#import "WashTheCarViewController.h"
#import "TrafficViolationViewController.h"
#import "CWLoginViewController.h"
#import "DiscountMainModel.h"
#import "MyLoveCarModel.h"
#import "UIImageView+WebCache.h"
#import "CWLoginRegisterManager.h"
#import "QRViewController.h"
#import "MJRefresh.h"
#import "CWMallViewController.h"
#import "UINavigationBar+Awesome.h"
#import "AFNetworking.h"
#import "CCLocationManager.h"
#import "PreferentialCarWashVC.h"
#import "AppDelegate.h"
#import "CCLocationManager.h"
#import "ScanPayViewController.h"
#import "TrafficListVC.h"
#import "TodaySpecialViewController.h"
#import "VIPFirstVC.h"
#import "JSONFunction.h"
#import "ScanPayFailVC.h"
@interface IndexViewController ()<UITableViewDelegate,UITableViewDataSource,BZEventCenterDelegate>
{
    QRViewController *_qr;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UILabel *licenseNumber;//车牌
@property (strong, nonatomic) IBOutlet UILabel *SeableLabel;//车型号
@property (strong, nonatomic) IBOutlet UIImageView *myCarLogo;//车辆logo

@property (weak, nonatomic) IBOutlet UIView *myPageView;
@property (strong, nonatomic) IBOutlet UIButton *bindingCar;//立刻绑定按钮

@property (nonatomic,strong)NSMutableArray *datasource;
@property (nonatomic,strong)MyLoveCarModel *myLoveCarModel;

@property (nonatomic, strong)UIView *emptyStateView;

@property (nonatomic, strong)NSMutableArray *refreshImages;
@property (nonatomic, strong)NSMutableArray *normalImages;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic,assign) int time;

@end

@implementation IndexViewController
- (void)cardNumberCount:(NSString *)carNumber{
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:CITY_DISPLAY object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSString *location = [NSString stringWithFormat:@" %@",note.object];
        self.navigationItem.leftBarButtonItem
        = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"定位icon"]
                                           highlightedImage:nil
                                                     titles:location
                                                      alpha:1.0f
                                                     target:self
                                                     action:@selector(myGpsClick:)
                                           forControlEvents:UIControlEventTouchUpInside];
    }];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeDiscount callback:self];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeAutoLogin callback:self];
    
    [self autoLogin];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeDiscount callback:self];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeAutoLogin callback:self];
    
}
#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    if([eventType isEqualToString:CWEventCenterTypeDiscount]){
        if (self.datasource) {
            [self.datasource removeAllObjects];
        }
        for (NSDictionary *dic in param) {
            NSArray *array = dic[@"discount_goods"];
            for (NSDictionary *dic in array) {
                DiscountModel *model = [[DiscountModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                NSLog(@"DiscountModel");
                [self.datasource addObject:model];
            }
        }
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
    }
    if([eventType isEqualToString:CWEventCenterTypeAutoLogin]){
        NSLog(@"自动登录返回数据：%@",param);
        NSString *car_id = param [@"car_id"];
        if ([car_id isEqual:[NSNull null]] || car_id == nil) {
            [_bindingCar setTitle:@"立即绑定" forState:0];
            _licenseNumber.text = @"绑定爱车";
            _SeableLabel.text = @"尊享特惠洗车服务";
            _myCarLogo.image = [UIImage imageNamed:@"绑定爱车图标"];
        }
        else {
            if ([[COM getLoginToken] isEqualToString:@""] || [COM getLoginToken] == nil) {
                
            }else{
            [_bindingCar setTitle:@"特惠洗车" forState:0];
            _licenseNumber.text = param[@"car_plate"];  //车牌
            _SeableLabel.text = param[@"car_type"]; //车型
            [_myCarLogo sd_setImageWithURL:[NSURL URLWithString:param[@"car_brandlogo"]] placeholderImage:[UIImage imageNamed:@"绑定爱车图标"]];
            
                NSString *token = param[@"token"];
                if (![token isEqual:[NSNull null]] ) {
                    [COM saveLoginToken:token];
                }
                
                
                NSString *phone = param[@"phone"];
                if (![phone isEqual:[NSNull null]]) {
                    [COM saveLoginPhone:phone];
                }
                
                NSString *name = param[@"name"];
                if (![name isEqual:[NSNull null]]) {
                    [COM saveLoginName:name];
                }
                
                NSString *imageUrl = param[@"avatar_url"];
                if (![imageUrl isEqual:[NSNull null]]) {
                    [COM saveUserURL:imageUrl];
                }
                //车牌
                NSString *car_plate = param[@"car_plate"];
                if (![car_plate isEqual:[NSNull null]]) {
                    [COM saveCarPlate:car_plate];
                }
                //车型
                NSString *car_type = param[@"car_type"];
                if (![car_type isEqual:[NSNull null]]) {
                    [COM saveCarType:car_type];
                }
                //车logo
                NSString *car_brandlogo = param[@"car_brandlogo"];
                if (![car_brandlogo isEqual:[NSNull null]]) {
                    COM.logoIconStr = car_brandlogo;
                }
                
                //用户id
                NSString *userId = param[@"id"];
                if (![userId isEqual:[NSNull null]]) {
                    [COM saveUserId:userId];
                }
                
                //是否vip
                NSString *isVip = param[@"is_vip"];
                if (![isVip isEqual:[NSNull null]]) {
                    [COM saveVip:isVip];
                }
                //绑定车辆id
                NSString *carID = param[@"car_id"];
                if (![carID isEqual:[NSNull null]]) {
                    [COM saveCarID:carID];
                }
                
                //余额
                NSString *blance = [NSString stringWithFormat:@"%@", param[@"blance"]];
                if (![blance isEqual:[NSNull null]]) {
                    [COM saveUserBlance:blance];
                }
                
                //我的卷
                NSString *ticket_count = [NSString stringWithFormat:@"%@", param[@"ticket_count"]];
                if (![ticket_count isEqual:[NSNull null]]) {
                    [COM saveTiketCount:ticket_count];
                }
                
                //银行卡
                NSString *bank_card_count = [NSString stringWithFormat:@"%@", param[@"bank_card_count"]];
                if (![bank_card_count isEqual:[NSNull null]]) {
                    [COM saveBankCardCount:bank_card_count];
                }
                //车架号
                NSString *carFrameNum = param[@"car_frame"];
                if (![carFrameNum isEqual:[NSNull null]]) {
                    [COM saveCarFrameNum:carFrameNum];
                }
                //发动机号
                NSString *engineNumber = param[@"car_engine"];
                if (![engineNumber isEqual:[NSNull null]]) {
                    [COM saveCarEngineNum:engineNumber];
                }
                //车系名称
                NSString *carsName = param[@"car_brand"];
                if (![carsName isEqual:[NSNull null]]) {
                    [COM saveCarsName:carsName];
                }
                //查询城市
                NSString *city = param[@"city"];
                if (![city isEqual:[NSNull null]]) {
                    COM.city = city;
                }
            //获取车辆的URL
                //会员日期
                NSString *vipDate =[NSString stringWithFormat:@"%@", param[@"vip_date"]];
                if (![vipDate isEqual:[NSNull null]]) {
                    [COM setVip_date:vipDate];
                }
                //服务器时间
                NSString *serverDate =[NSString stringWithFormat:@"%@", param[@"server_time"]];
                if (![serverDate isEqual:[NSNull null]]) {
                    [COM setServer_date:serverDate];
                }
            }
        }
    }
}
#pragma mark 下拉刷新
- (void)uploading{
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [[DiscountManager sharedManager] discount:@10 page:@1];
    }];
//    MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    [header setImages:self.refreshImages forState:MJRefreshStateRefreshing];
//    [header setImages:self.normalImages forState:MJRefreshStateIdle];
//    [header setImages:self.refreshImages forState:MJRefreshStatePulling];
//    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
//    header.stateLabel.hidden = YES;
//    self.myTableView.mj_header = header;
    
    
    
}
- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"1car_gif"]];
        [self.normalImages addObject:image];
    }
    return _normalImages;
}
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];
        //				循环添加图片
        for (NSUInteger i = 1; i<=24; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ldcar_gif", i]];
            [self.refreshImages addObject:image];
        }
    }
    return _refreshImages;
}
-(void)loadNewData {
    //模拟刷新的时间
    self.timer  =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    self.time = 10;
}
-(void)timeAction {
    self.time --;
    NSLog(@"%d",self.time);
    if (self.time == 0) {
        //		刷新数据
        [_myTableView reloadData];
        //		停止刷新
        [_myTableView.mj_header endRefreshing];
        [self.timer invalidate];
    }
}
#pragma mark -- 违章查询按钮回调
- (IBAction)trafficViolationButtonAction:(UIButton *)sender {
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
#pragma mark -- 立刻绑定按钮回调方法
- (IBAction)bindingCarAction:(UIButton *)sender {
#pragma mark==暂时修改
    NSString *token = [COM getLoginToken];
    //判断token是否为空。如果为空。那就去登录
    if (token == nil || [token isEqualToString:@""] || token.length == 0) { //没有登录
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"login"]
        ;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else if(token){//说明登录
        if ([COM getCarID]== nil || [[COM getCarID] isEqualToString:@""] || [[COM getCarID] isEqualToString:@"<null>"]) {//说明没有绑定车辆
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"EditMyLoveCar" bundle:nil];
            [self.navigationController pushViewController:[storyboard instantiateViewControllerWithIdentifier:@"EditMyCarViewController"] animated:YES];
        } else  {//已经绑定车辆
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BindSucceed" bundle:nil];
            PreferentialCarWashVC *preferentialCarWash = [storyboard instantiateViewControllerWithIdentifier:@"PreferentialCarWashVC"];
            [self.navigationController pushViewController:preferentialCarWash animated:YES];
        }
        
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count====%ld",self.datasource.count);
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PreferentialCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PreferentialCell" forIndexPath:indexPath];
    
    DiscountModel *model_1 = self.datasource[indexPath.row];
    [cell.goodsImage sd_setImageWithURL:[NSURL URLWithString:model_1.image_url] placeholderImage:[UIImage imageNamed:@"商品展示图"]];
    cell.goodsName.text = model_1.name;
    cell.goodsPrice.text = [NSString stringWithFormat:@"￥ %ld",model_1.price];
    cell.originalPrice.text = [NSString stringWithFormat:@"￥ %ld",model_1.original_price];
    NSString *sellerCount = [NSString stringWithFormat:@"%@", model_1.selled_count];
    NSInteger sellCount = [sellerCount integerValue];
//    cell.selledRate.text = [NSString stringWithFormat:@"%.0ld%%", model_1.presell_count/sellCountpo];
//    cell.selledRateProgressView.progress = model_1.presell_count/sellerCount;
//    if (model_1.selled_count != 0) {
//        cell.selledRate.text = [NSString stringWithFormat:@"%.0ld%%", model_1.presell_count/sellerCount];
//        cell.selledRateProgressView.progress = model_1.presell_count/sellerCount;
//    }
//    if (model_1.selled_count != 0) {
//        cell.selledRate.text = [NSString stringWithFormat:@"%.0ld%%", model_1.presell_count/model_1.selled_count];
//        cell.selledRateProgressView.progress = model_1.presell_count/model_1.selled_count;
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DiscountModel *model_1 = self.datasource[indexPath.row];
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"TodaySpecialViewController" bundle:nil];
    TodaySpecialViewController *todaySpecialViewController = [storyboard instantiateViewControllerWithIdentifier:@"TodaySpecialViewController"];
    NSString *IDString = [NSString stringWithFormat:@"%ld", model_1.ID];
    todaySpecialViewController.ID = IDString;
    [self.navigationController pushViewController:todaySpecialViewController animated:YES];
}
#pragma mark -- 定位按钮
- (void)myGpsClick:(UIButton *)sender {
    
}

- (void)scanClick:(UIButton *)sender {
    [self btnClick:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"洗洋洋";
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView = _headerView;
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    //左侧按钮
    self.navigationItem.leftBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"定位icon"]
                                       highlightedImage:nil
                                                 titles:@" 西安市"
                                                  alpha:1.0f
                                                 target:self
                                                 action:@selector(myGpsClick:)
                                       forControlEvents:UIControlEventTouchUpInside];
    
    //右侧按钮
    self.navigationItem.rightBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"扫一扫icon"]
                                       highlightedImage:nil
                                                 titles:@""
                                                  alpha:1.0f
                                                 target:self
                                                 action:@selector(scanClick:)
                                       forControlEvents:UIControlEventTouchUpInside];
    
    [self scrollViewOperation];
    
//    [self autoLogin];
    //获取今日特惠列表
    [[DiscountManager sharedManager] discount:@100 page:@1];
    //获取我绑定的车辆
    [[CarBrandManager sharedManager] myLoveCar];
    //改变tabBar字体颜色 全局
    self.tabBarController.tabBar.tintColor = [UIColor orangeColor];
    [self uploading];
    
    
    NSString *token = [COM getLoginToken];
    if ([token isEqualToString:@""] || token == nil) {
        _licenseNumber.text = @"绑定爱车";
        _SeableLabel.text = @"洗车代金券等您拿";
        [_bindingCar setTitle:@"立即绑定" forState:0];
        _myCarLogo.image = [UIImage imageNamed:@"绑定爱车图标"];
    }
    else {
        
        if ([COM getCarID].length == 0) {
            self.licenseNumber.text = @"绑定爱车";
            self.SeableLabel.text = @"洗车代金券等您拿";
            [_bindingCar setTitle:@"立即绑定" forState:0];
        }else{
            self.licenseNumber.text = [COM getCarPlate];
            
            self.SeableLabel.text = [COM getCarType];
            NSString *imageURL = [COM getCarImage];
            [_myCarLogo sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"绑定爱车图标"]];
            [_bindingCar setTitle:@"特惠洗车" forState:0];
        }  
    }
}

/**
 *  - 自动登录
 */
- (void)autoLogin {
    NSString *toke = [COM getLoginToken];
    if ([toke isEqualToString:@""] || toke == nil) {
        self.licenseNumber.text = @"绑定爱车";
        self.SeableLabel.text = @"汽车洗车券等你拿";
        self.myCarLogo.image = [UIImage imageNamed:@"绑定爱车图标"];
        [self.bindingCar setTitle:@"绑定爱车" forState:UIControlStateNormal];
        return;
    }
    [[CWLoginRegisterManager sharedManager] autoLogin:toke];
}

//轮播图
- (void)scrollViewOperation{
    //网络图片
    NSArray *imageArray = @[@"banner",@"banner", @"banner"];
    PageView *pageView = [[PageView alloc] initPageViewFrame:CGRectMake(0, 0, self.view.bounds.size.width-10, 78)];
    //是否是网络图片
    pageView.isWebImage = NO;
    //存放图片数组
    pageView.imageArray = imageArray;
    //停留时间
    pageView.duration = 2;
    
    [self.myPageView addSubview:pageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 点击洗车按钮
- (IBAction)washCarButtonAction:(UIButton *)sender {
    
    NSString *toke =  [COM getLoginToken];
    if ([toke isEqualToString:@""] || toke == nil) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController  *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WashTheCar" bundle:nil];
    WashTheCarViewController *washTheCarVC = [storyboard instantiateViewControllerWithIdentifier:@"washTheCarVC"];
    [self.navigationController pushViewController:washTheCarVC animated:YES];
    
}

#pragma mark -- VIP洗车
- (IBAction)careButtonAction:(UIButton *)sender {
    NSString *vip = [COM getVip];
    if ([vip isEqualToString:@"2"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"VIP" bundle:nil];
        VIPFirstVC *vipfirst = [storyboard instantiateViewControllerWithIdentifier:@"VIPSecondVC"];
        
        [self.navigationController pushViewController:vipfirst animated:YES];
        return;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"VIP" bundle:nil];
    VIPFirstVC *vipfirst = [storyboard instantiateViewControllerWithIdentifier:@"VIPFirstVC"];
    
    [self.navigationController pushViewController:vipfirst animated:YES];
}

//首页车品商城按钮回调
- (IBAction)carStoreButtonAction:(UIButton *)sender {
    self.tabBarController.selectedIndex = 1;
}

- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc] init];
    }
    return _datasource;
}

- (MyLoveCarModel *)myLoveCarModel{
    if (!_myLoveCarModel) {
        _myLoveCarModel = [[MyLoveCarModel alloc] init];
    }
    return _myLoveCarModel;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (void)btnClick:(id)sender {
    //    [self.session startRunning];
    
    NSString *token = [COM getLoginToken];
    if (token.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
            CWLoginViewController  *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"login"];
            [self.navigationController pushViewController:loginVC animated:YES];
        }];
        
        [alert addAction:action];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    _qr = [[QRViewController alloc]init];
    _qr.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:_qr];
    
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)qrCodeComplete:(NSString *)codeString
{
    [_qr dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"codeString = %@",codeString);
    
    NSString *Accepter_userid = [codeString substringFromIndex:16];
    
    //判断type的类型 3为用户扫商家 1为商家扫用户
    NSArray *stringArray;
    NSString *tokenString, *typeString;
    
    stringArray = [codeString componentsSeparatedByString:@"&"];
    tokenString = [stringArray[0] substringFromIndex:16];
    typeString = [stringArray[1] substringFromIndex:5];
    if ([typeString isEqualToString:@"3"]) {  //正常付费界面
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Pay" bundle:nil];
        ScanPayViewController  *scanPay = [storyboard instantiateViewControllerWithIdentifier:@"ScanPayVC"];
        scanPay.Accepter_userid = Accepter_userid;
        [self.navigationController pushViewController:scanPay animated:YES];
    } else {  //扫码错误界面
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"PaidSucceed" bundle:nil];
        ScanPayFailVC  *scanPay = [storyboard instantiateViewControllerWithIdentifier:@"ScanPayFailVC"];
        [self.navigationController pushViewController:scanPay animated:YES];
    }
}

- (void)qrCodeError:(NSError *)error
{
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    [self.session stopRunning];
    
    [self.preview removeFromSuperlayer];
    
    NSString *val = nil;
    if (metadataObjects.count > 0)
    {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        val = obj.stringValue;
        
        NSLog(@"val = %@",val);
    }
}
@end
