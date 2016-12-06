//
//  BZDatabaseManager.m
//  IOSDemo
//
//  Created by behring on 15/8/30.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import "BZDatabaseManager.h"
#import "FMDB.h"
#define DATABASE_NAME @"merchant.sqlite"
@interface BZDatabaseManager()
@property(nonatomic,strong) FMDatabaseQueue *dbQueue;
@end
@implementation BZDatabaseManager
+(BZDatabaseManager *)sharedDatabaseManager
{
    static BZDatabaseManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:DATABASE_NAME];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];//创建或者打开数据库
    }
    return self;
}


-(BOOL)insertToTable:(NSString *)tableName withParams:(NSDictionary *)dict
{
//  @"insert into t_student (name, age) values (?, ?);"
    NSString *keys = [[dict allKeys] componentsJoinedByString:@","];
//    NSString *values = [[dict allValues] componentsJoinedByString:@","];
    NSArray *values = [dict allValues];
    NSMutableString *valuesString = [NSMutableString string];
    for(int i=0;i<values.count;i++){
        if (i!=0) {
            [valuesString appendString:@","];
        }
        id value = values[i];
        if ([value isKindOfClass:[NSString class]]) {
            [valuesString appendFormat:@"\'%@\'",value];
        }else {
            [valuesString appendString:[NSString stringWithFormat:@"%@",value]];
        }
    }
    
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@);",tableName,keys,valuesString];
    return [self updateWithSql:sql];
}

-(BOOL)deleteFromTable:(NSString *)tableName where:(NSString *)where
{
    // delete from 表名称 where 列名称 = 值
    if (!where) {
        where = @"1=1";
    }
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@;",tableName,where];
    return [self updateWithSql:sql];
}


-(BOOL)updateTable:(NSString *)tableName withParams:(NSDictionary *)params where:(NSString *)where
{
    // update 表名称 set 列名称 = 新值,列名称 = 新值 where 列名称 = 某值
    if (!where) {
        where = @"1=1";
    }
    NSMutableString *update = [NSMutableString string];
    NSArray *keys = [params allKeys];
    for(int i=0;i<keys.count;i++){
        if (i!=0) {
            [update appendString:@","];
        }
        NSString *key = keys[i];
        NSString *value = params[key];
        [update appendFormat:@"%@ = %@",key,value];
    }
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ where %@;",tableName,update,where];
    return [self updateWithSql:sql];
}



-(FMResultSet *)queryFromTable:(NSString *)tableName withParams:(NSArray *)params where:(NSString *)where
{
    //select 列名称 from 表名称 where 列名称 = 某值
    if (!where) {
        where = @"1=1";
    }
    
    NSString *queryColumn;
    if (!params) {
        queryColumn = @"*";
    }else {
        queryColumn = [params componentsJoinedByString:@","];
        
    }
    NSString *sql = [NSString stringWithFormat:@"select %@ from %@ where %@;",queryColumn,tableName,where];
    
    return [self queryWithSql:sql];
}

/**
 *  通过sql语句执行“增删改”以及表的创建删除等操作（除了查询以外的操作）
 *
 *  @param sql sql语句字符串，不确定的参数用“?”占位
 *  @param params 替代?的参数集合
 *
 *  @return 语句是否执行成功
 */

- (BOOL)updateWithSql:(NSString *)sql andParams:(NSArray *)params
{
    NSLog(@"excute sql :%@",sql);
    __block BOOL isSuccess = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        isSuccess = [db executeUpdate:sql,params];
    }];
    return isSuccess;
}

/**
 *  通过sql语句执行“增删改”以及表的创建删除等操作（除了查询以外的操作）
 *
 *  @param sql sql语句字符串
 *
 *  @return 语句是否执行成功
 */
- (BOOL)updateWithSql:(NSString *)sql
{
    return [self updateWithSql:sql andParams:nil];
}

/**
 *  通过sql语句执行查询操作
 *
 *  @param sql sql语句字符串，不确定的参数用“?”占位
 *  @param params 替代?的参数集合
 *
 *  @return 返回查询结果集
 */
- (FMResultSet *)queryWithSql:(NSString *)sql andParams:(NSArray *)params
{
    NSLog(@"excute sql :%@",sql);
    __block FMResultSet *resultSet = nil;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        resultSet = [db executeQuery:sql,params];
    }];
    return resultSet;
}
/**
 *  通过sql语句执行查询操作
 *
 *  @param sql sql语句字符串
 *
 *  @return 返回查询结果集
 */
- (FMResultSet *)queryWithSql:(NSString *)sql
{
    return [self queryWithSql:sql andParams:nil];
}

- (void)closeDB
{
    [self.dbQueue close];
}
@end
