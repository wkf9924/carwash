//
//  SelectProvinceViewController.h
//  CarWash
//
//  Created by xa on 16/7/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectProvinceViewControllerDelegate <NSObject>

- (void)sendValue:(NSString *)province;

@end

@interface SelectProvinceViewController : UIViewController
@property (nonatomic, assign)id <SelectProvinceViewControllerDelegate> delegate;
@end
