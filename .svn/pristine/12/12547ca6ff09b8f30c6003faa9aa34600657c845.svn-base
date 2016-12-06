//
//  UIAlertView+CustomAlertView.h
//  BATeacher
//
//  Created by ivan on 15/6/17.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (CustomAlertView)

/**
 *  构建一个简易alertView
 *
 *  @param message  alertView携带消息
 */
+ (void)showSimpleAlert:(NSString*)message;

/**
 *  构建一个简易alertView
 *
 *  @param message  alertView携带消息
 *  @param title    alertView的表填
 *  @param text     button的文字
 *  @param delegate 响应代理
 */
+ (void)showSimpleAlert:(NSString*)message withTitle:(NSString*)title withButton:(NSString*)text toTarget:(id)delegate;


// 添加可以自动隐藏的提示框
+ (void)showAutoHidePromptView:(NSString*)string background:(UIImage*)image duration:(int)duration;

// 去除等待提示窗口遮罩层
+ (void)hidePromptView;

// 显示带有输入框的alertView
+ (void)showAlertViewWithInputText:(NSString *)alertTitle
                  withCancelButton:(NSString *)cancelButtonTitle
                    withDoneButton:(NSString *)doneButtonTitle
                          delegate:(id)delegate;

@end
