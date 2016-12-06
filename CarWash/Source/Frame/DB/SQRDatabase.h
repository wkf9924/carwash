//
//  SQRDatabase.h
//  IOSDemo
//
//  Created by behring on 15/8/30.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SQRPushMessage;
@interface SQRDatabase : NSObject
+(SQRDatabase *)sharedDatabase;

-(void)savePushMessage:(SQRPushMessage *)pushMessage;
-(NSArray *)getPushMessage;
@end
