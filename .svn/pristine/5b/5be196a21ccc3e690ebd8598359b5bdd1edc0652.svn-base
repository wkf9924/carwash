//
//  UIImage+Tools.h
//  BATeacher
//
//  Created by ivan on 15/6/29.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (Tools)

// 旋转拍照后的图片 autorelease
+ (UIImage *)rotateImage:(UIImage *)image oritation:(UIImageOrientation)theOritation;

// 接收和发送的图片在保存缩略图时，最长边不超过120，若有超过的均压缩至最长边为120。但显示时，最长边大小为120，此方法用来将缩略图的图片长宽，换算成显示的长和宽。
+ (CGSize)sizeScaleFixedThumbnailImageSize:(CGSize)sourceImageSize;

// 把image缩放到给定的size
+ (UIImage *)scaleImage:(UIImage *)sourceImage toSize:(CGSize)imageSize;

// 根据颜色生成纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// 生成MMS缩略图并进行等比例缩放，根据最小边缩小或放大到120
+ (UIImage *)thumbnailScaleForMMSImage:(UIImage *)sourceImage;

// 生成Moment缩略图并进行等比例缩放，宽度小于180的，返回原图；大于180，宽度小于564的，宽度缩放到180；宽度大于564，宽度缩放到564
+ (UIImage *)thumbnailScaleForMomentImage:(UIImage *)sourceImage;

// 拍照后获取旋转后的照片
+ (UIImage *)getPhotographRotateImage:(id)finishQBPickingMediaWithInfo;

// 根据最大边的尺寸进行等比例缩放原图
+ (UIImage *)scaleFixedSizeForImage:(UIImage *)sourceImage;

// 保存图片到文件
+ (void)dynamicCompressImageAndWriteToFile:(UIImage *)imageSource withFilePath:(NSString *)filePath;

// 根据asset中的图像数据生成一个图像的缩略图
+ (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size;

// 传入asset的图像宽高比是否比aspectRatio大，根据返回的结果进行图片处理
+ (BOOL)isMoreThanAspectRatio:(NSInteger)aspectRatio forAsset:(ALAsset *)asset;

+ (UIImage *)croppedImage:(UIImage *)sourceImage withRect:(CGRect)bounds;

+ (CGSize)scaleSizeFrom:(CGSize)resSize withMaxLength:(int)maxLength;
@end
