//
//  rechargeParam.h
//  CarWash
//
//  Created by WangKaifeng on 2016/9/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface rechargeParam : NSObject

@property (nonatomic, copy) NSString *Amount;	//提现金额
@property (nonatomic, copy) NSString *Appid;	//客户系统在支付平台申请所得的身份标识
@property (nonatomic, copy) NSString *CardNo; //提现卡号
@property (nonatomic, copy) NSString *Password; //支付密码
@property (nonatomic, copy) NSString *userid;  //客户系统用户标识

//信息校验码    verifyKey 生成规则为： MD5（所有信息+md5（secret）） 其中 secret 为 客户系统在支付平台申请所得的安全码
@property (nonatomic, copy) NSString *verifyKey;
//@property (nonatomic, strong)NSString *Accepter_userid;//收款平台标识
@end
