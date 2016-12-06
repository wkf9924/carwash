//
//  BZHttpRequest.h
//  IOSDemo
//
//  Created by behring on 15/8/29.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQRHttpApi.h"
@interface BZHttpRequest : NSObject
@property(nonatomic,assign) HttpApiRequestType requestType;

@property(nonatomic,copy) NSString *requestId;
@property(nonatomic,copy) NSString *protocolType;
@property(nonatomic,copy) NSString *host;
@property(nonatomic,strong) NSNumber * port;
@property(nonatomic,copy) NSString *partUrl;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,strong) NSDictionary *paramsDict;
@property(nonatomic,strong) NSDictionary *transParamsDict;
@property(nonatomic,copy) NSString *filePath;
@property(nonatomic,strong) NSData *imageData;
@property(nonatomic,strong) NSMutableArray* pictureList;

+ (instancetype)httpRequestWithUrl:(NSString *)url;
+ (instancetype)httpRequestWithPartUrl:(NSString *)partUrl;
+ (instancetype)httpRequestWithProtocolType:(NSString *)protocolType andHost:(NSString *)host andPort:(NSNumber *)port andPartUrl:(NSString *)partUrl;

- (instancetype)initWithUrl:(NSString *)url;
- (instancetype)initWithPartUrl:(NSString *)partUrl;
- (instancetype)initWithProtocolType:(NSString *)protocolType andHost:(NSString *)host andPort:(NSNumber *)port andPartUrl:(NSString *)partUrl;

//pay
+ (instancetype)payHttpRequestWithPartUrl:(NSString *)partUrl;
//pay
- (instancetype)initPayWithPartUrl:(NSString *)partUrl;


@end
