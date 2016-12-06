//
//  TransactionModel.h
//  CarWash
//
//  Created by WangKaifeng on 2016/11/18.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionList.h"
@interface TransactionModel : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)TransactionList *transactionList;
@property (nonatomic, strong)NSMutableArray *listArray;


@end
