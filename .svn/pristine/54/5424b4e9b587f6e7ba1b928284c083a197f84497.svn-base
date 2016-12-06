//
//  GetCashViewController.m
//  CarWash
//
//  Created by xa on 16/7/19.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "GetCashViewController.h"
#import "SelectBankCell.h"
#import "DefineConstant.h"
#import "PayManager.h"
#import "PasswordViewController.h"
#import "BindedBankCardModel.h"

@interface GetCashViewController ()<UITableViewDelegate, UITableViewDataSource, BZEventCenterDelegate>
@property (strong, nonatomic) IBOutlet UILabel *bankNameLabel;//银行名
@property (strong, nonatomic) IBOutlet UILabel *bankNumber;//银行卡后四位
@property (strong, nonatomic) IBOutlet UILabel *arriveTimeOfAccount;//到账时间
@property (strong, nonatomic) IBOutlet UILabel *canGetCashs;//可提现的金额
@property (strong, nonatomic) IBOutlet UITextField *getCashCountTextFiled;//输入提现金额

@property (nonatomic, strong) UIView *selectBankView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *closeView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) BindedBankCardModel *cardModel;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSString *cardNumber;
@end

@implementation GetCashViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeBindCardList callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeBindCardListFail callback:self];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeBindCardList callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeBindCardListFail callback:self];
    self.tabBarController.tabBar.hidden = NO;

    COM.isPay = NO;
}

#pragma mark -  BZEventCenterDelegate methods
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    if ([eventType isEqualToString:CWEventCenterTypeBindCardList]) {
        NSLog(@"绑定银行卡查询:%@",param);
        for (NSDictionary *dic in param) {
            BindedBankCardModel *model = [[BindedBankCardModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.datasource addObject:model];
        }
        
        
        if (self.datasource.count == 0) {
            self.bankNameLabel.text = @"请绑卡";
            self.bankNumber.text = @"****";
            return;
        }
        NSLog(@"绑定银行卡返回:%ld",self.datasource.count);
        BindedBankCardModel *model = self.datasource.firstObject;
        self.bankNameLabel.text = model.openBank;
        self.cardNumber = model.cardNo;
        NSString *cardNum = [model.cardNo substringFromIndex:model.cardNo.length - 4];
        self.bankNumber.text = [NSString stringWithFormat:@"尾号%@",cardNum];
        [self.tableView reloadData];
    }else {
        LC_SHOW_FAIL(@"请求失败,请检查网络后重试!");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    //加载银行卡列表
    [self loadCardList];
    [self loadSelectBankView];
    self.canGetCashs.text = [NSString stringWithFormat:@"可提现金额:%.2f",[self.model.active_amount floatValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadCardList {
    NSString *userid = [COM getUserId];
    if (userid.length == 0) {
        return;
    }
    COM.isPay = YES;
    LC_LOADING
    [[PayManager sharedManager] bindCardLisappid:APPID  userId:userid verifyKey:@""];
}
//加载选择银行的视图
- (void)loadSelectBankView{
    self.selectBankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.selectBankView.backgroundColor =[UIColor blackColor];
    self.selectBankView.alpha = 0.4;
    
    
    self.closeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.selectBankView.bounds.size.height,self.selectBankView.bounds.size.width, 40)];
    self.closeView.backgroundColor = [UIColor whiteColor];
    [self.selectBankView addSubview:self.closeView];
    
    
    UILabel *selectTitie = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, self.closeView.bounds.size.width/2, 30)];
    selectTitie.textColor = [UIColor darkGrayColor];
    selectTitie.font = [UIFont systemFontOfSize:16];
    selectTitie.text = @"请选择银行";
    selectTitie.textAlignment = NSTextAlignmentCenter;
    [self.closeView addSubview:selectTitie];
    
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(self.closeView.bounds.size.width-40, 5, 30, 30);
    [self.button setImage:[UIImage imageNamed:@"选择支付方式-关闭按钮"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.closeView addSubview:self.button];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.selectBankView.bounds.size.height+40, self.selectBankView.bounds.size.width, self.selectBankView.bounds.size.height /3) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectBankCell" bundle:nil] forCellReuseIdentifier:@"SelectBankCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.selectBankView addSubview:self.tableView];
    [self.view addSubview:self.selectBankView];
    self.selectBankView.hidden = YES;
}
//关闭选择银行的视图
- (void)closeButtonAction{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect_1 = self.closeView.frame;
        rect_1 = CGRectMake(0,self.selectBankView.bounds.size.height,self.selectBankView.bounds.size.width, 40);
        self.closeView.frame = rect_1;
        CGRect rect = self.tableView.frame;
        rect = CGRectMake(0, self.selectBankView.bounds.size.height+40, self.selectBankView.bounds.size.width, self.selectBankView.bounds.size.height/3);
        self.tableView.frame = rect;
        self.selectBankView.hidden = YES;
    }];
}
#pragma mark--tableView 代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectBankCell" forIndexPath:indexPath];
    
    BindedBankCardModel *model = self.datasource[indexPath.row];
    cell.bankName.text = model.openBank;
    
    NSString *cardNum = [model.cardNo substringFromIndex:model.cardNo.length - 4];
    cell.accountBalance.text = [NSString stringWithFormat:@"尾号%@",cardNum];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BindedBankCardModel *model = self.datasource[indexPath.row];
    self.bankNameLabel.text = model.openBank;
    NSString *cardNum = [model.cardNo substringFromIndex:model.cardNo.length - 4];
    self.bankNumber.text = [NSString stringWithFormat:@"尾号%@",cardNum];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect_1 = self.closeView.frame;
        rect_1 = CGRectMake(0,self.selectBankView.bounds.size.height,self.selectBankView.bounds.size.width, 40);
        self.closeView.frame = rect_1;
        CGRect rect = self.tableView.frame;
        rect = CGRectMake(0, self.selectBankView.bounds.size.height+40, self.selectBankView.bounds.size.width, self.selectBankView.bounds.size.height/3);
        self.tableView.frame = rect;
        self.selectBankView.hidden = YES;
    }];
}
//确认提现按钮回调
- (IBAction)commitGetCashButton:(UIButton *)sender {
    NSLog(@"确认提现");
    PasswordViewController *passwordVC = [[PasswordViewController alloc] init];
    passwordVC.interface = @"getCash";
    if (self.getCashCountTextFiled.text.length == 0){
        LC_SHOW_FAIL(@"请输入提现金额");
    }else{
        passwordVC.cashCount = self.getCashCountTextFiled.text;
        passwordVC.cardNum = self.cardNumber;
       [self.navigationController pushViewController:passwordVC animated:YES];
    }
    
    
    
    
    
}
//选择银行按钮回调
- (IBAction)selectBankButton:(UIButton *)sender {
    NSLog(@"选择银行");
    
    [UIView animateWithDuration:0.3 animations:^{
        self.selectBankView.hidden = NO;
        
        CGRect rect_1 = self.closeView.frame;
        rect_1 = CGRectMake(0,self.selectBankView.bounds.size.height * 2/3-40,self.selectBankView.bounds.size.width, 40);
        self.closeView.frame = rect_1;
        CGRect rect = self.tableView.frame;
        rect = CGRectMake(0, self.selectBankView.bounds.size.height*2/3, self.selectBankView.bounds.size.width, self.selectBankView.bounds.size.height /3);
        self.tableView.frame = rect;
    }];
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
