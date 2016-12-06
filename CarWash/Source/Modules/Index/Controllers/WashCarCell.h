//
//  WashCarCell.h
//  CarWash
//
//  Created by xa on 16/7/25.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WashCarCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *carStoreImage;
@property (strong, nonatomic) IBOutlet UILabel *carStoreName;
@property (strong, nonatomic) IBOutlet UILabel *carStoreDistance;
@property (strong, nonatomic) IBOutlet UILabel *carStoreLocation;
@property (strong, nonatomic) IBOutlet UILabel *carWashPrice;

@end
