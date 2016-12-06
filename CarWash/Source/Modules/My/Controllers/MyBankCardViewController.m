//
//  MyBankCardViewController.m
//  CarWash
//
//  Created by xa on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyBankCardViewController.h"
#import "MyBankCardCell.h"
#import "DefineConstant.h"
#import "MyBankCardDetailViewController.h"
#import "BindBankCardVC.h"
#import "PayManager.h"
#import "PasswordViewController.h"

@interface MyBankCardViewController ()<UITableViewDelegate, UITableViewDataSource,BZEventCenterDelegate>
@property (strong, nonatomic) IBOutlet UIView *emptyStatusView;//空状态显示此View,隐藏tableview
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation MyBankCardViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeBindCardList callback:self];
}
- (IBAction)asdfghj:(id)sender {
    PasswordViewController *passVC = [[PasswordViewController alloc] init];
    passVC.interface = @"addBankCard";
    [self.navigationController pushViewController:passVC animated:YES];
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeBindCardList callback:self];
    COM.isPay = NO;
    
}

- (void)popViewController {
    [super popViewController];
    NSString *countString = [NSString stringWithFormat:@"%ld", self.dataArray.count];
    [_delegate cardNumberCount:countString];
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeBindCardList]) {
        NSLog(@"绑定银行卡查询返回数据:%@",param);
        self.dataArray = param;
       
        [_tableView reloadData];
        
        if (self.dataArray.count == 0) {
            self.tableView.hidden = YES;
            self.emptyStatusView.hidden = NO;
            
        }else{
            self.tableView.hidden = NO;
            self.emptyStatusView.hidden = YES;
        }

    }else{
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *userId = [COM getUserId];
    COM.isPay = YES;
    LC_LOADING
    [[PayManager sharedManager] bindCardLisappid:APPID userId:userId verifyKey:@""];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    MyBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBankCardCell" forIndexPath:indexPath];
    cell.bankIcon.image = [UIImage imageNamed:@"招行logo"];
    NSString *openBank = self.dataArray[row][@"openBank"];
    NSString *cardType = self.dataArray[row][@"cardType"];
    NSString *cardNo = self.dataArray[row][@"cardNo"];
    
    NSString *stringstring = [NSString stringWithFormat:@"%@****%@",[cardNo substringToIndex:4],[cardNo substringWithRange:NSMakeRange(cardNo.length- 4, 4)]];

    if ([cardType isEqualToString:@"1"]) {
        cardType = @"信用卡";
    } else {
        cardType = @"储蓄卡";
    }
    cell.bankName.text = openBank;
    cell.bankCardStyle.text = cardType;
    cell.bankCardNumber.text = stringstring;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BankCard" bundle:nil];
    MyBankCardDetailViewController *myBankCardDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"MyBankCardDetailVC"];
    myBankCardDetailVC.cardNumber = self.dataArray[row][@"cardNo"];
    [self.navigationController pushViewController:myBankCardDetailVC animated:YES];
    
    [self addaddressAction:self.dataArray[row][@"cardNo"]];
}


- (void)addaddressAction:(NSString *)card{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"解除绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PasswordViewController *pass = [[PasswordViewController alloc] init];
        pass.interface = @"解绑";
        pass.cardNum  = card;
        [self.navigationController pushViewController:pass animated:YES];
        
    }];
    [action_1 setValue:[UIColor redColor] forKey:@"titleTextColor"];
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertcontroller addAction:action_1];
    [alertcontroller addAction:action_2];
    [self presentViewController:alertcontroller animated:YES completion:nil];
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
