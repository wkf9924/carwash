//
//  ArticleDetailModel.h
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleDetailModel : NSObject
@property (nonatomic, strong) NSNumber *collect; //收藏信息
@property (nonatomic, copy) NSString *comment_count; //评论总数
@property (nonatomic, copy) NSString *content_html; //html文章内容
@property (nonatomic, copy) NSString *ID; //文章id
@property (nonatomic, strong) NSNumber *like; //点赞信息
@property (nonatomic, copy) NSString *publisher; //发布者
@property (nonatomic, copy) NSString *send_time; //发布时间
@property (nonatomic, copy) NSString *title; //文章标题
@property (nonatomic, strong) NSString *likes_count;//点赞数量
@property (nonatomic, strong) NSString *img_url;

@end
