//
//  CWFindTableViewController.m
//  CarWash
//
//  Created by 赵林 on 9/24/16.
//  Copyright © 2016 xiyangyang. All rights reserved.
//

#import "CWFindTableViewController.h"
#import "BZEventCenter.h"
#import "CWEventCenterType.h"
#import "CWArticle.h"
#import "CWFindCell.h"
#import "BZPagingCenter.h"
#import "CWFindManager.h"
#import "MJRefresh.h"
#import "FindDetailVC.h"
#define FIND_LIST @"FIND_LIST"
#define COUNT 10
@interface CWFindTableViewController ()<BZEventCenterDelegate>
@property(nonatomic,strong) NSMutableArray *articlesArray;
@property (nonatomic,assign)  int currentPagingType;
@end

@implementation CWFindTableViewController

-(NSMutableArray *)articlesArray {
    if (!_articlesArray) {
        _articlesArray = [NSMutableArray array];
    }
    return _articlesArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeGetArticleListSuccess callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeGetArticleListFail callback:self];
    
    [[BZPagingCenter defaultCenter] registerPaging: FIND_LIST];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeGetArticleListSuccess callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeGetArticleListFail callback:self];
    [[BZPagingCenter defaultCenter] cancelRegisterPaging: FIND_LIST];
    
}

#pragma mark -  BZEventCenterDelegate methods
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    if ([eventType isEqualToString:CWEventCenterTypeGetArticleListSuccess])
    {
        if(_currentPagingType==BZPagingTypeDownPull){
            _articlesArray = param;
            [self.tableView.mj_header endRefreshing];
            
        }else {
            [_articlesArray addObjectsFromArray:param];
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    }else if([eventType isEqualToString:CWEventCenterTypeGetArticleListFail]) {
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPullToRefresh];
    [self.tableView.mj_header beginRefreshing];
   
}

-(void)initPullToRefresh
{
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPagingType = BZPagingTypeDownPull;
        int currentPage = [[BZPagingCenter defaultCenter]getPage:BZPagingTypeDownPull tag:FIND_LIST];
        [[CWFindManager shareManager]getArticleList:currentPage count:COUNT];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _currentPagingType = BZPagingTypeUpPull;
        int currentPage = [[BZPagingCenter defaultCenter]getPage:BZPagingTypeUpPull tag:FIND_LIST];
        [[CWFindManager shareManager]getArticleList:currentPage count:COUNT];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.articlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CWFindCell *cell = [[CWFindCell alloc]initWithTableView:tableView];
    CWArticle *article = [self.articlesArray objectAtIndex: indexPath.row];
    [cell setArticle:article];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     CWArticle *article = [self.articlesArray objectAtIndex: indexPath.row];
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FindDetailVC *findVC = [storyboard instantiateViewControllerWithIdentifier:@"FindDetailVC"];
    findVC.articleDetailId = article.articleId;
    [self.navigationController pushViewController:findVC animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
}




@end
