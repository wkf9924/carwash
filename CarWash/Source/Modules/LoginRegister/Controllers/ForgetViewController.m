//
//  ForgetViewController.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/12.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "ForgetViewController.h"
#import "DefineConstant.h"
#import "CWLoginRegisterManager.h"
#import "SmsManager.h"
@interface ForgetViewController () <BZEventCenterDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UILabel *titilelabel;

- (IBAction)modifyPasswordAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getSMSCodeButton;

@end

@implementation ForgetViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeForgetPassword callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeSmscode callback:self];
    self.navigationController.navigationBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeForgetPassword callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeSmscode callback:self];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    if([eventType isEqualToString:CWEventCenterTypeForgetPassword]){
        if ([self.controllerName isEqualToString:@"修改登录密码"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if ([eventType isEqualToString:CWEventCenterTypeSmscode]) {
        NSLog(@"获取验证码:%@",param);
    }else{
        
    }
}

- (IBAction)backAction:(id)sender {
    //判断是点击修改密码找回密码界面的还是从登陆界面点击忘记密码到找回密码界面的
    if ([self.controllerName isEqualToString:@"修改登录密码"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextField:_tfCode];
    [self setTextField:_phone];
    [self setTextField:_tfPassword];
    [self setBackBarButton];
    [_tfPassword setSecureTextEntry:YES];
    NSLog(@"controller名字:%@",self.controllerName);
    self.titilelabel.text = self.controllerName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- 修改密码提交
- (IBAction)modifyPasswordAction:(id)sender {

    BOOL isNumber = [COM checkIsdigital:_tfCode.text];
    if (!isNumber) {
        LCFAIL_ALERT(@"警告:验证码非法字符，请输入纯数字！")
        return;
    }
    if ([_tfCode.text isEqualToString:@""]) {
        LCFAIL_ALERT(@"请输入验证码")
        return;
    } else if ([_phone.text isEqualToString:@""]) {
        LCFAIL_ALERT(@"请输入手机号")
        return;
    } else if(_tfPassword.text.length < 6){
        LCFAIL_ALERT(@"密码必须大于六位")
        return;
    }
    

    if ([self.controllerName isEqualToString:@"修改登录密码"]) {
//        修改密码
      [[CWLoginRegisterManager sharedManager]  forgetPassword:_tfPassword.text phone:_phone.text smsCode:_tfCode.text token:@"token"];
    } else {
//        忘记密码
       [[CWLoginRegisterManager sharedManager]  forgetPassword:_tfPassword.text phone:_phone.text smsCode:_tfCode.text token:@""];
    }
}
- (IBAction)getSMSCodeAction:(UIButton *)sender {
    if ([self.phone.text isEqualToString:@""]) {
        LCFAIL_ALERT(@"请填写手机号");
        return;
    }
    NSString *searchText = self.phone.text;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^1[3|4|5|7|8][0-9]\\d{8}$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    if (result){
        [self startTime];
        [[SmsManager sharedManager] sms:self.phone.text smsTypeCode:@"1"];
    }else{
        LCSUCCESS_ALSERT(@"您输入的手机号不合法");
    }
    
    
    
    
}
-(void)startTime{
    __block int timeout= 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.getSMSCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                self.getSMSCodeButton.userInteractionEnabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.getSMSCodeButton setTitle:[NSString stringWithFormat:@"%zd秒后重发",timeout] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.getSMSCodeButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
@end
