//
//  BZDefine.h
//  Merchant
//
//  Created by behring on 15/9/2.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef Merchant_BZDefine_h
#define Merchant_BZDefine_h
#define BZOSVersion [UIDevice currentDevice].systemVersion
#define BZAppVersionBuild      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define BZAppVersion          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define BZSCreenScale [UIScreen mainScreen].scale // 屏幕的密度

#define BZSCreenSize [UIScreen mainScreen].bounds.size // 屏幕的尺寸
#define BZSCreenWidth BZSCreenSize.width // 屏幕宽度
#define BZSCreenHeight BZSCreenSize.height // 屏幕高度

#define BZSCreenPhysicsWidth BZSCreenWidth*BZSCreenScale // 屏幕物理宽度
#define BZSCreenPhysicsHeight BZSCreenHeight*BZSCreenScale // 屏幕物理高度

// 判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 判断是否为iOS8
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

// 获得RGB颜色
#define BZColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 获得RGBA颜色
#define BZColorRGBA(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
//获取设备型号
#define BZGetDeviceModel(deviceModel)({\
    if(BZSCreenScale==1){\
         deviceModel = @"iphone 3GS";\
    }else if(BZSCreenScale==2){\
        if(BZSCreenHeight==480){\
            deviceModel = @"iphone 4/4S";\
        }else if(BZSCreenHeight==568){\
            deviceModel = @"iphone 5/5S";\
        }else if(BZSCreenHeight==667){  \
            deviceModel = @"iphone 6";\
        }\
    }else if(BZSCreenScale==3){\
        deviceModel = @"iphone 6 Plus";\
    }\
})
#endif
