//
//  RegisterManager.h
//  CarWash
//
//  Created by WangKaifeng on 16/7/7.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineConstant.h"
#import "RegisterParam.h"

@interface RegisterManager : NSObject
+(RegisterManager *)sharedManager;

/**
 *  注册
 *
 *  @param phone    电话号码
 *  @param vercode  验证码
 *  @param password 密码
 */
-(void)reg:(NSString *)phone  verzxwification:(NSString *)vercode password:(NSString *)password;
@end
