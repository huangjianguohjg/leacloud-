//
//  CommonDimensStyle.m
//  haoyunhl
//
//  Created by lianghy on 16/1/13.
//  Copyright © 2016年 ZYProSoft. All rights reserved.
//

#import "CommonDimensStyle.h"

@implementation CommonDimensStyle
+ (int)screenWidth{
    return  [UIScreen mainScreen].bounds.size.width;
}
+ (int)screenHeight{
    return  [UIScreen mainScreen].bounds.size.height;
}
+ (int)inputHeight{
    return  45;
}
//普通边距
+ (int)normalMargin{
    return  20;
}
//小边距
+ (int)smallMargin{
    return  10;
}
//普通输入框内部图片高度
+ (int)inputImgHeight{
    return  [CommonDimensStyle inputHeight]-[CommonDimensStyle inputImgMargin]*2;
}
//普通输入框内部图片边距
+ (int)inputImgMargin{
    return  12;
}
//上边距
+ (int)topMargin{
    return  20;
}

//小圆角
+ (int)smallCornerRadius{
    return  5;
}

//按钮高度
+ (int)btHeight{
    return  50;
}
//普通行高度
+ (int)normaRowlHeight{
    return  45;
}
+ (int)normalMenuHeight{
    return  60;
}
+ (int)normalCornerRadius{
    return  5;
}
+ (int)superMargin{
    return  40;
}
//普通行高度
+ (int)newMenuHeight{
    return  53;
}
@end
