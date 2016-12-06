//
//  GoodsCollection.m
//  CarWash
//
//  Created by xa on 16/9/1.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "GoodsCollection.h"
#import "DefineConstant.h"

@implementation GoodsCollection
- (void)GetTokenAction:(NSString *)token cdv:(CDVInvokedUrlCommand *)command{
    token = [COM getLoginToken];
}
@end
