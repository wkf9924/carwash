//
//  FindDetailTitleCell.h
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleDetailModel.h"


@protocol FindDetailTitleCellDelegate <NSObject>

- (void)sendButtonAction:(UIButton *)sender;

@end


@interface FindDetailTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicTime;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (nonatomic, strong)NSString *articleId;
@property (nonatomic, strong)NSString *collect;
@property (nonatomic, assign) id <FindDetailTitleCellDelegate> delegate;
- (void)setDataWithModel:(ArticleDetailModel *)model;
@end
