//
//  PreferentialCell.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/13.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "PreferentialCell.h"

@implementation PreferentialCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //给原始价格画删除线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.originalPrice.text attributes:attribtDic];
    
    // 赋值
    self.originalPrice.attributedText = attribtStr;
    
    // Configure the view for the selected state
}

@end
