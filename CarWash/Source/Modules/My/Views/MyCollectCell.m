//
//  MyCollectCell.m
//  CarWash
//
//  Created by xa on 2016/10/9.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "MyCollectCell.h"
#import "UIImageView+WebCache.h"
#import "DefineConstant.h"

@implementation MyCollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataWithModel:(MyCollectModel *)model{
    NSString *imageUrl = [NSString stringWithFormat:@"http://%@/%@",API_SERVER_HOST,model.img_url];
    [self.articleImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"collectImage"]];
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
}
@end
