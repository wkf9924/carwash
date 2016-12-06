//
//  BZDatabaseManager.h
//  IOSDemo
//
//  Created by behring on 15/8/30.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;
@interface BZDatabaseManager : NSObject
+ (BZDatabaseManager *)sharedDatabaseManager;

-(BOOL)insertToTable:(NSString *)tableName withParams:(NSDictionary *)dict;
-(BOOL)deleteFromTable:(NSString *)tableName where:(NSString *)where;
-(BOOL)updateTable:(NSString *)tableName withParams:(NSDictionary *)params where:(NSString *)where;
-(FMResultSet *)queryFromTable:(NSString *)tableName withParams:(NSArray *)params where:(NSString *)where;

- (BOOL)updateWithSql:(NSString *)sql;
- (BOOL)updateWithSql:(NSString *)sql andParams:(NSArray *)params;

- (FMResultSet *)queryWithSql:(NSString *)sql;
- (FMResultSet *)queryWithSql:(NSString *)sql andParams:(NSArray *)params;
- (void)closeDB;
@end
