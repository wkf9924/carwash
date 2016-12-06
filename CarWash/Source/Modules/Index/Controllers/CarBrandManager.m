//
//  CarBrandManager.m
//  CarWash
//
//  Created by xa on 16/7/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CarBrandManager.h"
#import "DefineConstant.h"
#import "CarBrandParam.h"
@interface CarBrandManager()<BZHttpManagerDelegate>
@end
@implementation CarBrandManager
+(CarBrandManager *)sharedManager
{
    static CarBrandManager *sharedInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
        [[BZHttpManager sharedHttpManager]registerHttpManagerDelegate:sharedInstance];
    });
    return sharedInstance;
}

#pragma mark -- 绑定车辆现
-(void)carBranding:(NSString *)carbr
         carNumber:(NSString *)carNumber
           carType:(NSString *)cartype
           carLogo:(NSString *)carlogo
          carModel:(NSString *)carmodel
          carFrame:(NSString *)carFrame
            engine:(NSString *)engine
              city:(NSString *)city
{
    CarBrandParam *param = [[CarBrandParam alloc]init];
    param.carBrand = carbr;
    param.carType = cartype;
    param.carNumber = carNumber;
    param.carLogo = carlogo;
    param.carmodel = carmodel;
    param.carFrameNum = carFrame;
    param.engine_number = engine;
    param.city = city;
    [CWHTTP carBrandWithUrl:API_CAR_BRAND andParam:param];
}
#pragma mark -- 绑定成功后显示
-(void)myLoveCar {
    [CWHTTP myLoveCarWithUrl:API_myLoveCar];
}
#pragma mark -- 附近商家列表点击进入商家详情
- (void)sellerInfo:(NSString *)sellerInfoId {
    [CWHTTP sellerInfoWithUrl:API_mySellerInfo  sellInfoId:sellerInfoId];
}
#pragma mark -- 附近商家列表(我的爱车)
- (void)nearSellerInfolongitude:(NSString *)lon latitude:(NSString *)lat count:(NSNumber *)countNumber page:(NSNumber *)page;
 {
     SellerListParam *sellParam = [[SellerListParam alloc] init];
     sellParam.longitude = lon;
     sellParam.latitude = lat;
     sellParam.count = countNumber;
     sellParam.page = page;
     [CWHTTP sellerListWithUrl:API_sellerList andParam:sellParam];
}


#pragma mark -- 商家服务列表，洗车打蜡
- (void)sellerServiceList:(NSString *)serviceId
{
    [CWHTTP sellerServiceListWithUrl:API_sellerServiceList andParam:serviceId];
}
#pragma mark -- 商家服务详情，洗车打蜡详情

- (void)sellerServiceInfo:(NSString *)serviceId {
    [CWHTTP sellerServiceInfotWithUrl:API_sellerServiceInfo andParam:serviceId];
}
#pragma mark -- 按地区获取商家信息
- (void)areaWashSellerList: (NSString *)area longtude:(NSString *)lon latitude:(NSString *)lat count:(NSString *)countNumber page:(NSString *)page; {
   
    AreaWashParam *areaParam = [[AreaWashParam alloc] init];
    areaParam.area = area;
    areaParam.longtude = lon;
    areaParam.latitude = lat;
    areaParam.count = countNumber;
    areaParam.page = page;
    [CWHTTP washAreaSellerListWithUrl:API_goodSellerList andParam:areaParam];
}

#pragma mark -- 获取商家服务的城市
- (void)sellerServiceCityList: (NSString *)city {
    [CWHTTP sellerServiceCityListWithUrl:API_sellerCount city:city];
}

#pragma mark -- 编辑我的爱车
-(void)myLoveCar:(MyLoveCarParam *)param {
    [CWHTTP editCarInfoWithUrl:API_carCompleteCarInfo carinfo:param];
}
#pragma mark== 查询城市编码
- (void)searchCityCode:(NSString *)province city:(NSString *)city{
    [CWHTTP searchCityCodeWithUrl:API_CITYCODE city:city province_code:province];
}
#pragma mark == 查询违章
- (void)QueryViolationWithCityCode:(NSString *)cityCode carFrameNum:(NSString *)carFrameNum carNumber:(NSString *)carNumber engine_number:(NSString *)engine_number{
    [CWHTTP QueryViolationWithUrl:API_QUERYVIOLATION cityCode:cityCode carFrameNum:carFrameNum carNumber:carNumber engine_number:engine_number];
}
#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    NSString *message = httpReponse.json[@"message"];
    switch (httpReponse.requestType) {
        //编辑车辆信息
        case HttpApiRequestTypeEditCarInfo:
        if (httpReponse.error.code == 0) {
            LC_HIDEN
            NSString *token = httpReponse.json[@"result"];
            [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeEditCarInfo param:token mainTread:YES];
        }else {
            LCFAIL_ALERT(message)
            [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeEditCarInfoFail param:httpReponse.error mainTread:YES];
        }
        break;

            //按地区获取商家的服务城市列表
        case HttpApiRequestTypeSellerServiceCityList: //洗车--地区洗洗车列表
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerServiceCityList param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerServiceCityList param:httpReponse.error mainTread:YES];
            }
            break;

            
            //按地区获取商家信息
        case HttpApiRequestTypeAreaWashSellerlist: //洗车--地区洗洗车列表
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeAreaWashSellerList param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeAreaWashSellerList param:httpReponse.error mainTread:YES];
            }
            break;
            //查询城市编码
        case HttpApiRequestTypeCityCode:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCityCode param:token mainTread:YES];
            }else {
                LCSUCCESS_ALSERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCityCodeFail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //查询城市编码
        case HttpApiRequestTypeQueryViolation:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeQueryViolation param:token mainTread:YES];
            }else {
                LCSUCCESS_ALSERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeQueryViolationFail param:httpReponse.error mainTread:YES];
            }
            break;

            //今日特惠
        case HttpApiRequestTypeDiscount:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeDiscount param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeDiscountFail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //我的爱车
        case HttpApiRequestTypeMyLoveCar:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeMyLoveCar param:token mainTread:YES];
            }else {
               //LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeMyLoveCar_Fail param:httpReponse.error mainTread:YES];
            }
            break;
            //点击附近商家后的商家详情
        case HttpApiRequestTypeMySellerInfo:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerInfo param:token mainTread:YES];
            }else {
               LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerInfo_Fail param:httpReponse.error mainTread:YES];
            }
            break;

            //附近商家列表（我的爱车界面）
        case HttpApiRequestTypeSellerList:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerList param:token mainTread:YES];
            }else {
                LCSUCCESS_ALSERT(@"网络连接失败,请检查网络后重试!");
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerList_Fail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //商家服务列表 
        case HttpApiRequestTypeSellerServiceList:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerServiceList param:token mainTread:YES];
            }else {
               LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerServiceList_Fail param:httpReponse.error mainTread:YES];
            }
            break;
            
            //商家服务详情，比如洗车详情，打蜡详情
        case HttpApiRequestTypeSellerServiceLInfo:
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerServiceInfo param:token mainTread:YES];
            }else {
              LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeSellerServiceInfo_Fail param:httpReponse.error mainTread:YES];
            }
            break;
            //绑定车辆
        case HttpApiRequestTypeBindingMyCar: 
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeBindingMyCar param:token mainTread:YES];
            }else {
               LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeBindingMyCar_Fail param:httpReponse.error mainTread:YES];
            }
            break;


        default:
            break;
    }
}
@end

