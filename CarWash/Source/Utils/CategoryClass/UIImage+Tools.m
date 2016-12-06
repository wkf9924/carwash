//
//  UIImage+Tools.m
//  BATeacher
//
//  Created by ivan on 15/6/29.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import "UIImage+Tools.h"
#import "DefineConstant.h"
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import "DefineSize.h"
#import "BZDefine.h"

@implementation UIImage (Tools)


#pragma mark -
#pragma mark Image Operate Function

// 旋转拍照后的图片
+ (UIImage *)rotateImage:(UIImage *)image oritation:(UIImageOrientation)theOritation
{
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = (CGFloat)bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef),
                                  CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    
    switch(theOritation) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width,
                                                         imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height,
                                                         imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (theOritation == UIImageOrientationRight || theOritation ==
        UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

// 接受和发送的图片在保存缩略图时，最长边不超过120，若有超过的均压缩至最长边为120。但显示时，最长边大小为120，此方法用来将缩略图的图片长宽，换算成显示的长和宽。
+ (CGSize)sizeScaleFixedThumbnailImageSize:(CGSize)sourceImageSize
{
    int imageHeight = sourceImageSize.height;
    int imageWidth = sourceImageSize.width;
    float rate = 0.0;
    
    float scaleSideLongestLength = MMS_THUMBNAIL_SCALE_LENGTH_120;
    float scaleSideShortestLength = MMS_THUMBNAIL_SHORTEST_LENGTH_43;
    
    if ((imageWidth > scaleSideLongestLength) || (imageHeight > scaleSideLongestLength))
    {
        if (imageWidth > imageHeight)
        {
            rate = scaleSideLongestLength / imageWidth;
            imageWidth = scaleSideLongestLength;
            imageHeight = imageHeight * rate;
        }
        else {
            rate = scaleSideLongestLength / imageHeight;
            imageHeight = scaleSideLongestLength;
            imageWidth = imageWidth * rate;
        }
    }
    
    imageHeight = (imageHeight < scaleSideShortestLength) ? scaleSideShortestLength : imageHeight;
    imageWidth = (imageWidth < scaleSideShortestLength) ? scaleSideShortestLength : imageWidth;
    
    return CGSizeMake(imageWidth, imageHeight);
}

// 把image缩放到给定的size
+ (UIImage *)scaleImage:(UIImage *)sourceImage toSize:(CGSize)imageSize
{
    UIGraphicsBeginImageContext(CGSizeMake(imageSize.width, imageSize.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    [sourceImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 根据颜色生成纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 生成MMS缩略图并进行等比例缩放，根据最小边缩小或放大到120
+ (UIImage *)thumbnailScaleForMMSImage:(UIImage *)sourceImage
{
    // 获取当前图片宽高
    float width = sourceImage.size.width;
    float height = sourceImage.size.height;
    float rate = 0.0;
    
    // MMS缩略图缩放时最长边的长度-120
    float scaleSideLength = MMS_THUMBNAIL_SCALE_LENGTH_120;
    
    BOOL bScale = NO;
    UIImage* scaledImage = sourceImage;
    
    // 根据最短边是否大于120，如果大于等于则进行=120等比例缩放
    if (height > width && width > scaleSideLength) {
        rate = scaleSideLength / width;
        
        height = height * rate;
        width = scaleSideLength;
        
        bScale = YES;
    }
    else if (width > height && height > scaleSideLength) {
        rate = scaleSideLength / height;
        
        width = width * rate;
        height = scaleSideLength;
        
        bScale = YES;
    }
    
    // 需要等比例缩放
    if (bScale) {
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, width, height));
        
        [sourceImage drawInRect:CGRectMake(0, 0, width, height)];
        scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSLog(@"DEBUG: thumbnailScaleForMMSImage - drawInRect(0, 0, width = %f, height = %f), scaleSideLength = %f", width, height, scaleSideLength);
    }
    
    return scaledImage;
}

+ (UIImage *)thumbnailScaleForMomentImage:(UIImage *)sourceImage
{
    CGFloat scaleSideLength = BZSCreenWidth;
    
    CGFloat srcImageWidth = sourceImage.size.width;
    CGFloat srcImageHeight = sourceImage.size.height;
    
    if (srcImageWidth < scaleSideLength && srcImageHeight < scaleSideLength)
    {
        return sourceImage;
    }
    
    // 宽高比
    CGFloat aspectRatio = srcImageWidth/srcImageHeight;
    // 新截取的图
    UIImage* newSourceImage = nil;
    
    if (aspectRatio>(5.0/2.0) || aspectRatio <(2.0/5.0))
    {
        CGFloat coordinateX = 0;
        CGFloat coordinateY = 0;
        // aspectRatio > 1  宽图，否则是长图
        if(aspectRatio > 1)
        {
            srcImageWidth = srcImageHeight*(5.0/2.0);
            coordinateX = (sourceImage.size.width - srcImageWidth)/2.0;
        }
        else
        {
            // 长图
            srcImageHeight = srcImageWidth*(5.0/2.0);
            coordinateY = (sourceImage.size.height - srcImageHeight)/2.0;
        }
        
        // 原图中截取矩形框
        CGRect rect = CGRectMake(coordinateX, coordinateY, srcImageWidth, srcImageHeight);//创建矩形框
        CGImageRef cgImage = CGImageCreateWithImageInRect([sourceImage CGImage], rect);
        if (cgImage)
        {
            newSourceImage = [UIImage imageWithCGImage:cgImage];
            CFRelease(cgImage);
        }
    }
    else
    {
        // 原图
        newSourceImage = sourceImage;
    }
    
    // 按照高度进行缩放
    if (srcImageHeight > scaleSideLength)
    {
        aspectRatio = scaleSideLength / srcImageHeight;
        
        srcImageHeight = scaleSideLength;
        srcImageWidth = srcImageWidth * aspectRatio;
    }
    
    // 按照宽度进行缩放
    if (srcImageWidth > scaleSideLength)
    {
        aspectRatio = scaleSideLength / srcImageWidth;
        
        srcImageWidth = scaleSideLength;
        srcImageHeight = srcImageHeight * aspectRatio;
    }
    
    // 缩放图片
    UIGraphicsBeginImageContext(CGSizeMake(srcImageWidth, srcImageHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    UIRectFill(CGRectMake(0, 0, srcImageWidth, srcImageHeight));
    [newSourceImage drawInRect:CGRectMake(0, 0, srcImageWidth, srcImageHeight)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

// 获取拍照后经过旋转的图片对象
+ (UIImage *)getPhotographRotateImage:(id)finishQBPickingMediaWithInfo
{
    if (finishQBPickingMediaWithInfo == nil) {
        return nil;
    }
    
    BOOL bValid = NO;
    UIImage *rotateImage = nil;
    
    if ([[finishQBPickingMediaWithInfo objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"ALAssetTypePhoto"])
    {
        bValid = YES;
    }
    else if ([[finishQBPickingMediaWithInfo objectForKey:UIImagePickerControllerMediaType] isEqualToString:PUBLIC_IMAGE])
    {
        bValid = YES;
    }
    
    if (bValid) {
        // 获取当前摄像图片
        rotateImage = [finishQBPickingMediaWithInfo objectForKey:UIImagePickerControllerOriginalImage];
        
        // 旋转图片的方向
        switch (rotateImage.imageOrientation)
        {
            case UIImageOrientationUp:
                break;
            case UIImageOrientationDown:
            {
                rotateImage = [UIImage rotateImage:rotateImage oritation: UIImageOrientationDown];
            }
                break;
            case UIImageOrientationLeft:
            {
                rotateImage = [UIImage rotateImage:rotateImage oritation: UIImageOrientationLeft];
            }
                break;
            case UIImageOrientationRight:
            {
                rotateImage = [UIImage rotateImage:rotateImage oritation: UIImageOrientationRight];
            }
                break;
            default:
                break;
        }
    }
    
    return rotateImage;
}

// 根据最端边的尺寸进行等比例缩放原图
+ (UIImage *)scaleFixedSizeForImage:(UIImage *)sourceImage
{
    // 获取当前图片宽高
    float width = sourceImage.size.width;
    float height = sourceImage.size.height;
    float rate = 0.0;
    
    // 缩放时最短边的长度-720
    float scaleSideLength = IMAGE_SCALE_SHORTEST_LENGTH_720;
    
    BOOL bScale = NO;
    UIImage* scaledImage = sourceImage;
    
    // 根据最短边是否大于720，如果大于等于则进行=720等比例缩放
    if (height > width && width >= scaleSideLength) {
        
        rate = scaleSideLength / width;
        
        width = scaleSideLength;
        height = height * rate;
        
        bScale = YES;
    }
    else if (width > height && height >= scaleSideLength)
    {
        
        rate = scaleSideLength / height;
        
        height = scaleSideLength;
        width = width * rate;
        
        bScale = YES;
    }
    
    // 如果需要做等比例缩放则执行屏幕绘制
    if (bScale)
    {
        // UIGraphicsBeginImageContextWithOptions(CGSize size: 图片尺寸,
        // BOOL opaque: 是否设置为透明,
        // CGFloat scale: 图片缩放比（0.0则为当前手机屏幕缩放比-iPhone4~6为2倍，iPhone6+为3倍，1.0原始图片不变，2.0为固定两倍的缩放比）)
        
        //We prepare a bitmap with the new size
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), YES, 1.0);
        
        //Draws a rect for the image
        [sourceImage drawInRect:CGRectMake(0, 0, width, height)];
        
        //We set the scaled image from the context
        scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSLog(@"DEBUG: scaleFixedSizeForImage - drawInRect(0, 0, width = %f, height = %f), scaleSideLength = %f", width, height, scaleSideLength);
    }
    
    return scaledImage;
}

// 保存图片到文件
+ (void)dynamicCompressImageAndWriteToFile:(UIImage *)imageSource withFilePath:(NSString *)filePath
{
    NSLog(@"TOOLS: -----dynamicCompressImageAndWriteToFile Algorithm Begin-----");
    @autoreleasepool {
        
        // 根据最大边的尺寸进行等比例缩放原图
        UIImage * scaleFixedImage = [UIImage scaleFixedSizeForImage:imageSource];
        
        // 2. 使用固定0.3比率降低JPEG质量来压缩图片
        float compressionQuality = 0.3;
        
        // 转换JPEG图片进行质量的压缩
        NSData * imageJPEGData = UIImageJPEGRepresentation(scaleFixedImage, compressionQuality);
        
        [imageJPEGData writeToFile:filePath atomically:YES];
    }
    
    NSLog(@"TOOLS: -----dynamicCompressImageAndWriteToFile Algorithm End-----");
}

// Helper methods for thumbnailForAsset:maxPixelSize:
static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count){
    
    static int i = 0; ++i;
    ALAssetRepresentation *rep = (__bridge id)info;
    
    NSError *error = nil;
    
    //    NSLog(@"TOOLS: getAssetbytesCallback %d: off:%lld len:%zu", i, position, count);
    
    size_t countRead = [rep getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
    
    if (countRead == 0 && error) {
        // We have no way of passing this info back to the caller, so we log it, at least.
        NSLog(@"TOOLS: getAssetbytesCallback got an error reading an asset: %@", error);
    }
    
    return countRead;
}

// Returns a UIImage for the given asset, with size length at most the passed size.
// The resulting UIImage will be already rotated to UIImageOrientationUp, so its CGImageRef
// can be used directly without additional rotation handling.
// This is done synchronously, so you should call this method on a background queue/thread.
+ (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size
{
    NSParameterAssert(asset != nil);
    NSParameterAssert(size > 0);
    
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    
    CGDataProviderDirectCallbacks callbacks = {
        .version = 0,
        .getBytePointer = NULL,
        .releaseBytePointer = NULL,
        .getBytesAtPosition = getAssetBytesCallback,
        .releaseInfo = NULL,
    };
    
    CGDataProviderRef provider = CGDataProviderCreateDirect((__bridge void *)(rep), [rep size], &callbacks);
    // 创建原图像ref
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    
    // 使用原图像生成缩略图
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                                                                      (NSString *)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithUnsignedInteger:size],
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                                                                      });
    CFRelease(source);
    CFRelease(provider);
    
    if (!imageRef) {
        return nil;
    }
    
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    
    CFRelease(imageRef);
    
    return toReturn;
}

// 传入asset的图像宽高比是否比aspectRatio大，根据返回的结果进行图片处理
+ (BOOL)isMoreThanAspectRatio:(NSInteger)aspectRatio forAsset:(ALAsset *)asset
{
    NSParameterAssert(asset != nil);
    // 图片的宽高比，大值/小值
    float fRatioHW = 0.0;
    CGSize imageSize = CGSizeZero;
    
    ALAssetRepresentation *alassetRepresention = asset.defaultRepresentation;
    // 图片的分辨率尺寸
    
    imageSize = [alassetRepresention dimensions];
    if (imageSize.width > imageSize.height)
    {
        fRatioHW = imageSize.width / imageSize.height;
    }
    else
    {
        fRatioHW = imageSize.height / imageSize.width;
    }
    
    return (fRatioHW > aspectRatio);
}

// 计算文件大小为带单位的字符串（B、KB、M、G）
+ (NSString *)stringFileSizeWithBytes:(unsigned long)fileSizeBytes
{
    NSString * fileSizeString = @"0 B";
    
    //int fileSizeInt = [byteString intValue];
    if (fileSizeBytes > 0 && fileSizeBytes < 1024)
    {
        fileSizeString = [NSString stringWithFormat:@"0.1KB"];
    }
    else if (fileSizeBytes >= 1024 && fileSizeBytes < pow(1024, 2))
    {
        fileSizeString = [NSString stringWithFormat:@"%.1fKB", (fileSizeBytes / 1024.)];
    }
    else if (fileSizeBytes >= pow(1024, 2) && fileSizeBytes < pow(1024, 3))
    {
        fileSizeString = [NSString stringWithFormat:@"%.1fMB", (fileSizeBytes / pow(1024, 2))];
    }
    else if (fileSizeBytes >= pow(1024, 3))
    {
        fileSizeString = [NSString stringWithFormat:@"%.3fGB", (fileSizeBytes / pow(1024, 3))];
    }
    
    return fileSizeString;
}

+ (UIImage *)croppedImage:(UIImage *)sourceImage withRect:(CGRect)bounds
{
    if (sourceImage == nil) {
        return nil;
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect([sourceImage CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

+ (CGSize)scaleSizeFrom:(CGSize)resSize withMaxLength:(int)maxLength
{
    int width = 0;
    int height = 0;
    if (resSize.width > resSize.height)
    {
        width = maxLength;
        height = (width * resSize.height) / (resSize.width*1.0);
    }
    else
    {
        height = maxLength;
        width = (height * resSize.width) / (resSize.height*1.0);
    }
    CGSize size = CGSizeMake(width, height);
    return size;
}

@end
