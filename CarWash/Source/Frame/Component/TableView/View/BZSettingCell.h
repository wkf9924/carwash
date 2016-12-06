//
//  BZSettingCell.h
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BZSettingItem;

@interface BZSettingCell : UITableViewCell
@property (nonatomic, strong) BZSettingItem *item;
@property (nonatomic, assign, getter = isLastRowInSection) BOOL lastRowInSection;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
