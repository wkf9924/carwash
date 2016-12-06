//
//  MyDelegate.h
//  CarWash
//
//  Created by WangKaifeng on 2016/9/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyDelegate <NSObject>

- (void)autoLogin;
- (void)cardNumberCount:(NSString *)carNumber;

@end
