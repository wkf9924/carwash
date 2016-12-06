//
//  NetWorkingHelper.h
//  LO_Moment_MUMU
//
//  Created by xalo on 16/5/19.
//  Copyright © 2016年  All rights reserved.
//

#import <Foundation/Foundation.h>

//请求方式的结构体
typedef enum : NSUInteger {
    
    GET = 100,
    POST
    
} requestType;

typedef void(^errorBlock)(id error);


@interface NetWorkingHelper : NSObject

+(NetWorkingHelper *)sharedNetworkingHelper;

//自定义请求的类方法
/*
 @descripaion:请求的类方法
 
 urlString: 请求的网址
 reqType:   请求方式
 parameters:请求的参数
 success:   请求成功的block回调
 error:     请求出错的block回调
 */
+(void)requestWithUrl:(NSString *)urlString requestType:(requestType)reqType requestParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success error:(errorBlock)myError requestHeader:(NSString *)requestHeader;



@end
