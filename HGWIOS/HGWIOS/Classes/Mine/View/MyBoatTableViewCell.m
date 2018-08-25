//
//  MyBoatTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyBoatTableViewCell.h"

#import "MyBoatModel.h"

@interface MyBoatTableViewCell()

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UILabel * approveLable;

@property (nonatomic, weak) UILabel * typeLable;

@property (nonatomic, weak) UILabel * levelLable;

@property (nonatomic, weak) UIButton * detailButton;

@property (nonatomic, weak) UILabel * messageLable;

@property (nonatomic, weak) UILabel * currentLable;

@property (nonatomic, weak) UIButton * changeButton;

@property (nonatomic, weak) UIButton * editButton;

@property (nonatomic, weak) UIButton * deleteButton;

@end

@implementation MyBoatTableViewCell

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
    UIView * topLineView = [[UIView alloc]init];
    topLineView.backgroundColor = XXJColor(242, 242, 242);
    topLineView.alpha= 0.5;
    [self.contentView addSubview:topLineView];
    [topLineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.equalTo(realH(20));
    }];
    
    
    //船名
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"黄金梅丽号   500吨"];
    [nameLable sizeToFit];
    [self.contentView addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(topLineView.bottom).offset(realH(30));
    }];
    self.nameLable = nameLable;
    
    
    //是否认证
    UILabel * approveLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"未认证"];
    [approveLable sizeToFit];
    [self.contentView addSubview:approveLable];
    [approveLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.top.equalTo(topLineView.bottom).offset(realH(30));
    }];
    self.approveLable = approveLable;
    
    
    //船舶类型
    UILabel * typeLable = [UILabel lableWithTextColor:XXJColor(157, 157, 157) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"船舶类型"];
    [typeLable sizeToFit];
    [self.contentView addSubview:typeLable];
    [typeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(nameLable.bottom).offset(realH(30));
    }];
    self.typeLable = typeLable;
    
    //级别levelLable
    UILabel * levelLable = [UILabel lableWithTextColor:XXJColor(157, 157, 157) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"油船1级"];
    levelLable.numberOfLines = 0;
    [levelLable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [levelLable setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    levelLable.preferredMaxLayoutWidth = SCREEN_WIDTH - realW(300);
    [levelLable sizeToFit];
    [self.contentView addSubview:levelLable];
    [levelLable makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(typeLable.right).offset(realW(20));
        make.left.equalTo(self.contentView).offset(realW(180));
        make.top.equalTo(nameLable.bottom).offset(realH(30));
        make.right.equalTo(self.contentView).offset(realW(-120));
    }];
    self.levelLable = levelLable;
    
    
    //详情
    UIButton * detailButton = [[UIButton alloc]init];
    [detailButton setTitle:@"报空中" forState:UIControlStateNormal];
    [detailButton setTitleColor:XXJColor(30, 115, 169) forState:UIControlStateNormal];
    detailButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
//    [detailButton setImage:[UIImage imageNamed:@"form_icon_arrow04"] forState:UIControlStateNormal];
//    [detailButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(5)];
    [detailButton sizeToFit];
    [self.contentView addSubview:detailButton];
    [detailButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.centerY.equalTo(typeLable);
    }];
    self.detailButton = detailButton;
    
    //船舶信息
    UILabel * messageLable = [UILabel lableWithTextColor:XXJColor(157, 157, 157) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"船长:18米  船宽:8米  满载吃水:5米"];
    [messageLable sizeToFit];
    [self.contentView addSubview:messageLable];
    [messageLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(levelLable.bottom).offset(realH(30));
    }];
    self.messageLable = messageLable;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha= 0.5;
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(messageLable.bottom).offset(realH(30));
        make.height.equalTo(realH(1));
    }];
    
    
    //当前业务员
    UILabel * currentLable = [UILabel lableWithTextColor:XXJColor(157, 157, 157) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"当前业务员:张三"];
    [currentLable sizeToFit];
    [self.contentView addSubview:currentLable];
    [currentLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(lineView.bottom).offset(realH(40));
        make.bottom.equalTo(self.contentView).offset(realH(-40));
    }];
    self.currentLable = currentLable;
    
    
    //变更业务员
    UIButton * changeButton = [[UIButton alloc]init];
    [changeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [changeButton setTitle:@"变更业务员" forState:UIControlStateNormal];
    [changeButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    changeButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    changeButton.backgroundColor = XXJColor(116, 159, 227);
    changeButton.layer.cornerRadius = 5;
    changeButton.clipsToBounds = YES;
    [self.contentView addSubview:changeButton];
    [changeButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.centerY.equalTo(currentLable);
        make.size.equalTo(CGSizeMake(realW(200), realH(60)));
    }];
    self.changeButton = changeButton;
    
    //编辑
    UIButton * editButton = [[UIButton alloc]init];
    [editButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    editButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    editButton.backgroundColor = XXJColor(116, 159, 227);
    editButton.layer.cornerRadius = 5;
    editButton.clipsToBounds = YES;
    [self.contentView addSubview:editButton];
    [editButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(changeButton.left).offset(realW(-10));
        make.centerY.equalTo(currentLable);
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
    }];
    self.editButton = editButton;
    
    //删除
    UIButton * deleteButton = [[UIButton alloc]init];
    [deleteButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    deleteButton.backgroundColor = XXJColor(116, 159, 227);
    deleteButton.layer.cornerRadius = 5;
    deleteButton.clipsToBounds = YES;
    [self.contentView addSubview:deleteButton];
    [deleteButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(editButton.left).offset(realW(-10));
        make.centerY.equalTo(currentLable);
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
    }];
    self.deleteButton = deleteButton;
    
}




-(void)setModel:(MyBoatModel *)model
{
    _model = model;

    if ([model.is_admin isEqualToString:@"1"]) {
        self.changeButton.alpha = 1;
    }
    else
    {
        self.changeButton.alpha = 0;
    }
    
    
    self.nameLable.text = [NSString stringWithFormat:@"%@ %@吨",model.name,model.deadweight];
    
    self.approveLable.text = model.review_status_name;
    
    self.levelLable.text = model.type_name;
    
    
    

    
    
    
    self.messageLable.text = [NSString stringWithFormat:@"船长:%@米  船宽:%@米 满载吃水:%@米",model.length,model.width,model.draught];
    
    self.currentLable.text = [NSString stringWithFormat:@"当前业务员:%@",model.contact_person];
    
    if ([model.review_status_name isEqualToString:@"认证通过"]) {
        self.detailButton.alpha = 1;
        
        NSString * detailStr = nil;
        if ([model.status isEqualToString:@"1"]) {
            detailStr = @"已禁用";
        }
        else
        {
            if ([model.shipping.shipping_status_name isEqualToString:@"未报空"]) {
                detailStr = @"未报空";
            }
            else
            {
                detailStr = @"报空中";
            }
        }
        [self.detailButton setTitle:detailStr forState:UIControlStateNormal];
        
        
        [self.editButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(0), realH(60)));
        }];
        self.deleteButton.alpha = 0;
    }
    else
    {
        self.detailButton.alpha = 0;
        
        [self.editButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(100), realH(60)));
        }];
        self.deleteButton.alpha = 1;
    }
    
    
    if ([model.review_status_name isEqualToString:@"认证失败"]) {
        self.editButton.alpha = 1;
        [self.deleteButton updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.editButton.left).offset(realW(-10));
        }];
    }
    else
    {
        self.editButton.alpha = 0;
        [self.deleteButton updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.changeButton.left).offset(realW(-10));
        }];
    }
    
    
}





-(void)buttonClick:(UIButton *)button
{
    NSString * str = nil;
    if ([button.currentTitle isEqualToString:@"删除"]) {
        if ([self.model.review_status_name isEqualToString:@"认证通过"]) {
            str = @"认证通过";
        }else
        {
            str = @"删除";
        }
        
    }
    else if ([button.currentTitle isEqualToString:@"编辑"])
    {
        str = @"编辑";
    }
    else if ([button.currentTitle isEqualToString:@"变更业务员"])
    {
//        if ([UseInfo shareInfo].is_admin) {
            str = @"变更业务员";
//        }
        
    }
    
    if (self.myBoatBlock) {
        self.myBoatBlock(str,self.model.ship_id);
    }
}




































@end
