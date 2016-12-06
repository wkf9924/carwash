//
//  MD5.m
//  FreePPMobile
//
//  Created by Gray on 2010/10/14.
//  Copyright 2010 Browan. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>

#define CHUNK_SIZE 4096

@implementation NSString (MD5)

// 对字符串进行MD5算法，返回16进制的NSString字符串
+ (NSString *)stringMD5:(NSString *)string {
    if (string == nil) {
        return nil;
    }
    
	const char *cStr = [string UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
	CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    
	return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]] lowercaseString];
}

// 对字符串进行MD5算法，直接对参数charMD5进行赋值，得到16进制的指针数据
+ (void)unsignedCharMD5:(NSString *)string outputBytes:(unsigned char *)charMD5 {
    if (string == nil) {
        return;
    }
    
	const char *cStr = [string UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
	CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    
    memcpy(charMD5, result, sizeof(result));
}

@end

@implementation NSFileManager (MD5)

// 对文件数据进行MD5算法
+ (NSString *)fileMD5AtPath:(NSString *)filePath {
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    if (filePath == nil || [fileManager fileExistsAtPath:filePath] == NO) {
        return nil;
    }
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (handle == nil) {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength:CHUNK_SIZE];
        CC_MD5_Update(&md5, [fileData bytes], (unsigned int)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    
    unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
    CC_MD5_Final(result, &md5);
    
	return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]] lowercaseString];
}

@end

@implementation NSData (MD5)

// 对二进制数据进行MD5算法
+ (NSString *)dataMD5:(NSData *)dataSource
{
    unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
    CC_MD5( [dataSource bytes], (unsigned int)[dataSource length], result ); // This is the md5 call
    
    return [[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]] lowercaseString];
}

@end