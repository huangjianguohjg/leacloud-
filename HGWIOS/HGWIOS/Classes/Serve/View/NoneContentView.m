//
//  NoneContentView.m
//  haoyunhl
//
//  Created by lianghy on 16/7/28.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "NoneContentView.h"
#import "CommonFontColorStyle.h"
#import "CommonDimensStyle.h"
#import "UIView+GJCFViewFrameUitil.h"
@implementation NoneContentView


- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle WhiteColor];
        int picWidth = 225;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - picWidth)/2 , 100 , picWidth, 170)];
        self.imageView.image = [UIImage imageNamed:name];
        [self addSubview: self.imageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)name Top:(int)top
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle WhiteColor];
        int picWidth = 225;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - picWidth)/2 , top , picWidth, 170)];
        self.imageView.image = [UIImage imageNamed:name];
        [self addSubview: self.imageView];
    }
    return self;
}

@end
