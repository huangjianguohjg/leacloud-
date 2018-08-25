//
//  OfferMessageTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "OfferMessageTableViewCell.h"

@interface OfferMessageTableViewCell()

@property (nonatomic, weak) UIButton * iconButton;

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UIButton * scoreButton;

@property (nonatomic, weak) UILabel * companyLable;

@property (nonatomic, weak) UILabel * boatNameLable;

@property (nonatomic, weak) UILabel * weightLable;

@property (nonatomic, weak) UILabel * typeLable;

@property (nonatomic, weak) UILabel * priceLable;

@end

@implementation OfferMessageTableViewCell

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
    iconButton.layer.cornerRadius = realW(40);
    iconButton.clipsToBounds = YES;
    [self.contentView addSubview:iconButton];
    [iconButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(30));
        make.top.equalTo(self.contentView).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(80), realH(80)));
    }];
    self.iconButton = iconButton;
    
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"张从严"];
    [self.contentView addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        make.centerY.equalTo(iconButton);
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
    }];
    self.scoreButton = scoreButton;
    
    //公司
    UILabel * companyLable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"南京九则"];
    [companyLable sizeToFit];
    [self.contentView addSubview: companyLable];
    [companyLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(scoreButton);
        make.left.equalTo(scoreButton.right).offset(realW(20));
    }];
    self.companyLable = companyLable;
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha= 0.5;
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(iconButton.bottom).offset(realH(20));
        make.height.equalTo(realH(1));
    }];

    
    //船舶名称
    UILabel * boatNameLable = [UILabel lableWithTextColor:XXJColor(114, 114, 114) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"船舶名称：认证号"];
    [boatNameLable sizeToFit];
    [self.contentView addSubview:boatNameLable];
    [boatNameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(lineView.bottom).offset(realH(10));
    }];
    self.boatNameLable = boatNameLable;
    
    //参考重量
    UILabel * weightLable = [UILabel lableWithTextColor:XXJColor(114, 114, 114) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"参考重量：8000吨"];
    [weightLable sizeToFit];
    [self.contentView addSubview:weightLable];
    [weightLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(boatNameLable.bottom).offset(realH(20));
    }];
    self.weightLable = weightLable;
    
    //船舶类型
    UILabel * typeLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"船舶类型：油船1级"];
    [typeLable sizeToFit];
    [self.contentView addSubview:typeLable];
    [typeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(weightLable.bottom).offset(realH(20));
    }];
    self.typeLable = typeLable;
    
    
    UIView * centerLineView = [[UIView alloc]init];
    centerLineView.backgroundColor=[UIColor lightGrayColor];
    centerLineView.alpha= 0.5;
    [self.contentView addSubview:centerLineView];
    [centerLineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(typeLable.bottom).offset(realH(10));
        make.height.equalTo(realH(1));
    }];

    
    //单价
    UILabel * priceLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:@"10元/吨"];
    [priceLable sizeToFit];
    [self.contentView addSubview:priceLable];
    [priceLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(centerLineView.bottom).offset(realH(30));
    }];
    self.priceLable = priceLable;
    
    
    
    UIButton * selectButton = [[UIButton alloc]init];
    [selectButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [selectButton setTitle:@"选他中标" forState:UIControlStateNormal];
    [selectButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    selectButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    selectButton.backgroundColor = XXJColor(116, 159, 227);
    selectButton.layer.cornerRadius = 5;
    selectButton.clipsToBounds = YES;
    [self.contentView addSubview:selectButton];
    [selectButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.top.equalTo(centerLineView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(150), realH(60)));
    }];
    
    
    //底部下划线
    UIView * bottomLineView = [[UIView alloc]init];
    bottomLineView.backgroundColor = XXJColor(242, 242, 242);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLable.bottom).offset(realH(30));
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(realH(20));
        make.bottom.equalTo(self.contentView);
    }];
    
}


#pragma mark -- 选他中标
-(void)buttonClick
{
    
}




@end
