//
//  TransactionModel.m
//  CarWash
//
//  Created by WangKaifeng on 2016/11/18.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "TransactionModel.h"

@implementation TransactionModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"list"]) {
        self.listArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in value) {
            self.transactionList = [[TransactionList alloc] init];
            [self.transactionList setValuesForKeysWithDictionary:dic];
            [self.listArray addObject:self.transactionList];
        }
    }
}
@end
