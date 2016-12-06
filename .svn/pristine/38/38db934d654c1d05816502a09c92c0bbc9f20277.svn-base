//
//  UIEventCenter.h
//  IOSDemo
//
//  Created by behring on 15/8/31.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BZEventCenter;
@protocol BZEventCenterDelegate <NSObject>
@required
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param;
@end
@interface BZEventCenter : NSObject
+ (BZEventCenter *)defaultCenter;
-(void)subscribeWithEventType:(NSString *)eventType callback:(id<BZEventCenterDelegate>)delegate;
-(void)cancelSubscribeWithEventType:(NSString *)eventType callback:(id<BZEventCenterDelegate>)delegate;
-(void)postToEventType:(NSString *)eventType param:(id)param mainTread:(BOOL)isMainTread;
@end
