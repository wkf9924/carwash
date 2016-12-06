//
//  MD5.h
//  FreePPMobile
//
//  Created by Gray on 2010/10/14.
//  Copyright 2010 Browan. All rights reserved.
//
//  Gray.Wang:2013.03.18: Add File MD5 Function
//  Gray.Wang:2013.09.18: Add Data MD5 Function

#import <UIKit/UIKit.h>


@interface NSString (MD5)

// 对字符串进行MD5算法
+ (NSString *)stringMD5:(NSString *)string;
// 对字符串进行MD5算法，直接对参数charMD5进行赋值，得到16进制的指针数据
+ (void)unsignedCharMD5:(NSString *)string outputBytes:(unsigned char *)charMD5;

@end

@interface NSFileManager (MD5)

// 对文件数据进行MD5算法
+ (NSString *)fileMD5AtPath:(NSString *)filePath;

@end

@interface NSData (MD5)

// 对二进制数据进行MD5算法
+ (NSString *)dataMD5:(NSData *)dataSource;

@end
