//
//  ScoreView.m
//  HGWIOS
//
//  Created by mac on 2018/6/9.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ScoreView.h"

@implementation ScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = XXJColor(249, 249, 249);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(20));
        make.centerY.equalTo(self);
        make.height.equalTo(realH(80));
        make.width.equalTo(realW(80));
    }];
    self.imageView = imageView;
    
    
    
    
    UILabel * leftLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"船舶名称"];
    [leftLable sizeToFit];
    [self addSubview:leftLable];
    [leftLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.right).offset(realW(20));
        make.centerY.equalTo(self);
    }];
    self.leftLable = leftLable;
    
    UIButton * chooseButton = [[UIButton alloc]init];
    [chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    chooseButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [chooseButton addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
    chooseButton.userInteractionEnabled = NO;
    [chooseButton setImage:[UIImage imageNamed:@"cargo_ship_xq_03"] forState:UIControlStateNormal];
    [chooseButton sizeToFit];
    [self addSubview:chooseButton];
    [chooseButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.chooseButton = chooseButton;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(237, 237, 237);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-20));
        make.left.equalTo(self).offset(realW(20));
        make.height.equalTo(realH(1));
        make.bottom.equalTo(self);
    }];
}


-(void)chooseClick:(UIButton *)button
{
    if (self.scoreBlock) {
        self.scoreBlock(button.currentTitle);
    }
}







@end
