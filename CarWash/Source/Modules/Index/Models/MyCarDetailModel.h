//
//  MyCarDetailModel.h
//  CarWash
//
//  Created by xa on 16/8/25.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCarDetailModel : NSObject
@property (nonatomic, strong)NSString *brand_logo;//品牌logo
@property (nonatomic, strong)NSString *car_brand;//品牌名
@property (nonatomic, strong)NSString *car_id;//品牌logo
@property (nonatomic, strong)NSString * car_model;//具体车型
@property (nonatomic, strong)NSString *car_plate;//车辆号牌
@property (nonatomic, strong)NSString *car_type;//车辆型号
@property (nonatomic, strong)NSString *city;//查询城市
@property (nonatomic, strong)NSString *engine_number;//发动机型号
@property (nonatomic, strong)NSString *last_insurancetime;//上次购买保险日期
@property (nonatomic, strong)NSString *mileage;//公里数
@property (nonatomic, strong)NSString *shopcar_time;//购车日期
@property (nonatomic, strong)NSString *vehicle_type;//车辆类型
@end
