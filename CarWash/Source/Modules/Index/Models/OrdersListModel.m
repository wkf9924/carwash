//
//  OrdersListModel.m
//  CarWash
//
//  Created by xa on 2016/10/26.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "OrdersListModel.h"

@implementation OrdersListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
