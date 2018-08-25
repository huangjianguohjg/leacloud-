//
//  AdminTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AdminTableViewCell.h"

@implementation AdminTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.contentView.backgroundColor = XXJColor(236, 239, 246);
        
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"姓名"];
    [nameLable sizeToFit];
    [self.contentView addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(40));
        make.centerY.equalTo(self.contentView);
    }];
    self.nameLable = nameLable;
    
    UILabel * numberLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"手机号"];
    [numberLable sizeToFit];
    [self.contentView addSubview:numberLable];
    [numberLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(realW(-80));
        make.centerY.equalTo(self.contentView);
    }];
    self.numberLable = numberLable;
    
    UIButton * passButton = [[UIButton alloc]init];
    [passButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [passButton setTitle:@"通过" forState:UIControlStateNormal];
    passButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [passButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    passButton.backgroundColor = XXJColor(117, 159, 226);
    passButton.layer.cornerRadius = realW(5);
    passButton.clipsToBounds = YES;
    [passButton sizeToFit];
    [self.contentView addSubview:passButton];
    [passButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(realW(100));
    }];
    
    
    UIButton * refuseButton = [[UIButton alloc]init];
    [refuseButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [refuseButton setTitle:@"驳回" forState:UIControlStateNormal];
    refuseButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [refuseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    refuseButton.backgroundColor = XXJColor(117, 159, 226);
    refuseButton.layer.cornerRadius = realW(5);
    refuseButton.clipsToBounds = YES;
    [refuseButton sizeToFit];
    [self.contentView addSubview:refuseButton];
    [refuseButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(passButton.left).offset(realW(-40));
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(realW(100));
    }];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(242, 242, 242);
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(realH(10));
    }];
}





-(void)buttonClick:(UIButton *)button
{
    if (self.adminBlock) {
        self.adminBlock(button.currentTitle);
    }
}
























@end
