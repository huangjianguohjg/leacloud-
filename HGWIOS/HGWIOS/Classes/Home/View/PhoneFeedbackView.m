//
//  PhoneFeedbackView.m
//  HGWIOS
//
//  Created by mac on 2018/7/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "PhoneFeedbackView.h"
#import "FeedbackChooseView.h"

@interface PhoneFeedbackView ()

@property (nonatomic, weak) FeedbackChooseView * preView;

@end

@implementation PhoneFeedbackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.autoresizingMask = UIViewAutoresizingNone;
        
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    UILabel * titleLable = [UILabel lableWithTextColor:XXJColor(99, 99, 99) textFontSize:realFontSize(38) fontFamily:PingFangSc_Regular text:@"联系对方结果如何?"];
    [titleLable sizeToFit];
    [self addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(realH(60));
        make.centerX.equalTo(self);
    }];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(230, 230, 230);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(titleLable.bottom).offset(realH(40));
        make.height.equalTo(realH(1));
    }];
    
    FeedbackChooseView * oneView = [[FeedbackChooseView alloc]init];
    oneView.tag = 10;
    [oneView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTap:)]];
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
        oneView.leftLable.text = @"货已发走(信息失效)";
    }
    else
    {
        oneView.leftLable.text = @"船已被订(信息失效)";
    }
    [self addSubview:oneView];
    [oneView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(lineView.bottom);
        make.height.equalTo(realH(100));
    }];
    
    FeedbackChooseView * twoView = [[FeedbackChooseView alloc]init];
    twoView.tag = 11;
    [twoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTap:)]];
    twoView.leftLable.text = @"信息有误(号码、船名等错误)";
    [self addSubview:twoView];
    [twoView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(oneView.bottom);
        make.height.equalTo(realH(100));
    }];
    
    FeedbackChooseView * threeView = [[FeedbackChooseView alloc]init];
    threeView.tag = 12;
    [threeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTap:)]];
    threeView.leftLable.text = @"沟通顺利(考虑合作)";
    [self addSubview:threeView];
    [threeView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(twoView.bottom);
        make.height.equalTo(realH(100));
    }];
    
    UIButton * okButton = [[UIButton alloc]init];
    [okButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [okButton setTitleColor:XXJColor(79, 79, 79) forState:UIControlStateNormal];
    okButton.layer.cornerRadius = 5;
    okButton.clipsToBounds = YES;
    okButton.layer.borderWidth = realW(1);
    okButton.layer.borderColor = XXJColor(79, 79, 79).CGColor;
    [self addSubview:okButton];
    [okButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerX).offset(realW(60));
        make.top.equalTo(threeView.bottom).offset(realH(60));
        make.size.equalTo(CGSizeMake(realW(200), realH(80)));
    }];


    UIButton * cancelButton = [[UIButton alloc]init];
    [cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [cancelButton setTitleColor:XXJColor(79, 79, 79) forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 5;
    cancelButton.clipsToBounds = YES;
    cancelButton.layer.borderWidth = realW(1);
    cancelButton.layer.borderColor = XXJColor(79, 79, 79).CGColor;
    [self addSubview:cancelButton];
    [cancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.centerX).offset(realW(-60));
        make.top.equalTo(threeView.bottom).offset(realH(60));
        make.size.equalTo(CGSizeMake(realW(200), realH(80)));
    }];

}



-(void)chooseTap:(UITapGestureRecognizer *)tap
{
    self.preView.select = NO;
    
    FeedbackChooseView * view = (FeedbackChooseView *)tap.view;
    
    if (view.tag == 10) {
        view.select = YES;
    }
    else if (view.tag == 11)
    {
        view.select = YES;
    }
    else if (view.tag == 12)
    {
        view.select = YES;
    }
    
    self.preView = view;
    
}





-(void)buttonClick:(UIButton *)button
{
    if (self.feedBlock) {
        if ([button.currentTitle isEqualToString:@"取消"]) {
            self.feedBlock(button.currentTitle);
        }
        else
        {
            if (self.preView) {
                self.feedBlock(self.preView.leftLable.text);
            }
        }
    }
    
}























@end
