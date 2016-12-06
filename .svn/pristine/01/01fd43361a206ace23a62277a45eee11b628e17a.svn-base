//
//  MyManager.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyManager.h"
#import "BZHttpManager.h"
#import "BZEventCenter.h"
#import "CWEventCenterType.h"
#import "CWLoginParam.h"
#import "CWHttpKit.h"
#import "DefineConstant.h"
@interface MyManager()<BZHttpManagerDelegate>
@end
@implementation MyManager
+(MyManager *)sharedManager
{
    static MyManager *sharedInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
        [[BZHttpManager sharedHttpManager]registerHttpManagerDelegate:sharedInstance];
    });
    return sharedInstance;
}
#pragma mark -- 上传用户头像
-(void)uploadUserImage:(SQRUploadParam *)param{
    [CWHTTP uploadFileWithUrl:API_editAvatar andParam:param];
}
#pragma mark -- 编辑用户其他资料
- (void)editUserInfo:(NSString *)userName sex:(NSString *)sex{
    [CWHTTP editAccountWithUrl:API_editAcount name:userName sex:sex];
}
#pragma mark -- 车辆详情
- (void)carInfo:(NSString *)carid {
    [CWHTTP carInfoWithUrl:API_carInfo carId:carid];
}
#pragma mark -- 我的收藏

- (void)myCollectList:(NSString *)count page:(NSString *)page{
    [CWHTTP myColectListWithUrl:API_COLLECT_LIST count:count page:page];
}

#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    
     NSString *message = httpReponse.json[@"message"];
    switch (httpReponse.requestType) {
        case HttpApiRequestTypePersonalInfo://个人信息
            LC_HIDEN
            if (httpReponse.error.code == 0) {
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypePersonalInfo param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(message)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypePersonalInfoFail param:httpReponse.error mainTread:YES];
            }
            break;

        case HttpApiRequestTypeCarInfo: //车辆详情
        LC_HIDEN
        if (httpReponse.error.code == 0) {
            NSString *token = httpReponse.json[@"result"];
            [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCarDetailInfo param:token mainTread:YES];
        }else {
            LCFAIL_ALERT(message)
            [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCarDetailInfoFail param:httpReponse.error mainTread:YES];
        }
        break;
        
        case HttpApiRequestTypeUpload: //上传下载
        LCSUCCESS_ALSERT(message)
        if (httpReponse.error.code == 0) {
            NSString *token = httpReponse.json[@"result"];
            [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeUploadImage param:token mainTread:YES];
        }else {
            LCFAIL_ALERT(message)
            [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeUploadImageFail param:httpReponse.error mainTread:YES];
        }
        break;
            
        case HttpApiRequestTypeMyCollectList: //我的收藏
            LC_HIDEN
            if (httpReponse.error.code == 0) {
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeMyCollectList param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(@"网络不稳定,请稍候再试");
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeMyCollectListFail param:httpReponse.error mainTread:YES];
            }
            break;

        default:
            break;
    }
}

@end
