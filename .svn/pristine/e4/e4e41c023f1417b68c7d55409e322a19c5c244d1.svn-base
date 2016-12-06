//
//  INPickerView.h
//  Merchant
//
//  Created by ivan on 15/9/11.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol INPickerViewDelegate  <NSObject>

@optional
- (void)didSelectedPickerRow:(int)row;
- (void)didSelectedPickerRow:(int)row withTitle:(NSString *)title;

@end

@interface INPickerView : UIView

@property (nonatomic, assign) id<INPickerViewDelegate> delegate;
@property (nonatomic, strong) NSString *pickerTitle;
@property (nonatomic, strong) NSArray *pickerDataArray;
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withDataArray:(NSArray *)dataArray;

@end
