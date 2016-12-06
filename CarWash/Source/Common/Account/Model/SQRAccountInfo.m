//
//  SQRAccount.m
//  Merchant
//
//  Created by 赵林 on 15/9/2.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import "SQRAccountInfo.h"

@implementation SQRAccountInfo
+(SQRAccountInfo *)sharedInstance{
    static SQRAccountInfo *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}
@end
