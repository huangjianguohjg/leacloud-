//
//  AddressRightTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AddressRightTableViewCell.h"

@implementation AddressRightTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selected = NO;
//        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    
    
    UIButton * button = [[UIButton alloc]init];
    [button setTitle:@"11" forState:UIControlStateNormal];
    button.userInteractionEnabled = NO;
    [button setImage:[UIImage imageNamed:@"ship_icon_jt"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [button setTitleColor:XXJColor(52, 52, 52) forState:UIControlStateNormal];
    [button setTitleColor:XXJColor(79, 153, 221) forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(30)];
    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(20)];
    [self.contentView addSubview:button];
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.centerY.equalTo(self.contentView);
    }];
    self.button = button;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(235, 235, 235);
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(realH(1));
    }];
}


@end
