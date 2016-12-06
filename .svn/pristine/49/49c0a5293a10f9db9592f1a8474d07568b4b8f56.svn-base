//
//  BZNetworkingRequestCallbackManager.h
//  Merchant
//
//  Created by behring on 15/8/29.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZHttpReponse.h"

@class BZHttpManager,BZHttpRequest;

@protocol BZHttpManagerDelegate
@required
-(void)httpManager:(BZHttpManager *)httpManager
              httpCallback:(BZHttpReponse *)httpReponse;
@end

@interface BZHttpManager : NSObject
+ (BZHttpManager *)sharedHttpManager;
-(void)registerHttpManagerDelegate:(id<BZHttpManagerDelegate>)delegate;
-(void)cancelRegisterHttpManagerDelegate:(id<BZHttpManagerDelegate>)delegate;

- (void)getRequest:(BZHttpRequest *)httpRequest;
- (void)postRequest:(BZHttpRequest *)httpRequest;
-(void)uploadFileRequest:(BZHttpRequest *)httpRequest;
- (void)downloadFileRequest:(BZHttpRequest *)httpRequest;
@end
