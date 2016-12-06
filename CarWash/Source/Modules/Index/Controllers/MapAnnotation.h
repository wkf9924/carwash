//
//  MapAnnotation.h
//  CarWash
//
//  Created by xa on 16/7/30.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapAnnotation : NSObject<MKAnnotation>
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *title;
@end
