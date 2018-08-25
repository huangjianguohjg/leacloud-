//
//  TopView.m
//  HGWIOS
//
//  Created by 许小军 on 2018/5/14.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "TopView.h"

@interface TopView()



@property (nonatomic, weak) UIButton * rightButton;

@end

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(realW(1), realH(100)));
    }];
    
    
    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton setTitle:_title forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"arrow04_gray"] forState:UIControlStateNormal];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(20)];
    [leftButton sizeToFit];
    [self addSubview:leftButton];
    [leftButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(-SCREEN_WIDTH / 4);
        make.centerY.equalTo(self);
    }];
    self.leftButton = leftButton;
    
    
    UIButton * rightButton = [[UIButton alloc]init];
    [rightButton setTitle:@"筛选" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"arrow04_gray"] forState:UIControlStateNormal];
    [rightButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [rightButton sizeToFit];
    [self addSubview:rightButton];
    [rightButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(SCREEN_WIDTH / 4);
        make.centerY.equalTo(self);
    }];
    self.rightButton = rightButton;
    
    
    UIView * leftView = [[UIView alloc]init];
    [leftView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftClick)]];
    leftView.backgroundColor = [UIColor clearColor];
    [self addSubview:leftView];
    [leftView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.equalTo(SCREEN_WIDTH / 2);
    }];
    
    UIView * rightView = [[UIView alloc]init];
    [rightView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightClick)]];
    rightView.backgroundColor = [UIColor clearColor];
    [self addSubview:rightView];
    [rightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(SCREEN_WIDTH / 2);
    }];
    
    UIView * lineView1 = [[UIView alloc]init];
    lineView1.alpha = 0;
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView1];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, realH(1)));
    }];
    
    
}

-(void)setTitle:(NSString *)title
{
    _title = title;

    [self setUpUI];
}

-(void)changeTitle:(NSString *)title
{
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
}


-(void)leftClick
{
    if (self.topblock) {
        self.topblock(self.leftButton.currentTitle);
    }
}

-(void)rightClick
{
    if (self.topblock) {
        self.topblock(self.rightButton.currentTitle);
    }
}





@end
