
//
//  GoodsTopTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "GoodsTopTableViewCell.h"

#import "HomeGoodsModel.h"

@implementation GoodsTopTableViewCell

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
    iconButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
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
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(35) fontFamily:PingFangSc_Regular text:@"张从严"];
    [nameLable sizeToFit];
    [self.contentView addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        make.top.equalTo(self.contentView).offset(realH(30));
    }];
    self.nameLable = nameLable;
    
    
    UIButton * scoreButton = [[UIButton alloc]init];
    [scoreButton setTitle:@"信任值0.60" forState:UIControlStateNormal];
    [scoreButton setTitleColor:XXJColor(164, 189, 238) forState:UIControlStateNormal];
    scoreButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
    scoreButton.layer.borderWidth = realW(2);
    scoreButton.layer.borderColor = XXJColor(164, 189, 238).CGColor;
    [self.contentView addSubview:scoreButton];
    [scoreButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.right).offset(realW(20));
        make.centerY.equalTo(nameLable);
        make.width.equalTo(realW(200));
        make.height.equalTo(realH(40));
    }];
    self.scoreButton = scoreButton;
    
    //公司
    UILabel * companyLable = [UILabel lableWithTextColor:XXJColor(62, 62, 62) textFontSize:realFontSize(26) fontFamily:PingFangSc_Regular text:@"江苏浩云航联网络科技有限公司"];
    [companyLable sizeToFit];
    [self.contentView addSubview:companyLable];
    [companyLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        //        make.centerY.equalTo(iconButton);
        make.top.equalTo(nameLable.bottom).offset(realH(10));
//        make.bottom.equalTo(self.contentView).offset(realH(-30));
    }];
    self.companyLable = companyLable;
    
    //次数
    UILabel * timesLable = [UILabel lableWithTextColor:XXJColor(62, 62, 62) textFontSize:realFontSize(25) fontFamily:PingFangSc_Regular text:@"累计报空次/本单洽谈次"];
    [timesLable sizeToFit];
    [self.contentView addSubview:timesLable];
    [timesLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        make.top.equalTo(companyLable.bottom).offset(realH(10));
        make.bottom.equalTo(self.contentView.bottom).offset(realH(-20));
    }];
    self.timesLable = timesLable;
    
    //打电话
    UIButton * phoneButton = [[UIButton alloc]init];
    [phoneButton addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton setTitle:@"打电话" forState:UIControlStateNormal];
    phoneButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(27)];
    [phoneButton setImage:[UIImage imageNamed:@"ins_icon_phone"] forState:UIControlStateNormal];
    [phoneButton setTitleColor:XXJColor(87, 166, 237) forState:UIControlStateNormal];
    [phoneButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:realH(10)];
    [phoneButton sizeToFit];
    [self.contentView addSubview:phoneButton];
    [phoneButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconButton);
        make.right.equalTo(self.contentView).offset(realW(-20));
        
    }];
    self.phoneButton = phoneButton;
    
    
}



#pragma mark -- 打电话
-(void)phoneClick
{
    if (self.phoneBlock) {
        self.phoneBlock(self.model.mobile);
    }
}



-(void)setModel:(HomeGoodsModel *)model
{
    _model = model;
    
    NSString * surnName = nil;
    if (model.surname) {
        surnName = model.surname;
    }
    else
    {
        surnName = @"无";
    }
    
    [self.iconButton setTitle:surnName forState:UIControlStateNormal];
    
    self.nameLable.text = model.username == nil ? @"无" : model.username;
    
    [self.scoreButton setTitle:[NSString stringWithFormat:@"信任值%@",model.score == nil ? @"0" : model.score] forState:UIControlStateNormal];
    
    self.companyLable.text = model.enterprise;
    
//    self.timesLable.text = [NSString stringWithFormat:@"累计发货%@次/本单洽谈%@次",model.vacant,model.negotia];
}








@end
