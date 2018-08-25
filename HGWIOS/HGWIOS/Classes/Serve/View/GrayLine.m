
//
//  GrayLine.m
//  haoyunhl
//
//  Created by lianghy on 16/1/16.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "GrayLine.h"
#import "CommonDimensStyle.h"
#import "CommonFontColorStyle.h"
@interface GrayLine ()
{
    UIImageView* line;
    int thisWidth;
}
@end
@implementation GrayLine
- (instancetype)initWithFrame:(CGRect)frame {
    thisWidth = frame.size.width;
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Color:(UIColor *)color{
    thisWidth = frame.size.width;
    self = [super initWithFrame:frame];
    if (self) {
       UIImageView* newline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thisWidth, frame.size.height)];
        [newline setBackgroundColor:color];
       [self addSubview: newline];
    }
    return self;
}

- (void)commonInit {
    [self addSubview: self.Line];
    
}

- (UIImageView *)Line {
    if (line == nil) {
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thisWidth, 1)];
        [line setBackgroundColor:[CommonFontColorStyle BackNormalColor] ];
    }
    return line;
}
@end
