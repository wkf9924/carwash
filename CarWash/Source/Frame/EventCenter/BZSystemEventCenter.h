//
//  BZSystemEventCenter.h
//  Merchant
//
//  Created by behring on 15/9/4.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    BZSystemEventCenterTypeKeyboardWillShow,
    BZSystemEventCenterTypeKeyboardWillHide,
    BZSystemEventCenterTypeNetworkChange
}BZSystemEventCenterType;

@class BZSystemEventCenter;
@protocol BZSystemEventCenterDelegate <NSObject>
@required
-(void)systemEventCenter:(BZSystemEventCenter *)eventCenter eventType:(BZSystemEventCenterType)eventType callbackParam:(id)param;
@end



@interface BZSystemEventCenter : NSObject
+(BZSystemEventCenter *)defaultCenter;
-(void)subscribeWithEventType:(BZSystemEventCenterType)eventType callback:(id<BZSystemEventCenterDelegate>)delegate;
-(void)cancelSubscribeWithEventType:(BZSystemEventCenterType)eventType callback:(id<BZSystemEventCenterDelegate>)delegate;
@end
