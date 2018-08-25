//
//  BankListTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BankListTableViewCell.h"

#import "SupportBankModel.h"

@implementation BankListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wallet_icon_add"]];
    [self.contentView addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(40));
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(realW(70), realH(70)));
    }];
    self.bankImageView = imageView;
    
    UILabel * titleLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:@"添加银行卡"];
    [titleLable sizeToFit];
    [self.contentView addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.right).offset(realW(20));
        make.centerY.equalTo(self.contentView);
    }];
    self.titleLable = titleLable;
    
}



-(void)setModel:(SupportBankModel *)model
{
    _model = model;
    
    [self.bankImageView setImage:[UIImage imageNamed:model.imageurl]];
    
    self.titleLable.text = model.title;
    
}








@end
