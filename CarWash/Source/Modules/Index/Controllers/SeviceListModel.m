//
//  SeviceListModel.m
//  CarWash
//
//  Created by xa on 16/7/29.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SeviceListModel.h"

@implementation SeviceListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
