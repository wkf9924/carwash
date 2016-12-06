//
//  BillCell.h
//  CarWash
//
//  Created by xa on 2016/11/4.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *billName;
@property (weak, nonatomic) IBOutlet UILabel *billDate;
@property (weak, nonatomic) IBOutlet UILabel *billMoney;

@end
