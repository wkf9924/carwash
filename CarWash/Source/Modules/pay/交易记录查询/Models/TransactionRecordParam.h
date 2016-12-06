//  交易记录查询
//  TransactionRecordParam.h
//  CarWash
//
//  Created by WangKaifeng on 2016/9/27.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionRecordParam : NSObject
@property (nonatomic, copy) NSString *EndTime;	//收结束时间

//开始时间
@property (nonatomic, copy) NSString *StartTime;

//客户系统在支付平台申请所得的身份标识
@property (nonatomic, copy) NSString *Appid;

//一次请求返回的记录条数 非必填，默认返回10条
@property (nonatomic, copy) NSString *count;

//支付密码
@property (nonatomic, copy) NSString *Password;

//交易类型0：支付:1：退款:2：提现:3：充值
@property (nonatomic, copy) NSString *TradeType;

//返回结果的页码，默认为1
@property (nonatomic, copy) NSString *page;

//客户系统用户标识
@property (nonatomic, copy) NSString *userid;

//信息校验码	string	verifyKey 生成规则为： MD5（所有信息+md5（secret）） 其中 secret 为 客户系统在支付平台申请所得的安全码
@property (nonatomic, copy) NSString *verifyKey;
@end
