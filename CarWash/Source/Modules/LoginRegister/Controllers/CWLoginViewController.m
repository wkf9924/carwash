//
//  CWLoginViewController.m
//  CarWash
//
//  Created by 赵林 on 16/7/2.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CWLoginViewController.h"
#import "BZEventCenter.h"
#import "CWEventCenterType.h"
#import "MBProgressHUD+MJ.h"
#import "CWLoginRegisterManager.h"
#import "DefineConstant.h"
#import "Definition.h"
#import "IanAlert.h"
#import "ForgetViewController.h"
#import "LoginModel.h"
#import <MJExtension.h>
#import "PayManager.h"
#import "Common.h"
@interface CWLoginViewController ()<BZEventCenterDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property BOOL *isMyInfo; //用来判断是否从我的界面点击图像登录的

- (IBAction)loginAction:(id)sender;

- (IBAction)backAction:(id)sender;
@end

@implementation CWLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeLogin callback:self];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeAccountAccess callback:self];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeAccountAccessFail callback:self];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeLogin callback:self];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeAccountAccess callback:self];
     [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeAccountAccessFail callback:self];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self setTextField:_phoneTextField];
    [self setTextField:_passwordTextField];
    [_passwordTextField setSecureTextEntry:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"跳转");
    if ([segue.identifier isEqualToString:@"forgetVC"]) {
        ForgetViewController *forget = segue.destinationViewController;
        forget.controllerName = @"找回密码";
    }
}

- (IBAction)onClickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickLogin:(id)sender {
    if ([_phoneTextField.text isEqualToString:@""]) {
        LCFAIL_ALERT(@"请填写手机号");
        return;
    }
    NSString *searchText = _phoneTextField.text;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^1[3|4|5|7|8][0-9]\\d{8}$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    if (result){
        LC_LOADING
        [[CWLoginRegisterManager sharedManager]login:_phoneTextField.text password:_passwordTextField.text];
    }else{
        LCSUCCESS_ALSERT(@"您输入的手机号不合法");
    }
    
}


#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    
    if([eventType isEqualToString:CWEventCenterTypeLogin]){
        
        [Common sharedInstance].loginString = @"已经登录";
        
        NSString *token = [NSString stringWithFormat:@"%@", param[@"token"]];
        if (![token isEqual:[NSNull null]] ) {
             [COM saveLoginToken:token];
        }
        
        
        NSString *phone = [NSString stringWithFormat:@"%@",param[@"phone"]];
        if (![phone isEqual:[NSNull null]]) {
            [COM saveLoginPhone:phone];
        }
        
        NSString *name = [NSString stringWithFormat:@"%@",param[@"name"]];
        if (![name isEqual:[NSNull null]]) {
            [COM saveLoginName:name];
        }
        
        NSString *imageUrl = [NSString stringWithFormat:@"%@", param[@"avatar_url"]];
        if (![imageUrl isEqual:[NSNull null]]) {
            [COM saveUserURL:imageUrl];
        }
        //车牌
        NSString *car_plate = [NSString stringWithFormat:@"%@", param[@"car_plate"]];
        if (![car_plate isEqual:[NSNull null]]) {
            [COM saveCarPlate:car_plate];
        }
        //车型
        NSString *car_type = [NSString stringWithFormat:@"%@",param[@"car_type"]];
        if (![car_type isEqual:[NSNull null]]) {
            [COM saveCarType:car_type];
        }
        //车logo
        NSString *car_brandlogo =[NSString stringWithFormat:@"%@", param[@"car_brandlogo"]];
        if (![car_brandlogo isEqual:[NSNull null]]) {
            [COM saveCarImage:car_brandlogo];
        }
        
        //用户id
        NSString *userId =[NSString stringWithFormat:@"%@", param[@"id"]];
        if (![userId isEqual:[NSNull null]]) {
            [COM saveUserId:userId];
        }

        //是否vip
        NSString *isVip =[NSString stringWithFormat:@"%@", param[@"is_vip"]];
        if (![isVip isEqual:[NSNull null]]) {
            [COM saveVip:isVip];
        }
        //绑定车辆id
        NSString *carID = [NSString stringWithFormat:@"%@",param[@"car_id"]];
        if (![carID isEqual:[NSNull null]]) {
            [COM saveCarID:carID];
        }
        
        //余额
        NSString *blance = [NSString stringWithFormat:@"%@",param[@"blance"]];
        if (![blance isEqual:[NSNull null]]) {
            [COM saveUserBlance:blance];
        }
        
        //我的卷
        NSString *ticket_count = [NSString stringWithFormat:@"%@",param[@"ticket_count"]];
        if (![ticket_count isEqual:[NSNull null]]) {
            [COM saveTiketCount:ticket_count];
        }

        //银行卡
        NSString *bank_card_count = [NSString stringWithFormat:@"%@",param[@"bank_card_count"]];
        if (![bank_card_count isEqual:[NSNull null]]) {
            [COM saveBankCardCount:bank_card_count];
        }
        //车架号
        NSString *carFrameNum =[NSString stringWithFormat:@"%@", param[@"car_frame"]];
        if (![carFrameNum isEqual:[NSNull null]]) {
            [COM saveCarFrameNum:carFrameNum];
        }
        //发动机号
        NSString *engineNumber =[NSString stringWithFormat:@"%@", param[@"car_engine"]];
        if (![engineNumber isEqual:[NSNull null]]) {
            [COM saveCarEngineNum:engineNumber];
        }
        //车系名称
        NSString *carsName = [NSString stringWithFormat:@"%@",param[@"car_brand"]];
        if (![carsName isEqual:[NSNull null]]) {
            [COM saveCarsName:carsName];
        }
        //具体车型
        NSString *carModel= [NSString stringWithFormat:@"%@",param[@"car_model"]];
        if (![carModel isEqual:[NSNull null]]) {
            [COM saveCarModel:carModel];
        }
        //查询城市
        NSString *city =[NSString stringWithFormat:@"%@", param[@"city"]];
        if (![city isEqual:[NSNull null]]) {
            COM.city = city;
        }
        
        //会员日期
        NSString *vipDate =[NSString stringWithFormat:@"%@", param[@"vip_date"]];
        if (![vipDate isEqual:[NSNull null]]) {
            [COM setVip_date:vipDate];
        }
        
        //服务器时间
        NSString *serverDate =[NSString stringWithFormat:@"%@", param[@"server_time"]];
        if (![serverDate isEqual:[NSNull null]]) {
            [COM setServer_date:serverDate];
        }

        
#pragma mark 发送查询余额请求
        NSString *userid = [COM getUserId];
        if (userid.length == 0) {
            return;
        }
#pragma mark -- 注册账号 0 用户  1 商家
        COM.isPay = YES;
        [[PayManager sharedManager] accountAccess:APPID customerType:@"0" userid:userid verifyKey:SecretKey];
    }else {
    }
    
    //注册
    if ([eventType isEqualToString:CWEventCenterTypeAccountAccess]) {
        COM.isPay = NO;
        [self backAction:nil];
    }
    //如果此账号注册过则返回失败
    else if ([eventType isEqualToString:CWEventCenterTypeAccountAccessFail]) {
        [self backAction:nil];
        COM.isPay = NO;
    }
}
- (IBAction)loginAction:(id)sender {
    UIStoryboard *loginRegisterStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* loginViewController = [loginRegisterStoryBoard instantiateViewControllerWithIdentifier:@"homeBar"];
        [self.navigationController pushViewController:loginViewController animated:YES];
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
