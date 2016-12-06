
//
//  XYYViewController.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/6.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "XYYViewController.h"
#import "CarCell.h"
#import "MenuCell.h"
#import "QuTouTitleCell.h"
#import "TitleLablCell.h"
#import "ScrollViewCell.h"
#import "PageView.h"
@interface XYYViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *imageArray;
    PageView *pageView;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XYYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    imageArray = @[@"http://pic18.nipic.com/20111220/8478161_214305641176_2.jpg", @"http://pic1.nipic.com/2008-12-05/2008125223022161_2.jpg", @"http://pic18.nipic.com/20111220/8478161_214305641176_2.jpg", @"http://pic1.nipic.com/2008-12-05/2008125223022161_2.jpg"];


}
#pragma mark-tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *cell1=@"CarCell";
        CarCell* cell=[tableView dequeueReusableCellWithIdentifier:cell1];

        cell.jianTouImageView.image=[UIImage imageNamed:@"箭头@2x.png"];
    
       return cell;
    }else if(indexPath.row==1){
    
        static NSString *cell2=@"MenuCell";
        MenuCell *cell=[tableView dequeueReusableCellWithIdentifier:cell2];
        return cell;
    }
    if (indexPath.row==2) {
        static NSString *cell3=@"ScrollViewCell";
        ScrollViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cell3];
        pageView = [[PageView alloc] initPageViewFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
        pageView.isWebImage=YES;
        pageView.imageArray=imageArray;
        pageView.duration=1.5;
        [cell addSubview:pageView];

        return cell;
    }
    if (indexPath.row==3) {
        static NSString *cell4=@"TitleLablCell";
        TitleLablCell *cell=[tableView dequeueReusableCellWithIdentifier:cell4];
        cell.TitleImageView.image=[UIImage imageNamed:@"今日特惠icon@2x.png"];
        
        return cell;
    }else{
    static NSString *cell5=@"QuTouTitleCell";
        QuTouTitleCell *cell=[tableView dequeueReusableCellWithIdentifier:cell5];
        cell.ShopImageView.layer.masksToBounds=YES;
        cell.ShopImageView.layer.cornerRadius=45;
        cell.ShopImageView.image=[UIImage imageNamed:@"商品展示图@2x.png"];
        
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 70;
    }if (indexPath.row==1) {
        return 100;
    }if (indexPath.row==2) {
        return 120;
    }
    if (indexPath.row==3) {
        return 60;
    }
    if (indexPath.row==4) {
        return 100;
    }if (indexPath.row==5) {
        return 100;
    }if (indexPath.row==6) {
        return 100;
    }
    return 0;
    }

    
@end
