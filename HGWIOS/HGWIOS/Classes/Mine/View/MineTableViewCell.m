//
//  MineTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

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
    UIImageView * leftImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:leftImageView];
    [leftImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.centerY.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(realH(-20));
        make.size.equalTo(CGSizeMake(realW(80), realH(80)));
    }];
    self.leftImageView = leftImageView;
    
    
    UILabel * leftLable = [UILabel lableWithTextColor:XXJColor(106, 106, 106) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"可放空地"];
    [leftLable sizeToFit];
    [self.contentView addSubview:leftLable];
    [leftLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImageView.right).offset(realW(10));
        make.centerY.equalTo(leftImageView);
        make.width.equalTo(realW(220));
    }];
    self.leftLable = leftLable;
    
    UILabel * rightLable = [UILabel lableWithTextColor:XXJColor(56, 56, 56) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"上海"];
    [rightLable sizeToFit];
    [self.contentView addSubview:rightLable];
    [rightLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(220));
        make.centerY.equalTo(leftLable);
    }];
    self.rightLable = rightLable;
    
    UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_xq_03"]];
    arrowImageView.alpha = 0;
    [arrowImageView sizeToFit];
    [self.contentView addSubview:arrowImageView];
    [arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.centerY.equalTo(self.contentView);
    }];
    self.arrowImageView = arrowImageView;
    
    UILabel * approveLable = [UILabel lableWithTextColor:XXJColor(64, 64, 64) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"认证通过"];
    approveLable.alpha = 0;
    [approveLable sizeToFit];
    [self.contentView addSubview:approveLable];
    [approveLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImageView.left).offset(realW(-10));
        make.centerY.equalTo(self.contentView);
    }];
    self.approveLable = approveLable;
    
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
@end
