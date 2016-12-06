//
//  FindDetailButtonCell.h
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FindDetailButtonCellDelegate <NSObject>

- (void)sendLikeButtonAction:(UIButton *)sender;

- (void)sendLikeCountText:(NSString *)sender;

@end

@interface FindDetailButtonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *like_count;
@property (weak, nonatomic) IBOutlet UILabel *comment_count;
@property (nonatomic, assign) id <FindDetailButtonCellDelegate> delegate;
- (void)setDataWithLikeCount:(NSString *)likeCount commentCount:(NSString *)commnetCount like:(NSNumber *)likeStatus;
@end
