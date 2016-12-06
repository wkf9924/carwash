//
//  CarStyleModel.h
//  CarWash
//
//  Created by xa on 16/8/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarStyleSubModel.h"

@interface CarStyleModel : NSObject
@property (nonatomic, strong)NSString *seriesNum;
@property (nonatomic, strong)NSString *subBrandId;
@property (nonatomic, strong)NSString *subBrandName;
@property (nonatomic, strong)NSMutableArray *seriesArray;
@property (nonatomic, strong)CarStyleSubModel *carstyleModel;
@end
