//
//  UIImage+SCImage.m
//  SCGoJD


#import "UIImage+SCImage.h"

@implementation UIImage (SCImage)

+ (instancetype)originalImageNamed:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)stretchableImageNamed:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5
                                      topCapHeight:image.size.height * 0.5];
}

@end
