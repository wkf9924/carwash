
//
//  RemindServiceVC.m
//  CarWash
//
//  Created by xa on 16/8/18.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "RemindServiceVC.h"
#import "DefineConstant.h"
#import "Definition.h"

@interface RemindServiceVC ()
@property (nonatomic, strong)UIDatePicker *datePicker_1;
@property (nonatomic, strong)UIDatePicker *datePicker_2;
@end

@implementation RemindServiceVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史记录";
    [self setBackBarButton];
    [self datePicker_1];
    [self datePicker_2];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//保存按钮回调
- (IBAction)commitButtonAction:(id)sender {
    
    
}
- (UIDatePicker *)datePicker_1{
    if (!_datePicker_1) {
        _datePicker_1 = [[UIDatePicker alloc] init];
        _datePicker_1.datePickerMode = UIDatePickerModeDate;
        self.buyInsuranceTimeText.inputView = _datePicker_1;
        _datePicker_1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];;
        [_datePicker_1 addTarget:self action:@selector(datePicker_1:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker_1;
}
- (void)datePicker_1:(UIDatePicker *)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM"];
    self.buyInsuranceTimeText.text = [dateFormatter stringFromDate:sender.date];
}
- (UIDatePicker *)datePicker_2{
    if (!_datePicker_2) {
        _datePicker_2 = [[UIDatePicker alloc] init];
        _datePicker_2.datePickerMode = UIDatePickerModeDate;
        self.buyCarTimeText.inputView = _datePicker_2;
        _datePicker_2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [_datePicker_2 addTarget:self action:@selector(datePicker_2:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker_2;
}
- (void)datePicker_2:(UIDatePicker *)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM"];
    self.buyCarTimeText.text = [dateFormatter stringFromDate:sender.date];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
