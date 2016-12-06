//
//  DiscountMainModel.h
//  CarWash
//
//  Created by xa on 16/7/27.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscountModel.h"

@interface DiscountMainModel : NSObject
@property (nonatomic,strong)NSMutableArray *discount_goods;
@property (nonatomic,strong)NSString *total_number;
@property (nonatomic,strong)DiscountModel *discountModel;
@end
