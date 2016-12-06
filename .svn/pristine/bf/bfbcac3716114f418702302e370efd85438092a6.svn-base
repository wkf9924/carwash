//
//  FindDetailWebCell.m
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "FindDetailWebCell.h"

@interface FindDetailWebCell ()<UIWebViewDelegate>

@end

@implementation FindDetailWebCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.webView.delegate = self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataWithUrl:(NSString *)contentUrl{
    NSURL *baseUrl = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
    [self.webView loadHTMLString:contentUrl baseURL:baseUrl];
    NSLog(@"传值::%@",contentUrl);
    self.webView.scrollView.scrollEnabled = NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"webViewContentHeight" object:[NSNumber numberWithFloat:webView.scrollView.contentSize.height]];
}
@end
