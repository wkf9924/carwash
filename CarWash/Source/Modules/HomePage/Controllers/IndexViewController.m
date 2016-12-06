//
//  IndexViewController.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/12.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "IndexViewController.h"
#import "DefineConstant.h"
#import "PreferentialCell.h"

@interface IndexViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIScrollView *mySctollView;

@property (weak, nonatomic) IBOutlet UIView *myPageView;

@end

@implementation IndexViewController

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"PreferentialCell";
    PreferentialCell* cell = [self.myTableView dequeueReusableCellWithIdentifier:identifier];
    //if (cell == nil) {
        
        //cell = [[PreferentialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    //}


    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

#pragma mark -- 定位按钮
- (void)myGpsClick:(UIButton *)sender {
  
    
}

- (void)scanClick:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"洗洋洋";
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView = _headerView;
    
    
    //左侧按钮
    self.navigationItem.leftBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"定位icon"]
                                       highlightedImage:nil
                                                 titles:@"  西安"
                                                target:self
                                                 action:@selector(myGpsClick:)
                                       forControlEvents:UIControlEventTouchUpInside];

     //右侧按钮
    self.navigationItem.rightBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"扫一扫icon"]
                                       highlightedImage:nil
                                                 titles:@""
                                                 target:self
                                                 action:@selector(scanClick:)
                                       forControlEvents:UIControlEventTouchUpInside];

        //[self.myTableView registerNib:[UINib nibWithNibName:@"PreferentialCell" bundle:nil] forCellReuseIdentifier:@"PreferentialCell"];
    //本地图片
    //NSArray *imageArray = [[NSArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",nil];
    //网络图片
    NSArray *imageArray = @[@"http://pic18.nipic.com/20111220/8478161_214305641176_2.jpg", @"http://pic1.nipic.com/2008-12-05/2008125223022161_2.jpg", @"http://pic18.nipic.com/20111220/8478161_214305641176_2.jpg", @"http://pic1.nipic.com/2008-12-05/2008125223022161_2.jpg"];
    PageView *pageView = [[PageView alloc] initPageViewFrame:CGRectMake(0, 0, self.myPageView.bounds.size.width, self.myPageView.frame.size.height)];
    //是否是网络图片
    pageView.isWebImage = YES;
    //存放图片数组
    pageView.imageArray = imageArray;
    //停留时间
    pageView.duration = 2;
    
    [self.myPageView addSubview:pageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
