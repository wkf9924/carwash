//
//  RegisterViewController.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/7.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterManager.h"
#import "SmsManager.h"
@interface RegisterViewController () <BZEventCenterDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btCodeNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
//获取验证码
- (IBAction)smsCodeAction:(id)sender;

- (IBAction)backAction:(id)sender;

- (IBAction)regAction:(id)sender;
@end

@implementation RegisterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeRegister callback:self];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeSmscode callback:self];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeRegister callback:self];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeSmscode callback:self];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextField:_tfPhone];
    [self setTextField:_tfPassword];
    [self setTextField:_tfCode];
    [_tfPassword setSecureTextEntry:YES];
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

-(void)startTime{
    
    __block int timeout= 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_btCodeNumber setTitle:@"重新发送" forState:UIControlStateNormal];
                _btCodeNumber.userInteractionEnabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_btCodeNumber setTitle:[NSString stringWithFormat:@"%zd秒后重发",timeout] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _btCodeNumber.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
- (IBAction)smsCodeAction:(id)sender {
    if ([_tfPhone.text isEqualToString:@""]) {
        LCFAIL_ALERT(@"请填写手机号");
        return;
    }
    NSString *searchText = self.tfPhone.text;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^1[3|4|5|7|8][0-9]\\d{8}$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    if (result){
        [self startTime];
        //0 注册 1找回密码
        [[SmsManager sharedManager] sms:_tfPhone.text smsTypeCode:@"0"];
    }else{
        LCSUCCESS_ALSERT(@"您输入的手机号不合法");
    }   
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)regAction:(id)sender {
    NSString *phone = _tfPhone.text;
    NSString *vercode = _tfCode.text;
    NSString *password = _tfPassword.text;
    if ([phone isEqualToString:@""]|| phone.length != 11) {
        LCFAIL_ALERT(@"请正确输入手机号");
        return;
    }
    if ([vercode isEqualToString:@""]) {
        LCFAIL_ALERT(@"请输入验证码");
        return;
    }
    if ([password isEqualToString:@""]) {
        LCFAIL_ALERT(@"请输入密码");
        return;
    }
    [[RegisterManager sharedManager] reg:phone verzxwification:vercode  password:password];
    
}

#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    
    if([eventType isEqualToString:CWEventCenterTypeRegister]) {
        LCSUCCESS_ALSERT(@"成功注册请登录")
        [self popViewController];
    }else if ([eventType isEqualToString:CWEventCenterTypeSmscode]) {
        
        //直接写入验证码
//        _tfCode.text = param[@"captcha"];
        
    } else {
        
    }
}
- (IBAction)userDelegateContentButtonAction:(UIButton *)sender {
}
@end
