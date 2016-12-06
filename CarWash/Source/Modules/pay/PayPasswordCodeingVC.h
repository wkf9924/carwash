//
//  PayPasswordCodeingVC.h
//  CarWash
//
//  Created by xa on 2016/10/17.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayPasswordCodeingVC : UIViewController

@property (nonatomic, strong) NSString *Accepter_userid;
@property (nonatomic, strong) NSString *Amount;

//RCP
@property (nonatomic, strong)NSString *interface;//用来判断从哪个界面跳转过来的
@property (nonatomic, strong)NSString *couponID;//优惠券ID
@property (nonatomic, strong)NSString *serviceID;//服务ID
@property (nonatomic, strong)NSString *sellerID;//商家ID
@property (nonatomic, strong)NSString *money;//实付金额
@property (nonatomic, strong)NSString *ordersId;//订单唯一标示符

@end
