//
//  DiscountMainModel.m
//  CarWash
//
//  Created by xa on 16/7/27.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "DiscountMainModel.h"

@implementation DiscountMainModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"discount_goods"]) {
        self.discount_goods = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in value) {
            self.discountModel = [[DiscountModel alloc] init];
            [self.discountModel setValuesForKeysWithDictionary:dic];
            [self.discount_goods addObject:self.discountModel];
        }
    }
}

@end
