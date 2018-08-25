//
//  NullContentView.m
//  haoyunhl
//
//  Created by lianghy on 16/8/30.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "NullContentView.h"
#import "CommonFontColorStyle.h"
#import "CommonDimensStyle.h"
#import "UIView+GJCFViewFrameUitil.h"
#import "GJCFStringUitil.h"
@implementation NullContentView

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle EBF0F6Color];
        int picWidth = 120;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - picWidth)/2 , 100 , picWidth, 80)];
        self.imageView.image = [UIImage imageNamed:@"common_icon_nodata"];
        [self addSubview: self.imageView];
        
        if (![GJCFStringUitil stringIsNull:title]) {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.gjcf_bottom+10, self.frame.size.width, 15)];
            titleLabel.text = title;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [CommonFontColorStyle NormalSizeFont];
            titleLabel.textColor = [CommonFontColorStyle B8CA0Color];
            [self addSubview: titleLabel];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)name Title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle WhiteColor];
        int picWidth = 120;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - picWidth)/2 , 100 , picWidth, 80)];
        self.imageView.image = [UIImage imageNamed:name];
        [self addSubview: self.imageView];
        
        if (![GJCFStringUitil stringIsNull:title]) {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.gjcf_bottom, self.frame.size.width, 15)];
            titleLabel.text = title;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [CommonFontColorStyle NormalSizeFont];
            titleLabel.textColor = [CommonFontColorStyle B8CA0Color];
            [self addSubview: titleLabel];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)name Top:(int)top Width:(int)width Height:(int)height Title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle WhiteColor];
        int picWidth = width;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - picWidth)/2 , top , picWidth, height)];
        self.imageView.image = [UIImage imageNamed:name];
        [self addSubview: self.imageView];
        
        if (![GJCFStringUitil stringIsNull:title]) {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.gjcf_bottom, self.frame.size.width, 15)];
            titleLabel.text = title;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [CommonFontColorStyle NormalSizeFont];
            titleLabel.textColor = [CommonFontColorStyle B8CA0Color];
            [self addSubview: titleLabel];
        }
    }
    return self;
}

@end
