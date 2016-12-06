//
//  MenuCell.h
//  CarWash
//
//  Created by xa on 16/7/6.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *WashCarButton;
@property (strong, nonatomic) IBOutlet UIButton *KeepCarButton;
@property (strong, nonatomic) IBOutlet UIButton *CarShopButton;
@property (strong, nonatomic) IBOutlet UIButton *WeiZhangButton;
@property (strong, nonatomic) IBOutlet UILabel *WaskCarLabel;
@property (strong, nonatomic) IBOutlet UILabel *KeepCarLabel;
@property (strong, nonatomic) IBOutlet UILabel *CarShopLabel;
@property (strong, nonatomic) IBOutlet UILabel *WeiZhangLabel;

@end
