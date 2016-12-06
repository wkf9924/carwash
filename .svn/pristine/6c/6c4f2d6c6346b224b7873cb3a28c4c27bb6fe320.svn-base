//
//  UIAlertView+CustomAlertView.m
//  BATeacher
//
//  Created by ivan on 15/6/17.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import "UIAlertView+CustomAlertView.h"

#define PROMPT_WAITING_VIEW_TAG 100

@implementation UIAlertView (CustomAlertView)

/**
 *  构建一个简易alertView
 *
 *  @param message  alertView携带消息
 */
+ (void)showSimpleAlert:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:nil
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil];
    [alert show];
}

/**
 *  构建一个简易alertView
 *
 *  @param message  alertView携带消息
 *  @param title    alertView的表填
 *  @param text     button的文字
 *  @param delegate 代理对象
 */
+ (void)showSimpleAlert:(NSString*)message
              withTitle:(NSString*)title
             withButton:(NSString*)text
               toTarget:(id)delegate
{
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:title
						  message:message
						  delegate:delegate
						  cancelButtonTitle:text
						  otherButtonTitles: nil];
	[alert show];
}

// 计算字符串的size
+ (CGSize)calculateStringSize:(NSString *)textString withTextFont:(UIFont *)font constrainedToSize:(CGSize)maxSize
{
    if (textString == nil || font == nil)
    {
        return CGSizeZero;
    }
    CGSize size = CGSizeZero;
    
    if ([textString respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        CGRect rect = [textString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName] context:nil];
        size = CGSizeMake(rect.size.width, rect.size.height);
    }
    
    
    return size;
}

// 添加可以自动隐藏的提示框
+ (void)showAutoHidePromptView:(NSString*)string background:(UIImage*)image duration:(int)duration
{
    // 获取所要显示的字需要占据的空间大小
    UIFont *font = [UIFont systemFontOfSize:18];
    
    CGFloat screenWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen]bounds].size.height;
    //设定绘制字符串高和宽
    CGSize sizeString = [UIAlertView calculateStringSize:string withTextFont:font constrainedToSize:CGSizeMake(200, screenHeight)];
    
    CGFloat width = sizeString.width;
    CGFloat height = sizeString.height;
    
    
    
    // 创建要显示的View，
    UIView *alertView = nil;
    UIImageView *imageView = nil;
    UILabel *label = nil;
    
    //是否有图片显示
    if (image != nil)
    {
        //获取图文混排的高度和宽度
        float imageWidth = CGImageGetWidth(image.CGImage)/2;
        float imageHeight = CGImageGetHeight(image.CGImage)/2;
        //40是字图片和背景的间距X2
        float alertVieWidth = (width > imageWidth ? width : imageWidth) + 40;
        //20是字和图片的间距 40是字图片和背景的间距X2
        float alertVieHeight = height + imageHeight + 30 + 40;
        
        alertView = [[UIView alloc] initWithFrame:CGRectMake((screenWidth-alertVieWidth)/2.0, (screenHeight-alertVieHeight)/2.0, alertVieWidth, alertVieHeight)];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((alertVieWidth - imageWidth)/2.0, 20 , imageWidth, imageHeight)];
        [imageView setImage:image];
        label = [[UILabel alloc] initWithFrame:CGRectMake((alertVieWidth - sizeString.width)/2, 10 + imageHeight + 30, sizeString.width, sizeString.height)];
    }
    else
    {
        alertView = [[UIView alloc] initWithFrame:CGRectMake((screenWidth-width)/2.0 - 20, (screenHeight-height)/2.0 - 20, width+40, height+40)];
        label = [[UILabel alloc] initWithFrame:CGRectMake((alertView.frame.size.width - width)/2.0, (alertView.frame.size.height - height)/2.0, width, height)];
    }
    //设置文字对齐方式
    [label setTextAlignment:NSTextAlignmentCenter];
    //设置文字大小
    [label setFont:font];
    //设置文本
    [label setText:string];
    //设置文字颜色
    [label setTextColor:[UIColor whiteColor]];
    //设置label背景色为透明
    [label setBackgroundColor:[UIColor clearColor]];
    //设置label可以换行
    label.numberOfLines = 0;
    //设置label换行方式
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    
    [alertView setBackgroundColor:[UIColor blackColor]];
    //设定圆角
    alertView.layer.cornerRadius = 7.5;
    alertView.layer.masksToBounds = YES;
    //设定此view透明度
    [alertView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    [alertView addSubview:label];
    if (imageView != nil) {
        [alertView addSubview:imageView];
    }
    
    //获取当前window
    UIWindow *window = [[[UIApplication sharedApplication]windows] objectAtIndex:0];
    [window addSubview:alertView];
    alertView.tag = PROMPT_WAITING_VIEW_TAG;
    
    //开始动画设置
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    
    //设置扫尾动作
    [UIView setAnimationDidStopSelector:@selector(fadeOutMaskView)];
    alertView.alpha = 0.79;
    [UIView commitAnimations];
    
}

// 设置提示等待窗口的淡出效果
+ (void)fadeOutMaskView
{
    UIWindow *window = [[[UIApplication sharedApplication]windows] objectAtIndex:0];
    UIView *maskView = [window viewWithTag:PROMPT_WAITING_VIEW_TAG];
    if (maskView != nil)
    {
        // 整个遮罩层淡出效果，开始动画设置
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        
        // 设置扫尾动作
        [UIView setAnimationDidStopSelector:@selector(hidePromptView)];
        maskView.alpha = 0.0;
        [UIView commitAnimations];
    }
}

// 去除等待提示窗口遮罩层
+ (void)hidePromptView
{
    UIWindow *window = [[[UIApplication sharedApplication]windows] objectAtIndex:0];
    UIView *maskView = [window viewWithTag:PROMPT_WAITING_VIEW_TAG];
    if (maskView != nil)
    {
        // 将遮罩层去掉
        [maskView removeFromSuperview];
    }
}

// 显示带有输入框的alertView
+ (void)showAlertViewWithInputText:(NSString *)alertTitle
                  withCancelButton:(NSString *)cancelButtonTitle
                    withDoneButton:(NSString *)doneButtonTitle
                          delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:alertTitle
                          message:nil
                          delegate:delegate
                          cancelButtonTitle:nil
                          otherButtonTitles: cancelButtonTitle, doneButtonTitle, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

@end
