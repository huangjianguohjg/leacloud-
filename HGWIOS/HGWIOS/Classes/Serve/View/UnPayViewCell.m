//
//  UnPayViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "UnPayViewCell.h"
#import "GrayLine.h"
@implementation UnPayViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        //第一部分
        UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        firstView.backgroundColor =[CommonFontColorStyle WhiteColor];
        [self addSubview: firstView];
        
        
        self.TitleLabel =[[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 0, (self.frame.size.width-2*[CommonDimensStyle smallMargin]), firstView.gjcf_height)];
        self.TitleLabel.font = [CommonFontColorStyle BigSizeFont];
        self.TitleLabel.textColor = [CommonFontColorStyle I3Color];
        [firstView addSubview: self.TitleLabel];
        
        //横线
        GrayLine* GrayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake(10, firstView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth-20, 0.5) Color:[CommonFontColorStyle E2E5ECColor]];
        [self addSubview:GrayLine1];
        
        //第二部分
        UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], GrayLine1.gjcf_bottom, (self.frame.size.width - 2*[CommonDimensStyle smallMargin]), 72)];
        secondView.backgroundColor = [CommonFontColorStyle WhiteColor];
        [self addSubview: secondView];
        
        
        //船舶名称
        UILabel *shipNameTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 13, 80, 15)];
        shipNameTitleLabel.text = @"船舶名称：";
        shipNameTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        shipNameTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [shipNameTitleLabel sizeToFit];
        [secondView addSubview:shipNameTitleLabel];
        
        self.shipNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(shipNameTitleLabel.gjcf_right, 13, (self.frame.size.width - shipNameTitleLabel.gjcf_right), 15)];
        self.shipNameLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.shipNameLabel.textColor = [CommonFontColorStyle I3Color];
        [secondView addSubview:self.shipNameLabel];
        
        //起运时间
        UILabel *departureDateTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (shipNameTitleLabel.gjcf_bottom +10), 80, 15)];
        departureDateTitleLabel.text = @"起运时间：";
        departureDateTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        departureDateTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [departureDateTitleLabel sizeToFit];
        [secondView addSubview:departureDateTitleLabel];
        
        self.departureDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(departureDateTitleLabel.gjcf_right, (shipNameTitleLabel.gjcf_bottom +10), (self.frame.size.width - departureDateTitleLabel.gjcf_right), 15)];
        self.departureDateLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.departureDateLabel.textColor = [CommonFontColorStyle I3Color];
        [secondView addSubview:self.departureDateLabel];
        
        //船舶航线
        UILabel *boatTrankTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.departureDateLabel.gjcf_bottom +10), 80, 15)];
        boatTrankTitleLabel.text = @"船舶航线：";
        boatTrankTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        boatTrankTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [boatTrankTitleLabel sizeToFit];
        [secondView addSubview:boatTrankTitleLabel];
        
        self.boatTrankLabel = [[UILabel alloc]initWithFrame:CGRectMake(boatTrankTitleLabel.gjcf_right, (departureDateTitleLabel.gjcf_bottom +10), (self.frame.size.width - boatTrankTitleLabel.gjcf_right), 15)];
        self.boatTrankLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.boatTrankLabel.textColor = [CommonFontColorStyle I3Color];
        [secondView addSubview:self.boatTrankLabel];
        
        //保费
        UILabel *baofeiTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.boatTrankLabel.gjcf_bottom +10), 80, 15)];
        baofeiTitleLabel.text = @"保费：";
        baofeiTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        baofeiTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [baofeiTitleLabel sizeToFit];
        [secondView addSubview:baofeiTitleLabel];
        
        self.baofeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(baofeiTitleLabel.gjcf_right, (self.boatTrankLabel.gjcf_bottom +10),  (self.frame.size.width - baofeiTitleLabel.gjcf_right), 15)];
        self.baofeiLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.baofeiLabel.textColor = [CommonFontColorStyle I3Color];
        [secondView addSubview:self.baofeiLabel];
        
        //快递费
        UILabel *kuaidiTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.baofeiLabel.gjcf_bottom +10), 80, 15)];
        kuaidiTitleLabel.text = @"快递费：";
        kuaidiTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        kuaidiTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [kuaidiTitleLabel sizeToFit];
        [secondView addSubview:kuaidiTitleLabel];
        
        self.kuaidiLabel = [[UILabel alloc]initWithFrame:CGRectMake(kuaidiTitleLabel.gjcf_right, (baofeiTitleLabel.gjcf_bottom +10),  (self.frame.size.width - kuaidiTitleLabel.gjcf_right), 15)];
        self.kuaidiLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.kuaidiLabel.textColor = [CommonFontColorStyle I3Color];
        [secondView addSubview:self.kuaidiLabel];
        
        secondView.gjcf_height = self.kuaidiLabel.gjcf_bottom+10;
        //横线
        GrayLine* GrayLine2 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], secondView.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5) Color:[CommonFontColorStyle E2E5ECColor]];
        [self addSubview:GrayLine2];
        
        
        //第三部分
        int buttonWidth = 125;
        int buttonHeight = 45;
        
        self.deleteView = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*buttonWidth), GrayLine2.gjcf_bottom, buttonWidth, buttonHeight)];
        self.deleteView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
        [self addSubview:self.deleteView];
        
        int imageWidth = 20;
        UIImageView *deleteImgView = [[UIImageView alloc]initWithFrame:CGRectMake(35, (self.deleteView.gjcf_height - imageWidth)/2, imageWidth, imageWidth)];
        deleteImgView.image = [UIImage imageNamed:@"ins_icon_trash"];
        [self.deleteView addSubview:deleteImgView];
        
        UILabel *deleteLabel = [[UILabel alloc]initWithFrame:CGRectMake(deleteImgView.gjcf_right+5, 0, 80, self.deleteView.gjcf_height)];
        deleteLabel.text = @"删除";
        deleteLabel.font = [CommonFontColorStyle NormalSizeFont];
        deleteLabel.textColor = [CommonFontColorStyle WhiteColor];
        [self.deleteView addSubview:deleteLabel];
        
        self.editView = [[UIView alloc]initWithFrame:CGRectMake(self.deleteView.gjcf_right, GrayLine2.gjcf_bottom, buttonWidth, buttonHeight)];
        self.editView.backgroundColor = XXJColor(27, 69, 138);
        [self addSubview:self.editView];
        
        UIImageView *editImgView = [[UIImageView alloc]initWithFrame:CGRectMake(35, (self.editView.gjcf_height - imageWidth)/2, imageWidth, imageWidth)];
        editImgView.image = [UIImage imageNamed:@"ins_icon_edit2"];
        [self.editView addSubview:editImgView];
        
        UILabel *editLabel = [[UILabel alloc]initWithFrame:CGRectMake(editImgView.gjcf_right+5, 0, 80, self.editView.gjcf_height)];
        editLabel.text = @"编辑";
        editLabel.font = [CommonFontColorStyle NormalSizeFont];
        editLabel.textColor = [CommonFontColorStyle WhiteColor];
        [self.editView addSubview:editLabel];
        
        //横线
        GrayLine* GrayLine3 = [[GrayLine alloc]initWithFrame:CGRectMake(0, self.editView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle E2E5ECColor]];
        [self addSubview:GrayLine3];
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width -25-40), (secondView.gjcf_top+secondView.gjcf_height/2), 40, 12)];
        detailLabel.text = @"详情";
        detailLabel.font = [CommonFontColorStyle NormalSizeFont];
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.textColor = [CommonFontColorStyle UnSubmitColor];
        [self addSubview:detailLabel];
        
        
        UIImageView *detailimage = [[UIImageView alloc]initWithFrame:CGRectMake(detailLabel.gjcf_right, detailLabel.gjcf_top, 15, 15)];
        detailimage.image = [UIImage imageNamed:@"ins_icon_arrow"];
        [self addSubview:detailimage];
        
        
    }
    return self;
}

-(void)initContent:(NSString *)title ShipName:(NSString *)shipName DepartureDate:(NSString *)departureDate
         BoatTrank:(NSString *)boatTrank Baofei:(NSString *)baofei Kuaidi:(NSString *)kuaidi Id:(NSString *)id{
    self.insuranceId= id;
    self.TitleLabel.text = title;
    self.shipNameLabel.text = shipName;
    self.departureDateLabel.text = departureDate;
    self.boatTrankLabel.text = boatTrank;
    self.baofeiLabel.text = [NSString stringWithFormat:@"¥%@",baofei];
    self.kuaidiLabel.text = [NSString stringWithFormat:@"¥%@",kuaidi];
}

@end
