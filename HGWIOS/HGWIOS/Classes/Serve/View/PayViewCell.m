//
//  PayViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "PayViewCell.h"

@implementation PayViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        //第一部分
        UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        firstView.backgroundColor =[CommonFontColorStyle F8F9FBColor];
        firstView.layer.borderColor =[CommonFontColorStyle C6D2DEColor].CGColor;
        firstView.layer.borderWidth = 0.5;
        [self addSubview: firstView];
        
        UILabel *baodanLabel = [[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 12.5, 50, 15)];
        baodanLabel.text = @"保单号:";
        baodanLabel.textColor = [CommonFontColorStyle B8CA0Color];
        baodanLabel.textAlignment = NSTextAlignmentLeft;
        baodanLabel.font = [CommonFontColorStyle NormalSizeFont];
//        if([GJCFSystemUitil iPhone5Device]){
//            baodanLabel.font = [UIFont systemFontOfSize:13];
//        }
        [baodanLabel sizeToFit];
        [firstView addSubview: baodanLabel];
        
        self.baodanNumberLabel =[[UILabel alloc]initWithFrame:CGRectMake(baodanLabel.gjcf_right, 14.5, firstView.gjcf_width - baodanLabel.gjcf_right, 15)];
        self.baodanNumberLabel.font = [CommonFontColorStyle NormalSizeFont];
//        if([GJCFSystemUitil iPhone5Device]){
//            self.baodanNumberLabel.font = [UIFont systemFontOfSize:13];
//        }
        self.baodanNumberLabel.textColor = [CommonFontColorStyle B8CA0Color];
        [firstView addSubview: self.baodanNumberLabel];
        
        self.dianzibaodanLabel = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 70, 5, 60, 30)];
        [self.dianzibaodanLabel setTitle:@"电子保单" forState:UIControlStateNormal];
        self.dianzibaodanLabel.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [self.dianzibaodanLabel setTitleColor:[CommonFontColorStyle B8CA0Color] forState:UIControlStateNormal];
        [self.dianzibaodanLabel sizeToFit];
        [firstView addSubview: self.dianzibaodanLabel];
        self.dianzibaodanLabel.gjcf_left = self.gjcf_width - self.dianzibaodanLabel.gjcf_width - 10;
        
        //第二部分
        UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], firstView.gjcf_bottom, (self.frame.size.width - 2*[CommonDimensStyle smallMargin]), 40)];
        secondView.backgroundColor = [CommonFontColorStyle WhiteColor];
        [self addSubview: secondView];
        
        //货物险名称
        self.TitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, secondView.gjcf_width - 120, secondView.gjcf_height)];
        self.TitleLabel.font = [CommonFontColorStyle BigSizeFont];
        self.TitleLabel.textColor = [CommonFontColorStyle I3Color];
        [secondView addSubview: self.TitleLabel];
        
        self.okImage = [[UIImageView alloc]initWithFrame:CGRectMake((secondView.gjcf_right - 73), (secondView.gjcf_height - 13)/2, 13, 13)];
        self.okImage.image = [UIImage imageNamed:@"ins_icon_gou"];
        [secondView addSubview: self.okImage];
        
        self.okLabel = [[UILabel alloc]initWithFrame:CGRectMake(secondView.gjcf_width - 50,0, 50, secondView.gjcf_height)];
        self.okLabel.text = @"已通过";
        self.okLabel.textColor = [CommonFontColorStyle EBF46Color];
        self.okLabel.textAlignment = NSTextAlignmentRight;
        self.okLabel.font = [CommonFontColorStyle NormalSizeFont];
        [secondView addSubview: self.okLabel];
        
        //横线
        GrayLine* GrayLine2 = [[GrayLine alloc]initWithFrame:CGRectMake(0, secondView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle E2E5ECColor]];
        [self addSubview:GrayLine2];
        
        //第三部分
        UIView * threeView = [[UIView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], GrayLine2.gjcf_bottom, (self.frame.size.width - 2*[CommonDimensStyle smallMargin]), 72)];
        secondView.backgroundColor = [CommonFontColorStyle WhiteColor];
        [self addSubview: threeView];
        
        
        //船舶名称
        UILabel *shipNameTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 13, 80, 15)];
        shipNameTitleLabel.text = @"船舶名称：";
        shipNameTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        shipNameTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [shipNameTitleLabel sizeToFit];
        [threeView addSubview:shipNameTitleLabel];
        
        self.shipNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(shipNameTitleLabel.gjcf_right, 13, (self.frame.size.width - shipNameTitleLabel.gjcf_right), 15)];
        self.shipNameLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.shipNameLabel.textColor = [CommonFontColorStyle I3Color];
        [threeView addSubview:self.shipNameLabel];
        
        //起运时间
        UILabel *departureDateTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (shipNameTitleLabel.gjcf_bottom +10), 80, 15)];
        departureDateTitleLabel.text = @"起运时间：";
        departureDateTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        departureDateTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [departureDateTitleLabel sizeToFit];
        [threeView addSubview:departureDateTitleLabel];
        
        self.departureDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(departureDateTitleLabel.gjcf_right, (shipNameTitleLabel.gjcf_bottom +10), (self.frame.size.width - departureDateTitleLabel.gjcf_right), 15)];
        self.departureDateLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.departureDateLabel.textColor = [CommonFontColorStyle I3Color];
        [threeView addSubview:self.departureDateLabel];
        
        //船舶航线
        UILabel *boatTrankTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.departureDateLabel.gjcf_bottom +10), 80, 15)];
        boatTrankTitleLabel.text = @"船舶航线：";
        boatTrankTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        boatTrankTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [boatTrankTitleLabel sizeToFit];
        [threeView addSubview:boatTrankTitleLabel];
        
        self.boatTrankLabel = [[UILabel alloc]initWithFrame:CGRectMake(boatTrankTitleLabel.gjcf_right, (departureDateTitleLabel.gjcf_bottom +10), (self.frame.size.width - boatTrankTitleLabel.gjcf_right), 15)];
        self.boatTrankLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.boatTrankLabel.textColor = [CommonFontColorStyle I3Color];
        [threeView addSubview:self.boatTrankLabel];
        
        //保费
        UILabel *baofeiTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.boatTrankLabel.gjcf_bottom +10), 80, 15)];
        baofeiTitleLabel.text = @"保费：";
        baofeiTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        baofeiTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [baofeiTitleLabel sizeToFit];
        [threeView addSubview:baofeiTitleLabel];
        
        self.baofeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(baofeiTitleLabel.gjcf_right, (self.boatTrankLabel.gjcf_bottom +10),  (self.frame.size.width - baofeiTitleLabel.gjcf_right), 15)];
        self.baofeiLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.baofeiLabel.textColor = [CommonFontColorStyle I3Color];
        [threeView addSubview:self.baofeiLabel];
        
        //快递费
        UILabel *kuaidiTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.baofeiLabel.gjcf_bottom +10), 80, 15)];
        kuaidiTitleLabel.text = @"快递费：";
        kuaidiTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        kuaidiTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [kuaidiTitleLabel sizeToFit];
        [threeView addSubview:kuaidiTitleLabel];
        
        self.kuaidiLabel = [[UILabel alloc]initWithFrame:CGRectMake(kuaidiTitleLabel.gjcf_right, (baofeiTitleLabel.gjcf_bottom +10),  (self.frame.size.width - kuaidiTitleLabel.gjcf_right), 15)];
        self.kuaidiLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.kuaidiLabel.textColor = [CommonFontColorStyle I3Color];
        [threeView addSubview:self.kuaidiLabel];
        
        threeView.gjcf_height = self.kuaidiLabel.gjcf_bottom+10;
        //横线
        GrayLine* GrayLine3 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], secondView.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5) Color:[CommonFontColorStyle E2E5ECColor]];
        [self addSubview:GrayLine3];
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width -25-40), (threeView.gjcf_top+threeView.gjcf_height/2), 40, 12)];
        detailLabel.text = @"详情";
        detailLabel.font = [CommonFontColorStyle SuperSmallFont];
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.textColor = [CommonFontColorStyle UnSubmitColor];
        [self addSubview:detailLabel];
        
        
        UIImageView *detailimage = [[UIImageView alloc]initWithFrame:CGRectMake(detailLabel.gjcf_right, detailLabel.gjcf_top, 15, 15)];
        detailimage.image = [UIImage imageNamed:@"ins_icon_arrow"];
        [self addSubview:detailimage];
        
        //横线
        GrayLine* GrayLine4 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], threeView.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5) Color:[CommonFontColorStyle E2E5ECColor]];
        [self addSubview:GrayLine4];
        
        
        self.zhushiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, GrayLine4.gjcf_bottom, self.frame.size.width-5, 0)];
        self.zhushiLabel.text = @"注:核保未通过，请再次提交或联系客服025-85326660";
        self.zhushiLabel.font = [CommonFontColorStyle SuperSmallFont];
        self.zhushiLabel.textAlignment = NSTextAlignmentLeft;
        self.zhushiLabel.textColor = [CommonFontColorStyle RedColor];
        [self addSubview:self.zhushiLabel];
        
        self.GrayLine5 = [[GrayLine alloc]initWithFrame:CGRectMake(0, self.zhushiLabel.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle E2E5ECColor]];
        [self addSubview:self.GrayLine5];
        
        self.submitBt = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-100, self.GrayLine5.gjcf_bottom, 100, 0)];
        self.submitBt.alpha = 0;
        [self.submitBt setTitle:@"再次提交" forState:UIControlStateNormal];
        self.submitBt.backgroundColor = [CommonFontColorStyle WhiteVerCan];
        self.submitBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [self.submitBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
        [self addSubview:self.submitBt];
        
        self.GrayLine6 = [[GrayLine alloc]initWithFrame:CGRectMake(0, self.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth), 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
        [self addSubview:self.GrayLine6];
        
    }
    return self;
}

-(void)initContent:(NSString *)title ShipName:(NSString *)shipName DepartureDate:(NSString *)departureDate
         BoatTrank:(NSString *)boatTrank Baofei:(NSString *)baofei Kuaidi:(NSString *)kuaidi Id:(NSString *)id baodanId:(NSString *)baodanId Status:(NSString *)status{
    self.insuranceId= id;
    self.TitleLabel.text = title;
    self.shipNameLabel.text = shipName;
    self.departureDateLabel.text = departureDate;
    self.boatTrankLabel.text = boatTrank;
    self.baofeiLabel.text = [NSString stringWithFormat:@"¥%@",baofei];
    self.kuaidiLabel.text = [NSString stringWithFormat:@"¥%@",kuaidi];
    self.baodanNumberLabel.text = baodanId;
    self.okLabel.text =status;
    
    
//    if([status isEqualToString:@"已通过"]){
//        self.zhushiLabel.hidden = YES;
//        self.GrayLine5.hidden = YES;
//        self.submitBt.hidden = YES;
//        self.GrayLine6.hidden = YES;
//        self.dianzibaodanLabel.hidden = NO;
//
//        self.okLabel.textColor = [CommonFontColorStyle EBF46Color];
//        self.okImage.hidden = NO;
//    }else{
//        self.zhushiLabel.hidden = NO;
//        self.GrayLine5.hidden = NO;
//        self.submitBt.hidden = NO;
//        self.GrayLine6.hidden = NO;
//        //        self.okLabel.text =status;
//        self.okLabel.textColor = [CommonFontColorStyle WhiteVerCan];
//        self.okImage.hidden = YES;
//        self.dianzibaodanLabel.hidden = YES;
//    }
    
}


@end
