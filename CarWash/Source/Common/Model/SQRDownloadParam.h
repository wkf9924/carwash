//
//  SQRDownloadParam.h
//  Merchant
//
//  Created by 赵林 on 15/9/1.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQRBaseHttpParam.h"
@interface SQRDownloadParam : SQRBaseHttpParam
@property(nonatomic,copy) NSString *fileId;//服务器返回的文件id
@property(nonatomic,copy) NSString *filePath;
@end
