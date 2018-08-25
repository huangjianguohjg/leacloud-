//
//  ChooseView1.m
//  HGWIOS
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ChooseView1.h"

#import "ChooseLableView.h"

@interface ChooseView1 ()

@property (nonatomic, assign) CGFloat h1;

@property (nonatomic, assign) CGFloat h2;

@property (nonatomic, assign) CGFloat h3;

@end

@implementation ChooseView1

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
    
    
    
    ChooseLableView * typeLable1 = [[ChooseLableView alloc]init];
    [typeLable1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteTap1)]];
    typeLable1.alpha = 0;
    [self addSubview:typeLable1];
    [typeLable1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
//        make.top.equalTo(chooseButton.bottom).offset(realH(20));
        make.centerY.equalTo(self).offset(realH(20));
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/3 - realW(5), realH(68)));
    }];
    self.typeLable1 = typeLable1;
    
    UILabel * douhaoLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@","];
    [douhaoLable sizeToFit];
    [self addSubview:douhaoLable];
    [douhaoLable makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(SCREEN_WIDTH / 3);
        make.left.equalTo(typeLable1.right);
        make.centerY.equalTo(typeLable1);
    }];
    
    
    
    ChooseLableView * typeLable2 = [[ChooseLableView alloc]init];
    [typeLable2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteTap2)]];
    typeLable2.alpha = 0;
    [self addSubview:typeLable2];
    [typeLable2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(douhaoLable.right);
//        make.top.equalTo(chooseButton.bottom).offset(realH(20));
        make.centerY.equalTo(self).offset(realH(20));
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/3 - realW(5), realH(68)));
    }];
    self.typeLable2 = typeLable2;
    
    UILabel * douhaoLable1 = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@","];
    [douhaoLable1 sizeToFit];
    [self addSubview:douhaoLable1];
    [douhaoLable1 makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset((SCREEN_WIDTH / 3) * 2 + realW(5));
        make.left.equalTo(typeLable2.right);
        make.centerY.equalTo(typeLable2);
    }];
    
    
    ChooseLableView * typeLable3 = [[ChooseLableView alloc]init];
    [typeLable3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteTap3)]];
    typeLable3.alpha = 0;
    [self addSubview:typeLable3];
    [typeLable3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(douhaoLable1.right);
//        make.top.equalTo(chooseButton.bottom).offset(realH(20));
        make.centerY.equalTo(self).offset(realH(20));
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/3 - realW(5), realH(68)));
    }];
    self.typeLable3 = typeLable3;
  
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha= 0.5;
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(SCREEN_WIDTH - realW(40));
        make.centerX.equalTo(self);
//        make.top.equalTo(typeLable3.bottom).offset(realH(20));
        make.bottom.equalTo(self.bottom);
        make.height.equalTo(realH(1));
    }];
    self.lineView = lineView;
    
}



-(void)chooseClick
{
    if (self.emptyChooseBlock) {
        self.emptyChooseBlock();
    }
}


-(void)deleteTap1
{
    if (self.emptyDeleteBlock) {
        self.emptyDeleteBlock(@"1");
    }
}

-(void)deleteTap2
{
    if (self.emptyDeleteBlock) {
        self.emptyDeleteBlock(@"2");
    }
}


-(void)deleteTap3
{
    if (self.emptyDeleteBlock) {
        self.emptyDeleteBlock(@"3");
    }
}



-(void)setLable1:(NSString *)lable1
{
    if (lable1.length > 0) {
        self.typeLable1.alpha = 1;
    }
    else
    {
        self.typeLable1.alpha = 0;
        
        if (self.h2 == 0 && self.h3 == 0) {
            if (self.chooseHeightBlock) {
                self.chooseHeightBlock(34);
            }
        }
        else
        {
            if (self.chooseHeightBlock) {
                self.chooseHeightBlock(self.h2 > self.h3 ? self.h2 : self.h3);
            }
        }
        
        
    }
    
    self.typeLable1.contentLable.text = lable1;
    
    self.h1 = [UILabel getHeightByWidth:SCREEN_WIDTH / 3 - realW(5) - realW(72) title:lable1 font:[UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)]];
    
    [self.typeLable1 updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/3 - realW(5), self.h1));
    }];
    
    if (self.h1 > self.h2 && self.h1 > self.h3) {
//        [self.lineView updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.typeLable1.bottom).offset(realH(20));
//        }];
        if (self.chooseHeightBlock) {
            self.chooseHeightBlock(self.h1 < 34 ? 34 : self.h1);
        }
    }
    
}

-(void)setLable2:(NSString *)lable2
{
    if (lable2.length > 0) {
        self.typeLable2.alpha = 1;
    }
    else
    {
        self.typeLable2.alpha = 0;
        
        if (self.h1 == 0 && self.h3 == 0) {
            if (self.chooseHeightBlock) {
                self.chooseHeightBlock(34);
            }
        }
        else
        {
            if (self.chooseHeightBlock) {
                self.chooseHeightBlock(self.h1 > self.h3 ? self.h1 : self.h3);
            }
        }
        
        
    }

    self.typeLable2.contentLable.text = lable2;
    
    self.h2 = [UILabel getHeightByWidth:SCREEN_WIDTH / 3 - realW(5) - realW(72) title:lable2 font:[UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)]];
    
    [self.typeLable2 updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/3 - realW(5), self.h2));
    }];
    
    if (self.h2 > self.h1 && self.h2 > self.h3) {
//        [self.lineView updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.typeLable2.bottom).offset(realH(20));
//        }];
        if (self.chooseHeightBlock) {
            self.chooseHeightBlock(self.h2 < 34 ? 34 : self.h2);
        }
    }
}

-(void)setLable3:(NSString *)lable3
{
    if (lable3.length > 0) {
        self.typeLable3.alpha = 1;
    }
    else
    {
        self.typeLable3.alpha = 0;
        
        if (self.h1 == 0 && self.h2 == 0) {
            if (self.chooseHeightBlock) {
                self.chooseHeightBlock(34);
            }
        }
        else
        {
            if (self.chooseHeightBlock) {
                self.chooseHeightBlock(self.h1 > self.h2 ? self.h1 : self.h2);
            }
        }
        
        
    }
    
    
    self.typeLable3.contentLable.text = lable3;
    
    self.h3 = [UILabel getHeightByWidth:SCREEN_WIDTH / 3 - realW(5) - realW(72) title:lable3 font:[UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)]];
    
    [self.typeLable3 updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/3 - realW(5), self.h3));
    }];
    
    if (self.h3 > self.h1 && self.h3 > self.h2) {
//        [self.lineView updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.typeLable3.bottom).offset(realH(20));
//        }];
        if (self.chooseHeightBlock) {
            self.chooseHeightBlock(self.h3 < 34 ? 34 : self.h3);
        }
    }
    
    
}


@end
