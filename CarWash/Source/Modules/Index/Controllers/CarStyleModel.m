//
//  CarStyleModel.m
//  CarWash
//
//  Created by xa on 16/8/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CarStyleModel.h"

@implementation CarStyleModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"series"]) {
        self.seriesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in value) {
            self.carstyleModel = [[CarStyleSubModel alloc] init];
            [self.carstyleModel setValuesForKeysWithDictionary:dic];
            [self.seriesArray addObject:self.carstyleModel];
        }
    }
}
@end
