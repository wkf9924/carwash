//
//  CWFindManager.m
//  CarWash
//
//  Created by 赵林 on 9/24/16.
//  Copyright © 2016 xiyangyang. All rights reserved.
//

#import "CWFindManager.h"
#import "BZHttpManager.h"
#import "CWHttpKit.h"
#import "SQRHttpApi.h"
#import "CWArticle.h"
#import "CWEventCenterType.h"
#import "CWComment.h"

@interface CWFindManager()<BZHttpManagerDelegate>

@end

@implementation CWFindManager
+(CWFindManager *) shareManager
{
    static CWFindManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]init];
        [[BZHttpManager sharedHttpManager]registerHttpManagerDelegate:sharedInstance];
    });
    return sharedInstance;
}

//获取文章列表
-(void)getArticleList:(int)page count:(int)count {
    [[CWHttpKit sharedHttpKit]getArticleListWithUrl:API_ARTICLE_LIST_URL page:page count:count];    
}
//获取文章详情
-(void)getArticleDetail:(NSString *)articleId {
    [[CWHttpKit sharedHttpKit]getArticleDetailWithUrl:API_ARTICLE_DETAIL_URL articleId:articleId];
}
//获取文章评论列表
-(void)getArticleComments:(NSString *)articleId page:(int)page count:(int)count {
    [[CWHttpKit sharedHttpKit]getArticleCommentsWithUrl:API_ARTICLE_COMMENTS_URL articleId:articleId page:page count:count];
}

//评论文章
-(void)sendComment:(CWComment *)comment {
    [[CWHttpKit sharedHttpKit]sendCommentWithUrl:API_SEND_COMMENT_URL comment:comment];
}
//收藏或取消收藏
-(void)sendCollectStatus:(NSString *)articleId isCollect:(Boolean)isCollect {
    [[CWHttpKit sharedHttpKit]sendCollectStatusWithUrl:API_COLLECT_URL articleId:articleId isCollect:isCollect];
}
//点赞或取消点赞
-(void)sendLikeStatus:(NSString *)articleId isLike:(Boolean)isLike{
    [[CWHttpKit sharedHttpKit] sendLikeStatusWithUrl:API_LIKE_URL articleId:articleId isLike:isLike];
}



#pragma mark - BZHttpManagerDelegate
-(void)httpManager:(BZHttpManager *)httpManager httpCallback:(BZHttpReponse *)httpReponse
{
    switch (httpReponse.requestType)
    {
        case HttpApiRequestTypeGetArticleList://文章列表
            
            if (!httpReponse.error)
            {
                NSMutableArray *articleArray = [NSMutableArray array];
                
                if ([httpReponse.json[@"result"] isKindOfClass:[NSArray class]]) {
                    NSArray *jsonArray = httpReponse.json[@"result"];
                    for (id info in jsonArray)
                    {
                        CWArticle *article = [[CWArticle alloc]init];
                        article.articleId = info[@"id"];
                        article.titile = info[@"title"];
                        article.imageUrl = info[@"img_url"];
                        article.createTime = info[@"send_time"];
                        article.content = info[@"content"];
                        article.commentCount = info[@"comment_count"];
                        article.likeCount = info[@"likes_count"];
                        [articleArray addObject:article];
                    }
                    
                }
                
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeGetArticleListSuccess param:articleArray mainTread:YES];
            }
            else
            {
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeGetArticleListFail param:httpReponse.error mainTread:YES];
            }
            break;
            
            
        case HttpApiRequestTypeGetArticleDetail://文章详情
            
            if (!httpReponse.error)
            {
                NSString *jsonString = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeGetArticleDettail param:jsonString mainTread:YES];
            }
            else
            {
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeGetArticleDettailFail param:httpReponse.error mainTread:YES];
            }
            break;
        case HttpApiRequestTypeGetArticleComments://评论列表
            
            if (!httpReponse.error)
            {
                NSString *jsonString = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeGetArticleComments param:jsonString mainTread:YES];
            }
            else
            {
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeGetArticleCommentsFail param:httpReponse.error mainTread:YES];
            }
            break;
        case HttpApiRequestTypeSendComment://发表评论
            
            if (!httpReponse.error)
            {
                NSString *jsonString = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeComment param:jsonString mainTread:YES];
            }
            else
            {
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCommentFail param:httpReponse.error mainTread:YES];
            }
            break;
        case HttpApiRequestTypeSendLikeStatus://点赞或取消点赞状态
            
            if (!httpReponse.error)
            {
                NSString *jsonString = httpReponse.json[@"result"];
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeLikeStatus param:jsonString mainTread:YES];
            }
            else
            {
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeLikeStatusFail param:httpReponse.error mainTread:YES];
            }
            break;
        case HttpApiRequestTypeSendCollectStatus://收藏或取消收藏状态
            
            if (!httpReponse.error)
            {
                NSString *jsonString = httpReponse.json[@"result"];
            
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCollectStatus param:jsonString mainTread:YES];
            }
            else
            {
                [[BZEventCenter defaultCenter]postToEventType:CWEventCenterTypeCollectStatusFail param:httpReponse.error mainTread:YES];
            }
            break;
        default:
            break;
    }
}
@end
