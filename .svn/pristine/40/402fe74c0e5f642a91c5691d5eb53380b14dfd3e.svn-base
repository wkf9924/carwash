//
//  CWWebViewController.m
//  CarWash
//
//  Created by 赵林 on 16/7/13.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CWWebViewController.h"
#import "Common.h"
@interface CWWebViewController ()

@end

@implementation CWWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    COM.isGone = @"yes";
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setHeight:(CGFloat)height toView:(UIView *)view
{
    CGRect origionRect = view.frame;
    CGRect newRect = CGRectMake(origionRect.origin.x, origionRect.origin.y, origionRect.size.width, height);
    view.frame = newRect;
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
