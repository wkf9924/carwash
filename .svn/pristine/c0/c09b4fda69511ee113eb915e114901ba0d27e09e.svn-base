//
//  SQRDatabase.m
//  IOSDemo
//
//  Created by behring on 15/8/30.
//  Copyright (c) 2015年 behring. All rights reserved.
//

#import "SQRDatabase.h"
#import "BZDatabaseManager.h"
#import "SQRSqlCommand.h"
#import "BZDatabaseManager.h"
#import "BZModelHelper.h"
#import "FMDB.h"
@implementation SQRDatabase
+(SQRDatabase *)sharedDatabase;
{
    static SQRDatabase *sharedInstance = nil;
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
        [self createTable];
    }
    return self;
}

-(void)createTable
{
    BZDatabaseManager *databaseManager = [BZDatabaseManager sharedDatabaseManager];
//    [databaseManager updateWithSql:SQL_CREATE_TABLE_PRODUCT];
//    [databaseManager updateWithSql:SQL_CREATE_TABLE_ORDER];
//    [databaseManager updateWithSql:SQL_CREATE_TABLE_USER];
}

@end
