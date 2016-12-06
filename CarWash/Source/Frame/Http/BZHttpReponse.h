//
//  BZHttpReponse.h
//  IOSDemo
//
//  Created by behring on 15/8/29.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQRHttpApi.h"
#import "BZError.h"
@interface BZHttpReponse : NSObject
@property(nonatomic,assign) HttpApiRequestType requestType;//通过BZHttpRequest#requestType透传过来
@property(nonatomic,copy) NSString *requestId;//通过BZHttpRequest#requestId透传过来
@property(nonatomic,copy) NSString *filePath;//通过BZHttpRequest#filePath透传过来,下载文件的路径
@property(nonatomic,strong) NSDictionary *transParamsDict;//其他通过BZHttpRequest#transParamsDict透传过来的数据
@property(nonatomic,strong) NSDictionary *json;
@property(nonatomic,strong) BZError *error;
@end
