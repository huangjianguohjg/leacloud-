//
//  BoatDeatilBottomView.m
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BoatDeatilBottomView.h"

@implementation BoatDeatilBottomView

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
    self.backgroundColor = XXJColor(242, 242, 242);
    
    UIButton * locationButton = [[UIButton alloc]init];
    [locationButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [locationButton setTitle:@"定位船舶" forState:UIControlStateNormal];
    [locationButton setTitleColor:XXJColor(92, 149, 209) forState:UIControlStateNormal];
    locationButton.backgroundColor = XXJColor(230, 239, 247);
    locationButton.layer.cornerRadius = 5;
    locationButton.clipsToBounds = YES;
    locationButton.layer.borderWidth = realW(1);
    locationButton.layer.borderColor = XXJColor(94, 150, 198).CGColor;
    locationButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self addSubview:locationButton];
    [locationButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.centerX).offset(realW(-10));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(80))/2, realH(100)));
    }];
    
    
    UIButton * contactButton = [[UIButton alloc]init];
    [contactButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [contactButton setTitle:@"联系船东" forState:UIControlStateNormal];
    [contactButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    contactButton.backgroundColor = XXJColor(27, 69, 138);
    contactButton.layer.cornerRadius = 5;
    contactButton.clipsToBounds = YES;
//    contactButton.layer.borderWidth = realW(1);
//    contactButton.layer.borderColor = XXJColor(94, 150, 198).CGColor;
    contactButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self addSubview:contactButton];
    [contactButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.centerX).offset(realW(10));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(80))/2 , realH(100)));
    }];
    
}



-(void)buttonClick:(UIButton *)button
{
    if (self.detailBlock) {
        self.detailBlock(button.currentTitle);
    }
}












@end
