//
//  QRCodeVC.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "QRCodeVC.h"
#import "DefineConstant.h"
#import "NetWorkingHelper.h"
#import "UIImageView+WebCache.h"

@interface QRCodeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImage;//二维码
@property (weak, nonatomic) IBOutlet UITextView *DirectionForUseTextView;//使用说明
@property (weak, nonatomic) IBOutlet UILabel *validTimeLabel;//消费券有效期

@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)int sumTime;

@end

@implementation QRCodeVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    self.timer = nil;
    [self.timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码凭证";
    [self setBackBarButton];
    self.DirectionForUseTextView.userInteractionEnabled = NO;

    if (self.startTime == nil || self.endTime == nil) {
        self.validTimeLabel.text = @"";
    }else{
        self.validTimeLabel.text = [NSString stringWithFormat:@"有效期 : %@-%@",self.startTime,self.endTime];
    }
    
    if ([COM.shopType isEqualToString:@"会员"]) {
        NSString *url = [NSString stringWithFormat:@"http://%@/payment/payRcode?orderid=%@&token=%@",API_SERVER_HOST,self.orderID,[COM getLoginToken]];
        [self.QRCodeImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
        COM.shopType = @"";
    } else {
        NSString *url = [NSString stringWithFormat:@"http://%@/payment/payRcode?orderid=%@&token=%@",API_SERVER_HOST,self.orderID,[COM getLoginToken]];
        [self.QRCodeImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
    }
    
  
    [self.timer setFireDate:[NSDate distantPast]];
    
}
//NSTimer懒加载
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(cutSeconds) userInfo:nil repeats:YES];
        //暂停
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}
//定时器回调
- (void)cutSeconds{
    NSString *url = [NSString stringWithFormat:@"http://%@/payment/payRcode?orderid=%@&token=%@",API_SERVER_HOST,self.orderID,[COM getLoginToken]];
    [self.QRCodeImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
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
