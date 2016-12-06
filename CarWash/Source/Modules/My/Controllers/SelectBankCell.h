//
//  SelectBankCell.h
//  CarWash
//
//  Created by xa on 16/7/20.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBankCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bankIcon;
@property (strong, nonatomic) IBOutlet UILabel *bankName;
@property (strong, nonatomic) IBOutlet UILabel *accountBalance;

@end
