//
//  InviteTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InviteTableViewCell.h"

@implementation InviteTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = XXJColor(236, 239, 246);
        
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"姓名"];
    [nameLable sizeToFit];
    [self.contentView addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(70));
        make.centerY.equalTo(self.contentView);
    }];
    self.nameLable = nameLable;
    
    UILabel * numberLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"手机号"];
    [numberLable sizeToFit];
    [self.contentView addSubview:numberLable];
    [numberLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    self.numberLable = numberLable;
    
    UILabel * timeLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"时间"];
    timeLable.numberOfLines = 0;
    timeLable.textAlignment = NSTextAlignmentCenter;
    [timeLable sizeToFit];
    [self.contentView addSubview:timeLable];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-30));
        make.centerY.equalTo(self.contentView);
    }];
    self.timeLable = timeLable;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.5;
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.height.equalTo(realH(1));
        make.bottom.equalTo(self.contentView);
    }];
    
}

@end
