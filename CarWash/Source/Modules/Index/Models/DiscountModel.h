//
//  DiscountModel.h
//  CarWash
//
//  Created by xa on 16/7/27.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountModel : NSObject
@property (nonatomic, assign)NSInteger ID;
@property (nonatomic, strong)NSString *image_url;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, assign)NSInteger original_price;
@property (nonatomic, assign)NSInteger presell_count;
@property (nonatomic, assign)NSInteger price;
@property (nonatomic, assign)NSString  *selled_count;
@end
