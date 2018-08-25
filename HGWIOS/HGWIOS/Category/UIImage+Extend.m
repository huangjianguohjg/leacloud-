//
//  UIImage+Extend.m
//  haoyunhl
//
//  Created by lianghy on 16/3/5.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation  UIImage(Extend)


-(UIImage*) scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

+(UIImage *) singleColorImage:(UIColor *)uicolor Width:(int)width Height:(int)height{
    CGSize imageSize = CGSizeMake(width, height);
    CGRect imageFrame = CGRectMake(0., 0., width , height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [uicolor set];
    
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:5] addClip];
//    [self drawInRect:imageFrame];
    
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    

    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+(UIImage *) singleColorImageRect:(UIColor *)uicolor Width:(int)width Height:(int)height{
    CGSize imageSize = CGSizeMake(width, height);
    CGRect imageFrame = CGRectMake(0., 0., width , height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [uicolor set];
    
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:0] addClip];
    //    [self drawInRect:imageFrame];
    
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+(UIImage *) singleColorImageCircle:(UIColor *)uicolor Width:(int)width{
    CGSize imageSize = CGSizeMake(width, width);
    CGRect imageFrame = CGRectMake(0., 0., width , width);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [uicolor set];
    
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:width/2] addClip];
    //    [self drawInRect:imageFrame];
    
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+(UIImage *) singleColorBottomCircleImage:(UIColor *)uicolor Width:(int)width Height:(int)height{
    CGSize imageSize = CGSizeMake(width, height);
    CGRect imageFrame = CGRectMake(0., 0., width , height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [uicolor set];
    
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)] addClip];
    
//    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:0] addClip];
    //    [self drawInRect:imageFrame];
    
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+(UIImage *) singleColorImage:(UIColor *)uicolor Width:(int)width Height:(int)height Circle:(int)circle{
    CGSize imageSize = CGSizeMake(width, height);
    CGRect imageFrame = CGRectMake(0., 0., width , height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [uicolor set];
    
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:circle] addClip];
    //    [self drawInRect:imageFrame];
    
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+(UIImage *)scaleToTargetSize:(UIImage *)image{
    CGSize oldSize = image.size;
    int maxlength = 920;
    if (oldSize.width > maxlength || oldSize.height > maxlength) {
        if (oldSize.width > oldSize.height) {
         return  [image scaleToSize:CGSizeMake(maxlength, oldSize.height * maxlength / oldSize.width)];
        }else{
          //  oldSize.width * 1080 / oldSize.height
          return [image scaleToSize:CGSizeMake(oldSize.width * maxlength / oldSize.height,maxlength)];
        
        }
        
    }
    return image;
    
}
@end
