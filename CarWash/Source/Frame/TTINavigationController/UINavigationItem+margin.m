//
//  UINavigationItem+margin.m
//  iCNavigationController
//


#import "UINavigationItem+margin.h"

#define ios7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?YES:NO)

@implementation UINavigationItem (margin)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0

//- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
//{
//    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        spaceButtonItem.width = -8;
//    }
//    
//    
//    if (leftBarButtonItem)
//    {
//        [self setLeftBarButtonItems:@[spaceButtonItem, leftBarButtonItem]];
//    }
//    else
//    {
//        [self setLeftBarButtonItems:@[spaceButtonItem]];
//    }
//}
//
//- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
//{
//    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        spaceButtonItem.width = -8;
//    }
//    
//    if (rightBarButtonItem)
//    {
//        [self setRightBarButtonItems:@[spaceButtonItem, rightBarButtonItem]];
//    }
//    else
//    {
//        [self setRightBarButtonItems:@[spaceButtonItem]];
//    }
//}

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem

{
    
    if (ios7) {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        
        negativeSpacer.width = -10;
        [self setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem,nil]];
        
    } else {
        
        [self setLeftBarButtonItem:leftBarButtonItem];
        
    }
    
}



- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem

{
    
    if (ios7) {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        [self setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem,nil]];
        
    } else {
        
        
        [self setRightBarButtonItem:rightBarButtonItem];
        
    }
    
}

#endif
@end
