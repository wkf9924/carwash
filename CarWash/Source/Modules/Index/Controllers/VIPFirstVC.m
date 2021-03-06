//
//  VIPFirstVC.m
//  CarWash
//
//  Created by xa on 2016/11/10.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "VIPFirstVC.h"
#import "DefineConstant.h"
#import "Common.h"
#import "VIPTopUpVC.h"
#import "CWLoginViewController.h"

@interface VIPFirstVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView_VIP;
@property (weak, nonatomic) IBOutlet UIButton *VITtopUpVC;

@end

@implementation VIPFirstVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden= YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    
    self.title = @"VIP会员";
    if (IS_IPHONE_5) {
        self.imageView_VIP.image = [UIImage imageNamed:@"会员-banner4.0"];
    }else if (IS_IPHONE_6){
        self.imageView_VIP.image = [UIImage imageNamed:@"会员-banner4.7"];
    }else if (IS_IPHONE_6P){
        self.imageView_VIP.image = [UIImage imageNamed:@"会员-banner5.5"];
    }
    
    if ([[COM getLoginToken] isEqualToString:@""] || [COM getLoginToken] == nil) {
        return;
    }
    
    NSString *serverTime = [COM server_date];
    NSString *vipTime = [COM vip_date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *lastdateServer = [dateFormatter dateFromString:serverTime];
    NSDate *lastdateVip = [dateFormatter dateFromString:vipTime];
    NSLog(@"%@  %@", lastdateServer, lastdateVip);
    
    if ([lastdateServer laterDate:lastdateVip]) {
        LCSUCCESS_ALSERT(@"会员到期");
    }
    
    
    
//    UIDevice currentDevice
    // Do any additional setup after loading the view.
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
- (IBAction)ButtonAction:(id)sender {
    
    NSString *token  = [COM getLoginToken];
    if (!token || token == nil || [token isEqualToString:@""])  {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        CWLoginViewController  *lg = [sb instantiateViewControllerWithIdentifier:@"login"];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:lg animated:YES];
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择服务类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"请选择服务类型"];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, 7)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 7)];
    [alert setValue:alertControllerStr forKey:@"attributedTitle"];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"半年包:680" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        VIPTopUpVC *vipTopup = [[UIStoryboard storyboardWithName:@"VIP" bundle:nil] instantiateViewControllerWithIdentifier:@"VIPTopUpVC"];
        vipTopup.price = @"680";
        vipTopup.VIPType = @"半年包";
        [self.navigationController pushViewController:vipTopup animated:YES];
    }];
    [action_1 setValue:[UIColor darkGrayColor] forKey:@"titleTextColor"];
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"一年包:1280" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        VIPTopUpVC *vipTopup = [[UIStoryboard storyboardWithName:@"VIP" bundle:nil] instantiateViewControllerWithIdentifier:@"VIPTopUpVC"];
        vipTopup.price = @"1280";
        vipTopup.VIPType = @"一年包";
        [self.navigationController pushViewController:vipTopup animated:YES];
    }];
    [action_2 setValue:[UIColor darkGrayColor] forKey:@"titleTextColor"];
    UIAlertAction *action_3 = [UIAlertAction actionWithTitle:@"两年包:2280" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        VIPTopUpVC *vipTopup = [[UIStoryboard storyboardWithName:@"VIP" bundle:nil] instantiateViewControllerWithIdentifier:@"VIPTopUpVC"];
        vipTopup.price = @"2280";
        vipTopup.VIPType = @"两年包";
        [self.navigationController pushViewController:vipTopup animated:YES];
    }];
    [action_3 setValue:[UIColor darkGrayColor] forKey:@"titleTextColor"];
    UIAlertAction *action_4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [action_4 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alert addAction:action_1];
    [alert addAction:action_2];
    [alert addAction:action_3];
    [alert addAction:action_4];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
