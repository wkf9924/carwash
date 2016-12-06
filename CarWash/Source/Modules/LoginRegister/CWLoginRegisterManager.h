//
//  CWLoginRegisterManager.h
//  CarWash
//
//  Created by 赵林 on 16/7/2.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWLoginRegisterManager : NSObject
+(CWLoginRegisterManager *)sharedManager;

/**
 *  登录
 */
-(void)login:(NSString *)phone password:(NSString *)password;

/**
 *  忘记密码
 */
-(void)forgetPassword:(NSString *)password
                phone:(NSString *)phone
              smsCode:(NSString *)code
                token:(NSString *)tokenString;
//修改密码
//-(void)updatePassword:(NSString *)password
//                phone:(NSString *)phone
//              smsCode:(NSString *)code
//                token:(NSString *)tokenString;

/**
 *  自动登录
 */

- (void)autoLogin:(NSString *)token;
@end
