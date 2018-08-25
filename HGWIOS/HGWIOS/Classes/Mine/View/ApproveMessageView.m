//
//  ApproveMessageView.m
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ApproveMessageView.h"

@implementation ApproveMessageView

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
    UILabel * leftLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"真实姓名"];
    [leftLable sizeToFit];
    [self addSubview:leftLable];
    [leftLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(40));
        make.centerY.equalTo(self);
    }];
    self.leftLable = leftLable;
    
    
    UITextField * textField = [[UITextField alloc]init];
    textField.textAlignment = NSTextAlignmentRight;
    textField.tintColor = [UIColor redColor];
    textField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [self addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-40));
        make.centerY.equalTo(self);
    }];
    self.textField = textField;
    
    
    UIImageView * imageview = [[UIImageView alloc]init];
    imageview.backgroundColor = XXJColor(249, 249, 249);
    imageview.userInteractionEnabled = YES;
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick)]];
    [self addSubview:imageview];
    [imageview makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-40));
        make.centerY.equalTo(self);
        make.height.equalTo(realH(80));
        make.width.equalTo(realW(0));
    }];
    self.imageview = imageview;
    
    
    UIButton * uploadButton = [[UIButton alloc]init];
    uploadButton.alpha = 0;
    [uploadButton addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
    [uploadButton setTitle:@"点击上传" forState:UIControlStateNormal];
    uploadButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [uploadButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [uploadButton sizeToFit];
    [self addSubview:uploadButton];
    [uploadButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageview.left).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.uploadButton = uploadButton;
    
    
    
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(245, 245, 245);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - realW(50), realH(1)));
    }];
    
    
}


-(void)uploadClick
{
    if (self.uploadBlock) {
        self.uploadBlock();
    }
}

-(void)tapclick
{
    if (self.imageTapBlock) {
        self.imageTapBlock(self.imageview.image);
    }
}

@end
