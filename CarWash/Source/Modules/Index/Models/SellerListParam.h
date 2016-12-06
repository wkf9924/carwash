//
//  SellerListParam.h
//  CarWash
//
//  Created by WangKaifeng on 16/7/26.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SQRBaseHttpParam.h"

@interface SellerListParam : SQRBaseHttpParam
//经度
@property (nonatomic, copy) NSString *longitude;
//纬度
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSNumber *page;
@end
