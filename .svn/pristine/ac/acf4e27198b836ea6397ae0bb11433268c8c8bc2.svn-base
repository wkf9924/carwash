//
//  SQRBaseViewController.h
//  Merchant
//
//  Created by 赵林 on 15/9/1.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IanAlert.h"
#import "DefineColor.h"
#import "BZDefine.h"
#import "MBProgressHUD+MJ.h"
#import "CWEventCenterType.h"
#import "BZEventCenter.h"
@protocol SQRBaseViewControllerDelegate
@required
-(void)initViews;
@optional
-(void)handleParam:(id)param;
@end

@interface CWBaseViewController : UIViewController <SQRBaseViewControllerDelegate>
@property(nonatomic,assign) id<SQRBaseViewControllerDelegate> superDelegate;
-(void)setParam:(id)param;
-(id)getParam;
- (UITextField *)setTextField:(UITextField *)tf; //textField 左边空位
@end
