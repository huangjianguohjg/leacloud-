//
//  TransportStyleTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "TransportStyleTableViewCell.h"

#import "TransportDealModel.h"

@interface TransportStyleTableViewCell ()

@property (nonatomic, weak) UIButton * iconButton;

@property (nonatomic, weak) UILabel * typeLable;

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UILabel * timeLable;

@end

@implementation TransportStyleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selected = NO;
        self.contentView.backgroundColor = [UIColor whiteColor];
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
        make.left.equalTo(self.contentView).offset(realW(20));
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(realW(80), realH(80)));
    }];
    self.iconButton = iconButton;
    
    
    UILabel * typeLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"货主支付履约保证金"];
    [self.contentView addSubview:typeLable];
    [typeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        make.centerY.equalTo(iconButton);
    }];
    self.typeLable = typeLable;
    
    
    
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"李晓梅"];
    [self.contentView addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.centerX).offset(realW(40));
        make.centerY.equalTo(iconButton);
    }];
    self.nameLable = nameLable;
    
    UILabel * timeLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"2018-06-06\n19:11:17"];
    timeLable.numberOfLines = 0;
    timeLable.textAlignment = NSTextAlignmentCenter;
    [timeLable sizeToFit];
    [self.contentView addSubview:timeLable];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.right).offset(realW(30));
//        make.right.equalTo(self.contentView).offset(realW(-20));
        make.centerY.equalTo(iconButton);
    }];
    self.timeLable = timeLable;
    
}


-(void)setModel:(TransportDealModel *)model
{
    _model = model;
    
    [self.iconButton setTitle:model.event_no forState:UIControlStateNormal];
    
    self.typeLable.text = model.event;
    
    self.nameLable.text = model.username;
    
    self.timeLable.text = [NSString stringWithFormat:@"%@\n%@",[model.date componentsSeparatedByString:@" "][0],[model.date componentsSeparatedByString:@" "][1]];
    
}









@end
