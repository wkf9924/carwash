//
//  MyViewController.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/6.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyViewController.h"
#import "MyCell.h"
#import "MoneryCell.h"
#import "myDingDanCell.h"
#import "DaiFaCell.h"
#import "shouHouCell.h"
#import "GoWuCheCell.h"
#import "DiZhiCell.h"
#import "shouHouCell.h"
#import "PengYouCell.h"
#import "TiXingCell.h"
#import "KeFuCell.h"
#import "DaoLuCell.h"
#import "ShouCangCell.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.navigationController.navigationBarHidden = YES;
   
    
  }
#pragma mark-tableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.row==0) {
        static NSString *cell1=@"MyCell";
        MyCell* cell=[tableView dequeueReusableCellWithIdentifier:cell1];
       
        return cell;
      
    }else if(indexPath.row==1){
        
        static NSString *cell2=@"MoneryCell";
        MoneryCell *cell=[tableView dequeueReusableCellWithIdentifier:cell2];
        return cell;
    }
    if (indexPath.row==2) {
        static NSString *cell3=@"myDingDanCell";
        myDingDanCell*cell=[tableView dequeueReusableCellWithIdentifier:cell3];
        
        return cell;
    }if (indexPath.row==3) {
        static NSString * cell4=@"DaiFaCell";
        DaiFaCell*cell=[tableView dequeueReusableCellWithIdentifier:cell4];
               return cell;

    }if (indexPath.row==4) {
        static NSString * cell5=@"shouHouCell";
        shouHouCell*cell=[tableView dequeueReusableCellWithIdentifier:cell5];
              return cell;
    }if (indexPath.row==5) {
        static NSString * cell6=@"GoWuCheCell";
        GoWuCheCell*cell=[tableView dequeueReusableCellWithIdentifier:cell6];
      
        return cell;

    }if (indexPath.row==6) {
        static NSString *cell7=@"DiZhiCell";
        DiZhiCell *cell=[tableView dequeueReusableCellWithIdentifier:cell7];
        return cell;
    }if(indexPath.row==7){
    static NSString *cell8=@"ShouCangCell";
        ShouCangCell *cell=[tableView dequeueReusableCellWithIdentifier:cell8];
        return cell;
    
    }if (indexPath.row==8) {
        static NSString *cell9=@"PengYouCell";
        PengYouCell*cell=[tableView dequeueReusableCellWithIdentifier:cell9];
        return cell;
    }if (indexPath.row==9) {
        static NSString *Cell10=@"KeFuCell";
        KeFuCell *cell=[tableView dequeueReusableCellWithIdentifier:Cell10];
        return cell;
    }if (indexPath.row==10) {
        static NSString *cell11=@"TiXingCell";
        TiXingCell *cell=[tableView dequeueReusableCellWithIdentifier:cell11];
        return cell;
    }if (indexPath.row==11) {
        static NSString *cell12=@"DaoLuCell";
        DaoLuCell *cell=[tableView dequeueReusableCellWithIdentifier:cell12];
        return cell;
    }
    return nil;
  }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 180;
    }if (indexPath.row==1) {
        return 100;
    }if (indexPath.row==2) {
        return 50;
    }if (indexPath.row==3) {
        return 50;
    }if (indexPath.row==4) {
        return 40;
    }if (indexPath.row==5) {
        return 40;
    }if (indexPath.row==7) {
        return 40;
    }
    return 40;
}
@end
