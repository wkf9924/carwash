//
//  INPickerView.m
//  Merchant
//
//  Created by ivan on 15/9/11.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import "INPickerView.h"

@interface INPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *pickerView;
    UILabel *titleLabel;
}

@property (nonatomic) int selectedRow;

@end

@implementation INPickerView

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withDataArray:(NSArray *)dataArray
{
    self = [super initWithFrame: frame];
    if (self) {
        // [self setBackgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self initControl:frame withTitle:title withDataArray: dataArray];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        // [self setBackgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self initControl:frame withTitle:nil withDataArray: nil];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = [[UIScreen mainScreen] bounds];
        [self initControl:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) withTitle:nil withDataArray: nil];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -
#pragma mark Instance methods

- (void)initControl:(CGRect)frame withTitle:(NSString *)title withDataArray:(NSArray *)dataArray
{
    UIView *bgView = [[UIView alloc] initWithFrame: CGRectMake(0, frame.size.height - 256, frame.size.width, 256)];
    [bgView addSubview: pickerView];
    [bgView setBackgroundColor: [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0]];
    
    pickerView = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 40, frame.size.width, 216)];
    [pickerView setBackgroundColor: [UIColor whiteColor]];
    
    // 显示选中框
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [bgView addSubview: pickerView];
    
    
    titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, 39)];
    [bgView addSubview: titleLabel];
    [titleLabel setBackgroundColor: [UIColor whiteColor]];
    [titleLabel setTextAlignment: NSTextAlignmentCenter];
    [titleLabel setTextColor: [UIColor blackColor]];
    titleLabel.text = title;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(10.0, 5, 50, 30)];
    [button setTitle:@"取消" forState:UIControlStateNormal];// (255,68,0)
    [button setTitleColor:[UIColor colorWithRed:255/255.0 green:68/255.0 blue:0 alpha: 1.0] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    
    [button addTarget:self action:@selector(touchCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(self.frame.size.width - 60, 5, 50, 30)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:255/255.0 green:68/255.0 blue:0 alpha: 1.0] forState:UIControlStateNormal];
    [button setBackgroundColor: [UIColor clearColor]];
    [button addTarget:self action:@selector(touchDoneButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    
    [self addSubview: bgView];
    self.pickerDataArray = dataArray;
}

- (void)setPickerTitle:(NSString *)pickerTitle
{
    _pickerTitle = pickerTitle;
    titleLabel.text = pickerTitle;
}

- (void)setPickerDataArray:(NSArray *)pickerDataArray
{
    _pickerDataArray = pickerDataArray;
    self.selectedRow = 0;
    [pickerView selectRow:0 inComponent:0 animated:NO];
    [pickerView reloadAllComponents];
}

#pragma mark -
#pragma mark UIButton Action methods

- (void)touchCancelButton
{
    [self removeFromSuperview];
}

- (void)touchDoneButton
{
    if (self.delegate && [self.delegate respondsToSelector: @selector(didSelectedPickerRow:)])
    {
        [self.delegate didSelectedPickerRow: self.selectedRow];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedPickerRow:withTitle:)])
    {
        [self.delegate didSelectedPickerRow:self.selectedRow withTitle: [self.pickerDataArray objectAtIndex: self.selectedRow]];
    }
    [self removeFromSuperview];
}

#pragma mark -
#pragma mark UIPickerView
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerDataArray count];
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 300;
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedRow = (int)row;
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerDataArray objectAtIndex: row];
}

@end
