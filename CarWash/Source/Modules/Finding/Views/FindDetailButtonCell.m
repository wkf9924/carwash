//
//  FindDetailButtonCell.m
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "FindDetailButtonCell.h"
#import "Common.h"

@implementation FindDetailButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataWithLikeCount:(NSString *)likeCount commentCount:(NSString *)commnetCount like:(NSNumber *)likeStatus{
    self.like_count.text = [NSString stringWithFormat:@"赞:%@",likeCount];
    self.comment_count.text = [NSString stringWithFormat:@"(%@)",commnetCount];
    NSString *like = COM.isLike;
    if ([like isEqualToString:@"1"]) {//未点赞
        [self.likeButton setImage:[UIImage imageNamed:@"未点赞icon"] forState:UIControlStateNormal];
    }else if ([like isEqualToString:@"2"]){//已经点赞
        [self.likeButton setImage:[UIImage imageNamed:@"点赞icon"] forState:UIControlStateNormal];
    }
}
- (IBAction)likeButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendLikeButtonAction:)] && [self.delegate respondsToSelector:@selector(sendLikeCountText:)]) {
        [self.delegate sendLikeButtonAction:sender];
        [self.delegate sendLikeCountText:self.like_count.text];
    }
}

@end
