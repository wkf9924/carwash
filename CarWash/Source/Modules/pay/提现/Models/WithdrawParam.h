//
//  RechargeParam.h
//  CarWash
//
//  Created by WangKaifeng on 2016/9/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WithdrawParam : NSObject
@property (nonatomic, copy) NSString *Amount;	//提现金额
@property (nonatomic, copy) NSString *Appid;	//客户系统在支付平台申请所得的身份标识
@property (nonatomic, copy) NSString *CardNo; //提现卡号
//@property (nonatomic, copy) NSString *Disburse_userid;  //提现平台标识
@property (nonatomic, copy) NSString *Password; //支付密码
@property (nonatomic, copy) NSString *userid;  //客户系统用户标识
@property (nonatomic, copy) NSString *verifyKey; //信息校验码
@end
