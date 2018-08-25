//
//  InputView.m
//  化运网IOS
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 jiuze. All rights reserved.
//

#import "InputView.h"

@implementation InputView

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

    
    UIImageView * headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_icon_phone"]];
    [self addSubview:headImageView];
    [headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(realW(36));
        make.size.equalTo(CGSizeMake(realW(28), realH(28)));
    }];
    self.headImageView = headImageView;
    
    UITextField * nameTextField = [[UITextField alloc]init];
    nameTextField.keyboardType = UIKeyboardTypeDecimalPad;
    nameTextField.placeholder = @"请输入手机号";
//    nameTextField.tintColor = [UIColor colorWithHexString:@"#f39c38"];
//    nameTextField.textColor = [UIColor colorWithHexString:@"#999999"];
    nameTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [self addSubview:nameTextField];
    [nameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.right).offset(realW(22));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(realW(-80));
        make.height.equalTo(realH(120));
    }];
    self.nameTextField = nameTextField;
    
    
    
    UIButton * codeButton = [[UIButton alloc]init];
    [codeButton addTarget:self action:@selector(codeClick) forControlEvents:UIControlEventTouchUpInside];
    codeButton.alpha = 0;
    codeButton.layer.cornerRadius = 5;
    codeButton.clipsToBounds = YES;
    codeButton.layer.borderWidth = 1;
    codeButton.layer.borderColor = XXJColor(23, 148, 215).CGColor;
    [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeButton setTitleColor:XXJColor(23, 148, 215) forState:UIControlStateNormal];
    codeButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Light size:realFontSize(28)];
    [self addSubview:codeButton];
    [codeButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.right).offset(realW(-22));
        make.size.equalTo(CGSizeMake(realW(200), realH(80)));
    }];
    self.codeButton = codeButton;
    
}



-(void)codeClick
{
    if (self.codeBlock) {
        self.codeBlock();
    }
}











@end
