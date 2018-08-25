//
//  FeedbackChooseView.m
//  HGWIOS
//
//  Created by mac on 2018/7/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "FeedbackChooseView.h"

@interface FeedbackChooseView ()

@property (nonatomic, weak) UIButton * chooseButton;

@end

@implementation FeedbackChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingNone;
        
        [self setUpUI];
        
    }
    return self;
}


-(void)setUpUI
{
    UILabel * leftLable = [UILabel lableWithTextColor:XXJColor(79, 79, 79) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"船已被订(信息失效)"];
    [leftLable sizeToFit];
    [self addSubview:leftLable];
    [leftLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(40));
        make.centerY.equalTo(self);
    }];
    self.leftLable = leftLable;
    
    
    UIButton * chooseButton = [[UIButton alloc]init];
    chooseButton.userInteractionEnabled = NO;
    [chooseButton setImage:[UIImage imageNamed:@"fc"] forState:UIControlStateNormal];
    [chooseButton setImage:[UIImage imageNamed:@"fcs"] forState:UIControlStateSelected];
    [self addSubview:chooseButton];
    [chooseButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-40));
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(realW(50), realH(59)));
    }];
    self.chooseButton = chooseButton;
    
}


-(void)setSelect:(BOOL)select
{
    if (select) {
        self.chooseButton.selected = YES;
    }
    else
    {
        self.chooseButton.selected = NO;
    }
}












@end
