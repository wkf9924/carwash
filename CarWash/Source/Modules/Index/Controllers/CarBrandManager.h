//
//  CarBrandManager.h
//  CarWash
//
//  Created by xa on 16/7/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaWashParam.h"
#import "MyLoveCarParam.h"

@interface CarBrandManager : NSObject
+(CarBrandManager *)sharedManager;
/**
 *  绑定车辆
 */
-(void)carBranding:(NSString *)carbr
         carNumber:(NSString *)carNumber
           carType:(NSString *)cartype
           carLogo:(NSString *)carlogo
          carModel:(NSString *)carmodel
          carFrame:(NSString *)carFrame
            engine:(NSString *)engine
              city:(NSString *)city;

/**
 *  绑定后点击我的爱车
 */
-(void)myLoveCar;

/**
 *  附近商家列表点击进入商家详情
 */
- (void)sellerInfo:(NSString *)sellerInfoId;

/**
 *  附近商家(我的爱车)
 */
- (void)nearSellerInfolongitude:(NSString *)lon latitude:(NSString *)lat count:(NSNumber *)countNumber page:(NSNumber *)page;

/**
 *  商家服务列表 比如洗车打来服务
 */
- (void)sellerServiceList:(NSString *)serviceId;

/**
 *  商家服务详情 洗车详情，打蜡详情
 */
- (void)sellerServiceInfo:(NSString *)serviceId;


/**
 *   按地区获取商家信息
 */

- (void)areaWashSellerList: (NSString *)area longtude:(NSString *)lon latitude:(NSString *)lat count:(NSString *)countNumber page:(NSString *)page;


/**
 *   商家服务的城市列表
 */

- (void)sellerServiceCityList: (NSString *)city;
/**
 *   编辑我的爱车
 */
-(void)myLoveCar:(MyLoveCarParam *)param;

/**
 *查询城市编码
 *
 */
- (void)searchCityCode:(NSString *)province city:(NSString *)city;
/**
 *查询违章
 *
 */
- (void)QueryViolationWithCityCode:(NSString *)cityCode carFrameNum:(NSString *)carFrameNum carNumber:(NSString *)carNumber engine_number:(NSString *)engine_number;
@end
