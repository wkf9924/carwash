//
//  PayPasswordCodeingVC.m
//  CarWash
//
//  Created by xa on 2016/10/17.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "PayPasswordCodeingVC.h"
#import "DefineConstant.h"
#import "PayManager.h"
#import "ScanPaySucceedVC.h"
#import "PaySucceedVC.h"
#import "Definition.h"
#import "SecretHelper.h"
#import "TSEHttpTool.h"
#import "AFNetworking.h"
#define kDotSize CGSizeMake (10, 10)
#define kScreenWidth self.view.bounds.size.width
#define kDotCount 6
#define kFieldHeight 45
@interface PayPasswordCodeingVC ()<UITextFieldDelegate, BZEventCenterDelegate>
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)NSMutableArray *dotArray;
@end

@implementation PayPasswordCodeingVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeRcodePay callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeRcodePayFail callback:self];
    
    //RCp
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCouponPay callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCouponPayFail callback:self];
    //RCP
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeServicePay callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeServicePayFail callback:self];
    
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeOrdersPay callback:self];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeRcodePay callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeRcodePayFail callback:self];
    
    //RCp
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCouponPay callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCouponPayFail callback:self];
    //RCP
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeServicePay callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeServicePayFail callback:self];
    
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeOrdersPay callback:self];
}

#pragma mark -  BZEventCenterDelegate methods
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    
    LC_HIDEN
    if ([eventType isEqualToString:CWEventCenterTypeRcodePay]) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"PaidSucceed" bundle:nil];
        ScanPaySucceedVC *personalInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"ScanPaySucceedVC"];
        [self.navigationController pushViewController:personalInfoVC animated:YES];
    }else if ([eventType isEqualToString:CWEventCenterTypeRcodePayFail]) {
    }
    
    
    //RCP 特惠立即支付
    if ([eventType isEqualToString:CWEventCenterTypeCouponPay]) {
        NSLog(@"特惠立即支付:%@",param);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PaidSucceed" bundle:nil];
        PaySucceedVC *paysucceed = [storyboard instantiateViewControllerWithIdentifier:@"PaySucceedVC"];
        paysucceed.interface = self.interface;
        [self.navigationController pushViewController:paysucceed animated:YES];
        
        
    }else if ([eventType isEqualToString:CWEventCenterTypeCouponPayFail]){
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"特惠立即支付失败:%@",param);
    }
    
    //wkf扫码支付
    if ([eventType isEqualToString:CWEventCenterTypeRcodePay]) {
        
        
    }else if ([eventType isEqualToString:CWEventCenterTypeRcodePayFail]){
        
    }
    //RCP 我的劵中消费劵支付
    if ([eventType isEqualToString:CWEventCenterTypeServicePay]) {
        NSLog(@"购买服务立即支付:%@",param);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PaidSucceed" bundle:nil];
        PaySucceedVC *paysucceed = [storyboard instantiateViewControllerWithIdentifier:@"PaySucceedVC"];
        [self.navigationController pushViewController:paysucceed animated:YES];
    }else if ([eventType isEqualToString:CWEventCenterTypeServicePayFail]){
        NSLog(@"购买服务立即支付:%@",param);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ([eventType isEqualToString:CWEventCenterTypeOrdersPay]) {
        LC_HIDEN
        NSLog(@"我的服务支付:%@",param);
//        [LCProgressHUD hideHUDForView:self.view animated:YES];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PaidSucceed" bundle:nil];
        PaySucceedVC *paysucceed = [storyboard instantiateViewControllerWithIdentifier:@"PaySucceedVC"];
        [self.navigationController pushViewController:paysucceed animated:YES];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    
    self.title = @"密码验证";
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self alertLabelTitle];
    [self.view addSubview:self.textField];
    [self initPwdTextField];
}
#pragma mark 输入完密码后的操作写在下边方法里;
- (void)textFieldDidEndEditing:(UITextField *)textField{
    LC_LOADING
    NSLog(@"*****************走了支付密码验证***************");
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
            LCSUCCESS_ALSERT(@"支付密码不正确")
            return;
        }
        
        [self paySucess:textField];
        
    } failure:^(NSError *error) {
        LCSUCCESS_ALSERT(@"支付失败")
        LC_HIDEN
        
    }];
    
    //wkf
}

- (void)paySucess:(UITextField *)textField  {
    if ([_interface isEqualToString:@"扫码支付"]) {
        
        [[PayManager sharedManager] rcodeAccepter_Appid:APPID Accepter_userid:_Accepter_userid Amount:_Amount Appid:APPID Password:textField.text];
    }
    //RCP 特惠立即支付
    if ([self.interface isEqualToString:@"特惠立即支付"]) {
        [[PayManager sharedManager] couponPay:self.Amount password:textField.text];
    }
    if ([self.interface isEqualToString:@"服务支付"]) {
        if (self.couponID) {
            
            [[PayManager sharedManager] servicePayCoupon_id:self.couponID accepter_userid:self.sellerID password:textField.text price:self.money service_id:self.serviceID];
        }else{
            
           //我的劵中消费劵支付
            [[PayManager sharedManager] servicePayCoupon_id:@"" accepter_userid:self.sellerID password:textField.text price:self.money service_id:self.serviceID];
        }
    }
    
    if ([_interface isEqualToString:@"车商城"]) {
        NSString *token = [COM getLoginToken];
        NSString *urlStirng = [NSString stringWithFormat:@"http://%@%@",API_SERVER_HOST, API_GOOD_BRDERPAY];
        
        NSDictionary *dic = @{@"appid" : APPID,
                              @"orderid" : _ordersId,
                              @"password" : textField.text,
                              @"sys_price" : _Amount,
                              @"token" : token
                              };
        [TSEHttpTool post:urlStirng params:dic success:^(id json) {
            LC_HIDEN
            
            NSDictionary *jsondic = json;
            NSNumber *numberCode = jsondic[@"code"];
            if (![numberCode isEqualToNumber:[NSNumber numberWithInt:0]]) {
                LCSUCCESS_ALSERT(@"支付失败")
                return;
            }
            
            LCSUCCESS_ALSERT(@"支付成功")
        } failure:^(NSError *error) {
            LC_HIDEN
            NSLog(@"ERROR:%@", error);
        }];
    }
    

}
- (void)alertLabelTitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 200-kFieldHeight, kScreenWidth - 32, kFieldHeight)];
    label.textColor = [UIColor colorWithRed:0.32 green:0.32 blue:0.32 alpha:1.00];
            label.text = @"请输入支付密码,以验证身份";
    
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
