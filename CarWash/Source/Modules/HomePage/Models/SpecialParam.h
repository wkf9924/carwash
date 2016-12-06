//
//  SpecialParam.h
//  CarWash
//
//  Created by WangKaifeng on 16/7/8.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SQRBaseHttpParam.h"

@interface SpecialParam : SQRBaseHttpParam

@property(nonatomic,copy) NSString *count;
@property(nonatomic,copy) NSString *Id;
@property(nonatomic,copy) NSString *toke;
@property(nonatomic,copy) NSString *page;
@end
