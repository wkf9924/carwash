//
//  BZSettingArrowItem.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "BZSettingArrowItem.h"

@implementation BZSettingArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass
{
    BZSettingArrowItem *item = [self itemWithIcon:icon title:title subTitle:subTitle];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    BZSettingArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title subTitle:subTitle destVcClass:destVcClass];
}
@end
