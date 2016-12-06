//
//  MyCollectCell.h
//  CarWash
//
//  Created by xa on 2016/10/9.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectModel.h"

@interface MyCollectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (void)setDataWithModel:(MyCollectModel *)model;

@end
