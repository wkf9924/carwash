//
//  TopUpViewController.m
//  CarWash
//
//  Created by xa on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "TopUpViewController.h"
#import "DefineConstant.h"
#import "SelectBankCell.h"
#import "PasswordViewController.h"
#import "PayManager.h"
#import "BindedBankCardModel.h"

@interface TopUpViewController ()<BZEventCenterDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *AccountBalanceTextfild;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;
@property (weak, nonatomic) IBOutlet UILabel *bankCardNumber;
@property (weak, nonatomic) IBOutlet UILabel *canTopUpCashCount;
@property (nonatomic, strong) UIView *selectBankView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *closeView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSString *CardNumber;
@end

@implementation TopUpViewController
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
            self.bankName.text = @"请绑卡";
            self.bankCardNumber.text = @"****";
            return;
        }
        NSLog(@"绑定银行卡返回:%ld",self.datasource.count);
        BindedBankCardModel *model = self.datasource.firstObject;
        self.bankName.text = model.openBank;
        self.CardNumber = model.cardNo;
        NSString *cardNum = [model.cardNo substringFromIndex:model.cardNo.length - 4];
        self.bankCardNumber.text = [NSString stringWithFormat:@"尾号%@",cardNum];
        [self.tableView reloadData];
    }
}

- (void)loadCardList {
    NSString *userid = [COM getUserId];
    if (userid.length == 0) {
        return;
    }
    COM.isPay = YES;
    [[PayManager sharedManager] bindCardLisappid:APPID  userId:userid verifyKey:@""];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self loadCardList];
    //底部弹出半透明View
    [self.view bringSubviewToFront:self.selectBankView];
    [self loadSelectBankView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    NSLog(@"测试测试");
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectBankCell" forIndexPath:indexPath];
    
    BindedBankCardModel *model = self.datasource[indexPath.row];
    cell.bankName.text = model.openBank;
    
    NSString *cardNum = [model.cardNo substringFromIndex:model.cardNo.length - 4];
    cell.accountBalance.text = [NSString stringWithFormat:@"尾号%@",cardNum];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BindedBankCardModel *model = self.datasource[indexPath.row];
    self.bankName.text = model.openBank;
    NSString *cardNum = [model.cardNo substringFromIndex:model.cardNo.length - 4];
    self.bankCardNumber.text = [NSString stringWithFormat:@"尾号%@",cardNum];
    
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

//下一步按钮回调
- (IBAction)nextStepButton:(UIButton *)sender {
    NSLog(@"确认提现");
    PasswordViewController *passwordVC = [[PasswordViewController alloc] init];
    if (self.AccountBalanceTextfild.text.length == 0) {
        LC_SHOW_FAIL(@"请输入充值金额");
    }else{
    passwordVC.interface = @"topUp";
    passwordVC.cashCount = self.AccountBalanceTextfild.text;
    passwordVC.cardNum = self.CardNumber;
    [self.navigationController pushViewController:passwordVC animated:YES];
    }
}
//选择银行卡按钮回调
- (IBAction)selectBankButton:(UIButton *)sender {
    
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
