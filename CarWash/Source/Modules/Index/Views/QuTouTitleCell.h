//
//  QuTouTitleCell.h
//  CarWash
//
//  Created by xa on 16/7/6.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuTouTitleCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ShopImageView;
@property (strong, nonatomic) IBOutlet UILabel *ShopNameTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *PriceTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *PriceTitleLabel2;
@property (strong, nonatomic) IBOutlet UILabel *QiangGouLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *Progress;

@end
