//
//  CWFindCell.m
//  CarWash
//
//  Created by 赵林 on 9/24/16.
//  Copyright © 2016 xiyangyang. All rights reserved.
//

#import "CWFindCell.h"
#import "UIImageView+WebCache.h"
#import "CWArticle.h"
#import "DefineConstant.h"
@interface CWFindCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end
@implementation CWFindCell

- (instancetype)initWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"CWFindCell";
    self = [tableView dequeueReusableCellWithIdentifier:cellID];
    return self;
}

-(void)setArticle:(CWArticle *)article {
    _article = article;
    if (![article.imageUrl isKindOfClass:[NSNull class]]) {
        NSString *url = [NSString stringWithFormat:@"http://%@/%@", API_SERVER_HOST, _article.imageUrl];
         [self.coverImageView sd_setImageWithURL:[NSURL URLWithString: url] placeholderImage:[UIImage imageNamed:@"find_item_def_pic_discover"]];
    }
    [self.timeLabel setText:article.titile];
    [self.contentLabel setText:article.content];
    [self.timeLabel setText:article.createTime];
    [self.commentCountLabel setText:article.commentCount.stringValue];
    [self.likeCountLabel setText:article.likeCount.stringValue];

}

@end
