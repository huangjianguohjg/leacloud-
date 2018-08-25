//
//  TransportTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "TransportTableViewCell.h"

#import "AlreadyOfferModel.h"

@interface TransportTableViewCell()

@property (nonatomic, weak) UILabel * startAddressLable;

@property (nonatomic, weak) UILabel * endAddressLable;

@property (nonatomic, weak) UILabel * numberLable;

@property (nonatomic, weak) UILabel * materialsLable;

@property (nonatomic, weak) UILabel * startLable;

@property (nonatomic, weak) UILabel * overLable;

@property (nonatomic, weak) UILabel * payTypeLable;

@property (nonatomic, weak) UILabel * typeLable;

@property (nonatomic, weak) UIButton * typeButton;

@property (nonatomic, weak) UILabel * priceLable;


@end

@implementation TransportTableViewCell

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
    UIView * bottomLineView = [[UIView alloc]init];
    bottomLineView.backgroundColor = XXJColor(242, 242, 242);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(realH(20));
    }];
    
    UILabel * numberLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"运单编号:123456789545645"];
    [numberLable sizeToFit];
    [self.contentView addSubview:numberLable];
    [numberLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(bottomLineView.bottom).offset(realH(20));
//        make.width.equalTo(realW(120));
    }];
    self.numberLable = numberLable;
    
    
    
    UILabel * startAddressLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"河南郑州"];
    [startAddressLable sizeToFit];
    [self.contentView addSubview:startAddressLable];
    [startAddressLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(numberLable.bottom).offset(realH(20));
//        make.width.equalTo(realW(80));
    }];
    self.startAddressLable = startAddressLable;
    
    
    UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"to_rightUpdate"]];
    [arrowImageView sizeToFit];
    [self.contentView addSubview:arrowImageView];
    [arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startAddressLable.right).offset(realW(20));
        make.centerY.equalTo(startAddressLable);
        make.size.equalTo(CGSizeMake(realW(38), realH(38)));
    }];
    
    
    
    
    UILabel * endAddressLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"江西九江"];
    [endAddressLable sizeToFit];
    [self.contentView addSubview:endAddressLable];
    [endAddressLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrowImageView.right).offset(realW(20));
        make.top.equalTo(numberLable.bottom).offset(realH(20));
//        make.right.equalTo(self.contentView).offset(realW(-20));
    }];
    self.endAddressLable = endAddressLable;
    
    
    
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha= 0.5;
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(startAddressLable.bottom).offset(realH(20));
        make.height.equalTo(realH(1));
    }];
    
    //第一行图片
    UIImageView * firstImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ship_icon_ship"]];
    [self.contentView addSubview:firstImageView];
    [firstImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(20));
        make.top.equalTo(lineView.bottom).offset(realH(20));
    }];
    
    //材料
    UILabel * materialsLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"钢材 8000 9%"];
    [materialsLable sizeToFit];
    [self.contentView addSubview:materialsLable];
    [materialsLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstImageView.right).offset(realW(20));
        make.centerY.equalTo(firstImageView);
    }];
    self.materialsLable = materialsLable;
    
   
    //第二行图片
    UIImageView * secondImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_rq02_03"]];
    [self.contentView addSubview:secondImageView];
    [secondImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(20));
        make.top.equalTo(firstImageView.bottom).offset(realH(20));
    }];
    
    //起始时间
    UILabel * startLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"2018-05-11"];
    [startLable sizeToFit];
    [self.contentView addSubview:startLable];
    [startLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondImageView.right).offset(realW(20));
        make.centerY.equalTo(secondImageView);
    }];
    self.startLable = startLable;
    
    //至
    UILabel * centerLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"至"];
    [centerLable sizeToFit];
    [self.contentView addSubview:centerLable];
    [centerLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startLable.right).offset(realW(20));
        make.centerY.equalTo(secondImageView);
    }];
    
    //结束时间
    UILabel * overLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"2018-06-11"];
    [overLable sizeToFit];
    [self.contentView addSubview:overLable];
    [overLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerLable.right).offset(realW(20));
        make.centerY.equalTo(secondImageView);
    }];
    self.overLable = overLable;
    
    
    //中标价
    UILabel * biddingLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"中标价"];
    [biddingLable sizeToFit];
    [self.contentView addSubview:biddingLable];
    [biddingLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-40));
        make.bottom.equalTo(secondImageView.top).offset(realH(20));
    }];
    
    //单价
    UILabel * priceLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(40) fontFamily:PingFangSc_Regular text:@"66元/吨"];
    [priceLable sizeToFit];
    [self.contentView addSubview:priceLable];
    [priceLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-5));
        make.top.equalTo(biddingLable.bottom).offset(realH(5));
    }];
    self.priceLable = priceLable;
    

    //第三行图片
    UIImageView * thirdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dyna_icon_recharge"]];
    [self.contentView addSubview:thirdImageView];
    [thirdImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(realW(20));
        make.top.equalTo(secondImageView.bottom).offset(realH(20));
    }];
    
    
    //金额方式
    UILabel * payTypeLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"开航金 + 0.6结算款"];
    [payTypeLable sizeToFit];
    [self.contentView addSubview:payTypeLable];
    [payTypeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdImageView.right).offset(realW(20));
        make.centerY.equalTo(thirdImageView);
    }];
    self.payTypeLable = payTypeLable;
    
   
    
    UIView * centerLineView = [[UIView alloc]init];
    centerLineView.backgroundColor = [UIColor lightGrayColor];
    centerLineView.alpha = 0.5;
    [self.contentView addSubview:centerLineView];
    [centerLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdImageView.bottom).offset(realH(20));
        make.left.equalTo(self.contentView).offset(realW(20));
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.height.equalTo(realH(1));
    }];
    
    //状况
    UILabel * typeLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"双方未签订合同"];
    [typeLable sizeToFit];
    [self.contentView addSubview:typeLable];
    [typeLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerLineView.bottom).offset(realH(30));
        make.left.equalTo(self.contentView).offset(20);
    }];
    self.typeLable = typeLable;
    
    
    
    UIButton * typeButton = [[UIButton alloc]init];
    [typeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [typeButton setTitle:@"等待对方签订合同" forState:UIControlStateNormal];
    [typeButton setTitleColor:XXJColor(63, 86, 124) forState:UIControlStateNormal];
    typeButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    typeButton.backgroundColor = XXJColor(116, 159, 227);
    typeButton.layer.cornerRadius = 5;
    typeButton.clipsToBounds = YES;
    [typeButton sizeToFit];
    [self.contentView addSubview:typeButton];
    [typeButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(realW(-20));
        make.top.equalTo(centerLineView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
        make.bottom.equalTo(self.contentView).offset(realH(-20));
    }];
    self.typeButton = typeButton;
    
    
    
    
    
    
    
}






-(void)buttonClick:(UIButton *)button
{
    if (self.transportBlock) {
        self.transportBlock(button.currentTitle);
    }
}


-(void)setModel:(AlreadyOfferModel *)model
{
    _model = model;
    
    self.numberLable.text = [NSString stringWithFormat:@"运单编号:%@",model.deal_no];
    
    self.startAddressLable.text = [NSString stringWithFormat:@"%@",model.b_port];
    
    self.endAddressLable.text = [NSString stringWithFormat:@"%@",model.e_port];
    
    
    self.materialsLable.text = [NSString stringWithFormat:@"%@ %@吨 %@%@",model.cargo_type_name,model.weight,model.weight_num,@"%"];
    
    self.startLable.text = model.b_time;
    
    self.overLable.text = model.e_time;
    
    self.priceLable.text = model.money_show;
    
    self.payTypeLable.text = model.freight;
    
    if ([self.fromTag isEqualToString:@"待装货"]) {
        [self waitLoadGoods];
    }
    else if ([self.fromTag isEqualToString:@"待卸货"])
    {
        [self waitUnLoadGoods];
    }
    else if ([self.fromTag isEqualToString:@"待结算"])
    {
        [self closeAccount];
    }
    else if ([self.fromTag isEqualToString:@"待评价"])
    {
        [self waitDiscuss];
    }
    else if ([self.fromTag isEqualToString:@"全部"])
    {
        if ([model.deal_status isEqualToString:@"0"]) {
            //一结束
            [self alreadyEnd];
        }
        else if ([model.deal_status isEqualToString:@"1"])
        {
            //待装货
            [self waitLoadGoods];
        }
        else if ([model.deal_status isEqualToString:@"2"])
        {
            //待卸货
            [self waitUnLoadGoods];
        }
        else if ([model.deal_status isEqualToString:@"3"])
        {
            //待结算
            [self closeAccount];
        }
        else if ([model.deal_status isEqualToString:@"4"])
        {
            //待评价
            [self waitDiscuss];
        }
    }
    
    if (self.typeButton.currentTitle.length == 3) {
        [self.typeButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(150), realH(60)));
        }];
    }
    else if (self.typeButton.currentTitle.length == 4) {
        [self.typeButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(170), realH(60)));
        }];
    }
    else if (self.typeButton.currentTitle.length == 5)
    {
        [self.typeButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(190), realH(60)));
        }];
    }
    else if (self.typeButton.currentTitle.length == 6)
    {
        [self.typeButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(230), realH(60)));
        }];
    }
    else if (self.typeButton.currentTitle.length == 7)
    {
        [self.typeButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(280), realH(60)));
        }];
    }
    else if (self.typeButton.currentTitle.length == 8)
    {
        [self.typeButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(300), realH(60)));
        }];
    }
    else if (self.typeButton.currentTitle.length == 9)
    {
        [self.typeButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(330), realH(60)));
        }];
    }
    else if (self.typeButton.currentTitle.length == 10)
    {
        [self.typeButton updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(realW(350), realH(60)));
        }];
    }
    
    
}

//待装货
-(void)waitLoadGoods
{
    if ([[UseInfo shareInfo].identity isEqualToString:@"货主"])
    {
        
        if ([self.model.pay_type isEqualToString:@"0"])
        {
            //线下结算
            if ([self.model.s_sign_time isEqualToString:@"0"] || [self.model.s_sign_time isEqual:[NSNull null]] || self.model.s_sign_time == nil)
            {
                //船东未上传合同
                self.typeLable.text = @"对方未上传合同";
                [self.typeButton setTitle:@"等待对方上传" forState:UIControlStateNormal];
            }
            else
            {
                //船东已上传合同
                if ([self.model.bond isEqualToString:@"1"])
                {
                    //双方支付保证金
                    if ([self.model.s_payment_time isEqualToString:@"0"] || [self.model.s_payment_time isEqual:[NSNull null]] || self.model.s_payment_time == nil)
                    {
                        //船东未支付保证金
                        if ([self.model.c_payment_time isEqualToString:@"0"] || [self.model.c_payment_time isEqual:[NSNull null]] || self.model.c_payment_time == nil)
                        {
                            //货主未支付保证金
                            self.typeLable.text = @"双方未支付履约保证金";
                            [self.typeButton setTitle:@"支付履约保证金" forState:UIControlStateNormal];
                        }
                        else
                        {
                            //货主已支付保证金
                            self.typeLable.text = @"对方未支付履约保证金";
                            [self.typeButton setTitle:@"等待对方支付" forState:UIControlStateNormal];
                        }
                    }
                    else
                    {
                        //船东已支付保证金
                        if ([self.model.c_payment_time isEqualToString:@"0"] || [self.model.c_payment_time isEqual:[NSNull null]] || self.model.c_payment_time == nil)
                        {
                            //货主未支付保证金
                            if ([self.model.p_s_payment_time isEqualToString:@"0"] || [self.model.p_s_payment_time isEqual:[NSNull null]] || self.model.p_s_payment_time == nil)
                            {
                                //平台未确认船东支付了多少钱
                                self.typeLable.text = @"对方已支付履约保证金";
                                [self.typeButton setTitle:@"等待平台审核" forState:UIControlStateNormal];
                            }
                            else
                            {
                                //平台已确认船东支付了多少钱
                                self.typeLable.text = @"平台已确认对方保证金";
                                [self.typeButton setTitle:@"支付履约保证金" forState:UIControlStateNormal];
                            }
                        }
                        else
                        {
                            //货主已支付保证金
                            if ([self.model.p_s_payment_time isEqualToString:@"0"] || [self.model.p_s_payment_time isEqual:[NSNull null]] || self.model.p_s_payment_time == nil)
                            {
                                //平台未确认船东支付了多少钱
                                self.typeLable.text = @"对方已支付履约保证金";
                                [self.typeButton setTitle:@"等待平台审核" forState:UIControlStateNormal];
                            }
                            else
                            {
                                //平台已确认船东支付了多少钱
                                self.typeLable.text = @"双方已支付履约保证金";
                                [self.typeButton setTitle:@"等待对方上传发货单" forState:UIControlStateNormal];
                            }
                            
                        }
                    }
                }
                else if ([self.model.bond isEqualToString:@"0"])
                {
                    //无需支付保证金
                    self.typeLable.text = @"对方已上传合同";
                    [self.typeButton setTitle:@"等待对方上传发货单" forState:UIControlStateNormal];
                }
            }
        }
        else if ([self.model.pay_type isEqualToString:@"1"])
        {
            //平台结算
            if ([self.model.s_sign_time isEqualToString:@"0"] || [self.model.s_sign_time isEqual:[NSNull null]] || self.model.s_sign_time == nil )
            {
                //船东未上传合同
                if ([self.model.c_sign_time isEqualToString:@"0"] || [self.model.c_sign_time isEqual:[NSNull null]]  || self.model.c_sign_time == nil)
                {
                    //货主未上传合同
                    self.typeLable.text = @"双方未上传合同";
                    [self.typeButton setTitle:@"上传合同" forState:UIControlStateNormal];
                }
                else
                {
                    //货主已上传合同
                    self.typeLable.text = @"对方未上传合同";
                    [self.typeButton setTitle:@"等待对方上传合同" forState:UIControlStateNormal];
                }
                
            }
            else
            {
                //船东已上传合同
                if ([self.model.c_sign_time isEqualToString:@"0"] || [self.model.c_sign_time isEqual:[NSNull null]] || self.model.c_sign_time == nil )
                {
                    //货主未上传合同
                    self.typeLable.text = @"对方已上传合同";
                    [self.typeButton setTitle:@"上传合同" forState:UIControlStateNormal];
                }
                else
                {
                    //货主已上传合同
                    if ([self.model.bond isEqualToString:@"1"]) {
                        //双方支付保证金
                        if ([self.model.s_payment_time isEqualToString:@"0"] || [self.model.s_payment_time isEqual:[NSNull null]]  || self.model.s_payment_time == nil )
                        {
                            //船东未支付保证金
                            if ([self.model.c_payment_time isEqualToString:@"0"] || [self.model.c_payment_time isEqual:[NSNull null]]  || self.model.c_payment_time == nil)
                            {
                                //货主未支付保证金
                                self.typeLable.text = @"双方未支付履约保证金";
                                [self.typeButton setTitle:@"支付履约保证金" forState:UIControlStateNormal];
                            }
                            else
                            {
                                //货主已支付保证金
                                self.typeLable.text = @"对方未支付履约保证金";
                                [self.typeButton setTitle:@"等待对方支付" forState:UIControlStateNormal];
                            }
                        }
                        else
                        {
                            //船东已付保证金
                            if ([self.model.c_payment_time isEqualToString:@"0"] || [self.model.c_payment_time isEqual:[NSNull null]] || self.model.c_payment_time == nil)
                            {
                                //货主未支付保证金
                                if ([self.model.p_s_payment_time isEqualToString:@"0"] || [self.model.p_s_payment_time isEqual:[NSNull null]] || self.model.p_s_payment_time == nil)
                                {
                                    //平台未确认船东支付了多少钱
                                    self.typeLable.text = @"对方已支付履约保证金";
                                    [self.typeButton setTitle:@"等待平台审核" forState:UIControlStateNormal];
                                }
                                else
                                {
                                    //平台已确认船东支付了多少钱
                                    self.typeLable.text = @"平台已确认对方保证金";
                                    [self.typeButton setTitle:@"支付履约保证金" forState:UIControlStateNormal];
                                }
                        
                            }
                            else
                            {
                                //货主已支付保证金
                                if ([self.model.p_s_payment_time isEqualToString:@"0"] || [self.model.p_s_payment_time isEqual:[NSNull null]] || self.model.p_s_payment_time == nil)
                                {
                                    //平台未确认船东支付了多少钱
                                    self.typeLable.text = @"对方已支付履约保证金";
                                    [self.typeButton setTitle:@"等待平台审核" forState:UIControlStateNormal];
                                }
                                else
                                {
                                    //平台未确认船东支付了多少钱
                                    self.typeLable.text = @"双方已支付履约保证金";
                                    [self.typeButton setTitle:@"等待对方上传发货单" forState:UIControlStateNormal];
                                }
                            }
                        }
                        
                    }
                    else if ([self.model.bond isEqualToString:@"0"])
                    {
                        //无需支付保证金
                        self.typeLable.text = @"双方已上传合同";
                        [self.typeButton setTitle:@"等待对方上传发货单" forState:UIControlStateNormal];
                    }
                }
            }
        }
        
    }
    else
    {
        //船东
        
        if ([self.model.pay_type isEqualToString:@"0"])
        {
            //线下结算
            if ([self.model.s_sign_time isEqualToString:@"0"] || [self.model.s_sign_time isEqual:[NSNull null]] || self.model.s_sign_time == nil)
            {
                //船东未签订合同
                self.typeLable.text = @"";
                [self.typeButton setTitle:@"上传合同" forState:UIControlStateNormal];
            }
            else
            {
                //船东已签订合同
                if ([self.model.bond isEqualToString:@"1"])
                {
                    //双方支付保证金
                    if ([self.model.c_payment_time isEqualToString:@"0"] || [self.model.c_payment_time isEqual:[NSNull null]]  || self.model.c_payment_time == nil)
                    {
                        //货主未支付履约保证金
                        if ([self.model.s_sign_time isEqualToString:@"0"] || [self.model.s_sign_time isEqual:[NSNull null]]  || self.model.s_sign_time == nil)
                        {
                            //船东未支付履约保证金
                            self.typeLable.text = @"双方未支付履约保证金";
                            [self.typeButton setTitle:@"支付履约保证金" forState:UIControlStateNormal];
                        }
                        else
                        {
                            //船东已经支付履约保证金
                            self.typeLable.text = @"对方未支付履约保证金";
                            [self.typeButton setTitle:@"等待对方支付" forState:UIControlStateNormal];
                        }
                    }
                    else
                    {
                        //货主已支付履约保证金
                        if ([self.model.s_payment_time isEqualToString:@"0"] || [self.model.s_payment_time isEqual:[NSNull null]]  || self.model.s_payment_time == nil)
                        {
                            //船东未支付履约保证金
                            if ([self.model.p_c_payment_time isEqualToString:@"0"] || [self.model.p_c_payment_time isEqual:[NSNull null]]  || self.model.p_c_payment_time == nil) {
                                //平台未确定货主支付了多少钱
                                self.typeLable.text = @"对方已支付履约保证金";
                                [self.typeButton setTitle:@"等待平台审核" forState:UIControlStateNormal];
                                
                            }
                            else
                            {//平台已确定货主支付了多少钱
                                self.typeLable.text = @"对方已支付履约保证金";
                                [self.typeButton setTitle:@"支付履约保证金" forState:UIControlStateNormal];
                            }
                        }
                        else
                        {
                            //船东已经支付履约保证金
                            if ([self.model.p_c_payment_time isEqualToString:@"0"] || [self.model.p_c_payment_time isEqual:[NSNull null]]  || self.model.p_c_payment_time == nil)
                            {
                                //平台未确定货主支付了多少钱
                                self.typeLable.text = @"对方已支付履约保证金";
                                [self.typeButton setTitle:@"等待平台审核" forState:UIControlStateNormal];
                            }
                            else
                            {
                                //平台已确定货主支付了多少钱
                                self.typeLable.text = @"对方已支付履约保证金";
                                [self.typeButton setTitle:@"上传发货单" forState:UIControlStateNormal];
                            }
                            
                            
                        }
                    }
                }
                else if ([self.model.bond isEqualToString:@"0"])
                {
                    //无需支付保证金
                    self.typeLable.text = @"";
                    [self.typeButton setTitle:@"上传发货单" forState:UIControlStateNormal];
                }
            }
  
        }
        else if ([self.model.pay_type isEqualToString:@"1"])
        {
            //平台结算
            if ([self.model.c_sign_time isEqualToString:@"0"] || [self.model.c_sign_time isEqual:[NSNull null]] || self.model.c_sign_time == nil)
            {
                //货主未上传合同
                if ([self.model.s_sign_time isEqualToString:@"0"] || [self.model.s_sign_time isEqual:[NSNull null]] || self.model.s_sign_time == nil)
                {
                    //船东未上传合同
                    self.typeLable.text = @"双方未上传合同";
                    [self.typeButton setTitle:@"上传合同" forState:UIControlStateNormal];
                }
                else
                {
                    //船东已上传合同
                    self.typeLable.text = @"对方未上传合同";
                    [self.typeButton setTitle:@"等待对方上传合同" forState:UIControlStateNormal];
                }
                
            }
            else
            {
                //货主已上传合同
                if ([self.model.s_sign_time isEqualToString:@"0"] || [self.model.s_sign_time isEqual:[NSNull null]]  || self.model.s_sign_time == nil)
                {
                    //船东未上传合同
                    self.typeLable.text = @"对方已上传合同";
                    [self.typeButton setTitle:@"上传合同" forState:UIControlStateNormal];
                }
                else
                {
                    //船东已上传合同
                    if ([self.model.bond isEqualToString:@"1"]) {
                        //双方支付保证金
                        if ([self.model.c_payment_time isEqualToString:@"0"] || [self.model.c_payment_time isEqual:[NSNull null]]  || self.model.c_payment_time == nil)
                        {
                            //货主未支付履约保证金
                            if ([self.model.s_payment_time isEqualToString:@"0"] || [self.model.s_payment_time isEqual:[NSNull null]] || self.model.s_payment_time == nil)
                            {
                                //船东未支付履约保证金
                                self.typeLable.text = @"双方未支付履约保证金";
                                [self.typeButton setTitle:@"支付履约保证金" forState:UIControlStateNormal];
                            }
                            else
                            {
                                //船东已经支付履约保证金
                                self.typeLable.text = @"对方未支付履约保证金";
                                [self.typeButton setTitle:@"等待对方支付" forState:UIControlStateNormal];
                            }
                        }
                        else
                        {
                            //货主已支付履约保证金
                            if ([self.model.s_payment_time isEqualToString:@"0"] || [self.model.s_payment_time isEqual:[NSNull null]]  || self.model.s_payment_time == nil)
                            {
                                //船东未支付履约保证金
                                if ([self.model.p_c_payment_time isEqualToString:@"0"] || [self.model.p_c_payment_time isEqual:[NSNull null]]  || self.model.p_c_payment_time == nil)
                                {
                                    //平台未确定货主支付了多少钱
                                    self.typeLable.text = @"对方已支付履约保证金";
                                    [self.typeButton setTitle:@"等待平台审核" forState:UIControlStateNormal];
                                }
                                else
                                {
                                    //平台已确定货主支付了多少钱
                                    self.typeLable.text = @"平台已确认对方保证金";
                                    [self.typeButton setTitle:@"支付履约保证金" forState:UIControlStateNormal];
                                }
                            }
                            else
                            {
                                //船东已经支付履约保证金
                                if ([self.model.p_c_payment_time isEqualToString:@"0"] || [self.model.p_c_payment_time isEqual:[NSNull null]]  || self.model.p_c_payment_time == nil)
                                {
                                    //平台未确定货主支付了多少钱
                                    self.typeLable.text = @"对方已支付履约保证金";
                                    [self.typeButton setTitle:@"等待平台审核" forState:UIControlStateNormal];
                                }
                                else
                                {
                                    //平台已确定货主支付了多少钱
                                    self.typeLable.text = @"平台已确认对方保证金";
                                    [self.typeButton setTitle:@"上传发货单" forState:UIControlStateNormal];
                                }
                            }
                        }
                    }
                    else if ([self.model.bond isEqualToString:@"0"])
                    {
                        //无需支付保证金
                        self.typeLable.text = @"";
                        [self.typeButton setTitle:@"上传发货单" forState:UIControlStateNormal];
                    }
                }
            }
        }

    }
}

//待卸货
-(void)waitUnLoadGoods
{
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
    {
        if ([self.model.freight containsString:@"预付运费0%"]) {
            self.typeLable.text = @"预付运费0%";
            [self.typeButton setTitle:@"上传收货单" forState:UIControlStateNormal];
        }
        else
        {
            if ([self.model.payment_advance_time isEqualToString:@"0"] || [self.model.payment_advance_time isEqual:[NSNull null]]  || self.model.payment_advance_time == nil)
            {
                //货主未支付预付运费
                self.typeLable.text = @"对方未支付预付运费";
                [self.typeButton setTitle:@"等待对方支付" forState:UIControlStateNormal];
            }
            else
            {
                //货主已支付预付运费
                self.typeLable.text = @"对方已支付预付运费";
                [self.typeButton setTitle:@"上传收货单" forState:UIControlStateNormal];
            }
        }
        
        
    }
    else
    {
        //货主
        if ([self.model.payment_advance_time isEqualToString:@"0"] || [self.model.payment_advance_time isEqual:[NSNull null]] || self.model.payment_advance_time == nil)
        {
            //未支付预付运费
            self.typeLable.text = @"对方已上传发货单";
            if ([self.model.freight containsString:@"预付运费0%"]) {
                [self.typeButton setTitle:@"等待对方上传收货单" forState:UIControlStateNormal];
            }
            else
            {
                [self.typeButton setTitle:@"支付预付运费" forState:UIControlStateNormal];
            }
            
        }
        else
        {
//            //已支付预付运费
//            if ([self.model.unloading_time isEqualToString:@"0"] || [self.model.unloading_time isEqual:[NSNull null]] || self.model.unloading_time == nil)
//            {
//                //没有上传收货单
//                self.typeLable.text = @"对方未上传收货单";
//                [self.typeButton setTitle:@"等待上传收货单" forState:UIControlStateNormal];
//            }
//            else
//            {
//                //已经上传收货单
//                self.typeLable.text = @"对方已上传收货单";
//                [self.typeButton setTitle:@"支付结算运费" forState:UIControlStateNormal];
//            }
            
            self.typeLable.text = @"对方已上传收货单";
            [self.typeButton setTitle:@"等待对方上传收货单" forState:UIControlStateNormal];
            
        }
    }
}

//待结算
-(void)closeAccount
{
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
    {
        if ([self.model.freight containsString:@"结算运费0%"]) {
            self.typeLable.text = @"结算运费0%";
            [self.typeButton setTitle:@"等待平台结算" forState:UIControlStateNormal];
        }
        else
        {
            if ([self.model.payment_settlement_time isEqualToString:@"0"] || [self.model.payment_settlement_time isEqual:[NSNull null]] || self.model.payment_settlement_time == nil)
            {
                //未支付结算运费
                self.typeLable.text = @"对方未支付结算运费";
                [self.typeButton setTitle:@"等待对方支付" forState:UIControlStateNormal];
            }
            else
            {
                //已支付结算运费
                self.typeLable.text = @"对方已支付预付、结算运费";
                [self.typeButton setTitle:@"等待平台结算" forState:UIControlStateNormal];
            }
        }
    }
    else
    {
        //货主
        if ([self.model.payment_settlement_time isEqualToString:@"0"] || [self.model.payment_settlement_time isEqual:[NSNull null]] || self.model.payment_settlement_time == nil)
        {
            //未支付结算运费
            self.typeLable.text = @"对方已上传收货单";
            if ([self.model.freight containsString:@"结算运费0%"]) {
                [self.typeButton setTitle:@"等待平台结算" forState:UIControlStateNormal];
            }
            else
            {
                [self.typeButton setTitle:@"支付结算运费" forState:UIControlStateNormal];
            }
            
        }
        else
        {
            //已支付结算运费
            self.typeLable.text = @"对方已上传收货单";
            [self.typeButton setTitle:@"等待平台结算" forState:UIControlStateNormal];
        }
        
    }
}

//待评价
-(void)waitDiscuss
{
    
    
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
    {
        if ([self.model.req_comment_time isEqualToString:@"0"] || [self.model.req_comment_time isEqual:[NSNull null]] || self.model.req_comment_time == nil)
        {
            //货主未评价
            if ([self.model.confirm_comment_time isEqualToString:@"0"] || [self.model.confirm_comment_time isEqual:[NSNull null]]   || self.model.confirm_comment_time == nil)
            {
                //船东自己也没评价
                self.typeLable.text = @"已完成";
                [self.typeButton setTitle:@"评价对方" forState:UIControlStateNormal];
            }
            else
            {
                //船东自己已经评价
                self.typeLable.text = @"已完成";
                [self.typeButton setTitle:@"等待对方评价" forState:UIControlStateNormal];
            }
        }
        else
        {
            //货主已经评价
            if ([self.model.confirm_comment_time isEqualToString:@"0"] || [self.model.confirm_comment_time isEqual:[NSNull null]]  || self.model.confirm_comment_time == nil)
            {
                //货主自己没评价
                self.typeLable.text = @"对方已评价";
                [self.typeButton setTitle:@"评价对方" forState:UIControlStateNormal];
            }
            else
            {
                //货主自己已经评价
                self.typeLable.text = @"运单已完成";
                [self.typeButton setTitle:@"已完成" forState:UIControlStateNormal];
            }
        }
        
    }
    else
    {
        //货主
        if ([self.model.confirm_comment_time isEqualToString:@"0"] || [self.model.confirm_comment_time isEqual:[NSNull null]]  || self.model.confirm_comment_time == nil)
        {
            //船东未评价
            if ([self.model.req_comment_time isEqualToString:@"0"] || [self.model.req_comment_time isEqual:[NSNull null]] || self.model.req_comment_time == nil)
            {
                //货主自己也没评价
                self.typeLable.text = @"已完成";
                [self.typeButton setTitle:@"评价对方" forState:UIControlStateNormal];
            }
            else
            {
                //货主自己已经评价
                self.typeLable.text = @"已完成";
                [self.typeButton setTitle:@"等待对方评价" forState:UIControlStateNormal];
            }
        }
        else
        {
            //船东已经评价
            if ([self.model.req_comment_time isEqualToString:@"0"] || [self.model.req_comment_time isEqual:[NSNull null]] || self.model.req_comment_time == nil)
            {
                //货主自己没评价
                self.typeLable.text = @"对方已评价";
                [self.typeButton setTitle:@"评价对方" forState:UIControlStateNormal];
            }
            else
            {
                //货主自己已经评价
                self.typeLable.text = @"运单已完成";
                [self.typeButton setTitle:@"已完成" forState:UIControlStateNormal];
            }
        }
    }
}

//已结束
-(void)alreadyEnd
{
    //已结束
//    self.typeLable.text = @"运单已完成";
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
    {
        if ([self.model.confirm_comment_time isEqualToString:@"0"] || [self.model.confirm_comment_time isEqual:[NSNull null]]  || self.model.confirm_comment_time == nil)
        {
            //货主未评价
            if ([self.model.req_comment_time isEqualToString:@"0"] || [self.model.req_comment_time isEqual:[NSNull null]] || self.model.req_comment_time == nil)
            {
                //船东自己也没评价
                self.typeLable.text = @"已完成";
                [self.typeButton setTitle:@"评价对方" forState:UIControlStateNormal];
            }
            else
            {
                //船东自己已经评价
                self.typeLable.text = @"已完成";
                [self.typeButton setTitle:@"等待评价对方" forState:UIControlStateNormal];
            }
        }
        else
        {
            //货主已经评价
            if ([self.model.req_comment_time isEqualToString:@"0"] || [self.model.req_comment_time isEqual:[NSNull null]] || self.model.req_comment_time == nil)
            {
                //船东未评价
                if ([self.model.confirm_comment_time isEqualToString:@"0"] || [self.model.confirm_comment_time isEqual:[NSNull null]]  || self.model.confirm_comment_time == nil)
                {
                    //货主自己也没评价
                    self.typeLable.text = @"已完成";
                    [self.typeButton setTitle:@"评价对方" forState:UIControlStateNormal];
                }
                else
                {
                    //货主自己已经评价
                    self.typeLable.text = @"已完成";
                    [self.typeButton setTitle:@"等待对方评价" forState:UIControlStateNormal];
                }
                
                
            }
            else
            {
                //船东已经评价
                if ([self.model.confirm_comment_time isEqualToString:@"0"] || [self.model.confirm_comment_time isEqual:[NSNull null]]  || self.model.confirm_comment_time == nil)
                {
                    //货主自己没评价
                    self.typeLable.text = @"对方已评价";
                    [self.typeButton setTitle:@"评价对方" forState:UIControlStateNormal];
                }
                else
                {
                    //货主自己已经评价
                    self.typeLable.text = @"运单已完成";
                    [self.typeButton setTitle:@"已完成" forState:UIControlStateNormal];
                }
                
            }
        }
    }
    else
    {
        //货主
        if ([self.model.confirm_comment_time isEqualToString:@"0"] || [self.model.confirm_comment_time isEqual:[NSNull null]]  || self.model.confirm_comment_time == nil) {
            [self.typeButton setTitle:@"评价对方" forState:UIControlStateNormal];
        }
        else if ([self.model.req_comment_time isEqualToString:@"0"] || [self.model.req_comment_time isEqual:[NSNull null]] || self.model.req_comment_time == nil)
        {
            [self.typeButton setTitle:@"等待对方评价" forState:UIControlStateNormal];
        }
        else
        {
            [self.typeButton setTitle:@"已完结" forState:UIControlStateNormal];
        }
    }
}














@end
