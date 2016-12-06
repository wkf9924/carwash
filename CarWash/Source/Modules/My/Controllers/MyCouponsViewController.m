//
//  MyCouponsViewController.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/18.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

//优惠劵的色值： 251  149  47;

#import "MyCouponsViewController.h"
#import "DefineConstant.h"
#import "ConsumeListModel.h"//消费券列表模型
#import "CouponListModel.h"//优惠券列表模型
#import "PreferentialDetailCarWashVC.h"

@interface MyCouponsViewController () <UITableViewDelegate, UITableViewDataSource, BZEventCenterDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *consumeBtn;
@property NSInteger type;

- (IBAction)coupornsAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *discountBtn;
@property (nonatomic, strong)NSMutableArray *consumeData;
@property (nonatomic, strong)NSMutableArray *couponData;
@property (strong, nonatomic) IBOutlet UIView *emptyStatusView;//空状态View
@property (strong, nonatomic) IBOutlet UILabel *emptyStatusLabel;//显示暂无消费券,或者暂无优惠劵

@end

@implementation MyCouponsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeConsumeList callback:self];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeCouponList  callback:self];
    
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeConsumeList callback:self];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeCouponList callback:self];
    
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    if (_consumeData) {
        [_consumeData removeAllObjects];
    }
    if (_couponData) {
        [_couponData removeAllObjects];
    }
    if([eventType isEqualToString:CWEventCenterTypeConsumeList]){
        NSLog(@"消费券列表:%@",param);
        for (NSDictionary *dic in param) {
            ConsumeListModel *model = [[ConsumeListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.consumeData addObject:model];
        }
        
        if (_type == 100) {
            if (self.consumeData.count == 0) {
//                self.myTableView.hidden = YES;、
                self.emptyStatusView.hidden = NO;
            }else{
                self.myTableView.hidden = NO;
                self.emptyStatusView.hidden = YES;
            }
        }
        
        
    } else if ([eventType isEqualToString:CWEventCenterTypeCouponList]) {
        NSLog(@"优惠券列表:%@",param);
        for (NSDictionary *dic in param) {
            CouponListModel *model = [[CouponListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.couponData addObject:model];
        }
        if (_type == 200) {
            if (self.couponData.count == 0) {
//                self.myTableView.hidden = YES;
                self.emptyStatusView.hidden = NO;
            }else{
                self.myTableView.hidden = NO;
                self.emptyStatusView.hidden = YES;
            }
        }
        
    } else {
        
    }
    [self.myTableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的劵";
    [self setBackBarButton];
    self.view.backgroundColor = TSEColor(242, 242, 242);
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"ConsumeCell" bundle:nil] forCellReuseIdentifier:@"ConsumeCell"];
     [self.myTableView registerNib:[UINib nibWithNibName:@"CoupornsCell" bundle:nil] forCellReuseIdentifier:@"CoupornsCell"];
    self.myTableView.tableHeaderView.frame = CGRectMake(0, 10, 0, 43);
    self.myTableView.tableHeaderView = _headerView;
    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //导航右边按钮
//    self.navigationItem.rightBarButtonItem
//    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"帮助icon"]
//                                       highlightedImage:nil
//                                                 titles:@""
//                                                  alpha:1.0f
//                                                 target:self
//                                                 action:@selector(helpClick:)
//                                       forControlEvents:UIControlEventTouchUpInside];
    
    _type = 100;
    [_consumeBtn setTitleColor:TSEColor(251, 149, 47) forState:0];
    [_consumeBtn setBackgroundImage:[UIImage imageNamed:@"券类型被选中底色"] forState:UIControlStateNormal];
    [self myConsumeList]; //我的消费劵列表
    
}
//#pragma mark -- 点击问好按钮
//- (void)helpClick:(UIButton *)sender {
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 消费劵列表
- (void)myConsumeList {
    LC_LOADING
    [[CouponManager sharedManager] consumeList:@""];
}
#pragma mark -- 优惠劵列表
- (void)myCouponList {
    LC_LOADING
    [[CouponManager sharedManager] couponList:@""];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (_type) {
        case 100:
        {
            return self.consumeData.count;
        }
            break;
            
        case 200:
        {
            return self.couponData.count;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_type) {
        case 100:
        {
            ConsumeCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"ConsumeCell"];
            ConsumeListModel *model = self.consumeData[indexPath.row];
            
            cell.washLabel.font = [UIFont systemFontOfSize:15];
            cell.washLabel.textColor = [UIColor blackColor];
            cell.washContentLabel.font = [UIFont systemFontOfSize:13];
            cell.washContentLabel.textColor = [UIColor darkGrayColor];
            cell.washLabel.text = model.name;
            cell.washContentLabel.text = model.remark;
            
            
            if ([model.servicetype isEqualToString:@"1"]) {
                cell.cosumeImage.image = [UIImage imageNamed:@"order_洗车icon"];
            }else if ([model.servicetype isEqualToString:@"2"]){
                cell.cosumeImage.image = [UIImage imageNamed:@"order_四轮定位icon"];
            }else if ([model.servicetype isEqualToString:@"3"]){
                cell.cosumeImage.image = [UIImage imageNamed:@"order_打蜡icon"];
            }else if ([model.servicetype isEqualToString:@"4"]){
                cell.cosumeImage.image = [UIImage imageNamed:@"order_大保icon"];
            }else if ([model.servicetype isEqualToString:@"5"]){
                cell.cosumeImage.image = [UIImage imageNamed:@"order_小保icon"];
            }else if ([model.servicetype isEqualToString:@"-1"]){
                cell.cosumeImage.image = [UIImage imageNamed:@"order_特惠洗车icon"];
            }
            return cell;
        }
            break;
            
        case 200:
        {
            CoupornsCell  *cell = [_myTableView dequeueReusableCellWithIdentifier:@"CoupornsCell"];
            CouponListModel *model = self.couponData[indexPath.row];
            cell.cupornsLabel.text = model.name;
            cell.timeLabel.text = [NSString stringWithFormat:@"有效期至:%@", model.end_time];
            cell.detailLabel.text = model.use_range;
            cell.remarkLabel.text = model.remark;
            cell.moneyLabel.text = [NSString stringWithFormat:@"%ld",(long)model.money];
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (_type) {
        case 100:
        {
            ConsumeListModel *model = self.consumeData[indexPath.row];
            if (![model.servicetype isEqualToString:@"-1"]) {
                UIStoryboard *setingStoryBoard = [UIStoryboard storyboardWithName:@"ConsumTicketDetail" bundle:nil];
                ConsumTicketDetailVC* setingVC = [setingStoryBoard instantiateViewControllerWithIdentifier:@"ConsumTicketDetailVC"];
                ConsumeListModel *model = self.consumeData[indexPath.row];
                setingVC.consumeModel = model;
                [self.navigationController pushViewController:setingVC animated:YES];
            }else{
                UIStoryboard *setingStoryBoard = [UIStoryboard storyboardWithName:@"ConsumTicketDetail" bundle:nil];
                PreferentialDetailCarWashVC *prefer = [setingStoryBoard instantiateViewControllerWithIdentifier:@"PreferentialDetailCarWashVC"];
                prefer.consumeModel = model;
                [self.navigationController pushViewController:prefer animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_type) {
        case 100:
            return 64;
            break;
        case 200:
            return 136;
            break;
            
        default:
            break;
    }
    return 0;
}

#pragma mark -- 点击消费券和优惠劵
- (IBAction)coupornsAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag == 100) {  //消费券
        _type = 100;
        [_consumeBtn setTitleColor:TSEColor(251, 149, 47) forState:0];
        [_consumeBtn setBackgroundImage:[UIImage imageNamed:@"券类型被选中底色"] forState:UIControlStateNormal];
        [_discountBtn setTitleColor:[UIColor blackColor] forState:0];
        [_discountBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.emptyStatusLabel.text = @"暂无消费券";
        [self myConsumeList];

    } else {  //优惠劵
        _type = 200;
        [_discountBtn setTitleColor:TSEColor(251, 149, 47) forState:0];
        [_discountBtn setBackgroundImage:[UIImage imageNamed:@"券类型被选中底色"] forState:UIControlStateNormal];
        [_consumeBtn setTitleColor:[UIColor blackColor] forState:0];
        [_consumeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.emptyStatusLabel.text = @"暂无优惠券";
        [self myCouponList];
    }
    [_myTableView reloadData];
}
- (NSMutableArray *)consumeData{
    if (!_consumeData) {
        _consumeData = [[NSMutableArray alloc] init];
    }
    return _consumeData;
}
- (NSMutableArray *)couponData{
    if (!_couponData) {
        _couponData = [[NSMutableArray alloc] init];
    }
    return _couponData;
}
@end
