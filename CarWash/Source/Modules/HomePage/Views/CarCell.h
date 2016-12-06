//
//  CarCell.h
//  CarWash
//
//  Created by xa on 16/7/5.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *carLogoImageView;
@property (strong, nonatomic) IBOutlet UIButton *TieCarButton;
@property (strong, nonatomic) IBOutlet UIImageView *jianTouImageView;

@property (strong, nonatomic) IBOutlet UILabel *washTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *tieButton;

@end
