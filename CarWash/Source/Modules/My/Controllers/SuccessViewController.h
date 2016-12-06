//
//  GetCashSuccessViewController.h
//  CarWash
//
//  Created by xa on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *successTitle;
@property (strong, nonatomic) IBOutlet UILabel *moneyTransferCount;
@property (nonatomic, strong) NSString *successtitle;

@property (nonatomic, strong)NSString *getCashCount;

@end
