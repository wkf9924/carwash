//
//  GetAmontModel.m
//  CarWash
//
//  Created by xa on 2016/10/10.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "GetAmontModel.h"

@implementation GetAmontModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
