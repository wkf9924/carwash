//
//  AccountManager.m
//  Merchant
//
//  Created by 赵林 on 15/9/2.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import "SQRAccountManager.h"


@implementation SQRAccountManager
+(SQRAccountManager *)sharedAccountManager
{
    static SQRAccountManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

-(void)clearAccountInfo
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

-(void)clearPartAccountInfo
{
    // 1.利用NSUserDefaults,就能直接访问软件的偏好设置(Library/Preferences)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey: @"user_id"];
    [defaults removeObjectForKey: @"session"];
    [defaults removeObjectForKey: @"is_login"];

    // 2.立刻同步
    [defaults synchronize];
}

-(void)setAccountInfo:(SQRAccountInfo *)accountInfo
{
    // 1.利用NSUserDefaults,就能直接访问软件的偏好设置(Library/Preferences)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 2.存储数据
    [defaults setObject:accountInfo.userId forKey:@"user_id"];
    [defaults setObject:accountInfo.accountName forKey:@"account_name"];
    [defaults setObject:accountInfo.session forKey:@"session"];
    [defaults setBool:accountInfo.isLogin forKey:@"is_login"];
    // 3.立刻同步
    [defaults synchronize];

}

-(SQRAccountInfo *)getAccountInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"user_id"];
    NSString *accountName = [defaults objectForKey:@"account_name"];
    NSString *session = [defaults objectForKey:@"session"];
    BOOL login = [defaults boolForKey:@"is_login"];
    SQRAccountInfo *accountInfo = [[SQRAccountInfo alloc]init];
    accountInfo.accountName = accountName;
    accountInfo.session = session;
    accountInfo.login = login;
    accountInfo.userId = userId;
    return accountInfo;
}
@end
