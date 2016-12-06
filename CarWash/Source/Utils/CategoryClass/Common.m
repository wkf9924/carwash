//
//  Common.m
//  GoldArrow
//
//  Created by Long on 12-6-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Common.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "sys/utsname.h"
#import "CommonCrypto/CommonDigest.h"
#define LOGIN_DATA   @"token"   //登陆成功数据
#define Longtude @"longtude" //经度
#define Latitude @"latitude" //纬度

static Common *_sharedInstance = nil;

@implementation Common

#pragma mark - Common公共类: Class life cycle method
+ (Common *) sharedInstance
{
//    @synchronized(self)
//	{
//        if (_sharedInstance == nil)
//		{
//            _sharedInstance = [[self alloc] init];
//        }
//    }
//    return _sharedInstance;

    static Common *_sharedInstance = nil;
    
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(_sharedInstance == nil)
		{
            _sharedInstance = [super allocWithZone:zone];
			return _sharedInstance;
        }
    }
	
    return nil;
}

- (id)init
{
	if ((self=[super init]))
	{
    }
    return self;
}

- (void)dealloc {
}


#pragma mark - Common公共类: Other Custom Method


///tableview多余的线隐藏
+ (void)setExtraCellLineHidden:(UITableView *)tableView;
{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    
    
}


- (NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), result);
    NSLog(@"MD5->>>>>>%@",[NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ]);

    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ];
}

/**
 * 检测邮箱是否正确
 *
 *@param  email 邮箱地址
 *
 *
 *@return 是否为邮箱
 */
- (BOOL)checkIsEmail:(NSString *)email{
    if (!email || email.length == 0) {
        return NO;
    }
    NSString * regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:email];
    
    return isMatch;
}

/**
 * 检测是否只包含数字
 *
 *@param  digital 检测字符串
 *
 *
 *@return 是否只包含数字
 */
- (BOOL)checkIsdigital:(NSString *)digital{
    if (!digital || digital.length == 0) {
        return NO;
    }
    NSString * regex = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:digital];
    
    return isMatch;
    
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/**
 * 检测密码格式
 *
 *@param  str 检测字符串
 *
 *
 *@return 是否正确
 */
- (BOOL)checkPassword:(NSString *)str{
    if (!str || str.length == 0) {
        return NO;
    }
    //只能是字符，数字，下划线，长度大于8小于16
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";//@"^[a-zA-Z0-9_]{8,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
    
}

/**
 * 检测用户名格式
 *
 *@param  str 检测字符串
 *
 *
 *@return 是否正确
 */
- (BOOL)checkUserName:(NSString *)str{
    if (!str || str.length == 0) {
        return NO;
    }
    //只能是字符，数字，下划线，长度大于8小于16
    NSString * regex = @"^1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
    
}

//***************************验证

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}
//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}
//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{4,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"([\u4e00-\u9fa5]{2,5})(&middot;[\u4e00-\u9fa5]{2,5})*";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}
//银行卡后四位
+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length != 4) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{4})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}
//CVN
+ (BOOL) validateCVNCode: (NSString *)cvnCode
{
    BOOL flag;
    if (cvnCode.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{3})";
    NSPredicate *cvnCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [cvnCodePredicate evaluateWithObject:cvnCode];
}
//month
+ (BOOL) validateMonth: (NSString *)month
{
    BOOL flag;
    if (!(month.length == 2)) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"(^(0)([0-9])$)|(^(1)([0-2])$)";
    NSPredicate *monthPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [monthPredicate evaluateWithObject:month];
}
//month
+ (BOOL) validateYear: (NSString *)year
{
    BOOL flag;
    if (!(year.length == 2)) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^([1-3])([0-9])$";
    NSPredicate *yearPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [yearPredicate evaluateWithObject:year];
}
//verifyCode
+ (BOOL) validateVerifyCode: (NSString *)verifyCode
{
    BOOL flag;
    if (!(verifyCode.length == 6)) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{6})";
    NSPredicate *verifyCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [verifyCodePredicate evaluateWithObject:verifyCode];
}





//***********************************end

/**
 * 检测是否包含空格
 *
 *@param  str 检测字符串
 *
 *
 *@return 是否包含
 */
- (BOOL)checkContainSpce:(NSString *)str{
    if (!str ||str.length == 0) {
        return NO;
    }
    NSRange range  = [str rangeOfString:@" "];
    if (range.length > 0) {
        return YES;
    }
    return NO;
}


///判断字符串是否为空字符
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - URL编码
- (NSString *)urlCodingToUTF8ByUrlString:(NSString *)urlString
{
    return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - URL解码
- (NSString *)urlDecodingToUrlStringByUTF8String:(NSString *)utf8String
{
    return [utf8String stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString*) telNumber

{
    
    NSString*pattern =@"^1+[3578]+\\d{9}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    
    return isMatch;
    
}

#pragma 正则匹配用户密码6-18位数字和字母组合

+ (BOOL)checkPassword:(NSString*) password

{
    
    NSString*pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文

+ (BOOL)checkUserName : (NSString*) userName

{
    
    NSString*pattern =@"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:userName];
    
    return isMatch;
    
}

#pragma 正则匹配用户身份证号15或18位

+ (BOOL)checkUserIdCard: (NSString*) idCard

{
    
    NSString*pattern =@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:idCard];
    
    return isMatch;
    
}

#pragma 正则匹员工号,12位的数字

+ (BOOL)checkEmployeeNumber : (NSString*) number

{
    
    NSString*pattern =@"^[0-9]{12}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:number];
    
    return isMatch;
    
}

#pragma 正则匹配URL

+ (BOOL)checkURL : (NSString*) url

{
    
    NSString*pattern =@"^[0-9A-Za-z]{1,50}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:url];
    
    return isMatch;
    
}

#pragma mark ----- 获取当前的viewController
- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
        //        <span style="font-family: Arial, Helvetica, sans-serif;">//  这方法下面有详解    </span>
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}


//*********************end

/**
 *  保存经度
 */
- (void)saveLongtude:(NSString *)lon  {
    [[NSUserDefaults standardUserDefaults] setObject:lon forKey:Longtude];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getLongtude {
    return [[NSUserDefaults standardUserDefaults] objectForKey:Longtude];
}
/**
 *  保存纬度
 */
- (void)saveLatitude:(NSString *)lat {
    [[NSUserDefaults standardUserDefaults] setObject:lat forKey:Latitude];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (NSString *)getLatitude {
    return [[NSUserDefaults standardUserDefaults] objectForKey:Latitude];
    
}


/**
 *  保存和获取token
 *
 *  @param diction
 */
- (void)saveLoginToken:(NSString *)token {
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:LOGIN_DATA];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getLoginToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_DATA];
}
/**
 * 移除taken
 */
- (void)removeLoginToken {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGIN_DATA];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 *  获取是否记住密码状态
 *
 *  @return
 */

+ (BOOL)isSaveUserPwd
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isSavePwd"] == YES) {
        return YES;
    }
    else{
        return NO;
    }
}
/**
 *  移除所有的key
 */
- (void)removePersistent {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

//保存用户名获取用户名
- (void)saveLoginName:(NSString *)name  {
    
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"loginName"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
- (NSString *)getLoginName {
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
}
- (void)removeLoginName {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//保存用户 手机
- (void)saveLoginPhone:(NSString *)phone  {
    
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"userPhone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (NSString *)getLoginPhone {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
}
- (void)removeLoginPhone {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPhone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//保存用户id
- (void)saveUserId:(NSString *)userid {
    [[NSUserDefaults standardUserDefaults] setObject:userid forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserId {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    if (userid == nil) {
        return @"";
    }
    return userid;
}
- (void)removeUserId {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//保存爱车id
- (void)saveCarID:(NSString *)carID{
    [[NSUserDefaults standardUserDefaults] setObject:carID forKey:@"carID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getCarID {
    NSString *carID = [[NSUserDefaults standardUserDefaults] objectForKey:@"carID"];
    if (carID == nil) {
        return @"";
    }
    return carID;
}
- (void)removecarID {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"carID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//是否vip
- (void)saveVip:(NSString *)vip {
    [[NSUserDefaults standardUserDefaults] setObject:vip forKey:@"VIP"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
- (NSString *)getVip {
    NSString *vip = [[NSUserDefaults standardUserDefaults] objectForKey:@"VIP"];
    if (vip == nil) {
        return @"";
    }
    return vip;
}
- (void)removeVip {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"VIP"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setLoginString:(NSString *)loginString{
    if (loginString) {
        [[NSUserDefaults standardUserDefaults] setObject:loginString forKey:@"loginString"];
    }
}
- (NSString *)loginString{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"loginString"];
}
/**
 *   保存用户图像URL
 */
- (void)saveUserURL:(NSString *)iconURL {
    [[NSUserDefaults standardUserDefaults] setObject:iconURL forKey:@"userImageURL"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
/**
 *  获取用户图像URL
 */
- (NSString *)getUserURL {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userImageURL"];
}

- (void)remveUserURL {
   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userImageURL"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *   保存用户性别
 */
- (void)saveUserSex:(NSString *)sex {
    [[NSUserDefaults standardUserDefaults] setObject:sex forKey:@"USERSEX"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
/**
 *  获取用户性别
 */
- (NSString *)getUserSex {
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"USERSEX"];
}



/**
 *   保存车牌
 */
- (void)saveCarPlate:(NSString *)carPlate {
    [[NSUserDefaults standardUserDefaults] setObject: carPlate forKey:@"CARPLATE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
/**
 *  获取车牌
 */
- (NSString *)getCarPlate {
    NSString *carPlate =  [[NSUserDefaults standardUserDefaults] objectForKey:@"CARPLATE"];
    if (carPlate == nil) {
        return @"";
    }
    return carPlate;
}

- (void)remveCarPlate  {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CARPLATE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//保存爱车logo
- (void)setLogoIconStr:(NSString *)logoIconStr{
    if (logoIconStr) {
        [[NSUserDefaults standardUserDefaults] setObject:logoIconStr forKey:@"logoIconStr"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"logoIconStr"];
    }
}
//获取爱车logo
- (NSString *)logoIconStr{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"logoIconStr"];
}
//保存品牌名
- (void)setBrandName:(NSString *)brandName{
    if (brandName) {
        [[NSUserDefaults standardUserDefaults] setObject:brandName forKey:@"brandName"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"brandName"];
    }
}
//获取品牌名
- (NSString *)brandName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"brandName"];
}
//保存系列logo
- (void)setSeriesIcon:(NSString *)seriesIcon{
    if (seriesIcon) {
        [[NSUserDefaults standardUserDefaults] setObject:seriesIcon forKey:@"seriesIcon"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"seriesIcon"];
    }
}
//获取系列logo
- (NSString *)seriesIcon{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"seriesIcon"];
}
//保存系列名
- (void)setSeriesNameStr:(NSString *)seriesNameStr{
    if (seriesNameStr) {
        [[NSUserDefaults standardUserDefaults] setObject:seriesNameStr forKey:@"seriesNameStr"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"seriesNameStr"];
    }
}
//获取系列名
- (NSString *)seriesNameStr{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"seriesNameStr"];
}
//保存车辆型号
- (void)saveCarType:(NSString *)CarType {
    [[NSUserDefaults standardUserDefaults] setObject: CarType forKey:@"CarType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取车辆型号
- (NSString *)getCarType {
    NSString *carPlate =  [[NSUserDefaults standardUserDefaults] objectForKey:@"CarType"];
    if (carPlate == nil) {
        return @"";
    }
    return carPlate;
}
//保存具体车型
- (void)saveCarModel:(NSString *)CarModel {
    [[NSUserDefaults standardUserDefaults] setObject: CarModel forKey:@"CarModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取具体车型
- (NSString *)getCarModel {
    NSString *CarModel =  [[NSUserDefaults standardUserDefaults] objectForKey:@"CarModel"];
    if (CarModel == nil) {
        return @"";
    }
    return CarModel;
}
- (void)remveCarType {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CarModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//保存车系名称
- (void)saveCarsName:(NSString *)carsName {
    [[NSUserDefaults standardUserDefaults] setObject: carsName forKey:@"carsName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取车系名称
- (NSString *)getCarsName {
    NSString *carsName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"carsName"];
    if (carsName == nil) {
        return @"";
    }
    return carsName;
}
- (void)remveCarsName {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"carsName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//保存车辆logo
- (void)saveCarImage:(NSString *)carImage {
    [[NSUserDefaults standardUserDefaults] setObject: carImage forKey:@"CarImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getCarImage {
    NSString *carImage =  [[NSUserDefaults standardUserDefaults] objectForKey:@"CarImage"];
    if (carImage == nil) {
        return @"";
    }
    return carImage;
}
- (void)remveCarImage {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CarImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//查询城市.省市
- (void)setCity:(NSString *)city{
    if (city) {
        [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"city"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"city"];
    }
}
- (NSString *)city{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
}
//查询城市编码
- (void)setCityCode:(NSString *)cityCode{
    if (cityCode) {
        [[NSUserDefaults standardUserDefaults] setObject:cityCode forKey:@"cityCode"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"cityCode"];
    }
}
- (NSString *)cityCode{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityCode"];
}
//车架号
- (void)saveCarFrameNum:(NSString *)carFrameNum{
    [[NSUserDefaults standardUserDefaults] setObject:carFrameNum forKey:@"carFrameNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getCarFrameNum {
    NSString *carFrameNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"carFrameNum"];
    if (carFrameNum == nil) {
        return @"";
    }
    return carFrameNum;
}
- (void)removeCarFrameNum {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"carFrameNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//发动机号
- (void)saveCarEngineNum:(NSString *)carEngineNum{
    [[NSUserDefaults standardUserDefaults] setObject:carEngineNum forKey:@"carEngineNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getCarEngineNum{
    NSString *carEngineNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"carEngineNum"];
    if (carEngineNum == nil) {
        return @"";
    }
    return carEngineNum;
}


//用户余额
- (void)saveUserBlance:(NSString *)userBlance;{
    [[NSUserDefaults standardUserDefaults] setObject: userBlance forKey:@"BLANCE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserBlance {
    NSString *carImage =  [[NSUserDefaults standardUserDefaults] objectForKey:@"BLANCE"];
    if (carImage == nil) {
        return @"";
    }
    return carImage;

}

//劵的数量
- (void)saveTiketCount:(NSString *)tiket {
    [[NSUserDefaults standardUserDefaults] setObject: tiket forKey:@"TIKET"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getTiketCount {
    NSString *carImage =  [[NSUserDefaults standardUserDefaults] objectForKey:@"TIKET"];
    if (carImage == nil) {
        return @"";
    }
    return carImage;

}

//银行卡数量bank_card_count
- (void)saveBankCardCount:(NSString *)bankCardCount {
    [[NSUserDefaults standardUserDefaults] setObject: bankCardCount forKey:@"BANKCARD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getBankCardCount {
    NSString *carImage =  [[NSUserDefaults standardUserDefaults] objectForKey:@"BANKCARD"];
    if (carImage == nil) {
        return @"";
    }
    return carImage;
}
//保存支付密码
- (void)setPayPassword:(NSString *)payPassword{
    if (payPassword) {
        [[NSUserDefaults standardUserDefaults] setObject:payPassword forKey:@"payPassword"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"payPassword"];
    }
}
- (NSString *)payPassword{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"payPassword"];
}


//保存会员日期

- (void)setVip_date:(NSString *)vip_date {
    if (vip_date) {
        [[NSUserDefaults standardUserDefaults] setObject:vip_date forKey:@"vipDate"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"vipDate"];
    }
}

- (NSString *)vip_date {
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"vipDate"];
}


//保存服务器时间

-(void)setServer_date:(NSString *)server_date{
    if (server_date) {
        [[NSUserDefaults standardUserDefaults] setObject:server_date forKey:@"server_date"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"server_date"];
    }
}

-(NSString *)server_date {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"server_date"];

}


@end
