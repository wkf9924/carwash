//
//  NetWorkingHelper.m
//  LO_Moment_MUMU
//
//  Created by xalo on 16/5/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "NetWorkingHelper.h"

@interface NetWorkingHelper ()


@end

@implementation NetWorkingHelper

+(NetWorkingHelper *)sharedNetworkingHelper{
    static NetWorkingHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[NetWorkingHelper alloc] init];
    });
    return helper;
}
#pragma mark--网络请求
+(void)requestWithUrl:(NSString *)urlString requestType:(requestType)reqType requestParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success error:(errorBlock)myError requestHeader:(NSString *)requestHeader{
    
    NetWorkingHelper *helper = [[NetWorkingHelper alloc] init];
    //创建request对象
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    //设置请求头
    if (requestHeader) {
        [req setValue:requestHeader forHTTPHeaderField:@"Content-Type"];
    }
    if (reqType == POST) {
        //设置请求方式、请求参数
        req.HTTPMethod = @"POST";
        if (parameters && parameters.count) {
            req.HTTPBody = [helper transformWithDic:parameters];
        }
    }else{      //GET请求,不用设置
        
    }
//设置请求超时的时间
    req.timeoutInterval = 20 ;
    //调用请求方法  
    [helper myReqWithRequest:req success:success error:myError];
    
}
#pragma mark--请求方法的具体实现
-(void)myReqWithRequest:(NSURLRequest *)req success:(void (^)(id))success error:(errorBlock)myError{
    //初始化一个请求的session对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建任务对象
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {   
            myError(error.description);
        }else{ 
            //请求成功: 1、data==nil  2、data != nil
            if (data) { 
                //1、数据为json格式,可以解析
                //2、不是JSON格式，无法解析
                
                id resultObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                if ([NSJSONSerialization isValidJSONObject:resultObject]) {   //判断解析完成的数据是否为JSON格式
                    
                    success(resultObject);
                }else{  //数据不是JSON格式，无法解析
                    myError(@"数据不是JSON格式,无法解析");
                }
            }else{ 
                //请求成功,但是未请求到数据
                myError(@"请求成功,但是未请求到数据");
            }
        }
    }];
    //启动任务
    [task resume];
}
//将字典转换为请求参数格式的字符串
-(NSData *)transformWithDic:(NSDictionary *)dic{
    //取出键值对,并把每对键值对放入数组
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (NSString *key in dic) {
        NSString *keyValue = [NSString stringWithFormat:@"%@=%@",key,dic[key]];
        [resultArray addObject:keyValue];
    }
    //resultArray中的每个元素都是一个键值对，我们只需要将数组的每个元素用 & 符号拼接即可
    NSString *resultString = [resultArray componentsJoinedByString:@"&"];
    //resultString的格式为: key1=Value1&key2=Value2.....将该字符串转换为NSData类型即可
    return [resultString dataUsingEncoding:NSUTF8StringEncoding];
}
@end
