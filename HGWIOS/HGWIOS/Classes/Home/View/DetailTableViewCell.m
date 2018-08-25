//
//  DetailTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell
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
    
    UILabel * titlelable = [UILabel lableWithTextColor:XXJColor(158, 158, 158) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"运单编号:"];
    [titlelable sizeToFit];
    [self.contentView addSubview:titlelable];
    [titlelable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(realH(10));
        make.left.equalTo(self.contentView).offset(realW(40));
//        make.centerY.equalTo(self.contentView);
    }];
    self.titlelable = titlelable;
    
    UILabel * detailLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"22222222222222222222222222222222222222222"];
    detailLable.numberOfLines = 0;
    [detailLable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [detailLable setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    detailLable.preferredMaxLayoutWidth = SCREEN_WIDTH - 2 * realW(150);

//    [detailLable sizeToFit];
    [self.contentView addSubview:detailLable];
    [detailLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titlelable.right).offset(realW(10));
        make.top.equalTo(titlelable);
        make.bottom.equalTo(self.contentView).offset(realH(-10));
    }];
    self.detailLable = detailLable;
    
    UILabel * typeLable = [UILabel lableWithTextColor:XXJColor(253, 142, 37) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"待装货"];
    typeLable.alpha = 0;
    [typeLable sizeToFit];
    [self.contentView addSubview:typeLable];
    [typeLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.right).offset(realW(-20));
        make.top.equalTo(titlelable);
    }];
    self.typeLable = typeLable;
    
}

@end
