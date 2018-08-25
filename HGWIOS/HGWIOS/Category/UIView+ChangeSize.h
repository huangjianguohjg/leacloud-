//
//  UIView+ChangeSize.h
//  ContactExercise
//
//  Created by 123 on 14/12/31.
//  Copyright (c) 2014年 QYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
//当前设备的宽和320的比例
#define WRATIO [UIScreen mainScreen].bounds.size.width/375

//当前设备的高和480的比例
#define HRATIO [UIScreen mainScreen].bounds.size.height/667
#define XHRATIO [UIScreen mainScreen].bounds.size.height/812

@interface UIView (ChangeSize)

@property (nonatomic, assign) CGFloat xxj_x;
@property (nonatomic, assign) CGFloat xxj_y;
@property (nonatomic, assign) CGFloat xxj_centerX;
@property (nonatomic, assign) CGFloat xxj_centerY;
@property (nonatomic, assign) CGFloat xxj_width;
@property (nonatomic, assign) CGFloat xxj_height;

@property (nonatomic, assign) CGSize size;

+(float)setWidth:(float)width;
+(float)setHeight:(float)height;
+(CGRect)setFrame:(CGRect)frame;

@end
