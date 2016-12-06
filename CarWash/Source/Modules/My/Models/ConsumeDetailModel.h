//
//  ConsumeDetailModel.h
//  CarWash
//
//  Created by xa on 16/7/29.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumeDetailModel : NSObject
@property (nonatomic, strong)NSString *ID;//消费券ID
@property (nonatomic, strong)NSString *name;//消费券名称
@property (nonatomic, assign)NSInteger money;//面额
@property (nonatomic, assign)NSInteger pay_amount;//支付金额
@property (nonatomic, strong)NSString *remark;//使用说明;
@property (nonatomic, strong)NSString *couponmoney;//优惠券金额
@property (nonatomic, strong)NSString *couponname;//优惠券名称;
@property (nonatomic, strong)NSString *createdate;//消费券开始时间
@property (nonatomic, strong)NSString *enddate;//消费券结束时间
@property (nonatomic, strong)NSString *orderid;//订单ID
@property (nonatomic, strong)NSString *sellername;//商家名称
@property (nonatomic, strong)NSString *servicetel;//服务电话


@end
