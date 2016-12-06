//
//  MyCollectVC.m
//  CarWash
//
//  Created by xa on 16/8/23.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyCollectVC.h"
#import "DefineConstant.h"
#import "MyCollectCell.h"
#import "MyCollectModel.h"
#import "FindDetailVC.h"
#import "MyManager.h"

@interface MyCollectVC ()<UITableViewDataSource, UITableViewDelegate,BZEventCenterDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *emptyStutesView;//空状态显示此View,隐藏tableView
@property (nonatomic, strong)NSMutableArray *datasource;

@end

@implementation MyCollectVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeMyCollectList callback:self];
    [[MyManager sharedManager] myCollectList:@"10" page:@"1"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeMyCollectList callback:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的收藏";
    [self setBackBarButton];
    
    
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeMyCollectList]) {
        NSLog(@"我的收藏列表:%@",param);
        [self.datasource removeAllObjects];
        for (NSDictionary *dic in param) {
            MyCollectModel *model = [[MyCollectModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.datasource addObject:model];
        }
        if (self.datasource.count == 0) {
            self.tableView.hidden = YES;
            self.emptyStutesView.hidden = NO;
        }else{
            self.tableView.hidden = NO;
            self.emptyStutesView.hidden = YES;
        }
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  tableview代理方法实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectCell" forIndexPath:indexPath];
    MyCollectModel *model = self.datasource[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyCollectModel *model = self.datasource[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FindDetailVC *findDetail = [storyboard instantiateViewControllerWithIdentifier:@"FindDetailVC"];
    findDetail.articleDetailId = model.ID;
    [self.navigationController pushViewController:findDetail animated:YES];
}
- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
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
