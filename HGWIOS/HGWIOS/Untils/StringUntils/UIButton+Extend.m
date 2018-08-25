//
//  UIButton+Extend.m
//  haoyunhl
//
//  Created by lianghy on 16/3/12.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "UIButton+Extend.h"
#import "CommonFontColorStyle.h"
#import "UIImage+Extend.h"
#import "CommonDimensStyle.h"
@implementation UIButton(Extend)


+(UIButton *)getNormalButton:(NSString *)value X:(int)x Y:(int)y Width:(int)width Height:(int)height type:(int)type{
    UIButton *normalButton = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    if (type == 0) {
        [normalButton setBackgroundImage: [UIImage singleColorImage:[CommonFontColorStyle BlueColor] Width:width Height:height] forState:UIControlStateNormal];
        [normalButton setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    }else{
        [normalButton setBackgroundImage: [UIImage singleColorImage:[CommonFontColorStyle colorFromHexString:@"e5eaf0"] Width:width Height:height] forState:UIControlStateNormal];
        [normalButton setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
    }
    
    normalButton.layer.cornerRadius = [CommonDimensStyle normalCornerRadius];
    [normalButton setTitle:value forState:UIControlStateNormal];
    normalButton.titleLabel.font = [CommonFontColorStyle ButtonTextFont];
    return normalButton;
}

@end
