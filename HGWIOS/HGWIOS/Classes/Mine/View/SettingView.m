//
//  SettingView.m
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "SettingView.h"

@implementation SettingView

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
    UILabel * titleLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"关于我们"];
    [titleLable sizeToFit];
    [self addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(40));
        make.centerY.equalTo(self);
    }];
    self.titleLable = titleLable;
    
    UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow01_gray"]];
    [arrowImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
    arrowImageView.alpha = 0;
    [self addSubview:arrowImageView];
    [arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-40));
        make.centerY.equalTo(self);
    }];
    self.arrowImageView = arrowImageView;
    
    UILabel * versionsLable = [UILabel lableWithTextColor:[UIColor lightGrayColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"2.2.1"];
    versionsLable.alpha = 0;
    [versionsLable sizeToFit];
    [self addSubview:versionsLable];
    [versionsLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-40));
        make.centerY.equalTo(self);
    }];
    self.versionsLable = versionsLable;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.4;
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(realH(-1));
        make.height.equalTo(realH(1));
    }];
    
}



-(void)tapClick
{
    if (self.setBlock) {
        self.setBlock();
    }
}

















@end
