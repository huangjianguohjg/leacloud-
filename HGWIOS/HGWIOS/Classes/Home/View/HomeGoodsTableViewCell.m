//
//  HomeGoodsTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "HomeGoodsTableViewCell.h"

#import "HomeGoodsModel.h"

@interface HomeGoodsTableViewCell()

@property (nonatomic, weak) UIButton * iconButton;

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UIButton * scoreButton;

@property (nonatomic, weak) UILabel * aroundLable;

@property (nonatomic, weak) UILabel * timeLable;

@property (nonatomic, weak) UILabel * startLocationLable;

@property (nonatomic, weak) UILabel * endLocationLable;

@property (nonatomic, weak) UILabel * materialsLable;

@property (nonatomic, weak) UILabel * weightLable;

@property (nonatomic, weak) UILabel * startLable;

@property (nonatomic, weak) UILabel * overLable;



@end

@implementation HomeGoodsTableViewCell

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
    
    //底部下划线
    UIView * topLineView = [[UIView alloc]init];
    topLineView.backgroundColor = XXJColor(242, 242, 242);
    [self.contentView addSubview:topLineView];
    [topLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(realH(20));
    }];
    
    
    
    UIButton * iconButton = [[UIButton alloc]init];
    [iconButton setTitle:@"张" forState:UIControlStateNormal];
    iconButton.backgroundColor = XXJColor(96, 143, 236);
    iconButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    iconButton.layer.cornerRadius = realW(50);
    iconButton.clipsToBounds = YES;
    [self.contentView addSubview:iconButton];
    [iconButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(30));
        make.top.equalTo(topLineView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(100)));
    }];
    self.iconButton = iconButton;
    
    
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"张从严"];
    [self.contentView addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(realW(20));
        make.centerY.equalTo(iconButton);
    }];
    self.nameLable = nameLable;
    
    UIButton * scoreButton = [[UIButton alloc]init];
    [scoreButton setTitle:@"信任值0.60" forState:UIControlStateNormal];
    [scoreButton setTitleColor:XXJColor(164, 189, 238) forState:UIControlStateNormal];
    scoreButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
    scoreButton.layer.borderWidth = realW(2);
    scoreButton.layer.borderColor = XXJColor(164, 189, 238).CGColor;
    [self.contentView addSubview:scoreButton];
    [scoreButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.right).offset(realW(20));
        make.centerY.equalTo(nameLable);
        make.width.equalTo(realW(180));
        make.height.equalTo(realH(40));
    }];
    self.scoreButton = scoreButton;
    

    
    //时间
    UILabel * timeLable = [UILabel lableWithTextColor:XXJColor(207, 207, 207) textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:@"24天10时17分"];
    [timeLable sizeToFit];
    [self.contentView addSubview: timeLable];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(scoreButton);
        make.right.equalTo(self.contentView.right).offset(realW(-20));
    }];
    self.timeLable = timeLable;
    
    //周边
    UILabel * aroundLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:@"周边\n货盘"];
    aroundLable.numberOfLines = 0;
    [aroundLable sizeToFit];
    aroundLable.alpha = 0;
    [self.contentView addSubview: aroundLable];
    [aroundLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(scoreButton);
        make.right.equalTo(timeLable.left).offset(realW(-20));
    }];
    self.aroundLable = aroundLable;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha= 0.5;
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(iconButton.bottom).offset(realH(20));
        make.height.equalTo(realH(1));
    }];
    
    //第一行图片
    UIImageView * firstImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"locationUpdate"]];
    [self.contentView addSubview:firstImageView];
    [firstImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(10));
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
    
    
    
    
    UIButton * phoneButton = [[UIButton alloc]init];
    [phoneButton addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton setTitle:@"打电话" forState:UIControlStateNormal];
    phoneButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
    [phoneButton setImage:[UIImage imageNamed:@"ins_icon_phone"] forState:UIControlStateNormal];
    [phoneButton setTitleColor:XXJColor(87, 166, 237) forState:UIControlStateNormal];
    [phoneButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:realH(10)];
    [phoneButton sizeToFit];
    [self.contentView addSubview:phoneButton];
    [phoneButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstImageView.bottom);
        make.centerX.equalTo(timeLable).offset(realW(20));
    }];
    
    
    //第二行图片
    UIImageView * secondImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_hm_03"]];
    [self.contentView addSubview:secondImageView];
    [secondImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(10));
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
    
    
//    //间隔竖线
//    UIView * intervalView = [[UIView alloc]init];
//    intervalView.backgroundColor = XXJColor(115, 115, 115);
//    [self.contentView addSubview:intervalView];
//    [intervalView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(materialsLable.right).offset(realW(10));
//        make.centerY.equalTo(materialsLable);
//        make.size.equalTo(CGSizeMake(realW(1), realH(20)));
//    }];
    
    //吨位
    UILabel * weightLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"100吨  ±1%"];
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
        make.left.equalTo(self.contentView.left).offset(realW(10));
        make.top.equalTo(secondImageView.bottom).offset(realH(20));
        make.bottom.equalTo(self.contentView).offset(realH(-20));
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
    
//    //底部下划线
//    UIView * bottomLineView = [[UIView alloc]init];
//    bottomLineView.backgroundColor = XXJColor(242, 242, 242);
//    [self.contentView addSubview:bottomLineView];
//    [bottomLineView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(thirdImageView.bottom).offset(realH(20));
//        make.left.right.equalTo(self.contentView);
//        make.height.equalTo(realH(20));
//        make.bottom.equalTo(self.contentView);
//    }];
//
}

#pragma mark -- 打电话
-(void)phoneClick
{
    if (self.phoneBlock) {
        self.phoneBlock(self.model.user.mobile);
    }
}

-(void)setModel:(HomeGoodsModel *)model
{
    _model = model;
    
    //姓
    [self.iconButton setTitle:model.user.surname forState:UIControlStateNormal];
    
    //姓名
    self.nameLable.text = model.username;
    
    //信用分
    [self.scoreButton setTitle:[NSString stringWithFormat:@"信任值%@",model.user.total_comment_sroce] forState:UIControlStateNormal];
    
    //倒计时时间
    self.timeLable.text = model.valid_data;
    
    //起始位置
    self.startLocationLable.text = model.b_port;
    
    //目的位置
    self.endLocationLable.text = model.e_port;
    
    //起始时间
    self.startLable.text = [self timestampSwitchTime:[model.b_time integerValue]];
    
    //目的时间
    self.overLable.text = [self timestampSwitchTime:[model.e_time integerValue]];
    
    //材料
    self.materialsLable.text = model.cargo_type_name;
    
    //重量
    self.weightLable.text = [NSString stringWithFormat:@"%@吨 ±%@%@",model.weight,model.weight_num,@"%"];
    
    if ([model.around isEqualToString:@"1"]) {
        self.aroundLable.alpha = 1;
    }
    else
    {
        self.aroundLable.alpha = 0;
    }
    
}




#pragma mark - 将某个时间戳转化成 时间
- (NSString *)timestampSwitchTime:(NSInteger)timestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
//    NSLog(@"1296035591  = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}



















@end
