//
//  CommonPayViewController.h
//  CarWash
//
//  Created by xa on 16/7/26.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayManager.h"
#import "PayPasswordCodeingVC.h"
#import "PaySucceedVC.h"

typedef enum : NSUInteger {
    weChatPay = 100,
    balancePay,
} payMethod;

@interface CommonPayViewController : UIViewController
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *orderNameString;//上个界面传值 订单名称

@property (nonatomic, strong)NSString *interface;
@property (nonatomic, strong)NSString *serviceOrdersID;
@property (nonatomic, strong)NSString *ordersID;

//商品价格
@property (strong, nonatomic) IBOutlet UILabel *goodsPrice;
//实际付款
@property (strong, nonatomic) IBOutlet UILabel *weShouldPayLabel;

@property (weak, nonatomic) IBOutlet UIImageView *weChatSelected;
@property (weak, nonatomic) IBOutlet UIImageView *balanceSelected;
@property (weak, nonatomic) IBOutlet UILabel *orderName;//订单名称
@property (nonatomic, assign)payMethod payMethodString;



@end
