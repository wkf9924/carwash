//
//  PasswordViewController.m
//  CarWash
//
//  Created by xa on 16/7/19.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "PasswordViewController.h"
#import "DefineConstant.h"
#import "SuccessViewController.h"
#import "BindBankCardVC.h"
#import "PayManager.h"
#import "WithdrawParam.h"
#import "rechargeParam.h"
#import "SecretHelper.h"
#import "JXTAlertTools.h"
#define kDotSize CGSizeMake (10, 10)
#define kScreenWidth self.view.bounds.size.width
#define kDotCount 6
#define kFieldHeight 45
@interface PasswordViewController ()<BZEventCenterDelegate>
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)NSMutableArray *dotArray;
@property (nonatomic, strong)NSString *payPasswordText;
@end

@implementation PasswordViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    COM.isPay = YES;
    //设置支付密码
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypepayPassword callback:self];
    //修改支付密码
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeReplacepaypassword callback:self];
    //充值
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeRecharge callback:self];
    //提现
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeWithdraw callback:self];
    //解除绑定
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeBundlingCard callback:self];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypepayPassword callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeReplacepaypassword callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeRecharge callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeWithdraw callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeBundlingCard callback:self];
    COM.isPay = NO;
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypepayPassword]) {
        NSLog(@"设置支付密码:%@",param);
        [COM setPayPassword:self.payPasswordText];
        [self.navigationController popToRootViewControllerAnimated:YES];
        LCSUCCESS_ALSERT(@"密码设置成功,请继续使用");
    }else{
        
    }
    if ([eventType isEqualToString:CWEventCenterTypeReplacepaypassword]) {
        NSLog(@"更换支付密码:%@",param);
        [self.navigationController popToRootViewControllerAnimated:YES];
        LCSUCCESS_ALSERT(@"密码设置成功,请继续使用");
    }else{
        
    }
    if ([eventType isEqualToString:CWEventCenterTypeRecharge]) {
        NSLog(@"充值成功:%@",param);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyWallet" bundle:nil];
        SuccessViewController *successVC = [storyboard instantiateViewControllerWithIdentifier:@"SuccessVC"];
        successVC.successtitle = @"充值成功";
        successVC.getCashCount = self.cashCount;
        [self.navigationController pushViewController:successVC animated:YES];
    }else{
    }
    
    if ([eventType isEqualToString:CWEventCenterTypeWithdraw]) {
        NSLog(@"提现成功:%@",param);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyWallet" bundle:nil];
        SuccessViewController *successVC = [storyboard instantiateViewControllerWithIdentifier:@"SuccessVC"];
        successVC.successtitle = @"提现成功";
        successVC.getCashCount = self.cashCount;
        [self.navigationController pushViewController:successVC animated:YES];
        LCSUCCESS_ALSERT(@"提现成功,稍候到账");
    }else{
    }
    if ([eventType isEqualToString:CWEventCenterTypeBundlingCard]) {
        NSLog(@"解除绑定成功:%@",param);
        LCSUCCESS_ALSERT(@"解除绑定成功,如需要,请重新绑定");
    }else{
        
    }
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.title = @"密码管理";
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self alertLabelTitle];
    [self.view addSubview:self.textField];
    [self initPwdTextField];
    
}
- (void)alertLabelTitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 200-kFieldHeight, kScreenWidth - 32, kFieldHeight)];
    label.textColor = [UIColor colorWithRed:0.32 green:0.32 blue:0.32 alpha:1.00];
    if ([self.interface isEqualToString:@"settingPaySecret"]) {
        label.text = @"请设置6位支付密码";
    }else if ([self.interface isEqualToString:@"changePaySecret"]){
        label.text = @"请输入支付密码,以验证身份";
    }else if ([self.interface isEqualToString:@"resetPaySecret"]){
        label.text = @"请重新输入6位支付密码";
    }else if ([self.interface isEqualToString:@"reChangePaySecret"]){
        label.text = @"请输入6位新支付密码";
    }else if ([self.interface isEqualToString:@"reChangePaySecret2"]){
        label.text = @"请确认新6位支付密码";
    }else{
        label.text = @"请输入支付密码,以验证身份";
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)initPwdTextField{
    //每个密码输入框的宽度
    CGFloat width = (kScreenWidth - 32) / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, CGRectGetMinY(self.textField.frame), 1, kFieldHeight)];
        lineView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - kDotCount) / 2 + i * width, CGRectGetMinY(self.textField.frame) + (kFieldHeight - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self.view addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

- (void)paySucess :(UITextField *)textField {
    if ([self.interface isEqualToString:@"addBankCard"]){//添加银行卡
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BankCard" bundle:nil];
        BindBankCardVC *bindbank = [storyboard instantiateViewControllerWithIdentifier:@"BindBankCardVC"];
        bindbank.carPassword = textField.text;
        
        ;
        //        if ([[SecretHelper md5String:textField.text] isEqualToString:[COM payPassword]]) {
        [self.navigationController pushViewController:bindbank animated:YES];
        //        }else{
        //            textField.text = nil;
        //            LCSUCCESS_ALSERT(@"支付密码输入有误,请确认后重新输入");
        //        }
    }else if ([self.interface isEqualToString:@"settingPaySecret"]){//设置支付密码
        PasswordViewController *password = [[PasswordViewController alloc] init];
        password.interface = @"resetPaySecret";
        password.password = textField.text;
        
        
        [self.navigationController pushViewController:password animated:YES];
    }else if ([self.interface isEqualToString:@"resetPaySecret"]){//重新输入密码
        LC_LOADING
        [[PayManager sharedManager] payPasswordAppid:APPID userId:[COM getUserId] verifyKey:@"" confirmPassword:textField.text Password:self.password];
        NSString *payPasswordString = [SecretHelper md5String:textField.text];
        
        self.payPasswordText = payPasswordString;
    }else if ([self.interface isEqualToString:@"reChangePaySecret"]){//更改密码
        
        PasswordViewController *password = [[PasswordViewController alloc] init];
        password.interface = @"reChangePaySecret2";
        password.password = textField.text;
        [self.navigationController pushViewController:password animated:YES];
        
    }else if ([self.interface isEqualToString:@"reChangePaySecret2"]){//更改密码
        [[PayManager sharedManager] ancient_password:self.password2 appid:APPID password:self.password confirmPassword:textField.text userid:[COM getUserId] verifyKey:@""];
        LC_LOADING
        
    }else if ([self.interface isEqualToString:@"changePaySecret"]){//验证原密码
        PasswordViewController *password = [[PasswordViewController alloc] init];
        password.interface = @"reChangePaySecret";
        password.password2 = textField.text;
        [self.navigationController pushViewController:password animated:YES];
    }else if ([self.interface isEqualToString:@"getCash"]){//提现
        
        WithdrawParam *withdarw = [[WithdrawParam alloc] init];
        withdarw.Appid = APPID;
        withdarw.Amount = self.cashCount;//提现金
        
        withdarw.CardNo = self.cardNum;//卡号
        if (textField.text.length != 6 || textField.text.length == 0) {
            LC_SHOW_FAIL(@"支付密码有误,请重新输入");
        }else{
            withdarw.Password = textField.text;
        }
        withdarw.userid = [COM getUserId];
        withdarw.verifyKey = @"";
        if (withdarw.Appid != nil && withdarw.Amount != nil && withdarw.CardNo != nil && withdarw.userid != nil) {
            [[PayManager sharedManager] withdrawWithParam:withdarw];
            LC_LOADING
        }else{
            LC_SHOW_FAIL(@"请求失败, 请检查网络后重试");
        }
        
    }else if ([self.interface isEqualToString:@"topUp"]){//充值
        
        rechargeParam *recharge = [[rechargeParam alloc] init];
        
        recharge.Amount = self.cashCount;
        recharge.Appid = APPID;
        recharge.CardNo = self.cardNum;
        if (textField.text.length != 6 || textField.text.length == 0) {
            LC_SHOW_FAIL(@"支付密码有误,请重新输入");
        }else{
            recharge.Password = textField.text;
        }
        recharge.userid = [COM getUserId];
        recharge.verifyKey = @"";
        if (recharge.Amount != nil && recharge.Appid != nil && recharge.CardNo != nil && recharge.userid != nil) {
            [[PayManager sharedManager] rechargeWithparam:recharge];
            LC_LOADING
        }else{
            LC_SHOW_FAIL(@"请求失败, 请检查网络后重试");
        }
    }
    else if ([self.interface isEqualToString:@"解绑"]){
        [[PayManager sharedManager] unbundlingCardAppid:@"" userId:[COM getUserId] verifyKey:@"" CardNo:self.cardNum Password:textField.text];
        LC_LOADING
    }
    else{
        
        
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    NSLog(@"*****************走了绑定银行卡支付密码验证***************");
    
    if ([self.interface isEqualToString:@"settingPaySecret"]){//设置支付密码
        PasswordViewController *password = [[PasswordViewController alloc] init];
        password.interface = @"resetPaySecret";
        password.password = textField.text;
        
        
        [self.navigationController pushViewController:password animated:YES];
        return;
    }
    if ([self.interface isEqualToString:@"resetPaySecret"]){//重新输入密码
        LC_LOADING
        [[PayManager sharedManager] payPasswordAppid:APPID userId:[COM getUserId] verifyKey:@"" confirmPassword:textField.text Password:self.password];
        NSString *payPasswordString = [SecretHelper md5String:textField.text];
        
        self.payPasswordText = payPasswordString;
        return;
    
    }
    if ([self.interface isEqualToString:@"reChangePaySecret"]){//更改密码
        
        PasswordViewController *password = [[PasswordViewController alloc] init];
        password.interface = @"reChangePaySecret2";
        password.password = textField.text;
        [self.navigationController pushViewController:password animated:YES];
        return;
        
    }
    
    if ([self.interface isEqualToString:@"reChangePaySecret2"]){//更改密码
        [[PayManager sharedManager] ancient_password:self.password2 appid:APPID password:self.password confirmPassword:textField.text userid:[COM getUserId] verifyKey:@""];
        LC_LOADING
        return;
    }
    
    if ([self.interface isEqualToString:@"changePaySecret"]){//验证原密码
        PasswordViewController *password = [[PasswordViewController alloc] init];
        password.interface = @"reChangePaySecret";
        password.password2 = textField.text;
        [self.navigationController pushViewController:password animated:YES];
        return;
    }
    
    //先验证支付密码是否正确然后在往下执行
    NSString *password = textField.text;
    
    NSString *userId = [COM getUserId];
    if ([userId isEqualToString:@""] || userId == nil) {
        return;
    }
    //    NSString *urlStirng = @"http://192.168.2.9:8080/wop/v1/account/verifyPin";
    NSString *urlStirng = [NSString stringWithFormat:@"http://%@%@",API_SERVER_HOST_PAY, API_ACCOUNT_VERIFYPIN];
    NSString *dicStirng = [NSString stringWithFormat:@"Appid=%@&Password=%@&userid=%@",APPID,password,userId];
    NSString *verString = [[SecretHelper md5String:SecretKey]lowercaseString];
    NSString *newString = [NSString stringWithFormat:@"%@&%@",dicStirng,verString];
    NSString *mdString = [[SecretHelper md5String:newString] lowercaseString];
    
    
    NSDictionary *dic = @{
                          @"Appid" : APPID,
                          @"Password" : password,
                          @"userid" : userId,
                          @"verifyKey" : mdString
                          };
    
    [TSEHttpTool post:urlStirng params:dic success:^(id json) {
        LC_HIDEN
        NSDictionary *jsondic = json;
        NSString *numberCode = [NSString stringWithFormat:@"%@",jsondic[@"code"]];
        if (![numberCode isEqualToString:@"0"]) {
            NSString *messageString = [NSString stringWithFormat:@"%@",jsondic[@"message"]];
            LCSUCCESS_ALSERT(messageString)
            
//             [JXTAlertTools showTipAlertViewWith:self title:EmptyTitle message:messageString buttonTitle:nil buttonStyle:JXTAlertActionStyleDefault];
            
             [JXTAlertTools showTipAlertViewWith:self title:EmptyTitle message:messageString buttonTitle:@"确认" buttonStyle:JXTAlertActionStyleDefault];
            return;
        }
        
        [self paySucess:textField];
        
    } failure:^(NSError *error) {
        LCSUCCESS_ALSERT(@"支付失败")
        LC_HIDEN
        
    }];

    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

//重置显示的点
- (void)textFieldDidChange:(UITextField *)textField{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
    }
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(16, 200, kScreenWidth - 32, kFieldHeight)];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
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

@end
