//
//  FileManager.h
//  BATeacher
//
//  Created by ivan on 15/6/17.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (CustomManager)


+ (void)createFileFolder:(NSString *)filePath;

+ (BOOL)fileExistOfPath:(NSString *)filePath;

@end
