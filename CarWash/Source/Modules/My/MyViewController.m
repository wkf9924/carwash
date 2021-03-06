//
//  MyViewController.m
//  CarWash
//
//  Created by xa on 16/7/14.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyViewController.h"
#import "Definition.h"
#import "CustomCell.h"
#import "DefineConstant.h"
#import "SetingViewController.h"
#import "CWLoginViewController.h"
#import "MyAddressViewController.h"
#import "UIColor+Hex.h"
#import "CWLoginViewController.h"

#import "UINavigationBar+Awesome.h"
#import "RemindServiceVC.h"
#import "TrafficViolationViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

#import "MyCollectVC.h"
#import "SharedHelper.h"
#import "OrderViewController.h"
#import "ShopCardVC.h"
#import "MyLoveCarVC.h"
#import "MyDelegate.h"
#import "MyBankCardViewController.h"

#import "MyLoveCarNoBindVC.h"

#import "UIImageView+WebCache.h"
#import "PayManager.h"
#define NAVBAR_CHANGE_POINT 50
@interface MyViewController () <UITableViewDelegate, UITableViewDataSource,BZEventCenterDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *myTableHeaderView;
@property (weak, nonatomic) IBOutlet UIView *myTableFootView;

@property (weak, nonatomic) IBOutlet UIImageView *ImageIcon;
@property (strong, nonatomic) NSString *tapString;
@property (weak, nonatomic) IBOutlet UILabel *lbUserName;
@property (weak, nonatomic) IBOutlet UILabel *cararPlateLabel; //车牌
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel; //余额
@property (weak, nonatomic) IBOutlet UILabel *couponLabel; //劵
@property (weak, nonatomic) IBOutlet UILabel *bankCardCountLabel; //银行卡
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;


//我的钱包
@property (weak, nonatomic) IBOutlet UIImageView *walletImage;
//银行卡
@property (weak, nonatomic) IBOutlet UIImageView *carImage;
//我的劵
@property (weak, nonatomic) IBOutlet UIImageView *myTicketImage;
//我的车库
@property (weak, nonatomic) IBOutlet UIImageView *myCarImage;

- (IBAction)myAllOrder:(id)sender;


@end


@implementation MyViewController
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
            
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdenifer = @"CustomCell";
    CustomCell *cell = [_myTableView dequeueReusableCellWithIdentifier:cellIdenifer];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSString *imageString = [NSString stringWithFormat:@"%ld%ld", section,row];
    [cell.iconImageView setImage:[UIImage imageNamed:imageString]];
    
    if (section == 0) {
        if (row == 0) {
            cell.titLabel.text = @"购物车";
            cell.describeLabel.text = @"";
        } else if (row == 1) {
            cell.titLabel.text = @"收货地址";
            cell.describeLabel.text = @"";
        } else {
            
        }
    } else if (section == 1) {
        if (row == 0) {
            cell.titLabel.text = @"我的收藏";
            cell.describeLabel.text = @"";
        }
    } else if (section == 2) {
        if (row == 0) {
            cell.titLabel.text = @"邀请好友";
            cell.describeLabel.text = @"邀请好友有礼";
            [cell.describeLabel setAlpha:0.5];
        } else {
            cell.titLabel.text = @"客服服务";
            cell.describeLabel.text = @"";
        }
    } else {
        if (row == 0) {
            cell.titLabel.text = @"道路救援";
            cell.describeLabel.text = @"";
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *token = [COM getLoginToken];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([token isEqualToString:@""]  || token == nil) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
                CWLoginViewController  *lg = [sb instantiateViewControllerWithIdentifier:@"login"];
                self.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:lg animated:YES];
                return;
            }
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ShopCard" bundle:nil];
            ShopCardVC *myCollect = [storyboard instantiateViewControllerWithIdentifier:@"ShopCardVC"];
            [self.navigationController pushViewController:myCollect animated:YES];
        }else if (indexPath.row == 1){
            if ([token isEqualToString:@""] || token == nil) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
                CWLoginViewController  *lg = [sb instantiateViewControllerWithIdentifier:@"login"];
                self.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:lg animated:YES];
                return;
            }
            //收货地址
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MyAddress" bundle:nil];
            MyAddressViewController *myvc = [storyBoard instantiateViewControllerWithIdentifier:@"MyAddressViewController"];
            [self.navigationController pushViewController:myvc animated:YES];
        }else{
            
        }
    } else if (indexPath.section == 1) { //我的收藏
        if (indexPath.row == 0) {
            if ([token isEqualToString:@""]  || token == nil) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
                CWLoginViewController  *lg = [sb instantiateViewControllerWithIdentifier:@"login"];
                self.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:lg animated:YES];
                return;
            }
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyCollect" bundle:nil];
            MyCollectVC *myCollect = [storyboard instantiateViewControllerWithIdentifier:@"MyCollectVC"];
            [self.navigationController pushViewController:myCollect animated:YES];
        }
    } else if (indexPath.section == 2) { //邀请好友--分享
        if (indexPath.row == 0) {
            NSArray *imageArray = @[[UIImage imageNamed:@"二维码"]];
            //    NSArray *imageArray_1 = @[@""];
            [[SharedHelper sharedHelper] sharedImageArray:imageArray Text:@"洗洋洋是一款汽车服务类App,满足汽车的所有需求" url:[NSURL URLWithString:@"http://mob.com"] title:@"欢迎下载洗洋洋"];
        }else{
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://10086"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
    } else if (indexPath.section == 3) { //查询违章
        
        if (indexPath.row == 0) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://10086"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 41;
}


//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2;
    
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}


- (void)loadTabarItem {
    //设置按钮
    self.navigationItem.rightBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"设置按钮icon"]
                                       highlightedImage:nil
                                                 titles:@""
                                                  alpha:1.0f
                                                 target:self
                                                 action:@selector(setingAction:)
                                       forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -- 设置
- (void)setingAction:(UIButton *)sender {
    NSString *toke =  [COM getLoginToken];
    if ([toke isEqualToString:@""] || toke == nil) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController  *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }

    UIStoryboard *setingStoryBoard = [UIStoryboard storyboardWithName:@"Seting" bundle:nil];
    SetingViewController* setingVC = [setingStoryBoard instantiateViewControllerWithIdentifier:@"SetingViewController"];
    [self.navigationController pushViewController:setingVC animated:YES];
  
}

#pragma mark -- 
- (void)myClick {
    _ImageIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myImageClick:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    //tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_ImageIcon addGestureRecognizer:tapGestureRecognizer];
    
    _walletImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(walletImageClick:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    //tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_walletImage addGestureRecognizer:tapGestureRecognizer1];
    
    _carImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carImageClick:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    //tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_carImage addGestureRecognizer:tapGestureRecognizer2];
    
    _myTicketImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTicketlick:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    //tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_myTicketImage addGestureRecognizer:tapGestureRecognizer3];

    
    _myCarImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myCarImageClick:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    //tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_myCarImage addGestureRecognizer:tapGestureRecognizer4];
}

#pragma mark -- 我的钱包
-(void)walletImageClick:(UITapGestureRecognizer*)tap{
    NSString *tokeStirng = [COM getLoginToken];
    if ([tokeStirng isEqualToString:@""] || tokeStirng == nil || [tokeStirng isEqualToString:@"(null)"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController  *lg = [sb instantiateViewControllerWithIdentifier:@"login"];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MyWallet" bundle:nil];
        UIViewController *lg = [sb instantiateViewControllerWithIdentifier:@"MyWalletVC"];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
    }
}

#pragma mark -- 银行卡
-(void)carImageClick:(UITapGestureRecognizer*)tap{
    NSString *tokeStirng = [COM getLoginToken];
    if ([tokeStirng isEqualToString:@""] || tokeStirng == nil || [tokeStirng isEqualToString:@"null"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController  *lg = [sb instantiateViewControllerWithIdentifier:@"login"];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BankCard" bundle:nil];
        MyBankCardViewController *lg = [sb instantiateViewControllerWithIdentifier:@"MyBankCardVC"];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
    }
}
#pragma mark -- 我的券
-(void)myTicketlick:(UITapGestureRecognizer*)tap{
    NSString *tokeStirng = [COM getLoginToken];
    if ([tokeStirng isEqualToString:@""] || tokeStirng == nil || [tokeStirng isEqualToString:@"(null)"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController  *lg = [sb instantiateViewControllerWithIdentifier:@"login"];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MyCoupons" bundle:nil];
        UIViewController *lg = [sb instantiateViewControllerWithIdentifier:@"MyCoupons"];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
    }
}
#pragma mark -- 我的爱车
-(void)myCarImageClick:(UITapGestureRecognizer*)tap{
    NSString *tokeStirng = [COM getLoginToken];
    if ([tokeStirng isEqualToString:@""] || tokeStirng == nil || [tokeStirng isEqualToString:@"(null)"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController  *lg = [sb instantiateViewControllerWithIdentifier:@"login"];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
    } else {
        if ([COM getCarID]== nil || [[COM getCarID] isEqualToString:@""] || [[COM getCarID] isEqualToString:@"<null>"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MyLoveCar" bundle:nil];
            MyLoveCarNoBindVC  *myLoveCarNoBind = [sb instantiateViewControllerWithIdentifier:@"MyLoveCarNoBindVC"];
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:myLoveCarNoBind animated:YES];
        }else{
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MyLoveCar" bundle:nil];
        MyLoveCarVC  *lg = [sb instantiateViewControllerWithIdentifier:@"MyLoveCarVC"];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
        }
    }
}
-(void)myImageClick:(UITapGestureRecognizer*)tap{
    NSString *toke = [COM getLoginToken];
    if ([toke isEqualToString:@""] || toke == nil || [toke isEqualToString:@"(null)"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController *lg = [sb instantiateViewControllerWithIdentifier:@"login"];
        self.navigationController.navigationBarHidden = YES;
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
        return;
    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Seting" bundle:nil];
    UIViewController *lg = [sb instantiateViewControllerWithIdentifier:@"SetingViewController"];
    [self.navigationController pushViewController:lg animated:YES];
}
#pragma mark --  navigationBar渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0.99 green:0.80 blue:0.21 alpha:1.00];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    
    if (param == nil) {
        self.balanceLabel.text = @"";
        self.balanceLabel.text = [NSString stringWithFormat:@"余额:0"];
        self.bankCardCountLabel.text = @"";
        self.bankCardCountLabel.text = [NSString stringWithFormat:@"0张"];
        return;
    }
    
    if ([eventType isEqualToString:CWEventCenterTypeCouponCount]) {
        NSLog(@"%@",param);
        
        NSNumber *couponCountNum = param[@"ticket_count"];
        NSString *couponCount = [NSString stringWithFormat:@"%@",couponCountNum];
        
        if ([couponCount isEqualToString:@"-1"]) {
            NSLog(@"请求超时！！！");
            //劵
            NSString *tike = [NSString stringWithFormat:@"%@",[COM getTiketCount]];
            if (tike.length == 0) {
                self.couponLabel.text = @"";
            } else {
                self.couponLabel.text = [NSString stringWithFormat:@"%@张未使用",[COM getTiketCount]];
            }
        }else if ([couponCount isEqualToString:@"(null)"]){
            self.couponLabel.text = @"";
        }else{
            self.couponLabel.text = [NSString stringWithFormat:@"%@张未使用",couponCount];
        }
        
    }
    if ([eventType isEqualToString:CWEventCenterTypeCardcountAndBalance]) {
        NSLog(@"%@",param);
        NSNumber *balanceNum = param[@"blance"];
        NSString *blance = [NSString stringWithFormat:@"%@",balanceNum];
        
        if ([blance isEqualToString:@"-1"]) {
            //余额
            NSString *blane = [NSString stringWithFormat:@"%@",[COM getUserBlance]];
            if (blane.length == 0 || [blane isEqualToString:@"-1"]) {
                self.balanceLabel.text = @"";
            } else {
                if ([[COM getUserBlance] isEqualToString:@"(null)"]) {
                    self.balanceLabel.text = @"";
                    self.balanceLabel.text = [NSString stringWithFormat:@"余额:"];
                }else{
                    self.balanceLabel.text = [NSString stringWithFormat:@"余额:%@",[COM getUserBlance]];
                }
                
            }
        }else{
            _balanceLabel.text = [NSString stringWithFormat:@"余额:%@", blance];
        }
        
        
        NSString *bankCardCount = [NSString stringWithFormat:@"%@",param[@"bank_card_count"]];
        if ([bankCardCount isEqualToString:@"-1"]) {
            NSString *bankcardCount =[NSString stringWithFormat:@"%@",[COM getBankCardCount]];
            if (bankcardCount.length == 0 || [bankcardCount isEqualToString:@"-1"]) {
                self.bankCardCountLabel.text = @"";
            } else {
                
                if ([[COM getBankCardCount] isEqualToString:@"(null)"]) {
                    self.bankCardCountLabel.text = @"";
                    self.bankCardCountLabel.text = [NSString stringWithFormat:@"0张"];
                }else{
                    self.bankCardCountLabel.text = [NSString stringWithFormat:@"%@张",[COM getBankCardCount]];
                }
                
            }
        }else{
            self.bankCardCountLabel.text = [NSString stringWithFormat:@"%@张",bankCardCount];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCouponCount callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCardcountAndBalance callback:self];
    self.myTableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCardcountAndBalance callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCouponCount callback:self];
    //navigationBar渐变
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self scrollViewDidScroll:self.myTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    NSString *token = [COM getLoginToken];
    if ([token isEqualToString:@""] || token == nil || [token isEqualToString:@"(null)"]) {
        self.ImageIcon.image = [UIImage imageNamed:@"头像(未登录)"];
        self.lbUserName.text = @"";
        self.balanceLabel.text = @"";
        self.bankCardCountLabel.text = @"";
        self.couponLabel.text = @"";
        self.cararPlateLabel.text = @"";
        

        if ([COM getLoginToken].length > 0) {
            _vipImageView.hidden = NO;
        } else {
            _vipImageView.hidden = YES;
        }
        return;
    }
    
#pragma mark== 查询消费券数量
    LC_LOADING
    [[PayManager sharedManager] quaryCouponCount];
#pragma mark==查询银行卡数量和账户余额;
    LC_LOADING
    [[PayManager sharedManager] quarybankCardCountAndBalance];
    

    if ([COM getLoginToken].length > 0) {
        _vipImageView.hidden = NO;
    } else {
        _vipImageView.hidden = YES;
    }
    
    if ([[COM getCarPlate] isEqualToString:@"<null>"]) {
        
    }else{
        _cararPlateLabel.text = [COM getCarPlate]; //获取车牌
    }
    
    
    
//    设置圆形头像
    self.ImageIcon.layer.cornerRadius = self.view.frame.size.width/12;
    self.ImageIcon.layer.masksToBounds = YES;
    if ([COM getUserURL].length != 0) {
        NSString *imageString = [NSString stringWithFormat:@"%@%@/%@", @"http://", API_SERVER_HOST, [COM getUserURL]];
        NSURL *URL = [NSURL URLWithString:imageString];
        [self.ImageIcon sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"头像(未登录)"]];
    }else{
        self.ImageIcon.image = [UIImage imageNamed:@"头像(未登录)"];
    }
    
    NSString *toke = [COM getLoginToken];
    NSString *name = [COM getLoginPhone];
    if ([toke isEqualToString:@""] || toke == nil) {
        _lbUserName.text = @"";
    }
    else {
        _lbUserName.text = name;
    }
}
- (void)toOrderVC {
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"OrderViewController" bundle:nil];
    OrderViewController *personalInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
    [self.navigationController pushViewController:personalInfoVC animated:YES];
}

- (void)myToBeEvaluatedTap:(UITapGestureRecognizer *)tap {
    [self toOrderVC];
}
- (void)myReceiptGoodsVeiwTap:(UITapGestureRecognizer *)tap {
    [self toOrderVC];
}
- (void)myToBeShippedViewTap:(UITapGestureRecognizer *)tap {
    [self toOrderVC];
}
- (void)myPendingPaymentViewTap:(UITapGestureRecognizer *)tap {
    [self toOrderVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.tableHeaderView = _myTableHeaderView;
    //加载左右按钮
    [self loadTabarItem];
    [self myClick];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    
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


- (IBAction)myAllOrder:(id)sender {
    
    NSString *token = [COM getLoginToken];
    if ([token isEqualToString:@""] || token == nil) {
        LCSUCCESS_ALSERT(@"请登录后操作");
        return;
    }
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"OrderViewController" bundle:nil];
    OrderViewController *personalInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
    [self.navigationController pushViewController:personalInfoVC animated:YES];
}
@end
