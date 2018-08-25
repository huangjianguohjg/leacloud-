//
//  RecommendView.m
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "RecommendView.h"
#import "HomeBoatModel.h"
@implementation RecommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setModel:(HomeBoatModel *)model
{
    _model = model;
    
    UILabel * weightLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"意向货量:%@吨 ±%@%@",self.model.cargo_ton,self.model.cargo_ton_num,@"%"]];
    [weightLable sizeToFit];
    [self addSubview:weightLable];
    [weightLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(40));
        make.top.equalTo(self).offset(realH(20));
    }];
    
    
    UILabel * typeLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"前载货物:%@",self.model.before_cargo]];
    [typeLable sizeToFit];
    [self addSubview:typeLable];
    [typeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(40));
        make.top.equalTo(weightLable.bottom).offset(realH(20));
    }];
    
    
    UILabel * remarkLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"备注:%@",self.model.remark]];
    [remarkLable sizeToFit];
    [self addSubview:remarkLable];
    [remarkLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(40));
        make.top.equalTo(typeLable.bottom).offset(realH(20));
        make.bottom.equalTo(self).offset(realH(-10));
    }];
    
    
//    UIButton * deleteButton = [[UIButton alloc]init];
//    [deleteButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
//    [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    deleteButton.layer.cornerRadius = realW(5);
//    deleteButton.clipsToBounds = YES;
//    deleteButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
//    deleteButton.backgroundColor = XXJColor(115, 160, 227);
//    [self addSubview:deleteButton];
//    [deleteButton makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(realW(-40));
//        make.top.equalTo(remarkLable.bottom).offset(realH(40));
//        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
//        make.bottom.equalTo(self).offset(realH(-10));
//    }];
//    
//    
//    UIButton * refeshButton = [[UIButton alloc]init];
//    [refeshButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [refeshButton setTitle:@"刷新" forState:UIControlStateNormal];
//    [refeshButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    refeshButton.layer.cornerRadius = realW(5);
//    refeshButton.clipsToBounds = YES;
//    refeshButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
//    refeshButton.backgroundColor = XXJColor(115, 160, 227);
//    [self addSubview:refeshButton];
//    [refeshButton makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(deleteButton.left).offset(realW(-20));
//        make.top.equalTo(remarkLable.bottom).offset(realH(40));
//        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
//        make.bottom.equalTo(self).offset(realH(-10));
//    }];
    
}


-(void)buttonClick:(UIButton *)button
{
    if (self.recommendBlock) {
        self.recommendBlock(button.currentTitle);
    }
}





@end
