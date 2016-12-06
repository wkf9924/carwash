//
//  UIViewController+ViewControllerGeneralMethod.m
//  Golf

#import "UIViewController+GeneralMethod.h"
#import "KDXEasyTouchButton.h"
#import "Common.h"

@implementation UIViewController (GeneralMethod)

- (void)popViewController {
    if ([COM.popView isEqualToString:@"carShop"]) {
        [self dismissViewController];
        COM.popView = @"";
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:^{}];
}


- (void)setBackBarButton
{
    UIButton *button = [KDXEasyTouchButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 13, 25, 25);
    [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

//- (void)setBackButton : (SEL)selector
//{
//    UIButton *button = [KDXEasyTouchButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(0, 13, 20, 40);
//    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//}

- (void)setDismissBarButton
{
    UIButton *button = [KDXEasyTouchButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 45, 20);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setDoneBarButtonWithSelector:(SEL)selector andTitle:(NSString *)title alpha:(float)alp{
    UIButton *button = [KDXEasyTouchButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 10, 45, 45);
    //[button setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    //[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setDoneBarButtonImageWithSelector:(SEL)selector imageName:(NSString *)title lpha:(float)alp{
    
    UIButton *button = [KDXEasyTouchButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 36, 32);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setBackButtonItem :(SEL)selector backImage:(NSString *)title{
    
    UIButton *rightButton = [KDXEasyTouchButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(0,0,20,20);
    
    [rightButton setImage:[UIImage imageNamed:title]forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.leftBarButtonItem= rightItem;
    
}
@end
