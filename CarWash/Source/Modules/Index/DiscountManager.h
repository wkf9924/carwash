//
//  DiscountManager.h
//  CarWash
//
//  Created by WangKaifeng on 16/7/19.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountManager : NSObject
+(DiscountManager *)sharedManager;

-(void)discount:(NSNumber *)count page:(NSNumber *)page;
-(void)discountDetail:(NSString *)token count:(NSString *)good_id;
@end
