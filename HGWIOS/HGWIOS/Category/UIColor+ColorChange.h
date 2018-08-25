//
//  UIColor+ColorChange.h
//  新疆行
//
//  Created by 田宇 on 17/7/4.
//  Copyright © 2017年 田宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
