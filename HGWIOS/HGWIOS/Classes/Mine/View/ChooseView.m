//
//  ChooseView.m
//  HGWIOS
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ChooseView.h"
#import "YZTagList.h"
@implementation ChooseView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseClick)]];
    
    
    UIButton * chooseButton = [[UIButton alloc]init];
    [chooseButton setTitle:@"选择" forState:UIControlStateNormal];
    [chooseButton addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    chooseButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    //XXJColor(27, 69, 138)
    [chooseButton setTitleColor:XXJColor(116, 116, 116) forState:UIControlStateNormal];
    [chooseButton setImage:[UIImage imageNamed:@"cargo_ship_xq_03"] forState:UIControlStateNormal];
    [chooseButton sizeToFit];
    [chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [chooseButton sizeToFit];
    [self addSubview:chooseButton];
    [chooseButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(20));
        make.top.equalTo(self).offset(realH(20));
    }];
    self.chooseButton = chooseButton;
    
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    [self addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(chooseButton.bottom).offset(realH(20));
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(80));
    }];
    self.scrollView = scrollView;
    
    UIButton * typeButton = [[UIButton alloc]init];
    typeButton.alpha = 0;
//    typeButton.titleLabel.numberOfLines = 0;
    [typeButton setTitle:@"" forState:UIControlStateNormal];
    [typeButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    typeButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [typeButton setTitleColor:XXJColor(116, 116, 116) forState:UIControlStateNormal];
    [typeButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [typeButton sizeToFit];
    [scrollView addSubview:typeButton];
    [typeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.top.equalTo(scrollView).offset(realH(20));
        make.width.equalTo(SCREEN_WIDTH/3 - realW(5));
//        make.height.equalTo(realH(68));
    }];
    self.typeButton = typeButton;
    
    UILabel * douhaoLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@","];
//    douhaoLable.alpha = 0;
    [douhaoLable sizeToFit];
    [scrollView addSubview:douhaoLable];
    [douhaoLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeButton.right);
        make.centerY.equalTo(typeButton).offset(realH(-10));
    }];
    self.douhaoLable = douhaoLable;
    
    UIButton * typeButton1 = [[UIButton alloc]init];
//    typeButton1.titleLabel.numberOfLines = 0;
    typeButton1.alpha = 0;
    [typeButton1 setTitle:@"" forState:UIControlStateNormal];
    [typeButton1 addTarget:self action:@selector(deleteClick1) forControlEvents:UIControlEventTouchUpInside];
    typeButton1.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [typeButton1 setTitleColor:XXJColor(116, 116, 116) forState:UIControlStateNormal];
    [typeButton1 setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [typeButton1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [typeButton1 sizeToFit];
    [scrollView addSubview:typeButton1];
    [typeButton1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeButton.right).offset(realW(20));
        make.top.equalTo(scrollView).offset(realH(20));
        make.width.equalTo(SCREEN_WIDTH/3 - realW(5));
//        make.height.equalTo(realH(68));
    }];
    self.typeButton1 = typeButton1;
    
    UILabel * douhaoLable1 = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@","];
//    douhaoLable1.alpha = 0;
    [douhaoLable1 sizeToFit];
    [scrollView addSubview:douhaoLable1];
    [douhaoLable1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeButton1.right);
        make.centerY.equalTo(typeButton1).offset(realH(-10));
    }];
    self.douhaoLable1 = douhaoLable1;
    
    UIButton * typeButton2 = [[UIButton alloc]init];
//    typeButton2.titleLabel.numberOfLines = 0;
    typeButton2.alpha = 0;
    [typeButton2 setTitle:@"" forState:UIControlStateNormal];
    [typeButton2 addTarget:self action:@selector(deleteClick2) forControlEvents:UIControlEventTouchUpInside];
    typeButton2.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [typeButton2 setTitleColor:XXJColor(116, 116, 116) forState:UIControlStateNormal];
    [typeButton2 setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [typeButton2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [typeButton2 sizeToFit];
    [scrollView addSubview:typeButton2];
    [typeButton2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeButton1.right).offset(realW(20));
        make.top.equalTo(scrollView.top).offset(realH(20));
        make.width.equalTo(SCREEN_WIDTH/3 - realW(5));
//        make.height.equalTo(realH(68));
    }];
    self.typeButton2 = typeButton2;
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha= 0.5;
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(SCREEN_WIDTH - realW(40));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(realH(-1));
        make.height.equalTo(realH(1));
    }];
}

-(void)chooseClick
{
    if (self.emptyChooseBlock) {
        self.emptyChooseBlock();
    }
}

-(void)deleteClick
{
    if (self.emptyDeleteBlock) {
        self.emptyDeleteBlock(@"0");
    }
}

-(void)deleteClick1
{
    if (self.emptyDeleteBlock) {
        self.emptyDeleteBlock(@"1");
    }
}
-(void)deleteClick2
{
    if (self.emptyDeleteBlock) {
        self.emptyDeleteBlock(@"2");
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetMaxX(self.typeButton2.frame), 0)];
}


@end
