//
//  FindDetailCommentCell.m
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "FindDetailCommentCell.h"
#import "UIImageView+WebCache.h"

#import "DefineConstant.h"
@implementation FindDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setDataWithModel:(CommentModel *)model{
    NSString *url = [NSString stringWithFormat:@"http://%@/%@",API_SERVER_HOST,model.img_url];
    [self.photo sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"头像(未登录)"]];
    self.name.text = model.name;
    self.pubTime.text = model.eva_time;
#pragma mark 这里要获取内容的高度
    self.commentText.text = model.eva_content;
    CGSize size = [model.eva_content boundingRectWithSize:CGSizeMake(400, 10000) // 用于计算文本绘制时占据的矩形块
                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}        // 文字的属性
                                                context:nil].size;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"contentHeight" object:[NSNumber numberWithFloat:size.height]];
}
@end
