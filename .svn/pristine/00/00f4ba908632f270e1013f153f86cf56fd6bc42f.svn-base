//
//  CWArticle.h
//  CarWash
//
//  Created by 赵林 on 9/24/16.
//  Copyright © 2016 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWArticle : NSObject
//文章id
@property (nonatomic, copy) NSString *articleId;
//封面图地址
@property (nonatomic, copy) NSString *imageUrl;
//文章标题
@property (nonatomic, copy) NSString *titile;
//文章内容，去除了html标签
@property (nonatomic, copy) NSString *content;
//文章内容，带html标签
@property (nonatomic, copy) NSString *htmlContent;
//文章创建时间
@property (nonatomic, copy) NSString *createTime;
//评论数量
@property (nonatomic, strong) NSNumber *commentCount;
//赞的数量
@property (nonatomic, strong) NSNumber *likeCount;
//发布者姓名
@property (nonatomic, copy) NSString *name;
//文章收藏的状态，0：没有登录 1：收藏 2：未收藏
@property (nonatomic, strong) NSNumber *collectStatus;
@end
