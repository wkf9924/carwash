//
//  FindDetailVC.m
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "FindDetailVC.h"
#import "DefineConstant.h"

#import "CommentModel.h"
#import "ArticleDetailModel.h"
#import "CWFindManager.h"
#import "Common.h"
#import "FindDetailWebCell.h"
#import "FindDetailTitleCell.h"
#import "FindDetailButtonCell.h"
#import "FindDetailCommentCell.h"
#import "FindDetailHaveNoMoreCell.h"
#import "CWComment.h"
#import "UIImage+Tools.h"
#import "SharedHelper.h"

@interface FindDetailVC ()<UITableViewDelegate, UITableViewDataSource,BZEventCenterDelegate,FindDetailTitleCellDelegate,FindDetailButtonCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDistance;
@property (weak, nonatomic) IBOutlet UITextField *commentText;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) NSMutableArray *datacource;
@property (nonatomic, strong) ArticleDetailModel *articModel;
@property (nonatomic, strong) CommentModel *comModel;
@property (nonatomic, assign) float contentHeight;
@property (nonatomic, assign) float webViewHeight;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) NSString *likeCount;

@end

@implementation FindDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeGetArticleDettail callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeGetArticleComments callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeComment callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCollectStatus callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeLikeStatus callback:self];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeGetArticleDettail callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeGetArticleComments callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeComment callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCollectStatus callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeLikeStatus callback:self];
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    
    LC_HIDEN
    if ([eventType isEqualToString:CWEventCenterTypeGetArticleDettail]) {
        NSLog(@"文章详情:%@",param);
        COM.isCollect = [NSString stringWithFormat:@"%@", param[@"collect"]];
        COM.isLike = [NSString stringWithFormat:@"%@",param[@"like"]];
        self.articModel = [[ArticleDetailModel alloc] init];
        [self.articModel setValuesForKeysWithDictionary:param];
    }else {
        
        
    }
    
    if ([eventType isEqualToString:CWEventCenterTypeGetArticleComments]){
        NSLog(@"评论列表:%@",param);
        for (NSDictionary *dic in param) {
            self.comModel = [[CommentModel alloc] init];
            [self.comModel setValuesForKeysWithDictionary:dic];
            [self.datacource addObject:self.comModel];
        }
    }else {
        
    }
    
    if ([eventType isEqualToString:CWEventCenterTypeComment]){
        NSLog(@"发表评论:%@",param);
        [[CWFindManager shareManager] getArticleDetail:self.articleDetailId];
        [self.tableView reloadData];
    }else {
        
    }
    
    if ([eventType isEqualToString:CWEventCenterTypeCollectStatus]){
        NSLog(@"收藏或取消:%@",param);
        NSString *collectString = COM.isCollect;
        if ([collectString isEqualToString:@"1"]){
            LCSUCCESS_ALSERT(@"取消收藏")
            [self.collectButton setImage:[UIImage imageNamed:@"收藏icon"] forState:UIControlStateNormal];
            NSLog(@"已经取消收藏");
        }else if ([collectString isEqualToString:@"2"]){
            LCSUCCESS_ALSERT(@"收藏成功")
            [self.collectButton setImage:[UIImage imageNamed:@"已收藏icon"] forState:UIControlStateNormal];
            NSLog(@"已经收藏");
        }
    }else {
        
    }
    
    if ([eventType isEqualToString:CWEventCenterTypeLikeStatus]){
        NSLog(@"点赞或取消%@",param);
        NSString *likeString = COM.isLike;
        if ([likeString isEqualToString:@"1"]) {//未点赞
            [self.likeButton setImage:[UIImage imageNamed:@"未点赞icon"] forState:UIControlStateNormal];
            LCSUCCESS_ALSERT(@"取消点赞");
            [[CWFindManager shareManager] getArticleDetail:self.articleDetailId];
        }else if ([likeString isEqualToString:@"2"]){//已点赞
            [self.likeButton setImage:[UIImage imageNamed:@"点赞icon"] forState:UIControlStateNormal];
            LCSUCCESS_ALSERT(@"点赞成功");
            [[CWFindManager shareManager] getArticleDetail:self.articleDetailId];
        }
        [self.tableView reloadData];
    } else {
        
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.automaticallyAdjustsScrollViewInsets = NO;
    LC_LOADING
    [[CWFindManager shareManager] getArticleComments:self.articleDetailId page:1 count:100];
    [[CWFindManager shareManager] getArticleDetail:self.articleDetailId];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分享icon"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContnetheight:) name:@"contentHeight" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeWebViewHeight:) name:@"webViewContentHeight" object:nil];
}
#pragma mark 分享动作
- (void)rightBarButtonItemAction{
    NSArray *imageArray = @[[UIImage imageNamed:@"洗洋洋icon(选中)"]];
    //    NSArray *imageArray_1 = @[@""];
    [[SharedHelper sharedHelper] sharedImageArray:imageArray Text:@"" url:[NSURL URLWithString:@""] title:@""];
}
#pragma mark--滚动tableView的时候回收键盘,取消textField的第一响应者
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //回收键盘
    [self.commentText resignFirstResponder];
}
- (void)changeContnetheight:(NSNotification *)notification{
    float contentHeight = [notification.object floatValue];
    if (self.contentHeight == contentHeight) {
        return;
    }
    self.contentHeight = contentHeight;
    
    [self.tableView reloadData];
}
- (void)changeWebViewHeight:(NSNotification *)notification{
    float webViewHeight = [notification.object floatValue];
    if (self.webViewHeight == webViewHeight) {
        return;
    }
    self.webViewHeight = webViewHeight;
    [self.tableView reloadData];
    
}
//发表评论按钮回调
- (IBAction)commentButtonAction:(UIButton *)sender {
    
    NSString *token = [COM getLoginToken];
    if (token.length < 1 || token == nil || [token isKindOfClass:[NSNull class]] || [token isEqualToString:@""]) {
        [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        [self presentViewController:[[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil] instantiateViewControllerWithIdentifier:@"login"] animated:YES completion:nil];
        return;
    }
    
    if (self.commentText.text.length == 0) {
        LCFAIL_ALERT(@"说点什么吧🙂");
    }else{
        CWComment *comment = [[CWComment alloc] init];
        comment.articleId = self.articModel.ID;
        comment.avatarUrl = [COM getUserURL];
        comment.name = [COM getLoginName];
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentTime = [formatter stringFromDate:[NSDate date]];
        comment.time = currentTime;
        comment.content = self.commentText.text;
        [[CWFindManager shareManager] sendComment:comment];
        
        CommentModel *model = [[CommentModel alloc] init];
        model.articleId = self.articModel.ID;
        model.eva_content = self.commentText.text;
        model.name = [COM getLoginName];
        model.img_url = [COM getUserURL];
        model.eva_time = currentTime;
        [self.datacource addObject:model];
    }
    [self.commentText resignFirstResponder];
    self.commentText.text = nil;
    
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 61.5;
    }else if (indexPath.row == 1){
        return self.webViewHeight;
    }else if (indexPath.row == 2) {
        return 137;
    }else if (indexPath.row == self.datacource.count + 3) {
        return 43;
    }else{
        return self.contentHeight + 70;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4 + self.datacource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FindDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindDetailTitleCell" forIndexPath:indexPath];
        cell.delegate = self;
        if (self.articModel) {
            [cell setDataWithModel:self.articModel];
        }
        return cell;
    }else if (indexPath.row == 1){
        FindDetailWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindDetailWebCell" forIndexPath:indexPath];
        if (self.articModel) {
            [cell setDataWithUrl:self.articModel.content_html];
        }
        return cell;
    }else if (indexPath.row == 2){
        FindDetailButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindDetailButtonCell" forIndexPath:indexPath];
        cell.delegate = self;
        if (self.articModel) {
            [cell setDataWithLikeCount:self.articModel.likes_count commentCount:[NSString stringWithFormat:@"%.0ld",self.datacource.count] like:self.articModel.like];
        }
        return cell;
    }else if (indexPath.row == self.datacource.count + 3){
        FindDetailHaveNoMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindDetailHaveNoMoreCell" forIndexPath:indexPath];
        cell.haveNoMoreCommentLabel.text = @"没有更多评论了";
        return cell;
    }else{
        FindDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindDetailCommentCell" forIndexPath:indexPath];
        CommentModel *model = self.datacource[indexPath.row - 3];
        [cell setDataWithModel:model];
        return cell;
    }
}
//indexPath.row == 0  cell上收藏按钮的代理回调
- (void)sendButtonAction:(UIButton *)sender{
    self.collectButton = sender;
    NSString *collectString = COM.isCollect;
    
    if ([[COM getLoginToken] isEqualToString:@""] || [[COM getLoginToken] isKindOfClass:[NSNull class]] || [COM getLoginToken].length < 1) {
        
        [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        [self presentViewController:[[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil] instantiateViewControllerWithIdentifier:@"login"] animated:YES completion:nil];
        COM.isCollect = @"1";
        return;
    }
    
    if ([collectString isEqualToString:@"1"]) {
        COM.isCollect = @"2";
        [[CWFindManager shareManager] sendCollectStatus:self.articModel.ID isCollect:YES];//收藏
    }else if ([collectString isEqualToString:@"2"]){
        COM.isCollect = @"1";
        [[CWFindManager shareManager] sendCollectStatus:self.articModel.ID isCollect:NO];//取消收藏
    }
}
//indexPath.row == 2  cell上点赞按钮的代理回调
- (void)sendLikeButtonAction:(UIButton *)sender{
    self.likeButton = sender;
    NSString *likeString = COM.isLike;
    
    if ([[COM getLoginToken] isEqualToString:@""] || [[COM getLoginToken] isKindOfClass:[NSNull class]] || [COM getLoginToken].length < 1) {
        
        [UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil];
        [self presentViewController:[[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil] instantiateViewControllerWithIdentifier:@"login"] animated:YES completion:nil];
        COM.isLike = @"1";
        return;
    }
    

    
    if ([likeString isEqualToString:@"1"]) {//未点赞
        COM.isLike = @"2";
        [[CWFindManager shareManager] sendLikeStatus:self.articModel.ID isLike:YES];
        
    }else if ([likeString isEqualToString:@"2"]){//已点赞
        COM.isLike = @"1";
        [[CWFindManager shareManager] sendLikeStatus:self.articModel.ID isLike:NO];
    }
}

- (void)sendLikeCountText:(NSString *)sender{
    self.likeCount = [sender substringFromIndex:2];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)datacource{
    if (!_datacource) {
        _datacource = [[NSMutableArray alloc] init];
    }
    return _datacource;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
