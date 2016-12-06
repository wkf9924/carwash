//
//  UIBarButtonItem+SCBarButtonItem.m
//  SCGoJD


#import "UIBarButtonItem+SCBarButtonItem.h"

@implementation UIBarButtonItem (SCBarButtonItem)

+ (instancetype)barButtonItemWithBackgroundImage:(UIImage *)backgroundImage
highlightedImage:(UIImage *)highlightedImage
titles:(NSString *)titleString
alpha:(float)alp
target:(id)target
action:(SEL)action
forControlEvents:(UIControlEvents)controlEvents {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:backgroundImage forState:UIControlStateNormal];
    [button setAlpha:alp];
    [button setTitle:titleString forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    if (highlightedImage != nil) {
        
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    // 必须要设置控件尺寸，这里选择根据内容自适应
    [button sizeToFit];
    
    //点击事件
    [button addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


+ (instancetype)barButtonItemWithBackgroundImage:(UIImage *)backgroundImage
                                highlightedImage:(UIImage *)highlightedImage
                                          titles:(NSString *)titleString
                                           alpha:(float)alp
                                           color:(UIColor *)color
                                          target:(id)target
                                          action:(SEL)action
                                forControlEvents:(UIControlEvents)controlEvents {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:backgroundImage forState:UIControlStateNormal];
    [button setAlpha:alp];
    [button setTitle:titleString forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    if (highlightedImage != nil) {
        
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    // 必须要设置控件尺寸，这里选择根据内容自适应
    [button sizeToFit];
    
    //点击事件
    [button addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end