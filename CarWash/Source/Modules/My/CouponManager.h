//
//  CouponManager.h
//  CarWash
//
//  Created by WangKaifeng on 16/7/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponManager : NSObject
+(CouponManager *)sharedManager;
/**
 *  优惠劵列表
 *
 *  @param token 
 */
-(void)couponList:(NSString *)token;
/**
 *  消费劵列表方法
 *
 *  @param token
 */
-(void)consumeList:(NSString *)token;

/**
 *  消费劵详情
 *
 *  @param token
 */
- (void)consumerDetail:(NSString *)token consumer:(NSString *)conId;

/**
 *  附近商家
 *
 *  @param token
 */
- (void)nearbyBusinesses:(NSString *)token longitude:(NSString *)lon latitude:(NSString *)lat count:(NSNumber *)countNumber page:(NSNumber *)page;
@end
