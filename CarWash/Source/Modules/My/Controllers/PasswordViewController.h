//
//  PasswordViewController.h
//  CarWash
//
//  Created by xa on 16/7/19.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong)NSString *interface;
@property (nonatomic, strong)NSString *cardNum;//银行卡号
@property (nonatomic, strong)NSString *password;

@property (nonatomic, strong)NSString *cashCount;//提现金额;

@property (nonatomic, strong)NSString *password2;
@end
