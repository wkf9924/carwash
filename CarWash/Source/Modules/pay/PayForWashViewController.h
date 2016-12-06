//
//  PayForWashViewController.h
//  CarWash
//
//  Created by xa on 16/7/26.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeviceDedailModel.h"

@interface PayForWashViewController : UIViewController
@property (nonatomic, strong) SeviceDedailModel *serviceModel;
@property (nonatomic, strong) NSString *interface;

@property (nonatomic, strong)NSString *sellerID;//商家ID

@end
