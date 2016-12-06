//
//  CDVTabbarVisibility.m
//  HelloWorld
//
//  Created by 赵林 on 16/7/8.
//
//

#import "CDVTabbarVisibility.h"
#import "CWWebViewController.h"
#import "UIAlertView+CustomAlertView.h"
#import "Common.h"
@implementation CDVTabbarVisibility
- (void)TabbarVisibilityAction:(CDVInvokedUrlCommand*)command
{
    CWWebViewController *viewController = (CWWebViewController *)self.viewController;
    NSString* myarg = [command.arguments objectAtIndex:0];
    if ([myarg isEqualToString:@"VISIBLE"]) {
        [viewController.tabBar setHidden:NO];
    } else {
        if ([COM.isGone isEqualToString:@"yes"]) {
            if ([myarg isEqualToString:@"GONE"]) {
                
                [viewController.tabBar setHidden:YES];
                [self setHeight:viewController.rootView.frame.size.height+49 toView:viewController.rootView];
                COM.isGone = @"no";
                
            }
        }
        else {
            [viewController.tabBar setHidden:YES];
        }
//        if ([myarg isEqualToString:@"GONE"]) {
//            
//            [viewController.tabBar setHidden:YES];
//            [self setHeight:viewController.rootView.frame.size.height+49 toView:viewController.rootView];
//        }
//        else {
//            [self setHeight:viewController.rootView.frame.size.height-49 toView:viewController.rootView];
//            [viewController.tabBar setHidden:NO];
//        }
    }
    
    
//    if (myarg != nil) {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    } else {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
//    }
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
//    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"标题" message:myarg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertview show];

}

- (void)setHeight:(CGFloat)height toView:(UIView *)view
{
    CGRect origionRect = view.frame;
    CGRect newRect = CGRectMake(origionRect.origin.x, origionRect.origin.y, origionRect.size.width, height);
    view.frame = newRect;
}
@end
