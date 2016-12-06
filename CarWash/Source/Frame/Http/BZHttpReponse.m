//
//  BZHttpReponse.m
//  IOSDemo
//
//  Created by behring on 15/8/29.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import "BZHttpReponse.h"

@implementation BZHttpReponse
-(BZError *)error
{
    _error = nil;
    if (_json) {
        //解析json获取resultCode
        int resultCode = [[_json valueForKeyPath:@"code"]intValue];
        if (resultCode!=0) {
            _error = [[BZError alloc]init];
            _error.code = resultCode;
            _error.message = [_json valueForKeyPath:@"message"];
        }
    }
    return _error;
}
@end
