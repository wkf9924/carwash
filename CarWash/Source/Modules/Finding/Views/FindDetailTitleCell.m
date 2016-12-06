//
//  FindDetailTitleCell.m
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "FindDetailTitleCell.h"
#import "CWFindManager.h"
#import "Common.h"


@implementation FindDetailTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataWithModel:(ArticleDetailModel *)model{
    self.titleLabel.text = model.title;
    self.authorLabel.text = model.publisher;
    self.publicTime.text = model.send_time;
//    NSString *collectStatus = [NSString stringWithFormat:@"%@",model.collect];
    [self.collectButton setImage:[UIImage imageNamed:@"收藏icon"] forState:UIControlStateNormal];
    NSString *collectStatus = COM.isCollect;
    if ([collectStatus isEqualToString:@"1"]) {//未收藏
        [self.collectButton setImage:[UIImage imageNamed:@"收藏icon"] forState:UIControlStateNormal];
    }else if ([collectStatus isEqualToString:@"2"]){//已经收藏过
        [self.collectButton setImage:[UIImage imageNamed:@"已收藏icon"] forState:UIControlStateNormal];
    }

}
- (IBAction)collectButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendButtonAction:)]) {
        [self.delegate sendButtonAction:sender];
    }
}

@end
