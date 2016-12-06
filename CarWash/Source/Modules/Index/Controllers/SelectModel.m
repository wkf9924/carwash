//
//  SelectModel.m
//  CarWash
//
//  Created by xa on 16/7/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SelectModel.h"

@implementation SelectModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"brands"]) {
        self.rcp_brands = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in value) {
            self.selectCarModel = [[SelectCarModel alloc] init];
            [self.selectCarModel setValuesForKeysWithDictionary:dic];
            [self.rcp_brands addObject:self.selectCarModel];
        }
    }
}
@end
