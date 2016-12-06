//
//  QRCodeVC.h
//  CarWash
//
//  Created by WangKaifeng on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CWBaseViewController.h"

@interface QRCodeVC : CWBaseViewController
@property (nonatomic, strong)NSString *orderID;

@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *endTime;

//会员生成订单要传的参数
@property (nonatomic, strong)NSString *tokenStirng;
@end
