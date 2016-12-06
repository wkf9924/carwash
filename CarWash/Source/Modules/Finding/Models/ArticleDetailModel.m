//
//  ArticleDetailModel.m
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "ArticleDetailModel.h"

@implementation ArticleDetailModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
