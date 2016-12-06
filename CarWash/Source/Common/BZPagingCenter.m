//
//  SQRPagingCenter.m
//  Merchant
//
//  Created by 赵林 on 15/9/15.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import "BZPagingCenter.h"
static NSMutableDictionary *mDict;//key事件类型：value事件代理集合
@implementation BZPagingCenter
+(instancetype)defaultCenter
{
    static BZPagingCenter *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

-(void)registerPaging:(NSString *)tag
{
    
    if (!mDict)
    {
        mDict = [NSMutableDictionary dictionary];
    }
    mDict[tag] = @(0);
}

-(void)cancelRegisterPaging:(NSString *)tag
{
    if (mDict) {
        [mDict removeObjectForKey:tag];
    }
}

-(int)getPage:(BZPagingType)pagingType tag:(NSString *)tag
{
    switch (pagingType) {
        case BZPagingTypeUpPull:
        {
            int page = [mDict[tag]intValue] + 1;
            mDict[tag] = @(page);
            return page;
        }
        case BZPagingTypeDownPull:
            mDict[tag] = @(1);
            return 1;
        default:
            break;
    }
    return 1;
}
-(void)rollbackPage:(NSString *)tag{
    int page = [mDict[tag]intValue] - 1;
    mDict[tag] = @(page);
}
@end
