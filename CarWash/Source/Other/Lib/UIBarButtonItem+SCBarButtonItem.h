//
//  UIBarButtonItem+SCBarButtonItem.h
//  SCGoJD

//  快速创建UIBarButtonItem

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SCBarButtonItem)

/**
 *  快速创建一个UIBarButtonItem对象
 *
 *  @param backgroundImage  背景图片
 *  @param highlightedImage 高亮图片
 *  @param target           动作目标
 *  @param action           动作
 *  @param controlEvents    事件类型
 *
 *  @return 一个UIBarButtonItem对象
 */
+ (instancetype)barButtonItemWithBackgroundImage:(UIImage *)backgroundImage
                                highlightedImage:(UIImage *)highlightedImage
                                          titles:(NSString *)titleString
                                           alpha:(float)alp
                                          target:(id)target
                                          action:(SEL)action
                                forControlEvents:(UIControlEvents)controlEvents;

/**
 *  可以设置字体颜色的navigationItem
 *
 *  @param backgroundImage  <#backgroundImage description#>
 *  @param highlightedImage <#highlightedImage description#>
 *  @param titleString      <#titleString description#>
 *  @param alp              <#alp description#>
 *  @param color            <#color description#>
 *  @param target           <#target description#>
 *  @param action           <#action description#>
 *  @param controlEvents    <#controlEvents description#>
 *
 *  @return <#return value description#>
 */

+ (instancetype)barButtonItemWithBackgroundImage:(UIImage *)backgroundImage
                                highlightedImage:(UIImage *)highlightedImage
                                          titles:(NSString *)titleString
                                           alpha:(float)alp
                                           color:(UIColor *)color
                                          target:(id)target
                                          action:(SEL)action
                                forControlEvents:(UIControlEvents)controlEvents;


@end