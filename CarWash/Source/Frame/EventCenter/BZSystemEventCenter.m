//
//  BZSystemEventCenter.m
//  Merchant
//
//  Created by behring on 15/9/4.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import "BZSystemEventCenter.h"
#import <UIKit/UIKit.h>
static NSMutableDictionary *mDict;//key事件类型：value事件代理集合
@implementation BZSystemEventCenter
+ (BZSystemEventCenter *)defaultCenter
{
    static BZSystemEventCenter *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

-(void)subscribeWithEventType:(BZSystemEventCenterType)eventType callback:(id<BZSystemEventCenterDelegate>)delegate{
    NSString *systemEventType;
    switch (eventType) {
        case BZSystemEventCenterTypeKeyboardWillShow:
            systemEventType = UIKeyboardWillShowNotification;
            break;
        case BZSystemEventCenterTypeKeyboardWillHide:
             systemEventType = UIKeyboardWillHideNotification;
            break;
        case BZSystemEventCenterTypeNetworkChange:
        default:
            break;
    }
    
    if (!mDict) {
        mDict = [NSMutableDictionary dictionary];
    }
    
    NSMutableArray *delegateArray = [mDict objectForKey:@(eventType)];
    if (!delegateArray) {
        NSMutableArray *array = [NSMutableArray arrayWithObject:delegate];
        mDict[@(eventType)] = array;
    }else {
        if (![delegateArray containsObject:delegate]) {
            [delegateArray addObject:delegate];
        }
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(systemEvent:)
                                            name:systemEventType
                                            object:nil];
}



-(void)cancelSubscribeWithEventType:(BZSystemEventCenterType)eventType callback:(id<BZSystemEventCenterDelegate>)delegate{
    
}

- (void)systemEvent:(NSNotification *)notification {
    NSNumber *eventType;
    NSString *systemEventType = notification.name;
    if ([systemEventType isEqualToString:UIKeyboardWillShowNotification]) {
        eventType = [NSNumber numberWithInt:BZSystemEventCenterTypeKeyboardWillShow];
    }else if([systemEventType isEqualToString:UIKeyboardWillHideNotification]){
        eventType = [NSNumber numberWithInt:BZSystemEventCenterTypeKeyboardWillHide];
    }
    
    NSMutableArray *delegateArray = [mDict objectForKey:eventType];
    if (delegateArray) {
        for (id<BZSystemEventCenterDelegate>delegate in delegateArray) {
            [delegate systemEventCenter:self eventType:[eventType intValue] callbackParam:notification];
        }
        
    }else {
        NSLog(@"EventType %@ haven't subscribe!",eventType);
    }
}
@end
