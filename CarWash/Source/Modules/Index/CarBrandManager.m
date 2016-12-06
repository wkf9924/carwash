//
//  CarBrandManager.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CarBrandManager.h"
#import "DefineConstant.h"
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

-(void)discount:(NSString *)token count:(NSString *)count page:(NSString *)page;
{
    //DiscountParam *param = [[DiscountParam alloc]init];
    //param.page = page;
    //param.toke = token;
    //param.count = count;
    //[CWHTTP discountWithUrl:API_TODAY_DISCOUNT_GOODS andParam:param];
}


#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    switch (httpReponse.requestType) {
        case HttpApiRequestTypeDiscount:
            //NSLog(@"%@", httpReponse.error);
            if (httpReponse.error.code == 27335) {
                LCSUCCESS_ALSERT(@"登录成功");
                NSString *token = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeDiscount param:token mainTread:YES];
            }else {
                LCFAIL_ALERT(@"登录失败");
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeDiscountFail param:httpReponse.error mainTread:YES];
            }
            break;
        default:
            break;
    }
}
@end

