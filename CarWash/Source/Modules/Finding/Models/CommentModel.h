//
//  CommentModel.h
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
//文章id
@property (nonatomic, copy) NSString *articleId;
//头像地址url
@property (nonatomic, copy) NSString *img_url;
//评论人姓名
@property (nonatomic, copy) NSString *name;
//评论时间
@property (nonatomic, copy) NSString *eva_time;
//评论内容
@property (nonatomic, copy) NSString *eva_content;

@end
