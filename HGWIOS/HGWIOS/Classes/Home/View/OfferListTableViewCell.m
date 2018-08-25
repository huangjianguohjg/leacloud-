//
//  OfferListTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "OfferListTableViewCell.h"

#import "OfferListModel.h"
//#import "ShipUser.h"
//#import "CargoInfo.h"

@interface OfferListTableViewCell()

@property (nonatomic, weak) UIButton * iconButton;

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UIButton * scoreButton;



@property (nonatomic, weak) UILabel * boatNameLable;

@property (nonatomic, weak) UILabel * weightLable;

@property (nonatomic, weak) UILabel * typeLable;

@property (nonatomic, weak) UILabel * priceLable;

@end

@implementation OfferListTableViewCell

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
    iconButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(35)];
    iconButton.layer.cornerRadius = realW(50);
    iconButton.clipsToBounds = YES;
    [self.contentView addSubview:iconButton];
    [iconButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(30));
        make.top.equalTo(self.contentView).offset(realH(10));
        make.size.equalTo(CGSizeMake(realW(100), realH(100)));
    }];
    self.iconButton = iconButton;
    
    
    
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(35) fontFamily:PingFangSc_Regular text:@"张从严"];
    [self.contentView addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        make.top.equalTo(iconButton);
    }];
    self.nameLable = nameLable;
    
    
    
    
    UIButton * scoreButton = [[UIButton alloc]init];
    [scoreButton setTitleColor:XXJColor(119, 148, 217) forState:UIControlStateNormal];
    scoreButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
    scoreButton.layer.borderWidth = 1;
    scoreButton.layer.borderColor = XXJColor(119, 148, 217).CGColor;
    [scoreButton setTitle:@"信任值50" forState:UIControlStateNormal];
    [self.contentView addSubview:scoreButton];
    [scoreButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.right).offset(realW(20));
        make.centerY.equalTo(nameLable);
        make.size.equalTo(CGSizeMake(realW(200), realH(40)));
    }];
    self.scoreButton = scoreButton;
    
    
    UILabel * companyLable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"张从严"];
    [self.contentView addSubview:companyLable];
    [companyLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        make.bottom.equalTo(iconButton.bottom);
    }];
    self.companyLable = companyLable;
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha= 0.5;
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(iconButton.bottom).offset(realH(10));
        make.height.equalTo(realH(1));
    }];
    
    
    //船名
    UILabel * boatNameLable = [UILabel lableWithTextColor:[UIColor darkGrayColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"船舶名称:黄金梅丽号"];
    [boatNameLable sizeToFit];
    [self.contentView addSubview:boatNameLable];
    [boatNameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(30));
        make.top.equalTo(lineView.bottom).offset(realH(10));
    }];
    self.boatNameLable = boatNameLable;
    
   
    
    
    //地址
    UILabel * weightLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"参考载重:100吨"];
    [weightLable sizeToFit];
    [self.contentView addSubview:weightLable];
    [weightLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(30));
        make.top.equalTo(boatNameLable.bottom).offset(realH(20));
    }];
    self.weightLable = weightLable;
    
    
    
    //起始时间
    UILabel * typeLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"船舶类型:油船"];
    [typeLable sizeToFit];
    [self.contentView addSubview:typeLable];
    [typeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(30));
        make.top.equalTo(weightLable.bottom).offset(realH(20));
    }];
    self.typeLable = typeLable;
    
    
    UIView * centerLineView = [[UIView alloc]init];
    centerLineView.backgroundColor = XXJColor(242, 242, 242);
    [self.contentView addSubview:centerLineView];
    [centerLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLable.bottom).offset(realH(20));
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(realH(1));
    }];
    
    
    
    //
    UILabel * priceLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"25元/吨"];
    [priceLable sizeToFit];
    [self.contentView addSubview:priceLable];
    [priceLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(30));
        make.top.equalTo(centerLineView.bottom).offset(realH(20));
    }];
    self.priceLable = priceLable;
    
    
    UIButton * chooseButton = [[UIButton alloc]init];
    [chooseButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [chooseButton setTitle:@"选他中标" forState:UIControlStateNormal];
    chooseButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    chooseButton.backgroundColor = XXJColor(117, 159, 226);
    chooseButton.layer.cornerRadius = realW(10);
    chooseButton.clipsToBounds = YES;
    [chooseButton sizeToFit];
    [self.contentView addSubview:chooseButton];
    [chooseButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.centerY.equalTo(priceLable);
        make.width.equalTo(realW(150));
    }];
    
    
    //底部下划线
    UIView * bottomLineView = [[UIView alloc]init];
    bottomLineView.backgroundColor = XXJColor(242, 242, 242);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLable.bottom).offset(realH(20));
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(realH(10));
        make.bottom.equalTo(self.contentView);
    }];
    
    
}



-(void)buttonClick
{
    if (self.offerBlock) {
        self.offerBlock(self.model);
    }
}


-(void)setModel:(OfferListModel *)model
{
    _model = model;
    
    [self.iconButton setTitle:[model.ship_user.username substringToIndex:1] forState:UIControlStateNormal];
    
    self.nameLable.text = model.ship_user.username;
    
    self.companyLable.text = model.ship_user.enterprice;
    
    [self.scoreButton setTitle:[NSString stringWithFormat:@"信任值%@",model.ship_user.score] forState:UIControlStateNormal];
    
    self.boatNameLable.text = [NSString stringWithFormat:@"船舶名称: %@",model.cargo.name];
    
    self.weightLable.text = [NSString stringWithFormat:@"参考载重: %@吨",model.cargo.deadweight];
    
    self.typeLable.text = [NSString stringWithFormat:@"船舶类型: %@",model.cargo.type_name];
    
    self.priceLable.text = [NSString stringWithFormat:@"%@",model.money];
}





@end
