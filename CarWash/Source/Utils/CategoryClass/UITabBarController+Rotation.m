//
//  UITabBarController+Rotation.m
//  BATeacher
//
//  Created by ivan on 15/6/17.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import "UITabBarController+Rotation.h"

@implementation UITabBarController (Rotation)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL isRotate = NO;
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        isRotate = YES;
    }
	return isRotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    NSUInteger interfaceOrientation = UIInterfaceOrientationMaskPortrait;
    return interfaceOrientation;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
