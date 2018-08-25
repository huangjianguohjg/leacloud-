//
//  RecommendTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/29.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "RecommendTableViewCell.h"

@implementation RecommendTableViewCell

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
    UILabel * startlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"11111"];
    [startlable sizeToFit];
    [self.contentView addSubview:startlable];
    [startlable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(50));
        make.top.equalTo(self.contentView).offset(realH(40));
        make.height.equalTo(realH(36));
    }];
    self.startlable = startlable;
    
    UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"to_rightUpdate"]];
    [arrowImageView sizeToFit];
    [self.contentView addSubview:arrowImageView];
    [arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(startlable);
        make.left.equalTo(startlable.right).offset(realW(10));
        make.height.equalTo(realH(38));
        make.width.equalTo(realW(38));
    }];
    
    
    
    UILabel * endlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"11111"];
    [endlable sizeToFit];
    [self.contentView addSubview:endlable];
    [endlable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrowImageView.right).offset(realW(10));
        make.centerY.equalTo(arrowImageView);
        make.height.equalTo(realH(36));
    }];
    self.endlable = endlable;
    
    
    
    UILabel * weightlable = [UILabel lableWithTextColor:XXJColor(107, 107, 107) textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"11111"];
    [weightlable sizeToFit];
    [self.contentView addSubview:weightlable];
    [weightlable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startlable.bottom).offset(realW(10));
//        make.left.equalTo(self.contentView).offset(realW(50));
        make.centerX.equalTo(arrowImageView);
        make.height.equalTo(realH(36));
    }];
    self.weightlable = weightlable;
    
    
    
    UILabel * startDatelable = [UILabel lableWithTextColor:XXJColor(107, 107, 107) textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"2018-05-28 至 2018-06-21"];
    [startDatelable sizeToFit];
    [self.contentView addSubview:startDatelable];
    [startDatelable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weightlable.bottom).offset(realH(10));
        make.left.equalTo(self.contentView).offset(realW(50));
        make.height.equalTo(realH(36));
    }];
    self.startDatelable = startDatelable;
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(242, 242, 242);
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startDatelable.bottom).offset(realH(30));
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(realH(20));
    }];
    
    UILabel * recommendLable = [UILabel lableWithTextColor:XXJColor(161, 161, 161) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"推荐船盘"];
    [recommendLable sizeToFit];
    [self.contentView addSubview:recommendLable];
    [recommendLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(realH(30));
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.bottom).offset(realH(-30));
    }];
    
    
    
}

@end
