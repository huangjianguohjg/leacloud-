//
//  AddBankView.m
//  HGWIOS
//
//  Created by mac on 2018/6/2.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AddBankView.h"

@implementation AddBankView

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

    
    UILabel *leftLabel = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"持卡人"];
    [leftLabel sizeToFit];
    [self addSubview:leftLabel];
    [leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(20));
        make.centerY.equalTo(self);
    }];
    self.leftLabel = leftLabel;
    
    UITextField * textField = [[UITextField alloc]init];
    textField.placeholder = @"持卡人姓名";
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(30)];
    [self addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLabel.right).offset(realW(60));
//        make.right.equalTo(self);
        
        make.centerY.equalTo(self);
    }];
    self.textField = textField;
    
    
}



@end
