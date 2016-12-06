//
//  CWFindManager.h
//  CarWash
//
//  Created by 赵林 on 9/24/16.
//  Copyright © 2016 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CWComment;
@interface CWFindManager : NSObject
+(CWFindManager *) shareManager;
//获取文章列表
-(void)getArticleList:(int)page count:(int)count;
//获取文章详情
-(void)getArticleDetail:(NSString *)articleId;

//获取文章评论列表
-(void)getArticleComments:(NSString *)articleId page:(int)page count:(int)count;
//评论文章
-(void)sendComment:(CWComment *)comment;
//收藏或取消收藏
-(void)sendCollectStatus:(NSString *)articleId isCollect:(Boolean)isCollect;
//点赞或取消点赞
-(void)sendLikeStatus:(NSString *)articleId isLike:(Boolean)isLike;
@end
