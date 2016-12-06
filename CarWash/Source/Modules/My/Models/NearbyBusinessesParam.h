//
//  NearbyBusinessesParam.h
//  CarWash
//
//  Created by WangKaifeng on 16/7/25.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineConstant.h"

@interface NearbyBusinessesParam : NSObject
//经度
@property (nonatomic, copy) NSString *longitude;
//纬度
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSString *take;
@property (nonatomic, copy) NSNumber *page;
@end
