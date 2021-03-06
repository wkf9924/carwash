//
//  VIPPayPasswordVC.m
//  CarWash
//
//  Created by xa on 2016/11/10.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "VIPPayPasswordVC.h"
#import "DefineConstant.h"
#import "SecretHelper.h"

@interface VIPPayPasswordVC ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)NSMutableArray *dotArray;
@end

@implementation VIPPayPasswordVC
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
    [self setBackBarButton];
    self.title = @"密码验证";
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self alertLabelTitle];
    [self.view addSubview:self.textField];
    [self.textField becomeFirstResponder];
    [self initPwdTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"*****************走了VIP支付密码验证***************");
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
        
        [self payloading:textField];
        
    } failure:^(NSError *error) {
        LCSUCCESS_ALSERT(@"支付失败")
        LC_HIDEN
        
    }];

    
   
//    [self.navigationController popViewControllerAnimated:YES];
//    COM.VIPTopUpSucceed = @"充值成功";
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//appid	平台id	string
//password	支付密码	string
//serviceType	服务类型	string	半年包 :0，一年包:1，两年包:2
//sys_price	系统优惠价格	string
//token	用户认证标识（用做被动互踢和自动登录过期等操作，可逆加密算法生成）	string

- (void)payloading : (UITextField *)textField {
    
    if ([_VIPType isEqualToString:@"半年包"]) {
        _VIPType = @"0";
    }
    else if ([_VIPType isEqualToString:@"一年包"]) {
        _VIPType = @"1";
    }
    else {
        _VIPType = @"2";
    }
    
    NSString *token = [COM getLoginToken];
    if ([token isEqualToString:@""] || token == nil) {
        return;
    }
    NSString *urlStirng = [NSString stringWithFormat:@"http://%@%@",API_SERVER_HOST,API_PAYMENT_VIPPAY];
    
    NSDictionary *dic = @{@"appid" : APPID,
                          @"password" : textField.text,
                          @"serviceType" :_VIPType,
                          @"sys_price" : _price,
                          @"token" : token
                          };
    
    LC_LOADING
    [TSEHttpTool post:urlStirng params:dic success:^(id json) {
        LC_HIDEN
        NSDictionary *jsondic = json;
        NSString *numberCode = [NSString stringWithFormat:@"%@",jsondic[@"code"]];
        if (![numberCode isEqualToString:@"0"]) {
            return;
            
        }
        
        COM.VIPTopUpSucceed = @"充值成功";
        [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        LCSUCCESS_ALSERT(@"充值成功")
        
    } failure:^(NSError *error) {
        
    }];
    

}

@end
