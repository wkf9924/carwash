
//#im//
//  TransactionVC.m
//  CarWash
//
//  Created by WangKaifeng on 2016/11/16.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "TransactionVC.h"
#import "Definition.h"
#import "DefineConstant.h"
#import "TransactionCell.h"
#import "SecretHelper.h"
#import "PayManager.h"
#import "TransactionModel.h"
#define FIND_LIST @"FIND_LIST"
#define COUNT @"1000"
#import "MJRefresh.h"
#import "BZPagingCenter.h"
@interface TransactionVC () <UITableViewDelegate,UITableViewDataSource,BZEventCenterDelegate> {
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic)  NSArray *sectionTitleArray;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (nonatomic,assign)  int currentPagingType;
@end

@implementation TransactionVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeTransaction callback:self];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeTransaction callback:self];
    
    COM.isPay = NO;
}

#pragma mark -  BZEventCenterDelegate methods
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
    if ([eventType isEqualToString:CWEventCenterTypeTransaction]) {
        
        if(_currentPagingType==BZPagingTypeDownPull){
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in param) {
                TransactionModel  *model = [[TransactionModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];
            }
            self.datasource = array;
        }else {
            NSArray *array = param;
            if (array.count == 0) {
                LCSUCCESS_ALSERT(@"没有更多数据了")
                [self.myTableView reloadData];
                return;
            }
            for (NSDictionary *dic in param) {
                TransactionModel *model = [[TransactionModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.datasource arrayByAddingObject:model];
            }
            
        }
        self.myTableView.dataSource = self;
        self.myTableView.delegate = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
    }else {
        LCSUCCESS_ALSERT(@"请求失败,请检查网络后重试!");
    }
}

- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc]init];
    }
    return _datasource;
}



- (NSArray *)sectionTitleArray {
    if (!_sectionTitleArray) {
        _sectionTitleArray = [NSMutableArray array];
    }
    return _sectionTitleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易记录";
    [self setBackBarButton];

    [self.myTableView registerNib:[UINib nibWithNibName:@"TransactionCell" bundle:nil] forCellReuseIdentifier:@"TransactionCell"];
    int currentPage = [[BZPagingCenter defaultCenter]getPage:BZPagingTypeDownPull tag:FIND_LIST];
    NSString *currentPateString = [NSString stringWithFormat:@"%d", currentPage];
    [[PayManager sharedManager] transactionListcount:COUNT page:currentPateString tpye:@"0"];
    _currentPagingType = BZPagingTypeDownPull;
//    [self initPullToRefresh];
//    [self.myTableView.mj_header beginRefreshing];
//    [self transactionList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)transactionList {
    [[PayManager sharedManager] transactionListcount:@"10" page:@"1" tpye:@"0"];
}


-(void)initPullToRefresh
{
    
    // 下拉刷新
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPagingType = BZPagingTypeDownPull;
        int currentPage = [[BZPagingCenter defaultCenter]getPage:BZPagingTypeDownPull tag:FIND_LIST];
        NSString *currentPateString = [NSString stringWithFormat:@"%d", currentPage];
        [[PayManager sharedManager] transactionListcount:COUNT page:currentPateString tpye:@"0"];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    self.myTableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _currentPagingType = BZPagingTypeUpPull;
        int currentPage = [[BZPagingCenter defaultCenter]getPage:BZPagingTypeUpPull tag:FIND_LIST];
        NSString *currentPateString = [NSString stringWithFormat:@"%d", currentPage + 1];

       [[PayManager sharedManager] transactionListcount:COUNT page:currentPateString tpye:@"0"];
    }];
    
}

   

#pragma mark--tableView代理方法实现

//section （标签）标题显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TransactionModel *transModel = [self.datasource objectAtIndex:section];
    return transModel.name;
}
//标签数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.datasource.count;
}

// 设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 30;
//    }
    return 40;
}


//tableviewcell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    TransactionModel *transModel = [self.datasource objectAtIndex:section];
    return transModel.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionCell" forIndexPath:indexPath];
     TransactionModel *transModel = [self.datasource objectAtIndex:indexPath.section];
    TransactionList *transList = transModel.listArray [indexPath.row];
    cell.lbTitle.text = transList.remark;
    cell.lbTime.text = transList.create_time;
    NSString *amount;
    amount = [NSString stringWithFormat:@"%@", transList.amount];
    NSInteger change =  [amount intValue];
     cell.lbPrice.text = amount;
    if (change > 0)
    {
        [cell.lbPrice setTextColor:[UIColor redColor]];
        cell.lbPrice.text  = [NSString stringWithFormat:@"+%@", amount];
    }
    else
    {
        
        [cell.lbPrice setTextColor:[UIColor greenColor]];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 57;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
