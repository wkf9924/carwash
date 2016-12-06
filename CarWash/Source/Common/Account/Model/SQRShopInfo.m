//
//  SQRShopInfo.m
//  Merchant
//
//  Created by 赵林 on 15/9/2.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import "SQRShopInfo.h"

@implementation SQRShopInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shopName = @"";
        self.shopKindName = @"";
        self.shopKindDescription = @"";
        self.shopKindImageUrl = @"";
        self.shopKindId = @(-1);
        self.shopId = @"";
        self.userName = @"";
        self.shopName = @"";
        self.shopAddress = @"";
        self.longitude = @(0.0);
        self.latitude = @(0.0);
        self.shopDescription = @"";
        self.phoneNumber =  @"";
        self.imagePathArray = [NSMutableArray array];
        self.fileIdArray = [NSMutableArray array];
        self.shopVerifyProgress = @(-1);
        self.sendCost = @"5元";
        self.sendPrice = @"25元";
        self.sendScope = @"";
        self.sendType = @(-1);
        self.businessStatus = @(-1);
        self.businessHours = @"";
        self.accountBalance = @(0);
        self.totalIncome = @(0);
        self.startTime = @"";
        self.endTime = @"";
        
    }
    return self;
}
@end
