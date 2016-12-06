//
//  BindingVC.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "BindingVC.h"
#import "DefineConstant.h"
#import "SelectCarViewController.h"
#import "SelectProvinceViewController.h"
#import "Common.h"

#import "CarBrandManager.h"

#import "UIImageView+WebCache.h"

@interface BindingVC ()<SelectProvinceViewControllerDelegate,BZEventCenterDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *carLogo;
@property (strong, nonatomic) IBOutlet UILabel *carStyle;
@property (strong, nonatomic) IBOutlet UIButton *selectProvinceButton;
@property (strong, nonatomic) IBOutlet UITextField *carNumberFiled;

@end

@implementation BindingVC

//选择车型按钮的回调
- (IBAction)selectCarButtonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Binding" bundle:nil];
    SelectCarViewController *selectCarVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectCarVC"]
    ;
    [self.navigationController pushViewController:selectCarVC animated:YES];
}

//选择省份按钮回调
- (IBAction)selectProvinceButton:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Binding" bundle:nil];
    SelectProvinceViewController *selectProvinceVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectProvinceVC"]
    ;
    //指定代理
    selectProvinceVC.delegate = self;
    [self.navigationController pushViewController:selectProvinceVC animated:YES];
}
- (void)sendValue:(NSString *)province{
    NSString *string = [province substringToIndex:1];
    [self.selectProvinceButton setTitle:string forState:UIControlStateNormal];
}
//绑定按钮回调
- (IBAction)commitButtonAction:(UIButton *)sender {
    //把'省'跟牌号以'-'连接拼在一起
    
    if (self.carNumberFiled.text.length != 6) {
        return;
        LC_SHOW_FAIL(@"请正确输入您的车牌号,注意区分大小写");
    }
    NSString *carPlate = [self.selectProvinceButton.titleLabel.text stringByAppendingFormat:@"%@",self.carNumberFiled.text];
    //提交数据
    if (COM.logoIconStr.length != 0 && COM.seriesNameStr.length != 0 && self.carNumberFiled.text.length != 0) {
//        [[CarBrandManager sharedManager] carBranding:[COM brandName] carNumber:carPlate carType:COM.brandName carLogo:COM.logoIconStr carModel:[COM seriesNameStr]];
    }else{
        LC_SHOW_FAIL(@"请完善车辆基本信息");
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeBindingMyCar callback:self];
    
    if (COM.logoIconStr.length == 0 || COM.seriesNameStr.length == 0) {
        return;
    }else{
        [self.carLogo sd_setImageWithURL:[NSURL URLWithString:COM.logoIconStr] placeholderImage:[UIImage imageNamed:@"绑定爱车"]];
        self.carStyle.text = COM.seriesNameStr;
        NSLog(@"logo%@",COM.logoIconStr);
    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeBindingMyCar callback:self];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    
    if ([eventType isEqualToString:CWEventCenterTypeBindingMyCar]) {
        NSLog(@"%@",param);
//#pragma mark 正式调用
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Binding" bundle:nil];
//        AddMoreInfoVC *addMoreInfo = [storyboard instantiateViewControllerWithIdentifier:@"AddMoreInfoVC"];
//        
//        if (param == NULL) {
//            return;
//            NSLog(@"没有返回数据");
//        }else{
//            addMoreInfo.car_id = param[@"car_id"];
//        }
//        
//        [self.navigationController pushViewController:addMoreInfo animated:YES];
    }else{
        NSLog(@"绑定失败");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定爱车";
    [self setBackBarButton];
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
