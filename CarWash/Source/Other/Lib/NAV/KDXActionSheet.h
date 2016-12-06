//
//  GEActionSheet.h
//  Grouvent


#import <UIKit/UIKit.h>

@interface KDXActionSheet : NSObject

- (id)initWithTitle:(NSString *)title
  cancelButtonTitle:(NSString *)cancelButtonTitle
  cancelActionBlock:(void ( ^)())cancelActionBlock
destructiveButtonTitle:(NSString *)destructiveButtonTitle
destructiveActionBlock:(void ( ^)())destructiveActionBlock;

- (void)addButtonWithTitle:(NSString *)title actionBlock:(void ( ^)())actionBlock;

- (void)showInView:(UIView *)view;

@end
