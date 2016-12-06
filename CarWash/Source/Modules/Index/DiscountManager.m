
//
//  DiscountManager.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/19.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "DiscountManager.h"
#import "DefineConstant.h"
@interface DiscountManager()<BZHttpManagerDelegate>
@end
@implementation DiscountManager
+(DiscountManager *)sharedManager
{
    static DiscountManager *sharedInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
        [[BZHttpManager sharedHttpManager]registerHttpManagerDelegate:sharedInstance];
    });
    return sharedInstance;
}

#pragma mark -- 获取今日优惠list
-(void)discount:(NSNumber *)count page:(NSNumber *)page
{
    DiscountParam *param = [[DiscountParam alloc]init];
    param.page = page;
    param.count = count;
    [CWHTTP discountWithUrl:API_TODAY_DISCOUNT_GOODS andParam:param];
}

#pragma mark -- 今日优惠详情
-(void)discountDetail:(NSString *)token count:(NSString *)good_id {
    
    
    
}


#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    switch (httpReponse.requestType) {
        case HttpApiRequestTypeDiscount:
            //NSLog(@"%@", httpReponse.error);
            if (httpReponse.error.code == 0) {
                LC_HIDEN
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeDiscount param:token mainTread:YES];
            }else {
               LC_SHOW_FAIL(LOAD_FAIL)
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeDiscountFail param:httpReponse.error mainTread:YES];
            }
            break;
        default:
            break;
    }
}
@end
