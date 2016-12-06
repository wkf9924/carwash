//
//  BZSettingItem.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "BZSettingItem.h"

@implementation BZSettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle;
{
    BZSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.subtitle = subTitle;
    return item;
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    BZSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}


+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    return [self itemWithIcon:nil title:title subTitle:subTitle];
}

@end
