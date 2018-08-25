//
//  MessageTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessageModel.h"

@interface MessageTableViewCell ()

@property (nonatomic, weak) UIImageView * iconImageView;

@property (nonatomic, weak) UILabel * titleLable;

@property (nonatomic, weak) UILabel * timeLable;

@property (nonatomic, weak) UILabel * detailLable;

@end

@implementation MessageTableViewCell

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
    UIImageView * iconImageView = [[UIImageView alloc]init];
    iconImageView.layer.cornerRadius = realW(50);
    iconImageView.clipsToBounds = YES;
    [self.contentView addSubview:iconImageView];
    [iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(realW(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(100)));
    }];
    self.iconImageView = iconImageView;
    
    
    UILabel * titleLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"1111"];
    [titleLable sizeToFit];
    [self.contentView addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(realH(30));
        make.left.equalTo(iconImageView.right).offset(realW(20));
    }];
    self.titleLable = titleLable;
    
    UILabel * timeLable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(26) fontFamily:PingFangSc_Regular text:@"1111"];
    [timeLable sizeToFit];
    [self.contentView addSubview:timeLable];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLable);
        make.right.equalTo(self.contentView.right).offset(realW(-20));
    }];
    self.timeLable = timeLable;
    
    
    UILabel * detailLable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"1111"];
    [detailLable sizeToFit];
    [self.contentView addSubview:detailLable];
    [detailLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.bottom).offset(realH(20));
        make.left.equalTo(iconImageView.right).offset(realW(20));
    }];
    self.detailLable = detailLable;

    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.4;
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(realW(20));
        make.height.equalTo(realH(1));
    }];
    
}



-(void)setModel:(MessageModel *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.real_image_url] placeholderImage:[UIImage imageNamed:@"news_icon_hd"]];
    
    self.titleLable.text = model.class_name;
    
    self.timeLable.text = model.ct_time;
    
    self.detailLable.text = model.ct_title;
}
















@end
