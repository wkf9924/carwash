//
//  CouponsCell.m
//  CarWash
//
//  Created by xa on 2016/10/19.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CouponsCell.h"

@implementation CouponsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataWithModel:(CouponListModel *)model{
    if (model) {
        self.couponName.text = model.name;
        self.effectiveTimeLabel.text = model.end_time;
        self.couponMoney.text = [NSString stringWithFormat:@"%ld", (long)model.money];
        if (model.remark.length == 0) {
            self.conditionsOfUseLabel.text = @"";
        }else{
            self.conditionsOfUseLabel.text = [NSString stringWithFormat:@"(%@)", model.remark];
        }
        
        self.usingRange.text = model.use_range;
    }
}

@end
