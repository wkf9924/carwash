//
//  TrafficListCell.m
//  CarWash
//
//  Created by xa on 2016/10/27.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "TrafficListCell.h"

@implementation TrafficListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataWithModel:(TrafficDetailModel *)model{
    if (model) {
        self.trafficContentLabel.text = model.act;
        
        if ([model.handled isEqualToString:@"0"]) {
            self.trafficStatusLabel.textColor = [UIColor orangeColor];
            self.trafficStatusLabel.text = @"未处理";
        }else{
            self.trafficStatusLabel.textColor =[UIColor darkGrayColor];
            self.trafficStatusLabel.text = @"已处理";
        }
        self.trafficAddressLable.text = model.area;
        self.trafficTimeLabel.text = model.date;
    }
}
@end
