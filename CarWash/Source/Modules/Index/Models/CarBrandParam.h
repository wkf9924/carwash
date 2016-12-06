//
//  CarBrandParam.h
//  CarWash
//
//  Created by xa on 16/7/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//
#import "SQRBaseHttpParam.h"

@interface CarBrandParam : SQRBaseHttpParam
@property (nonatomic, strong)NSString *carBrand;  //车品牌
@property (nonatomic, strong)NSString *carNumber;  //车牌
@property (nonatomic, strong)NSString *carType;  //车型
@property (nonatomic, strong) NSString *carmodel; //具体车型
@property (nonatomic, strong) NSString *carLogo;  //品牌logo
@property (nonatomic, strong) NSString *carFrameNum;
@property (nonatomic, strong) NSString *engine_number;
@property (nonatomic, strong)NSString *toke;
@property (nonatomic, strong)NSString *city;
@end
