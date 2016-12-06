//
//  BindCard.h
//  CarWash
//
//  Created by WangKaifeng on 2016/9/24.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BindCard : NSObject
//客户系统在支付平台申请所得的身份标识
@property (nonatomic, copy) NSString *Appid;
//银行预留手机号
@property (nonatomic, copy) NSString *Bank_cellphone;
//卡号
@property (nonatomic, copy) NSString *CardNo;
//姓名
@property (nonatomic, copy) NSString *IdName;
//身份证号码
@property (nonatomic, copy) NSString *IdNo;
//支付密码
@property (nonatomic, copy) NSString *password;
//客户系统用户标识
@property (nonatomic, copy) NSString *userid;
//信息校验码
@property (nonatomic, copy) NSString *verifyKey;
@end
