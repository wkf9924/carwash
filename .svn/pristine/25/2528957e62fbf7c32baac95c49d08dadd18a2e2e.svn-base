//
//  BZHttpRequest.m
//  IOSDemo
//
//  Created by behring on 15/8/29.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import "BZHttpRequest.h"
#import "SQRHttpApi.h"
#import "Common.h"
#define PROTOCOL_HTTP @"http"
#define PROTOCOL_HTTPS @"https"
#define PROTOCOL_DEFAULT PROTOCOL_HTTP
#define HOST API_SERVER_HOST
#define HOSTPAY API_SERVER_HOST_PAY
#define PORT 8080

@implementation BZHttpRequest



+ (instancetype)httpRequestWithProtocolType:(NSString *)protocolType andHost:(NSString *)host andPort:(NSNumber *)port andPartUrl:(NSString *)partUrl
{
    return [[self alloc]initWithProtocolType:protocolType andHost:host andPort:port andPartUrl:partUrl];
}

+ (instancetype)httpRequestWithPartUrl:(NSString *)partUrl
{
    return [[self alloc]initWithPartUrl:partUrl];
}

+ (instancetype)httpRequestWithUrl:(NSString *)url
{
    return [[self alloc]initWithUrl:url];
}

- (instancetype)initWithProtocolType:(NSString *)protocolType andHost:(NSString *)host andPort:(NSNumber *)port andPartUrl:(NSString *)partUrl
{
    self = [super init];
    if (self) {
        self.protocolType = protocolType;
        self.host         = host;
        self.port         = port;
        self.partUrl      = partUrl;
        if (port) {
             self.url = [NSString stringWithFormat:@"%@://%@:%@%@",protocolType,host,port,partUrl];
        }else{
            self.url = [NSString stringWithFormat:@"%@://%@%@",protocolType,host,partUrl];
        }
    }
    return self;
}

- (instancetype)initWithPartUrl:(NSString *)partUrl
{
    if (COM.isPay == YES) {
        return [self initWithProtocolType:PROTOCOL_DEFAULT andHost:HOSTPAY andPort:nil andPartUrl:partUrl];
    }
    return [self initWithProtocolType:PROTOCOL_DEFAULT andHost:HOST andPort:nil andPartUrl:partUrl];
}

- (instancetype)initWithUrl:(NSString *)url
{
    NSURL *tempUrl = [NSURL URLWithString:url];

    return [self initWithProtocolType:[tempUrl scheme] andHost:[tempUrl host] andPort:[tempUrl port] andPartUrl:[tempUrl path]];
}


//支付
//pay
+ (instancetype)payHttpRequestWithPartUrl:(NSString *)partUrl
{
    return [[self alloc] initPayWithPartUrl:partUrl];
}


//pay
- (instancetype)initPayWithPartUrl:(NSString *)partUrl
{
    return [self initWithProtocolType:PROTOCOL_DEFAULT andHost:HOSTPAY andPort:nil andPartUrl:partUrl];
}

@end
