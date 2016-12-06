//
//  TransactionList.h
//  CarWash
//
//  Created by WangKaifeng on 2016/11/18.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionList : NSObject
@property (nonatomic, strong) NSString *amount;  //价格
@property (nonatomic, strong) NSString *months;  //日期
@property (nonatomic, strong) NSString *remark;  //名称
@property (nonatomic, strong) NSString *version;  //名称
@property (nonatomic, strong) NSString *balance;  //名称
@property (nonatomic, strong) NSString *create_time;  //时间

@end

