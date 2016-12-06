//
//  FileManager.m
//  BATeacher
//
//  Created by ivan on 15/6/17.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import "FileManager.h"

@implementation NSFileManager (CustomManager)

+ (void)createFileFolder:(NSString *)filePath
{
    if (filePath == nil) {
        return;
    }
    BOOL isDirectory = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath isDirectory: &isDirectory] == NO)
    {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (BOOL)fileExistOfPath:(NSString *)filePath
{
    if (filePath == nil) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath: filePath];
}

@end
