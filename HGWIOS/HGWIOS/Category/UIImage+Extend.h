//
//  UIImage+Extend.h
//  haoyunhl
//
//  Created by lianghy on 16/3/5.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  UIImage(Extend)

-(UIImage*) scaleToSize:(CGSize)size;

+(UIImage *) singleColorImage:(UIColor *)uicolor Width:(int)width Height:(int)height;

+(UIImage *) singleColorImage:(UIColor *)uicolor Width:(int)width Height:(int)height Circle:(int)circle;

+(UIImage *) singleColorImageRect:(UIColor *)uicolor Width:(int)width Height:(int)height;

+(UIImage *) singleColorImageCircle:(UIColor *)uicolor Width:(int)width;

+(UIImage *) singleColorBottomCircleImage:(UIColor *)uicolor Width:(int)width Height:(int)height;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

+(UIImage *)scaleToTargetSize:(UIImage *)image;
@end
