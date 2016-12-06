//
//  BZNetworkingRequestCallbackManager.m
//  Merchant
//
//  Created by behring on 15/8/29.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import "BZHttpManager.h"
#import "AFNetworking.h"
#import "BZHttpRequest.h"
#import "LCProgressHUD.h"
@interface BZHttpManager()
@property(nonatomic,strong) NSMutableArray *delegateArray;
@end

@implementation BZHttpManager

/**
 *  懒加载代理集合
 *
 *  @return 不为空的NSMutableArray集合，存放这所有实现BZHttpManagerDelegate代理的对象
 */
-(NSMutableArray *)delegateArray
{
    if (!_delegateArray) {
        _delegateArray = [NSMutableArray array];
    }
    return _delegateArray;
}

/**
 *  单例httpManager
 *
 *  @return 单例的BZHttpManager对象
 */
+ (BZHttpManager *)sharedHttpManager
{
    static BZHttpManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
/**
 *  注册BZHttpManagerDelegate到delegateArray里面
 *
 *  @param delegate 实现了BZHttpManagerDelegate的对象
 */
-(void)registerHttpManagerDelegate:(id<BZHttpManagerDelegate>)delegate
{
    if (![self.delegateArray containsObject:delegate]) {
        [self.delegateArray addObject:delegate];
    }
}
/**
 *  从delegateArray里取消注册BZHttpManagerDelegate
 *
 *  @param delegate 实现BZHttpManagerDelegate的对象需要取消http相关的监听
 */
-(void)cancelRegisterHttpManagerDelegate:(id<BZHttpManagerDelegate>)delegate
{
    [self.delegateArray removeObject:delegate];
}


-(void)uploadFileRequest:(BZHttpRequest *)httpRequest
{
    //  确定需要上传的文件(假设选择本地的文件)
    //NSURL *filePath = [NSURL fileURLWithPath:httpRequest.filePath];
    NSDictionary *parameters = httpRequest.paramsDict;
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    [requestManager POST:httpRequest.url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        /**
         *  appendPartWithFileURL   //  指定上传的文件
         *  name                    //  指定在服务器中获取对应文件或文本时的key
         *  fileName                //  指定上传文件的原始文件名
         *  mimeType                //  指定商家文件的MIME类型
         */
        [formData appendPartWithFileData:httpRequest.imageData
                                    name:@"head_img"
                                fileName:@"avatar.png"
                                mimeType:@"image/png"];
        
        //多张图片上传
        //[httpRequest.pictureList enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL * stop) {
            //if ([obj isKindOfClass:[UIImage class]]) {
                //UIImage *photoFile = (UIImage *)obj;
                //NSData *imageData = UIImageJPEGRepresentation(photoFile, 0.8);
                //if (imageData) {
                    //NSString *fileName = [NSString stringWithFormat:@"photoFile%ld.jpg",idx];
                    //[formData appendPartWithFileData:httpRequest.imageData
                                                //name:@"file"
                                            //fileName:fileName
                                            //mimeType:@"image/png"];
                //}
            //}
        //}];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"upload success: %@", responseObject);
        for (id<BZHttpManagerDelegate> delegate in self.delegateArray) {
            BZHttpReponse *httpResponse = [[BZHttpReponse alloc]init];
            httpResponse.requestType = httpRequest.requestType;
            httpResponse.requestId = httpRequest.requestId;
            httpResponse.transParamsDict = httpRequest.transParamsDict;
            httpResponse.filePath = httpRequest.filePath;
            httpResponse.json = responseObject;
            [delegate httpManager:self httpCallback:httpResponse];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"upload fail:%@",error);
    }];
    
}

/**
 *  下载文件到指定路径下
 *
 *  @param filePath 文件的路径
 *  @param fileUrl  文件的url地址
 */
-(void)downloadFileRequest:(BZHttpRequest *)httpRequest
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpRequest.url]];
//    NSString *query = AFQueryStringFromParameters(httpRequest.paramsDict);
//    [request setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *filePathUrl;
        if (httpRequest.filePath) {
            NSString *filePath = [NSString stringWithFormat:@"file://%@",httpRequest.filePath];
            filePathUrl = [NSURL URLWithString:filePath];
        }else {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            filePathUrl = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            NSLog(@"Method-[downloadFileRequest]-requestId-|%@|-httpRequest.filePath is nil! create default path :%@",httpRequest.requestId,filePathUrl);
        }
        return filePathUrl;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        for (id<BZHttpManagerDelegate> delegate in self.delegateArray) {
            BZHttpReponse *httpResponse = [[BZHttpReponse alloc]init];
            httpResponse.requestType = httpRequest.requestType;
            httpResponse.requestId = httpRequest.requestId;
            httpResponse.transParamsDict = httpRequest.transParamsDict;
            httpResponse.filePath = httpRequest.filePath;
            [delegate httpManager:self httpCallback:httpResponse];
        }
        
    }];
    [downloadTask resume];
}


- (void)getRequest:(BZHttpRequest *)httpRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:httpRequest.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Method-[getRequest]-requestId-|%@|-Response result :%@",httpRequest.requestId, responseObject);
        for (id<BZHttpManagerDelegate> delegate in self.delegateArray) {
            BZHttpReponse *httpResponse = [[BZHttpReponse alloc]init];
            httpResponse.requestId = httpRequest.requestId;
            httpResponse.transParamsDict = httpRequest.transParamsDict;
            httpResponse.json = responseObject;
            [delegate httpManager:self httpCallback:httpResponse];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Method-[getRequest]-requestId-|%@|-an error: %@", httpRequest.requestId,error);
        NSLog(@"Method-[getRequest]-requestId-|%@|-requestUrl:%@", httpRequest.requestId,httpRequest.url);
    }];
}


- (void)postRequest:(BZHttpRequest *)httpRequest
{
    NSLog(@"Method-[postRequest]-requestId-|%@|-requestUrl:%@", httpRequest.requestId,httpRequest.url);
    NSLog(@"Method-[postRequest]-requestId-|%@|-params:%@",httpRequest.requestId,httpRequest.paramsDict);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager POST:httpRequest.url parameters:httpRequest.paramsDict success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Method-[postRequest]-requestId-|%@|-Response result :%@",httpRequest.requestId, responseObject);
        for (id<BZHttpManagerDelegate> delegate in self.delegateArray)
        {
            BZHttpReponse *httpResponse = [[BZHttpReponse alloc]init];
            httpResponse.requestId = httpRequest.requestId;
            httpResponse.requestType = httpRequest.requestType;
            httpResponse.transParamsDict = httpRequest.transParamsDict;
            httpResponse.json = responseObject;
            
            [delegate httpManager:self httpCallback:httpResponse];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Method-[postRequest]-requestId-|%@|-an error: %@",httpRequest.requestId,error);
        
        for (id<BZHttpManagerDelegate> delegate in self.delegateArray)
        {
            BZHttpReponse *httpResponse = [[BZHttpReponse alloc]init];
            httpResponse.requestId = httpRequest.requestId;
            httpResponse.requestType = httpRequest.requestType;
            httpResponse.transParamsDict = httpRequest.transParamsDict;
            
            [delegate httpManager:self httpCallback:httpResponse];
        }
    }];
}

@end
