//
//  UITabBarController+Rotation.h
//  BATeacher
//
//  Created by ivan on 15/6/17.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (Rotation)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (NSUInteger)supportedInterfaceOrientations;
- (BOOL)shouldAutorotate;

@end