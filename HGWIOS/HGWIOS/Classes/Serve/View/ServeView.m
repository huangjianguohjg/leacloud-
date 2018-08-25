//
//  ServeView.m
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ServeView.h"

@implementation ServeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setUpUI];
    }
    return self;
}


-(void)setTitleArray:(NSArray *)titleArray ImageArray:(NSArray *)imageArray Title:(NSString *)title
{
    
    UILabel * titleLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:title];
    [titleLable sizeToFit];
    [self addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.top).offset(realH(44));
    }];
    
    UIView * firstLineView = [[UIView alloc]init];
    firstLineView.alpha = 0.4;
    firstLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:firstLineView];
    [firstLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(realH(88));
        make.left.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, realH(1)));
    }];
    
    UIView * secondLineView = [[UIView alloc]init];
    secondLineView.alpha = 0.4;
    secondLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:secondLineView];
    [secondLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(realH(88) + SCREEN_WIDTH / 4);
        make.left.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, realH(1)));
    }];
    
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton * button = [[UIButton alloc]init];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:realW(40)];
        [self addSubview:button];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo((SCREEN_WIDTH / 4) * (i % 4 ));
            make.top.equalTo((SCREEN_WIDTH / 4) * (i / 4) + realH(88));
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 4, SCREEN_WIDTH / 4));
        }];
        
    }
    
    for (NSInteger i = 0; i < 8; i++)
    {
        UIView * lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.alpha = 0.4;
        [self addSubview:lineView];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(1), SCREEN_WIDTH / 4 - realH(40)));
            make.top.equalTo(self.top).offset((SCREEN_WIDTH / 4) * (i / 4) + realH(88) + realH(20));
            make.left.equalTo(self).offset((SCREEN_WIDTH / 4) * (i % 4));
        }];
    }
    
}



-(void)buttonClick:(UIButton *)button
{
    if (self.serveButtonBlock) {
        self.serveButtonBlock(button.currentTitle);
    }
}


@end
