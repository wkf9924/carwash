//
//  Definition.h
//  BATeacher
//
//  Created by ivan on 15/6/17.
//  Copyright (c) 2015年 Yoowa. All rights reserved.

//

#ifndef BATeacher_Definition_h
#define BATeacher_Definition_h

//测试token
#define TOKEN @"12345565465454"
#define LOAD_FAIL @"网络不稳定，请稍候再试！"
#define LOAD_SUCCESS @"加载成功"
#define LC_SHOW_FAIL(LOAD_FAIL) [LCProgressHUD showFailure:LOAD_FAIL];
#define LC_SHOW_SUCCESS(LOAD_SUCCESS) [LCProgressHUD showFailure:LOAD_SUCCESS];


#define LC_HIDEN [LCProgressHUD hide];
#define LC_LOADING [LCProgressHUD showLoading:nil];
#define LC_Loading(string) [LCProgressHUD showLoading:string];

//提示成功
#define LCSUCCESS_ALSERT(stirng) [XHToast showCenterWithText:stirng];
//失败提示
#define LCFAIL_ALERT(string)[XHToast showCenterWithText:string];

#define UISCREEN_BOUNDS_SIZE      [UIScreen mainScreen].bounds.size // 屏幕的物理尺寸
#define TEACHER_VERSION_BUILD      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define TEACHER_VERSION          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define MOMENT_LIMIT_COUNTS   20

#define _WEAK_SELF __weak __typeof(&*self)weakSelf = self;

#define SEND_USER_PHOTO_MAX_COUNTS 3

// 带RGB参数生成Color的宏定义
#define COLOR_WITH_RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define COLOR_MORE_VIEW_BACKGROUND COLOR_WITH_RGB(240, 240, 240)

#define USER_LIBRARY_DIRECTORY [NSHomeDirectory() stringByAppendingPathComponent:@"Library/DB"]
#define USER_DOCUMENTS_DIRECTORY [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Image"]
#define USER_DOCUMENTS_DIRECTORY_AVATAR [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Avatar"]


#define MESSAGE_TEXT_FONT	 [UIFont systemFontOfSize:16.0] // 消息文本字体的字体大小
#define PROMPT_WAITING_VIEW_TAG             1102	// 提示view 遮罩层TAG
#define PROMPT_WAITING_LODING_WEB_TAG             1103	// 提示view 遮罩层TAG

#define MAX_IMAGE_LENGHT  600
#define MIN_IMAGE_LENGHT  300
#define THUBNIAL_HEIGHT   100
#define DAY_TIME          24*60*60

#define IMAGE_SCALE_SHORTEST_LENGTH_720      720 // 普通图片缩放时最短边的长度

#define MMS_THUMBNAIL_SCALE_LENGTH_120     120 // MMS缩略图缩放时最长边的长度
#define MMS_THUMBNAIL_SHORTEST_LENGTH_43    43 // MMS缩略图缩放时最短边的长度

// thumbwidth：服务器缩略图边长。目前公网支持180，564，内网支持300，564
#define MOMENT_SERVER_THUMBNAIL_WIDTH  180
// thumbwidth：缩略图最长边，按照图片宽高的最大值进行等比例缩放。
#define MOMENT_THUMBNAIL_MIN_WIDTH  UISCREEN_BOUNDS_SIZE.width
// thumbwidth：缩略图最短边
#define MOMENT_SINGLE_THUMBNAIL_MIN_WIDTH  UISCREEN_BOUNDS_SIZE.width*0.11

#define NOTIFICATION_CHANGE_TAB_IMAGE           @"ChangeTabImage"        // 改变tab图的通知
#define NOTIFICATION_UPDATE_IMAGE           @"updateImage"        // 刷新图片


// 图片媒体类型
#define PUBLIC_IMAGE               @"public.image"

//设备判断
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

// 设置   颜色
#define TSEColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define TSEAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenWidth5S 320
#define ScreenWidth6 375
#define ScreenWidth6plus 414

//调试模式下输入NSLog，发布后不再输入。
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#if defined (DEBUG) && DEBUG == 1

#else
#define NSLog(...) {};
#endif

//xcode8  
#ifdef DEBUG
#define CLLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif


// 加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]


// RGB颜色转换（16进制->10进制）

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


// View 坐标(x,y)和宽高(width,height)
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define FlushPool(p)                        [p drain]; p = [[NSAutoreleasePool alloc] init]
#define StatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define SelfDefaultToolbarHeight            self.navigationController.navigationBar.frame.size.height
#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsiOS7Later                         !(IOSVersion < 7.0)

#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)


#define TabBarHeight                        49.0f
#define NaviBarHeight                       44.0f
#define HeightFor4InchScreen                568.0f
#define HeightFor3p5InchScreen              480.0f

#define ViewCtrlTopBarHeight                (IsiOS7Later ? (NaviBarHeight + StatusBarHeight) : NaviBarHeight)
#define IsUseIOS7SystemSwipeGoBack          (IsiOS7Later ? YES : NO)


//---------界面跳转-------
#define POP_NAVIGATION_NUM(num) [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count - (num))] animated:YES];


#endif
