//
//  RecommendBottomView.m
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "RecommendBottomView.h"

@interface RecommendBottomView()

@property (nonatomic, weak) UILabel * titleLable;

@property (nonatomic, weak) UILabel * detailLable;

@property (nonatomic, weak) UIButton * findButton;



@end

@implementation RecommendBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = XXJColor(242, 242, 242);
        
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    UIImageView * topImageView = [[UIImageView alloc]init];
    [topImageView setImage:[UIImage imageNamed:@"cargo_ship_k_"]];
    [self addSubview:topImageView];
    [topImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(realH(80));
        make.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(realW(100), realH(100)));
    }];
    
    UILabel * titleLable = [UILabel lableWithTextColor:XXJColor(99, 99, 99) textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"没有符合条件的货盘"];
    [titleLable sizeToFit];
    [self addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.bottom).offset(realH(50));
        make.centerX.equalTo(self);
    }];
    self.titleLable = titleLable;
    
    UILabel * detailLable = [UILabel lableWithTextColor:XXJColor(163, 163, 163) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"现在就去找货吧"];
    [detailLable sizeToFit];
    [self addSubview:detailLable];
    [detailLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.bottom).offset(realH(30));
        make.centerX.equalTo(self);
    }];
    self.detailLable = detailLable;
    
    
    UIButton * findButton = [[UIButton alloc]init];
    [findButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [findButton setTitle:@"现在去找货" forState:UIControlStateNormal];
    [findButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    findButton.layer.cornerRadius = realW(10);
    findButton.clipsToBounds = YES;
    findButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(36)];
    findButton.backgroundColor = XXJColor(29, 71, 137);
    [self addSubview:findButton];
    [findButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(detailLable.bottom).offset(realH(40));
        make.size.equalTo(CGSizeMake(realW(250), realH(80)));
        
    }];
    self.findButton = findButton;
    
    
}

-(void)changeTitle:(NSString *)title DetailTitle:(NSString *)detailTitle ButtonTitle:(NSString *)buttonTitle
{
    self.titleLable.text = title;
    
    self.detailLable.text = detailTitle;
    
    [self.findButton setTitle:buttonTitle forState:UIControlStateNormal];
}



-(void)buttonClick
{
    if (self.recommendFindBlock) {
        self.recommendFindBlock();
    }
}


@end
