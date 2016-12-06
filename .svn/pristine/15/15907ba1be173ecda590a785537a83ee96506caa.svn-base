//
//  Common.h
//  GoldArrow

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define COM [Common sharedInstance]

#pragma mark - Common公共类
/**
 * Common公共类
 *
 * 该类放置与本次项目相关的公用变量、属性或方法。
 * 注意：如果是通用代码（与项目或业务逻辑无关的代码），请放置到RLLibrary中。
 */

@interface Common : NSObject<MBProgressHUDDelegate>

@property (nonatomic, strong) NSString *sexString; //性别
@property (nonatomic, strong) NSString *carSouceString; //判断是不是从车源管理过来的
@property (nonatomic, strong) NSString *cancelString;
@property (nonatomic, strong) NSDictionary *goodDic;
@property BOOL clickYesOrNo;
@property (nonatomic, strong) NSString *loginString; //保存登录状态

@property (nonatomic, assign) BOOL isBind;//保存绑定状态
@property (nonatomic, strong) NSString *modifyPassword; //修改密码

@property (nonatomic, strong) NSString *logoIconStr; //汽车LOGO
@property (nonatomic, strong) NSString *seriesNameStr; //具体车型名字
@property (nonatomic, strong) NSString *seriesIcon; //具体车型照片
@property (nonatomic, strong) NSString *brandName;//品牌名称


@property (nonatomic, strong) NSString *city;//查询违章城市
@property (nonatomic, strong) NSString *cityCode;//城市编码
@property (nonatomic, strong)NSString *car_frame;
@property (nonatomic, strong)NSString *car_engine;


@property (nonatomic, strong) NSString *isCollect;//收藏状态
@property (nonatomic, strong) NSString *isLike;//点赞状态

@property  BOOL isPay;//是否点用了支付的server YES 为支付  NO为非支付状态

@property (nonatomic, strong)NSString *payPassword;

@property (nonatomic, strong) NSString *popView; //从哪里过来的viewcontroller
@property (nonatomic, strong)NSString *VIPTopUpSucceed;

@property (nonatomic, strong) NSString *isGone; //判断是不是第一次到车商城详情的
@property (nonatomic, strong) NSString *shopType; //从会员洗车进来还是普通洗车

@property (nonatomic, strong) NSString *vip_date; //vip会员日期

@property (nonatomic, strong) NSString *server_date; //vip会员日期




/// Common类的单例实例
+ (Common *)sharedInstance;

- (NSString *) md5: (NSString *) inPutText;

///判断字符串是否为空字符
- (BOOL) isBlankString:(NSString *)string;

/**
 * 检测邮箱是否正确
 *@param  email 邮箱地址
 *@return 是否为邮箱
 */
- (BOOL)checkIsEmail:(NSString *)email;

/**
 * 检测是否只包含数字
 *@param  digital 检测字符串
 *@return 是否只包含数字
 */
- (BOOL)checkIsdigital:(NSString *)digital;
/**
 * 检测密码格式
 *@param  str 检测字符串
 *@return 是否正确
 */
- (BOOL)checkPassword:(NSString *)str;



/**
 * 检测用户名密码格式
 *@param  str 检测字符串
 *@return 是否正确
 */
- (BOOL)checkUserName:(NSString *)str;

/**
 * 检测是否包含空格
 *@param  email 检测字符串
 *@return 是否包含
 */
- (BOOL)checkContainSpce:(NSString *)str;

//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;
//银行卡后四位
+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber;
//CVN
+ (BOOL) validateCVNCode: (NSString *)cvnCode;
//month
+ (BOOL) validateMonth: (NSString *)month;
//month
+ (BOOL) validateYear: (NSString *)year;
//verifyCode
+ (BOOL) validateVerifyCode: (NSString *)verifyCode;

#pragma mark - URL编码
/**
 *  URL编码，http请求遇到汉字的时候，需要转化成UTF-8
 *
 *  @param urlString 需要编码的URL字符串
 *
 *  @return 编码的字符串
 */
- (NSString *)urlCodingToUTF8ByUrlString:(NSString *)urlString;


#pragma mark - URL解码
/**
 *  URL解码，URL格式是 %3A%2F%2F 这样的，则需要进行UTF-8解码
 *
 *  @param utf8String 需要解码的URL字符串
 *
 *  @return 解码的字符串
 */
- (NSString *)urlDecodingToUrlStringByUTF8String:(NSString *)utf8String;


/**
 *  保存定位城市
 */


/**
 *  正则匹配手机号
 */

+ (BOOL)checkTelNumber:(NSString*) telNumber;
/**
 *  正则匹配用户密码6-18位数字和字母组合
 */
+ (BOOL)checkPassword:(NSString*) password;

/**
 *  正则匹配用户姓名,20位的中文或英文
 */

+ (BOOL)checkUserName : (NSString*) userName;

/**
 *  正则匹配用户身份证号
 */

+ (BOOL)checkUserIdCard: (NSString*) idCard;

/**
 *  正则匹配URL
 */

+ (BOOL)checkURL : (NSString*) url;

/**
 *  获取当前的viewController
 */
- (UIViewController *)getCurrentVC;

- (void)removePersistent;

/**
 *  保存经度
 */
- (void)saveLongtude:(NSString *)lon;
- (NSString *)getLongtude;
/**
 *  保存纬度
 */
- (void)saveLatitude:(NSString *)lat ;
- (NSString *)getLatitude;


/**
 *  保存登陆后的token
 */
- (void)saveLoginToken:(NSString *)token;

/**
 *  获取taoken
 */
- (NSString *)getLoginToken;

/**
 * 移除taken
 */
- (void)removeLoginToken;

/**
 *  用户相关
 */
- (void)saveLoginName:(NSString *)name;
- (NSString *)getLoginName;
- (void)removeLoginName;

- (void)saveLoginPhone:(NSString *)phone;
- (NSString *)getLoginPhone;
- (void)removeLoginPhone;

- (void)saveUserId:(NSString *)userid;
- (NSString *)getUserId;
- (void)removeUserId;

/**
 *   是否vip
 */
- (void)saveVip:(NSString *)vip;
- (NSString *)getVip;
- (void)removeVip;

/**
 *   保存用户图像URL
 */
- (void)saveUserURL:(NSString *)iconURL;
- (NSString *)getUserURL;
- (void)remveUserURL;


/**
 *   保存用户性别
 */
- (void)saveUserSex:(NSString *)sex;
- (NSString *)getUserSex;



/**
 *  车牌相关
 *
 *  @param carPlate
 */
- (void)saveCarPlate:(NSString *)carPlate;
- (NSString *)getCarPlate;
- (void)remveCarPlate;

/**
 *  具体车型相关
 *
 */
- (void)saveCarType:(NSString *)CarType;
- (NSString *)getCarType;
- (void)remveCarType;

- (void)saveCarImage:(NSString *)carImage;
- (NSString *)getCarImage;
- (void)remveCarImage;



//用户余额
- (void)saveUserBlance:(NSString *)userBlance;
- (NSString *)getUserBlance;

//劵的数量
- (void)saveTiketCount:(NSString *)tiket;
- (NSString *)getTiketCount;

//银行卡数量bank_card_count
- (void)saveBankCardCount:(NSString *)bankCardCount;
- (NSString *)getBankCardCount;

/**
 *  保存爱车iD
 *
 */
- (void)saveCarID:(NSString *)carID;
- (NSString *)getCarID;
- (void)removecarID;

/**
 *  //车架号
 *
 */
- (void)saveCarFrameNum:(NSString *)carFrameNum;
- (NSString *)getCarFrameNum;
- (void)removeCarFrameNum;

/**
 *  //发动机号
 *
 */
- (void)saveCarEngineNum:(NSString *)carEngineNum;
- (NSString *)getCarEngineNum;
- (void)removeCarEngineNum;

/**
 *  //车系名称
 *
 */
- (void)saveCarsName:(NSString *)carsName;
- (NSString *)getCarsName;
- (void)remveCarsName;
/**
 *  //具体车型
 *
 */
- (void)saveCarModel:(NSString *)CarModel;

- (NSString *)getCarModel;

//会员时间
- (void)setVip_date:(NSString *)vip_date;

- (NSString *)vip_date;

//服务器时间
-(void)setServer_date:(NSString *)server_date;

-(NSString *)server_date;

@end
