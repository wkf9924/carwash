//
//  SQRPagingCenter.h
//  Merchant
//
//  Created by 赵林 on 15/9/15.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    BZPagingTypeUpPull = 0,
    BZPagingTypeDownPull
}BZPagingType;

@interface BZPagingCenter : NSObject
+(instancetype)defaultCenter;
-(void)registerPaging:(NSString *)tag;
-(void)cancelRegisterPaging:(NSString *)tag;

-(int)getPage:(BZPagingType)pagingType tag:(NSString *)tag;
-(void)rollbackPage:(NSString *)tag;
@end
