//
//  CommonDimensStyle.h
//  haoyunhl
//
//  Created by lianghy on 16/1/13.
//  Copyright © 2016年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

@interface CommonDimensStyle : NSObject
//屏幕宽度
+ (int)screenWidth;
//屏幕高度
+ (int)screenHeight;
//普通输入框高度
+ (int)inputHeight;
//普通输入框内部图片高度
+ (int)inputImgHeight;
//普通输入框内部图片边距
+ (int)inputImgMargin;
//普通边距
+ (int)normalMargin;
//小边距
+ (int)smallMargin;
//上边距
+ (int)topMargin;
//小圆角
+ (int)smallCornerRadius;
//按钮高度
+ (int)btHeight;
//普通行高度
+ (int)normaRowlHeight;
//普通行高度
+ (int)normalMenuHeight;
//普通行高度
+ (int)newMenuHeight;
//普通圆角
+ (int)normalCornerRadius;
//超级间距
+ (int)superMargin;
@end
