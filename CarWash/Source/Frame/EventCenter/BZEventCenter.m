//
//  UIEventCenter.m
//  IOSDemo
//
//  Created by behring on 15/8/31.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import "BZEventCenter.h"
static NSMutableDictionary *mDict;//key事件类型：value事件代理集合
@implementation BZEventCenter

+ (BZEventCenter *)defaultCenter
{
    static BZEventCenter *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

-(void)subscribeWithEventType:(NSString *)eventType callback:(id<BZEventCenterDelegate>)delegate
{
    if (!mDict)
    {
        mDict = [NSMutableDictionary dictionary];
    }
    
    NSMutableArray *delegateArray = [mDict objectForKey:eventType];
    if (!delegateArray)
    {
        NSMutableArray *array = [NSMutableArray arrayWithObject:delegate];
        mDict[eventType] = array;
    }
    else
    {
        if (![delegateArray containsObject:delegate])
        {
            [delegateArray addObject:delegate];
        }else {
            NSLog(@"EventType %@ is subscribe!",eventType);
        }
    }
}

-(void)postToEventType:(NSString *)eventType param:(id)param mainTread:(BOOL)isMainTread
{
    NSMutableArray *delegateArray = [mDict objectForKey:eventType];
    if (delegateArray)
    {
        for (id<BZEventCenterDelegate>delegate in delegateArray)
        {
            if (isMainTread) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [delegate eventCenter:self eventType:eventType callbackParam:param];
                });
            }else {
                [delegate eventCenter:self eventType:eventType callbackParam:param];
            }
        }

    }
    else
    {
        NSLog(@"EventType %@ haven't subscribe!",eventType);
    }    
}

-(void)cancelSubscribeWithEventType:(NSString *)eventType callback:(id<BZEventCenterDelegate>)delegate{
    if (mDict) {
        NSMutableArray *delegateArray = [mDict objectForKey:eventType];
        if (delegateArray) {
            if ([delegateArray containsObject:delegate]) {
                [delegateArray removeObject:delegate];
            }
        }
    }
}

@end
