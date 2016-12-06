//
//  BZSettingItem.h
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  每一个cell都应一个BZSettingItem模型

#import <Foundation/Foundation.h>

typedef void (^BZSettingItemOption)();



@interface BZSettingItem : NSObject

/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subtitle;


/**
 *  存储数据用的key
 */
//@property (nonatomic, copy) NSString *key;

/**
 *  点击那个cell需要做什么事情
 */
@property (nonatomic, copy) BZSettingItemOption option;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
