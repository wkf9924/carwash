//
//  PaymentParam.h
//  CarWash
//
//  Created by WangKaifeng on 2016/9/24.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentParam : NSObject

@property (nonatomic, copy) NSString *accepter_userid;	//收款客户标识
//支付金额
@property (nonatomic, copy) NSString *amount;
//客户系统在支付平台申请所得的身份标识
@property (nonatomic, copy) NSString *appid;
//银行卡号
@property (nonatomic, copy) NSString *cardNo;
//支付密码	
@property (nonatomic, copy) NSString *password;
//支付类型
@property (nonatomic, copy) NSString *paymentType;
//描述	
@property (nonatomic, copy) NSString *descriptions;
//客户系统用户标识
@property (nonatomic, copy) NSString *userid;

//信息校验码	string	verifyKey 生成规则为： MD5（所有信息+md5（secret）） 其中 secret 为 客户系统在支付平台申请所得的安全码
@property (nonatomic, copy) NSString *verifyKey;

@end
