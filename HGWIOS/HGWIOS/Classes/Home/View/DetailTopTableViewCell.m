//
//  DetailTopTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "DetailTopTableViewCell.h"

@implementation DetailTopTableViewCell

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
    UIView * verLineView = [[UIView alloc]init];
    verLineView.backgroundColor = XXJColor(67, 154, 228);
    [self.contentView addSubview:verLineView];
    [verLineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(self.contentView).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(5), realH(34)));
        make.bottom.equalTo(self.contentView).offset(realH(-20));
    }];
    
    UILabel * titlelable = [UILabel lableWithTextColor:XXJColor(67, 154, 228) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"运单信息"];
    [titlelable sizeToFit];
    [self.contentView addSubview:titlelable];
    [titlelable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(verLineView.right).offset(realW(15));
    }];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(245, 245, 245);
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(verLineView.bottom).offset(realH(20));
        make.height.equalTo(realH(1));
    }];
    
}


















































@end
