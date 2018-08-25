//
//  WebBottomView.m
//  HGWIOS
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "WebBottomView.h"

@implementation WebBottomView

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
    UIButton * backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"前"] forState:UIControlStateNormal];
    [self addSubview:backButton];
    [backButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(40));
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(realW(50), realH(50)));
    }];
    self.backButton = backButton;
    
    UIButton * goButton = [[UIButton alloc]init];
    [goButton addTarget:self action:@selector(goClick) forControlEvents:UIControlEventTouchUpInside];
    [goButton setImage:[UIImage imageNamed:@"后"] forState:UIControlStateNormal];
    [self addSubview:goButton];
    [goButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backButton.right).offset(realW(40));
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(realW(50), realH(50)));
    }];
    self.goButton = goButton;
}


-(void)backClick
{
    self.webBlock(@"返回");
}

-(void)goClick
{
    self.webBlock(@"前进");
}
















@end
