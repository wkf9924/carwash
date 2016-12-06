//
//  SecretChangeVC.m
//  CarWash
//
//  Created by xa on 2016/10/10.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SecretChangeVC.h"
#import "ForgetViewController.h"
#import "PasswordViewController.h"
#import "DefineConstant.h"

@interface SecretChangeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecretChangeVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码管理";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setBackBarButton];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改登录密码";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"设置支付密码";
    }else{
        cell.textLabel.text = @"修改支付密码";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        //修改密码
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        ForgetViewController  *forgetVC = [storyboard instantiateViewControllerWithIdentifier:@"ForgetViewController"];
        forgetVC.controllerName = @"修改登录密码";
        [self.navigationController presentViewController:forgetVC animated:YES completion:nil];
    }else if (indexPath.row == 1){
        PasswordViewController *password = [[PasswordViewController alloc] init];
        password.interface = @"settingPaySecret";
        [self.navigationController pushViewController:password animated:YES];
    }else{
        PasswordViewController *password = [[PasswordViewController alloc] init];
        password.interface = @"changePaySecret";
        [self.navigationController pushViewController:password animated:YES];
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
