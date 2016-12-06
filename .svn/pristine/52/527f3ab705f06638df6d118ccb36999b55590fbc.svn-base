//
//  IndexViewController.h
//  CarWash
//
//  Created by WangKaifeng on 16/7/12.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "CWBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRViewController.h"
#import "MyDelegate.h"
@interface IndexViewController : CWBaseViewController <AVCaptureMetadataOutputObjectsDelegate,QRViewControllerDelegate, MyDelegate>

@property (nonatomic, strong) NSString *image_url; //商品缩略图
@property (nonatomic, strong) NSString *name; //商品名称
@property (nonatomic, strong) NSString *original_price; //商品原始价格
@property (nonatomic, strong) NSString *price; //商品当前

@property (strong,nonatomic)AVCaptureDevice *device;

@property (strong,nonatomic)AVCaptureMetadataOutput *output;

@property (strong,nonatomic)AVCaptureDeviceInput *input;

@property (strong, nonatomic)AVCaptureSession *session;

@property (strong, nonatomic)AVCaptureVideoPreviewLayer *preview;
@end
