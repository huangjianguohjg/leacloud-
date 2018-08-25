//
//  MineTopTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MineTopTableViewCell.h"

@implementation MineTopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    UIButton * iconButton = [[UIButton alloc]init];
    [iconButton setTitle:@"张" forState:UIControlStateNormal];
    iconButton.backgroundColor = XXJColor(96, 143, 236);
    iconButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    iconButton.layer.cornerRadius = realW(50);
    iconButton.clipsToBounds = YES;
    [self.contentView addSubview:iconButton];
    [iconButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(30));
        make.top.equalTo(self.contentView).offset(realH(50));
        make.size.equalTo(CGSizeMake(realW(100), realH(100)));
    }];
    self.iconButton = iconButton;
    
    //船主
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"张从严   企业管理员"];
    [nameLable sizeToFit];
    [self.contentView addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        make.top.equalTo(self.contentView).offset(realH(30));
    }];
    self.nameLable = nameLable;
    
    //手机号
    UILabel * phoneLable = [UILabel lableWithTextColor:XXJColor(62, 62, 62) textFontSize:realFontSize(24) fontFamily:PingFangSc_Regular text:@"1381404304"];
    [phoneLable sizeToFit];
    [self.contentView addSubview:phoneLable];
    [phoneLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        //        make.centerY.equalTo(iconButton);
        make.top.equalTo(nameLable.bottom).offset(realH(10));
    }];
    self.phoneLable = phoneLable;
    
    //公司
    UILabel * companyLable = [UILabel lableWithTextColor:XXJColor(62, 62, 62) textFontSize:realFontSize(24) fontFamily:PingFangSc_Regular text:@"南京九则"];
    [companyLable sizeToFit];
    [self.contentView addSubview:companyLable];
    [companyLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        make.top.equalTo(phoneLable.bottom).offset(realH(10));
        make.bottom.equalTo(self.contentView.bottom).offset(realH(-20));
    }];
    self.companyLable = companyLable;
    
    UIButton * scoreButton = [[UIButton alloc]init];
    [scoreButton addTarget:self action:@selector(scoreClick) forControlEvents:UIControlEventTouchUpInside];
    [scoreButton setTitle:@"信任值 87" forState:UIControlStateNormal];
    scoreButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [scoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scoreButton.layer.borderWidth = realW(1);
    scoreButton.layer.borderColor = XXJColor(133, 168, 233).CGColor;
    [self.contentView addSubview:scoreButton];
    [scoreButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(1));
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(realW(220), realH(80)));
    }];
    self.scoreButton = scoreButton;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.4;
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(realH(1));
    }];
    
    
    
}


-(void)scoreClick
{
    if (self.scoreBlock) {
        self.scoreBlock();
    }
}






@end
