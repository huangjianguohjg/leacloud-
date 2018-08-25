//
//  ShipownerTableViewCell.m
//  HGWIOS
//
//  Created by 许小军 on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipownerTableViewCell.h"

#import "HomeBoatModel.h"

@implementation ShipownerTableViewCell

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
    UILabel * companyLable = [UILabel lableWithTextColor:XXJColor(62, 62, 62) textFontSize:realFontSize(25) fontFamily:PingFangSc_Regular text:@"江苏浩云航联网络科技有限公司"];
    [companyLable sizeToFit];
    [self.contentView addSubview:companyLable];
    [companyLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
//        make.centerY.equalTo(iconButton);
        make.top.equalTo(nameLable.bottom).offset(realH(10));
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
    

    

}




-(void)setModel:(HomeBoatModel *)model
{
    _model = model;
    
    [self.iconButton setTitle:model.user.surname forState:UIControlStateNormal];
    
    self.nameLable.text = model.username;
    
    [self.scoreButton setTitle:[NSString stringWithFormat:@"信任值%@",model.score] forState:UIControlStateNormal];
    
    self.companyLable.text = model.ship.enterprise;
    
    self.timesLable.text = [NSString stringWithFormat:@"累计报空%@次/本单洽谈%@次",model.vacant,model.negotia];
    
    
}















@end
