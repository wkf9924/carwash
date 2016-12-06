//
//  BindBankCardVC.m
//  CarWashMerchant
//
//  Created by xa on 16/8/16.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "BindBankCardVC.h"
#import "DefineConstant.h"
#import "Definition.h"
#import "PayManager.h"
#import "BindCard.h"
#import "SmsManager.h"

@interface BindBankCardVC ()<BZEventCenterDelegate>
{
    NSString *_codeString; //验证码
}
@property (nonatomic, assign)BOOL isSelect;
@property (nonatomic, strong)NSTimer *timer;//用来倒计时,且倒计时时关闭用户交互
@property (nonatomic, assign)int sumTime;//倒计时总时间;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) BindCard *bindcarParam;
@property (weak, nonatomic) IBOutlet UITextField *nameText;//姓名
@property (weak, nonatomic) IBOutlet UITextField *idCardNumber;//身份证
@end

@implementation BindBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self datePicker];
    self.title = @"绑定银行卡";
    
}
- (void)popViewController {
    [super popViewController];
//    POP_NAVIGATION_NUM(2);
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeBindCard callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeBindCardFail callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeSmscode callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeAuthCode callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeValidataion callback:self];
    self.tabBarController.tabBar.hidden = YES;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeBindCard callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeBindCardFail callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeAuthCode callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeValidataion callback:self];
    self.tabBarController.tabBar.hidden = NO;
    [self.timer invalidate];
    self.timer = nil;
    self.getCodeButton.enabled = YES;
    COM.isPay = NO;
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeBindCard]) {
        NSLog(@"绑定银行卡返回数据:%@",param);
        //RCP
        [self.navigationController popToRootViewControllerAnimated:YES];
        LCSUCCESS_ALSERT(@"恭喜您,绑定成功");
    } else {
        NSLog(@"绑定银行卡失败:%@",param);
    }
    
    if ([eventType isEqualToString:CWEventCenterTypeAuthCode]) {
        NSLog(@"CWEventCenterTypeAuthCode:%@",param);
//        _codeNumber.text = param[@"captcha"];
    } else {
        NSLog(@"CWEventCenterTypeAuthCodeFail:%@",param);
    }

    
    if ([eventType isEqualToString:CWEventCenterTypeValidataion]) {
        NSLog(@"CWEventCenterTypeValidataion:%@",param);
        [self bindCardNumber];
    } else {
        NSLog(@"CWEventCenterTypeValidataionFail:%@",param);
    }

    
        
    
}
//处理最终提交数据
- (void)dateOperationForCommit{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//选择银行卡类型/储蓄卡/信用卡
- (IBAction)selectBankCardAction:(UIButton *)sender {
    [self selectBankCardType];
}
//手机号码相关信息按钮
- (IBAction)telInfoButtonAction:(UIButton *)sender {
}
#pragma mark ----- 获取验证码按钮回调
- (IBAction)getCodeAction:(UIButton *)sender {
    if ([self.telphoneNumber.text isEqualToString:@""]) {
        LCFAIL_ALERT(@"请填写手机号");
        return;
    }
    NSString *searchText = self.telphoneNumber.text;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^1[3|4|5|7|8][0-9]\\d{8}$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    if (result){
        self.sumTime = 60;
        self.getCodeButton.enabled = NO;
        [self.timer setFireDate:[NSDate distantPast]];
        //0 注册 1找回密码
        [[PayManager sharedManager] authCodePhone:_telphoneNumber.text];
    }else{
        LCSUCCESS_ALSERT(@"您输入的手机号不合法");
    }
    
    
    
    
}
//NSTimer懒加载
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(cutSeconds) userInfo:nil repeats:YES];
        //暂停
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}
//定时器回调
- (void)cutSeconds{
    self.sumTime--;
    NSString *buttonTitle = @"";
    if (self.sumTime >= 0) {
        buttonTitle = [NSString stringWithFormat:@"%ds",self.sumTime];
    }else{
        buttonTitle = @"再次发送";
        self.getCodeButton.enabled = YES;
        [self.timer invalidate];
        self.timer = nil;
    }
    [self.getCodeButton setTitle:buttonTitle forState:UIControlStateNormal];
}
//有效期相关信息按钮
- (IBAction)selectYearMonthAction:(UIButton *)sender {
}
//安全码相关信息按钮
- (IBAction)selectbackCardNum:(UIButton *)sender {
}
//勾选同意用户协议
- (IBAction)selectButtonAction:(UIButton *)sender {
    if (self.isSelect != YES) {
        [sender setBackgroundImage:[UIImage imageNamed:@"单选框(未选中)-0"] forState:UIControlStateNormal];
        self.isSelect = YES;
    }else if (self.isSelect == YES){
        [sender setBackgroundImage:[UIImage imageNamed:@"单选框(选中)"] forState:UIControlStateNormal];
        self.isSelect = NO;
    }
}
//用户协议
- (IBAction)userDelegate:(UIButton *)sender {
}
#pragma mark ----- 确定提交按钮 先验证手机号是否正确在进行绑卡处理
- (IBAction)conmitButtonAction:(UIButton *)sender {
    [[PayManager sharedManager] validationPhone:_telphoneNumber.text smsCode:_codeNumber.text];
}

#pragma mark ----- 开始绑定银行卡
- (void)bindCardNumber {
    
    COM.isPay = YES;
    self.bindcarParam.Bank_cellphone = self.telphoneNumber.text;
    
    self.bindcarParam.CardNo = _bankCardNumber.text;
    self.bindcarParam.Appid = APPID;
    self.bindcarParam.IdName = _nameText.text;
    
    NSString *searchText = _idCardNumber.text;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d{14}[[0-9],0-9xX]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    if (result){
        self.bindcarParam.IdNo = _idCardNumber.text;
    }else{
        LCSUCCESS_ALSERT(@"您输入的身份证不合法");
    }
    
    self.bindcarParam.password = _carPassword;
    self.bindcarParam.userid = [COM getUserId];
    self.bindcarParam.verifyKey = SecretKey;//
    
    //绑定银行卡请求:
    [[PayManager sharedManager] bindCarparam:self.bindcarParam];

}
- (void)selectBankCardType{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择银行卡类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"储蓄卡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.bankCardType.text = action.title;
        self.creditCardInfoViewHeight.constant = 0;
        self.creditCardInfoView.hidden = YES;
        [action_1 setValue:[UIColor darkGrayColor] forKey:@"titleTextColor"];
    }];
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"信用卡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.bankCardType.text = action.title;
        self.creditCardInfoViewHeight.constant = 84;
        self.creditCardInfoView.hidden = NO;
        [action_2 setValue:[UIColor darkGrayColor] forKey:@"titleTextColor"];
    }];
    [alert addAction:action_1];
    [alert addAction:action_2];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [_datePicker addTarget:self action:@selector(datePicker:) forControlEvents:UIControlEventValueChanged];
        self.timeOfValidity.inputView = _datePicker;
        
    }
    return _datePicker;
}
- (void)datePicker:(UIDatePicker *)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM"];
    self.timeOfValidity.text = [dateFormatter stringFromDate:sender.date];
}
- (BindCard *)bindcarParam{
    if (!_bindcarParam) {
        _bindcarParam  = [[BindCard alloc] init];
    }
    return _bindcarParam;
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
