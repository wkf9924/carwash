//
//  PreferentialCarWashVC.h
//  CarWash
//
//  Created by xa on 2016/10/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsumeListModel.h"
@interface PreferentialDetailCarWashVC : UIViewController
@property (nonatomic, strong)NSString *sellerName;//上个界面传值使用
@property (nonatomic, strong)ConsumeListModel *consumeModel;
@end
