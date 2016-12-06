//
//  MyManager.h
//  CarWash
//
//  Created by WangKaifeng on 16/7/22.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQRUploadParam.h"
@interface MyManager : NSObject
+(MyManager *)sharedManager;
/**
 *   上传用户头像
 */
-(void)uploadUserImage:(SQRUploadParam *)param;
/**
 *   编辑用户其他资料
 */
- (void)editUserInfo:(NSString *)userName sex:(NSString *)sex;
/**
 *  车辆详情
 */

- (void)carInfo:(NSString *)carid;
/**
 *  我的收藏列表
 */

- (void)myCollectList:(NSString *)count page:(NSString *)page;

@end
