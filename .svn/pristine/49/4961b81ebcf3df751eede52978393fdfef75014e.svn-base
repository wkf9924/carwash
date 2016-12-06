//
//  SelectBankViewController.m
//  CarWash
//
//  Created by xa on 16/7/19.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SelectBankViewController.h"
#import "SelectBankCell.h"

@interface SelectBankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@end

@implementation SelectBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.headerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectBankCell" forIndexPath:indexPath];
    cell.bankIcon.image = [UIImage imageNamed:@"西安银行icon"];
    cell.bankName.text = @"中国银行";
    cell.voutherCount.text = @"尾号2536可用额度10,000.00元";
    
    return cell;
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
