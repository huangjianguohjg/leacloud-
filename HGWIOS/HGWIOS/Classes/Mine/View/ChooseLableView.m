//
//  ChooseLableView.m
//  HGWIOS
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ChooseLableView.h"

@implementation ChooseLableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    UILabel * contentLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@""];
    contentLable.numberOfLines = 0;
    [contentLable sizeToFit];
    [self addSubview:contentLable];
    [contentLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(SCREEN_WIDTH / 3 - realW(5) - realW(72));
        make.bottom.equalTo(self);
    }];
    self.contentLable = contentLable;
    
    UIImageView * closeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"关闭"]];
    [self addSubview:closeImageView];
    [closeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(contentLable.right);
    }];
    
    
}











@end
