//
//  HomeTableViewCell.m
//  HGWIOS
//
//  Created by 许小军 on 2018/5/14.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "HomeTableViewCell.h"

#import "HomeBoatModel.h"

@interface HomeTableViewCell()

@property (nonatomic, weak) UIButton * iconButton;

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UIButton * scoreButton;

@property (nonatomic, weak) UILabel * aroundLable;

@property (nonatomic, weak) UILabel * boatNameLable;

@property (nonatomic, weak) UILabel * tonnageLable;

@property (nonatomic, weak) UILabel * levelLable;

@property (nonatomic, weak) UILabel * timeLable;

@property (nonatomic, weak) UILabel * addressLable;

@property (nonatomic, weak) UILabel * startLable;

@property (nonatomic, weak) UILabel * overLable;

@end

@implementation HomeTableViewCell

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
    self.topLineView = topLineView;
    
    UIButton * iconButton = [[UIButton alloc]init];
    [iconButton setTitle:@"张" forState:UIControlStateNormal];
    iconButton.backgroundColor = XXJColor(96, 143, 236);
    iconButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    iconButton.layer.cornerRadius = realW(50);
    iconButton.clipsToBounds = YES;
    [self.contentView addSubview:iconButton];
    [iconButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(30));
        make.top.equalTo(topLineView.bottom).offset(realH(10));
        make.size.equalTo(CGSizeMake(realW(100), realH(100)));
    }];
    self.iconButton = iconButton;
    
    
    
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(35) fontFamily:PingFangSc_Regular text:@"张从严"];
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
    UILabel * timeLable = [UILabel lableWithTextColor:XXJColor(207, 207, 207) textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"24天10时17分"];
    [timeLable sizeToFit];
    [self.contentView addSubview: timeLable];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLable);
        make.right.equalTo(self.contentView.right).offset(realW(-20));
    }];
    self.timeLable = timeLable;
    
    //周边
    UILabel * aroundLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:@"周边\n船盘"];
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
        make.top.equalTo(iconButton.bottom).offset(realH(10));
        make.height.equalTo(realH(1));
    }];
    
    //第一行图片
    UIImageView * firstImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ship_icon_ship"]];
    [self.contentView addSubview:firstImageView];
    [firstImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(10));
        make.top.equalTo(lineView.bottom).offset(realH(20));
    }];
    
    //船名
    UILabel * boatNameLable = [UILabel lableWithTextColor:[UIColor darkGrayColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"黄金梅丽号"];
    [boatNameLable sizeToFit];
    [self.contentView addSubview:boatNameLable];
    [boatNameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstImageView.right).offset(realW(20));
        make.centerY.equalTo(firstImageView);
    }];
    self.boatNameLable = boatNameLable;
    
    //吨位
    UILabel * tonnageLable = [UILabel lableWithTextColor:[UIColor darkGrayColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"500吨"];
    [tonnageLable sizeToFit];
    [self.contentView addSubview:tonnageLable];
    [tonnageLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(boatNameLable.right).offset(realW(20));
        make.centerY.equalTo(boatNameLable);
    }];
    self.tonnageLable = tonnageLable;
    
    
    //级别
    UILabel * levelLable = [UILabel lableWithTextColor:[UIColor darkGrayColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"油船1级"];
    [levelLable sizeToFit];
    [self.contentView addSubview:levelLable];
    [levelLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tonnageLable.right).offset(realW(20));
        make.centerY.equalTo(boatNameLable);
    }];
    self.levelLable = levelLable;
    
    
    
    
    
    
    
    
    
    //第二行图片
    UIImageView * secondImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_k"]];
    [self.contentView addSubview:secondImageView];
    [secondImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(10));
        make.top.equalTo(firstImageView.bottom).offset(realH(20));
    }];
    
    
    //地址
    UILabel * addressLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"上海"];
    [addressLable sizeToFit];
    [self.contentView addSubview:addressLable];
    [addressLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondImageView.right).offset(realW(20));
        make.centerY.equalTo(secondImageView);
    }];
    self.addressLable = addressLable;
    
    
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
        make.centerY.equalTo(secondImageView);
        make.centerX.equalTo(timeLable).offset(realW(20));
    }];
    
    
    
    
    
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
    
}

#pragma mark -- 打电话
-(void)phoneClick
{
    if (self.phoneBlock) {
        self.phoneBlock(self.model.user.mobile);
    }
}




-(void)setModel:(HomeBoatModel *)model
{
    _model = model;
    
    //姓
    [self.iconButton setTitle:model.user.surname forState:UIControlStateNormal];
    
    //名字
    self.nameLable.text = model.username;
    
    [self.scoreButton setTitle:[NSString stringWithFormat:@"信任值%@",model.user.total_comment_sroce] forState:UIControlStateNormal];
    
    //船名
    self.boatNameLable.text = model.name;
    
    //吨位
    self.tonnageLable.text = [NSString stringWithFormat:@"%@吨",model.ship.deadweight];
    
    //级别
    self.levelLable.text = model.ship.type_name;
    
    //倒计时
    self.timeLable.text = model.valid_data;
    
    //港口
    self.addressLable.text = model.n_port;
    
    //出发时间
    self.startLable.text = [self timestampSwitchTime:[model.n_time integerValue]];
    
    //截止时间
    self.overLable.text = [self timestampSwitchTime:[model.e_n_time integerValue]];
    
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
