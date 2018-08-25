//
//  MessageDetailTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MessageDetailTableViewCell.h"

#import "MessageDetailModel.h"

@interface MessageDetailTableViewCell()

@property (nonatomic, weak) UIView * backView;

@property (nonatomic, weak) UILabel * timeLable;

@property (nonatomic, weak) UILabel * titleLable;

@property (nonatomic, weak) UIImageView * image_View;

@property (nonatomic, weak) UILabel * detailLable;

@property (nonatomic, weak) UILabel * checkLable;

@property (nonatomic, weak) UIImageView * arrowImageView;

@property (nonatomic, weak) UIView * lineView;

@end

@implementation MessageDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = XXJColor(234, 239, 245);
        
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    UILabel * timeLable = [UILabel lableWithTextColor:[UIColor whiteColor] textFontSize:realFontSize(24) fontFamily:PingFangSc_Regular text:@"1111"];
    timeLable.backgroundColor = [UIColor lightGrayColor];
    timeLable.layer.cornerRadius = realW(5);
    timeLable.clipsToBounds = YES;
    timeLable.textAlignment = NSTextAlignmentCenter;
//    [timeLable sizeToFit];
    [self.contentView addSubview:timeLable];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(realH(10));
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(realW(150));
        make.height.equalTo(realH(30));
    }];
    self.timeLable = timeLable;
    
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = realW(5);
    backView.clipsToBounds = YES;
    [self.contentView addSubview:backView];
    [backView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLable.bottom).offset(realH(20));
        make.left.equalTo(self.contentView).offset(realW(20));
        make.right.equalTo(self.contentView).offset(realW(-20));
//        make.height.equalTo(realH(150));
        make.bottom.equalTo(self.contentView.bottom).offset(realH(-20));
    }];
    self.backView = backView;
    
    //标题
    UILabel * titleLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Medium text:@"2222222222222222222222222222"];
    [titleLable sizeToFit];
    [backView addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(realW(40));
        make.top.equalTo(backView).offset(realH(20));
        make.height.equalTo(realH(32));
    }];
    self.titleLable = titleLable;
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.image = [UIImage imageNamed:@"ic_launcher"];
    [backView addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(realW(40));
        make.top.equalTo(titleLable.bottom).offset(realH(30));
        make.right.equalTo(backView).offset(realW(-40));
        make.height.equalTo(0);
    }];
    self.image_View = imageView;
    
    
    UILabel * detailLable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333"];
    detailLable.numberOfLines = 0;
    [detailLable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [detailLable setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    detailLable.preferredMaxLayoutWidth = SCREEN_WIDTH - 2 * realW(20) - 2 * realW(40);
    [backView addSubview:detailLable];
    [detailLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.bottom).offset(realH(20));
        make.left.equalTo(backView.left).offset(realW(40));
    }];
    self.detailLable = detailLable;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.4;
    [backView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(realW(40));
        make.right.equalTo(backView).offset(realW(-40));
        make.top.equalTo(detailLable.bottom).offset(realH(20));
        make.height.equalTo(realH(1));
    }];
    self.lineView = lineView;
    
    UILabel * checkLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"查看详情"];
    [checkLable sizeToFit];
    [backView addSubview:checkLable];
    [checkLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(realW(40));
        make.top.equalTo(lineView.bottom).offset(realH(20));
        make.bottom.equalTo(backView.bottom).offset(realH(-20));
    }];
    self.checkLable = checkLable;
    
    UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_xq_03"]];
    [arrowImageView sizeToFit];
    [backView addSubview:arrowImageView];
    [arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(checkLable);
        make.right.equalTo(backView).offset(realW(-40));
    }];
    self.arrowImageView = arrowImageView;
    
//    [backView makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.contentView.bottom).offset(realH(-20));
//    }];
   
    
}


-(void)setModel:(MessageDetailModel *)model
{
    _model = model;
    
    self.timeLable.text = [TYDateUtils timestampSwitchTime:[model.u_time integerValue]];
    
    self.titleLable.text = model.title;
    
    
    if (self.model.image_url) {
        if ([self.model.image_url isEqualToString: @"0"]) {
            [self.imageView updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(0);
            }];
        }
        else
        {
            [self.image_View updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo((SCREEN_WIDTH - realH(40)) * 9 / 16);
            }];
            [self.image_View sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
        }
    }
    else
    {
        [self.imageView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    }
    
    
    self.detailLable.text = model.summary;
    
    
    
}


-(void)setFromTag:(NSString *)fromTag
{
    _fromTag = fromTag;
    if ([self.fromTag isEqualToString:@"系统消息"]) {
        self.checkLable.alpha = 0;
        self.arrowImageView.alpha = 0;
        [self.lineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView).offset(realW(40));
            make.right.equalTo(self.backView).offset(realW(-40));
            make.top.equalTo(self.detailLable.bottom).offset(realH(20));
            make.height.equalTo(realH(1));
            make.bottom.equalTo(self.backView.bottom).offset(realH(-0));
        }];
    }
}





@end
