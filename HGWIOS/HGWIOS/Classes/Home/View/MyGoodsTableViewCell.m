//
//  MyGoodsTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyGoodsTableViewCell.h"

#import "AlreadyOfferModel.h"

@interface MyGoodsTableViewCell()

@property (nonatomic, weak) UILabel * topLable;



@property (nonatomic, weak) UILabel * startLocationLable;

@property (nonatomic, weak) UILabel * endLocationLable;

@property (nonatomic, weak) UILabel * materialsLable;

@property (nonatomic, weak) UILabel * weightLable;

@property (nonatomic, weak) UILabel * startLable;

@property (nonatomic, weak) UILabel * overLable;

//@property (nonatomic, weak) UILabel * bidLable;
//
////@property (nonatomic, weak) UILabel * countLable;
//
//@property (nonatomic, weak) UIButton * deleteButton;
//
//@property (nonatomic, weak) UIButton * updateButton;
//
//@property (nonatomic, weak) UIButton * refreshButton;
//
//@property (nonatomic, weak) UIButton * allotButton;

@property (nonatomic, weak) UIButton * preButton;

@end

@implementation MyGoodsTableViewCell

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
    
    
    UILabel * topLable = [UILabel lableWithTextColor:XXJColor(120, 120, 120) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"货盘编号:HP180515115afa55f17af7c6"];
    [topLable sizeToFit];
    [self.contentView addSubview:topLable];
    [topLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(self.contentView).offset(realH(20));
    }];
    self.topLable = topLable;

    UILabel * alreadyLable = [UILabel lableWithTextColor:XXJColor(120, 120, 120) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"已开标"];
    [alreadyLable sizeToFit];
    [self.contentView addSubview:alreadyLable];
    [alreadyLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.top.equalTo(self.contentView).offset(realH(20));
    }];
    self.alreadyLable = alreadyLable;
    
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha= 0.5;
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(topLable.bottom).offset(realH(20));
        make.height.equalTo(realH(1));
    }];
    
    //第一行图片
    UIImageView * firstImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"locationUpdate"]];
    [self.contentView addSubview:firstImageView];
    [firstImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(20));
        make.top.equalTo(lineView.bottom).offset(realH(20));
    }];
    
    //起始位置
    UILabel * startLocationLable = [UILabel lableWithTextColor:[UIColor darkGrayColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"湖北鄂州"];
    [startLocationLable sizeToFit];
    [self.contentView addSubview:startLocationLable];
    [startLocationLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstImageView.right).offset(realW(20));
        make.centerY.equalTo(firstImageView);
    }];
    self.startLocationLable = startLocationLable;
    
    //箭头
    UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"to_rightUpdate"]];
    [self.contentView addSubview:arrowImageView];
    [arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startLocationLable.right).offset(realW(10));
        make.centerY.equalTo(startLocationLable);
    }];
    
    //终点位置
    UILabel * endLocationLable = [UILabel lableWithTextColor:[UIColor darkGrayColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"山东台儿庄"];
    [endLocationLable sizeToFit];
    [self.contentView addSubview:endLocationLable];
    [endLocationLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrowImageView.right).offset(realW(10));
        make.centerY.equalTo(firstImageView);
    }];
    self.endLocationLable = endLocationLable;
    

    //货盘种类
    UILabel * typeLable = [UILabel lableWithTextColor:[UIColor darkGrayColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"公开标价"];
    typeLable.alpha = 0;
    [typeLable sizeToFit];
    [self.contentView addSubview:typeLable];
    [typeLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.centerY.equalTo(firstImageView);
    }];
    self.typeLable = typeLable;
    
    
    
    //第二行图片
    UIImageView * secondImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_hm_03"]];
    [self.contentView addSubview:secondImageView];
    [secondImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(20));
        make.top.equalTo(firstImageView.bottom).offset(realH(20));
    }];
    
    
    //材料
    UILabel * materialsLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"钢材"];
    [materialsLable sizeToFit];
    [self.contentView addSubview:materialsLable];
    [materialsLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondImageView.right).offset(realW(20));
        make.centerY.equalTo(secondImageView);
    }];
    self.materialsLable = materialsLable;
    
    //间隔竖线
//    UIView * intervalView = [[UIView alloc]init];
//    intervalView.backgroundColor = XXJColor(115, 115, 115);
//    [self.contentView addSubview:intervalView];
//    [intervalView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(materialsLable.right).offset(realW(10));
//        make.centerY.equalTo(materialsLable);
//        make.size.equalTo(CGSizeMake(realW(1), realH(20)));
//    }];
    
    //吨位
    UILabel * weightLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"100吨  ±5%"];
    [weightLable sizeToFit];
    [self.contentView addSubview:weightLable];
    [weightLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(materialsLable.right).offset(realW(10));
        make.centerY.equalTo(secondImageView);
    }];
    self.weightLable = weightLable;
    
    
    
    //第三行图片
    UIImageView * thirdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_rq02_03"]];
    [self.contentView addSubview:thirdImageView];
    [thirdImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(20));
        make.top.equalTo(secondImageView.bottom).offset(realH(20));
    }];
    
    //起始时间
    UILabel * startLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"2018-05-11"];
    [startLable sizeToFit];
    [self.contentView addSubview:startLable];
    [startLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdImageView.right).offset(realW(20));
        make.centerY.equalTo(thirdImageView);
    }];
    self.startLable = startLable;
    
    //至
    UILabel * centerLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"至"];
    [centerLable sizeToFit];
    [self.contentView addSubview:centerLable];
    [centerLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startLable.right).offset(realW(20));
        make.centerY.equalTo(thirdImageView);
    }];
    
    //结束时间
    UILabel * overLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"2018-06-11"];
    [overLable sizeToFit];
    [self.contentView addSubview:overLable];
    [overLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerLable.right).offset(realW(20));
        make.centerY.equalTo(thirdImageView);
    }];
    self.overLable = overLable;
    
    
    UIView * centerLineView = [[UIView alloc]init];
//    centerLineView.backgroundColor = XXJColor(242, 242, 242);
    centerLineView.backgroundColor = [UIColor lightGrayColor];
    centerLineView.alpha = 0.5;
    [self.contentView addSubview:centerLineView];
    [centerLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdImageView.bottom).offset(realH(20));
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(realH(1));
    }];
    
 //中标情况下
    //中标船舶
    UILabel * bidLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:@"中标船舶:天空号 10元/吨"];
    [bidLable sizeToFit];
    [self.contentView addSubview:bidLable];
    [bidLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerLineView.bottom).offset(realH(30));
        make.left.equalTo(self.contentView).offset(10);
    }];
    self.bidLable = bidLable;
    
 //未中标情况下
//    UILabel * countLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(26) fontFamily:PingFangSc_Regular text:@"已有0人报价"];
//    countLable.alpha = 0;
//    [countLable sizeToFit];
//    [self.contentView addSubview:countLable];
//    [countLable makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(centerLineView.bottom).offset(realH(20));
//        make.left.equalTo(self.contentView).offset(10);
//    }];
//    self.countLable = countLable;
    
    UIButton * deleteButton = [[UIButton alloc]init];
    deleteButton.alpha = 0;
    [deleteButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    deleteButton.backgroundColor = XXJColor(116, 159, 227);
    deleteButton.layer.cornerRadius = 5;
    deleteButton.clipsToBounds = YES;
    [self.contentView addSubview:deleteButton];
    [deleteButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.top.equalTo(centerLineView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
    }];
    self.deleteButton = deleteButton;
    
    
    
    UIButton * updateButton = [[UIButton alloc]init];
    updateButton.alpha = 0;
    [updateButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [updateButton setTitle:@"修改" forState:UIControlStateNormal];
    [updateButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    updateButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    updateButton.backgroundColor = XXJColor(116, 159, 227);
    updateButton.layer.cornerRadius = 5;
    updateButton.clipsToBounds = YES;
    [self.contentView addSubview:updateButton];
    [updateButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(deleteButton.left).offset(realW(-10));
        make.top.equalTo(centerLineView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
    }];
    self.updateButton = updateButton;
    
    
    
    UIButton * refreshButton = [[UIButton alloc]init];
    refreshButton.alpha = 0;
    [refreshButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    refreshButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    refreshButton.backgroundColor = XXJColor(116, 159, 227);
    refreshButton.layer.cornerRadius = 5;
    refreshButton.clipsToBounds = YES;
    [self.contentView addSubview:refreshButton];
    [refreshButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(updateButton.left).offset(realW(-10));
        make.top.equalTo(centerLineView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
    }];
    self.refreshButton = refreshButton;
    
    
    
    UIButton * inviteButton = [[UIButton alloc]init];
    inviteButton.alpha = 0;
    [inviteButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [inviteButton setTitle:@"邀请" forState:UIControlStateNormal];
    [inviteButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    inviteButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    inviteButton.backgroundColor = XXJColor(116, 159, 227);
    inviteButton.layer.cornerRadius = 5;
    inviteButton.clipsToBounds = YES;
    [self.contentView addSubview:inviteButton];
    [inviteButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(refreshButton.left).offset(realW(-10));
        make.top.equalTo(centerLineView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
    }];
    self.inviteButton = inviteButton;
    
    
    
    UIButton * allotButton = [[UIButton alloc]init];
    allotButton.alpha = 0;
    [allotButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [allotButton setTitle:@"配船" forState:UIControlStateNormal];
    [allotButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    allotButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    allotButton.backgroundColor = XXJColor(116, 159, 227);
    allotButton.layer.cornerRadius = 5;
    allotButton.clipsToBounds = YES;
    [self.contentView addSubview:allotButton];
    [allotButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(inviteButton.left).offset(realW(-10));
        make.top.equalTo(centerLineView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
    }];
    self.allotButton = allotButton;
    
    
    
    
    
    
    
    UIButton * cancelButton = [[UIButton alloc]init];
    cancelButton.selected = YES;
    cancelButton.alpha = 0;
    [cancelButton addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"取消报价" forState:UIControlStateNormal];
    [cancelButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [cancelButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage createImageWithColor:XXJColor(116, 159, 227)] forState:UIControlStateSelected];
    cancelButton.layer.cornerRadius = 5;
    cancelButton.clipsToBounds = YES;
    [self.contentView addSubview:cancelButton];
    [cancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.top.equalTo(centerLineView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(160), realH(60)));
    }];
    self.cancelButton = cancelButton;
    
    
    
    UIButton * ingButton = [[UIButton alloc]init];
    ingButton.alpha = 0;
//    [ingButton addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
    [ingButton setTitle:@"报价中" forState:UIControlStateNormal];
    [ingButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    ingButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [ingButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [ingButton setBackgroundImage:[UIImage createImageWithColor:XXJColor(116, 159, 227)] forState:UIControlStateSelected];
    ingButton.layer.cornerRadius = 5;
    ingButton.clipsToBounds = YES;
    [self.contentView addSubview:ingButton];
    [ingButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-10));
        make.centerY.equalTo(firstImageView);
        make.size.equalTo(CGSizeMake(realW(130), realH(60)));
    }];
    self.ingButton = ingButton;
    
    
    //底部下划线
    UIView * bottomLineView = [[UIView alloc]init];
    bottomLineView.backgroundColor = XXJColor(242, 242, 242);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bidLable.bottom).offset(realH(30));
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(realH(20));
        make.bottom.equalTo(self.contentView);
    }];

}





-(void)buttonClick:(UIButton *)button
{
    NSString * str = nil;
    if ([button.currentTitle isEqualToString:@"删除"])
    {
        str = @"删除";
    }
    else if ([button.currentTitle isEqualToString:@"修改"])
    {
        if ([self.model.count isEqualToString:@"0"]) {
            str = @"修改";
        }
        else
        {
            str = @"无法修改";
        }
    }
    else if ([button.currentTitle isEqualToString:@"刷新"])
    {
        str = @"刷新";
    }
    else if ([button.currentTitle isEqualToString:@"配船"])
    {
        str = @"配船";
    }
    else if ([button.currentTitle isEqualToString:@"邀请"])
    {
        str = @"邀请";
    }
    else if ([button.currentTitle isEqualToString:@"关闭"])
    {
        str = @"关闭";
    }
    
    if (self.offerBlock) {
        self.offerBlock(str);
    }
    
}


-(void)chooseClick:(UIButton *)button
{
    if (self.offerBlock) {
        self.offerBlock(button.currentTitle);
    }
}




-(void)setModel:(AlreadyOfferModel *)model
{
    _model = model;
    
    if ([self.fromTag isEqualToString:@"我的货盘"]) {
        
        self.alreadyLable.text = model.status_name;
        
        self.topLable.text = [NSString stringWithFormat:@"货盘编号:%@",model.no];
        
        self.startLocationLable.text = [NSString stringWithFormat:@"%@%@",model.parent_b,model.b_port];
        
        self.endLocationLable.text = [NSString stringWithFormat:@"%@%@",model.parent_e,model.e_port];
        
        if ([model.cons_type isEqualToString:@"1"]) {
            self.typeLable.text = @"公开询价";
        }
        else
        {
            self.typeLable.text = @"指定询价";
        }
        
        self.materialsLable.text = model.cargo_type;
        
        self.weightLable.text = [NSString stringWithFormat:@"%@吨 ±%@%@",model.weight,model.weight_num,@"%"];
        
        self.startLable.text = [TYDateUtils timestampSwitchTime:[model.b_time integerValue]];
        
        self.overLable.text = [TYDateUtils timestampSwitchTime:[model.e_time integerValue]];
        
    
    
        
        if ([model.status_name isEqualToString:@"已过期"]) {
            self.bidLable.text = [NSString stringWithFormat:@"已有%@人报价",model.count];
            
            self.bidLable.textColor = XXJColor(116, 116, 116);
            self.bidLable.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
            
            if ([model.count integerValue] > 0) {
                self.bidLable.textColor = [UIColor redColor];
                self.bidLable.font = [UIFont fontWithName:PingFangSc_Medium size:realFontSize(28)];
            }
            else
            {
                self.bidLable.textColor = XXJColor(116, 116, 116);
                self.bidLable.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
            }

            self.deleteButton.alpha = 1;
            self.updateButton.alpha = 0;
            self.refreshButton.alpha = 0;
            self.allotButton.alpha = 0;
            self.inviteButton.alpha = 0;


            if ([model.cons_type isEqualToString:@"0"]) {
                //指定询价
                self.allotButton.alpha = 0;
                [self.allotButton setTitle:@"关闭" forState:UIControlStateNormal];
            }
            else
            {
                //公开询价
                self.allotButton.alpha = 0;
                [self.allotButton setTitle:@"配船" forState:UIControlStateNormal];
                
            }
        }
        else if ([model.status_name isEqualToString:@"报价中"])
        {
            self.bidLable.text = [NSString stringWithFormat:@"已有%@人报价",model.count];

            self.bidLable.textColor = XXJColor(116, 116, 116);
            self.bidLable.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
            
            
            self.deleteButton.alpha = 1;
            if ([model.count integerValue] > 0) {
                self.updateButton.alpha = 0;
                [self.refreshButton updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.deleteButton.left).offset(realW(-10));
                }];
                self.bidLable.textColor = [UIColor redColor];
                self.bidLable.font = [UIFont fontWithName:PingFangSc_Medium size:realFontSize(28)];
            }
            else
            {
                self.updateButton.alpha = 1;
                [self.refreshButton updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.updateButton.left).offset(realW(-10));
                }];
                self.bidLable.textColor = XXJColor(116, 116, 116);
                self.bidLable.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
            }
            self.refreshButton.alpha = 1;
            self.allotButton.alpha = 1;



            if ([model.cons_type isEqualToString:@"0"]) {
                //指定询价
                self.inviteButton.alpha = 1;

                [self.allotButton updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.inviteButton.left).offset(realW(-10));
                }];
                [self.allotButton setTitle:@"关闭" forState:UIControlStateNormal];
                
                if ([model.open isEqualToString:@"已失效"]) {
                    self.deleteButton.alpha = 1;
                    self.updateButton.alpha = 0;
                    self.refreshButton.alpha = 0;
                    self.allotButton.alpha = 0;
                    self.inviteButton.alpha = 0;
                    
                    self.alreadyLable.text = @"已开标";
                }
                
            }
            else
            {
                //公开询价
                self.inviteButton.alpha = 0;
                [self.allotButton updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.refreshButton.left).offset(realW(-10));
                }];
                [self.allotButton setTitle:@"配船" forState:UIControlStateNormal];
            }




        }
        else if ([model.status_name isEqualToString:@"已开标"])
        {
            self.bidLable.text = [NSString stringWithFormat:@"中标船舶:%@ %@",model.ship_name,model.money_show];
            self.bidLable.textColor = [UIColor redColor];
            self.bidLable.font = [UIFont fontWithName:PingFangSc_Medium size:realFontSize(28)];
            self.deleteButton.alpha = 0;
            self.updateButton.alpha = 0;
            self.refreshButton.alpha = 0;
            self.allotButton.alpha = 0;
            self.inviteButton.alpha = 0;

            if ([model.cons_type isEqualToString:@"0"]) {
                //指定询价
                self.allotButton.alpha = 0;
                [self.allotButton setTitle:@"关闭" forState:UIControlStateNormal];
            }
            else
            {
                //公开询价
                self.allotButton.alpha = 0;
                [self.allotButton setTitle:@"配船" forState:UIControlStateNormal];
                
            }


        }
        else if ([model.status_name isEqualToString:@"已关闭"])
        {
            self.bidLable.text = [NSString stringWithFormat:@"已有%@人报价",model.count];
            
            self.deleteButton.alpha = 1;
            if ([model.count integerValue] > 0) {
                self.updateButton.alpha = 0;
                [self.refreshButton updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.deleteButton.left).offset(realW(-10));
                }];
                self.bidLable.textColor = [UIColor redColor];
                self.bidLable.font = [UIFont fontWithName:PingFangSc_Medium size:realFontSize(28)];
            }
            else
            {
                self.updateButton.alpha = 0;
                [self.refreshButton updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.updateButton.left).offset(realW(-10));
                }];
                self.bidLable.textColor = XXJColor(116, 116, 116);
                self.bidLable.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
            }
            self.refreshButton.alpha = 0;
            self.allotButton.alpha = 0;
            self.inviteButton.alpha = 0;
            

        }
        
        
        
        
    }
    else
    {
        self.topLable.text = [NSString stringWithFormat:@"货盘编号:%@",model.cargo.no];
        
        self.startLocationLable.text = model.cargo.b_port;
        
        self.endLocationLable.text = model.cargo.e_port;
        
        self.materialsLable.text = model.cargo.cargo_type;
        
        self.weightLable.text = [NSString stringWithFormat:@"%@吨 ±%@%@",model.cargo.weight,model.cargo.weight_num,@"%"];
        
        self.startLable.text = [TYDateUtils timestampSwitchTime:[model.cargo.c_time integerValue]];
        
        self.overLable.text = [TYDateUtils timestampSwitchTime:[model.cargo.valid_time integerValue]];
        
        
        self.bidLable.text = [NSString stringWithFormat:@"%@元/吨",model.money];
        self.bidLable.textColor = XXJColor(116, 116, 116);
        self.bidLable.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
        
        
        if ([model.type_name isEqualToString:@"报价中"]) {
            [self.ingButton setTitle:@"报价中" forState:UIControlStateNormal];
            [self.cancelButton setTitle:@"取消报价" forState:UIControlStateNormal];
        }
        else
        {
            [self.ingButton setTitle:@"未中标" forState:UIControlStateNormal];
            [self.cancelButton setTitle:@"删除报价" forState:UIControlStateNormal];
        }
    }
    
    
    
}






















@end
