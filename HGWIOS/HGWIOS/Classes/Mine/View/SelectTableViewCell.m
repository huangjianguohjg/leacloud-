//
//  SelectTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "SelectTableViewCell.h"

@interface SelectTableViewCell()



@end

@implementation SelectTableViewCell

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
    UIButton * selectButton = [[UIButton alloc]init];
    [selectButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [selectButton setImage:[UIImage imageNamed:@"form_pic_choose04"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"form_pic_choose03"] forState:UIControlStateSelected];
    [selectButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(20)];
    selectButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
    [selectButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [selectButton sizeToFit];
    [self.contentView addSubview:selectButton];
    [selectButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(20));
        make.centerY.equalTo(self);
    }];
    self.selectButton = selectButton;
    
    UIView * coverView = [[UIView alloc]init];
    [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
    coverView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:coverView];
    [coverView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
//        make.left.equalTo(self.selectButton.right);
    }];
    
}


-(void)selectClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (self.selectBlock) {
        self.selectBlock(button.currentTitle);
    }
    
    
}

-(void)tapClick
{
    self.selectButton.selected = !self.selectButton.selected;
    
    if (self.selectBlock) {
        self.selectBlock(self.selectButton.currentTitle);
    }
    
}




@end
