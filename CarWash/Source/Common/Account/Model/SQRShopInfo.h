//
//  SQRShopInfo.h
//  Merchant
//
//  Created by 赵林 on 15/9/2.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQRBaseHttpParam.h"
typedef enum{
    SQRShopInfoVerifyProgressWaitingHandle = 0,
    SQRShopInfoVerifyProgressShopInfoCommited,
    SQRShopInfoVerifyProgressShopInfoValided,
    SQRShopInfoVerifyProgressPhoneValided,
    SQRShopInfoVerifyProgressGoneShop,
    SQRShopInfoVerifyProgressSuccess,
    SQRShopInfoVerifyProgressFail
}SQRShopInfoVerifyProgress;


enum _shop_sub_kind_type
{
    SHOP_SUB_KIND_TYPE_GARDEN_STUFF = 272,  // 社区果蔬
    SHOP_SUB_KIND_TYPE_CONVENIENCE = 568,  // 社区便利
    SHOP_SUB_KIND_TYPE_CATERING = 606, // 周边餐饮
};

@interface SQRShopInfo : SQRBaseHttpParam
@property(nonatomic,copy) NSString *shopId;
@property(nonatomic,strong) NSNumber *shopKindId;//目前业务来说 52,云洗衣   53,云家政   54,户外游   178,拼购   270,楼下小店
@property(nonatomic,strong) NSNumber *shopSubKindId;//目前只有楼下小店使用(272,社区果蔬 568,社区便利 606,周边餐饮)
@property(nonatomic,copy) NSString *shopKindName;
@property(nonatomic,copy) NSString *shopKindImageUrl;
@property(nonatomic,copy) NSString *shopKindDescription;

@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *shopName;
@property(nonatomic,copy) NSString *shopAddress;
@property(nonatomic,strong) NSNumber *longitude;
@property(nonatomic,strong) NSNumber *latitude;
@property(nonatomic,copy) NSString *shopDescription;
@property(nonatomic,copy) NSString *phoneNumber;
@property(nonatomic,copy) NSString *logoUrl;
@property(nonatomic,copy) NSString *logoPath;
@property(nonatomic,strong) NSMutableArray *imagePathArray;//店铺图片的id集合
@property(nonatomic,strong) NSMutableArray *fileIdArray;//店铺图片的id集合
@property(nonatomic,strong) NSNumber *shopVerifyProgress;//status审核的状态   0、待处理；1、店铺资料已提交；2、店铺资料已认证；3、电话确认已通过；4、到店确认已通过；5、审核通过,恭喜您开店成功；6、审核未通过
@property(nonatomic,copy) NSString *sendScope;//派送范围
@property(nonatomic,strong) NSNumber *sendType;//0:自提 1:送货上门 2:自提+送货上门
@property(nonatomic,strong) NSNumber *businessStatus; //0:关闭 1:开启
@property(nonatomic,copy) NSString *businessHours;//营业时段 9:00-21:00字符串
@property(nonatomic,strong) NSNumber *accountBalance;//账户余额
@property(nonatomic,strong) NSNumber *totalIncome;//累计收入
@property(nonatomic,copy) NSString *sendPrice;//起送价格
@property(nonatomic,copy) NSString *sendCost;//派送费
@property(nonatomic,strong) NSNumber *shopPoints;//派送费
@property(nonatomic,strong) NSNumber *yesterdayIncome;//昨日收益

@property (nonatomic, copy) NSString *startTime;  // 营业的开始时间
@property (nonatomic, copy) NSString *endTime;   // 营业的结束时间
@property (nonatomic, copy) NSString *community;   //所属社区
@end
