//
//  FindDetailWebCell.h
//  CarWash
//
//  Created by xa on 2016/9/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindDetailWebCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (void)setDataWithUrl:(NSString *)contentUrl;
@end
