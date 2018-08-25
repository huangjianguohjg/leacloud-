//
//  ShipHelperChangJiangView.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperChangJiangView.h"
#import "GrayLine.h"
#import "DottedLineView.h"
#import "DataHelper.h"
#define STAGE 1
#define FLOW 2
@implementation ShipHelperChangJiangView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}



-(void)setUpUI
{
    self.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    //标题
//    self.headView = [self setHeadTitle:@"长江水位情况"];
//    [self addSubview:self.headView];
//
//    self.shareBt = [BaseHelper getShareBt:self.headView.gjcf_right - 40 Y:self.headView.gjcf_top+10];
//    [self addSubview:self.shareBt];
    
    int itemWidth = [CommonDimensStyle screenWidth]/2;
    
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, 2*itemWidth, realH(90))];
    [self addSubview:self.navView];
    
    //水位
    UIView *stageView = [[UIView alloc]initWithFrame:CGRectMake(0, -self.navView.gjcf_height, itemWidth, self.navView.gjcf_height)];
    stageView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.navView addSubview:stageView];
    
    UITapGestureRecognizer *stageGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stageViewClick:)];
    stageGesture.numberOfTapsRequired=1;
    [stageView addGestureRecognizer:stageGesture];
    //文字
    self.stageLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 11.5, stageView.gjcf_width, 15)];
    [stageView addSubview:self.stageLable];
    self.stageLable.text = @"水位";
    self.stageLable.font = [CommonFontColorStyle NormalSizeFont];
    self.stageLable.textColor = DDColor(@"0f92ea");
    self.stageLable.textAlignment = NSTextAlignmentCenter;
    //下面蓝色
    self.stageBlueView = [[UIView alloc]initWithFrame:CGRectMake(0, (stageView.gjcf_height-1.5), stageView.gjcf_width, 1.5)];
    self.stageBlueView.backgroundColor = DDColor(@"0f92ea");
    [stageView addSubview:self.stageBlueView];
    
    //流量
    UIView *flowView = [[UIView alloc]initWithFrame:CGRectMake(stageView.gjcf_right, self.navView.gjcf_height, itemWidth, stageView.gjcf_height)];
    flowView.backgroundColor = [CommonFontColorStyle WhiteColor];
    flowView.alpha = 0;
    [self.navView addSubview:flowView];
    
    UITapGestureRecognizer *flowGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flowViewClick:)];
    flowGesture.numberOfTapsRequired=1;
    [flowView addGestureRecognizer:flowGesture];
    //文字
    self.flowLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 11.5, flowView.gjcf_width, 15)];
    [flowView addSubview:self.flowLable];
    self.flowLable.text = @"流量";
    self.flowLable.font = [CommonFontColorStyle NormalSizeFont];
    self.flowLable.textColor = [CommonFontColorStyle FontNormalColor];
    self.flowLable.textAlignment = NSTextAlignmentCenter;
    //下面蓝色
    self.flowBlueView = [[UIView alloc]initWithFrame:CGRectMake(0, (flowView.gjcf_height-1.5), flowView.gjcf_width, 1.5)];
    self.flowBlueView.backgroundColor = DDColor(@"0f92ea");
    self.flowBlueView.hidden = YES;
    [flowView addSubview:self.flowBlueView];
}



-(UIView * _Nullable)getHead{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [CommonDimensStyle screenWidth], 45)];
    contentView.backgroundColor = [CommonFontColorStyle WhiteColor];
    //标题
    int firstWidth = [CommonDimensStyle screenWidth]/3;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, firstWidth, 45)];
    [self setContentLabel:titleLabel];
    titleLabel.text = @"港口名称";
    titleLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    [contentView addSubview:titleLabel];
    
    //水位
    UILabel *stageLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, firstWidth, 45)];
    [self setContentLabel:stageLabel];
    stageLabel.text = @"水位(米)";
    stageLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    [contentView addSubview:stageLabel];
    
    //涨幅
    UILabel *changeLabel = [[UILabel alloc]initWithFrame:CGRectMake(stageLabel.gjcf_right, 0, firstWidth, 45)];
    [self setContentLabel:changeLabel];
    changeLabel.text = @"较前日涨幅(米)";
    changeLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    [contentView addSubview:changeLabel];
    
    //划线
    UIView *headLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentView.gjcf_width, 0.5)];
    headLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:headLineView];
    
    UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, 0.5, 45)];
    oneLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:oneLineView];
    
    UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(stageLabel.gjcf_right, 0, 0.5, 45)];
    twoLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:twoLineView];
    
    UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(0, titleLabel.gjcf_bottom-0.5, contentView.gjcf_width, 0.5)];
    fourLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:fourLineView];
    return  contentView;
}





-(UIView * _Nullable)getflowHead{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [CommonDimensStyle screenWidth], 60)];
    contentView.backgroundColor = [CommonFontColorStyle WhiteColor];
    
    //标题
    int firstWidth = [CommonDimensStyle screenWidth]/3;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, firstWidth, contentView.gjcf_height)];
    [self setContentLabel:titleLabel];
    titleLabel.text = @"港口名称";
    titleLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    [contentView addSubview:titleLabel];
    
    //水位
    UILabel *stageLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, firstWidth, contentView.gjcf_height)];
    [self setContentLabel:stageLabel];
    stageLabel.text = @"流量(立方米/秒)";
    stageLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    [contentView addSubview:stageLabel];
    
    //涨幅
    UILabel *changeLabel = [[UILabel alloc]initWithFrame:CGRectMake(stageLabel.gjcf_right, 0, firstWidth, contentView.gjcf_height)];
    changeLabel.numberOfLines = 2;
    [self setContentLabel:changeLabel];
    changeLabel.text = @"较前日涨幅\n(立方米/秒)";
    changeLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    [contentView addSubview:changeLabel];
    
    //划线
    UIView *headLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentView.gjcf_width, 0.5)];
    headLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:headLineView];
    
    UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, 0.5, contentView.gjcf_height)];
    oneLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:oneLineView];
    
    UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(stageLabel.gjcf_right, 0, 0.5, contentView.gjcf_height)];
    twoLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:twoLineView];
    
    UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(0, titleLabel.gjcf_bottom-0.5, contentView.gjcf_width, 0.5)];
    fourLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:fourLineView];
    return  contentView;
}


-(UIView * _Nullable)getTableItem:(NSString * _Nullable)title Stage:(NSString * _Nullable)stage Change:(NSString * _Nullable)change Y:(int)y{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, y, [CommonDimensStyle screenWidth], 45)];
    
    //标题
    int firstWidth = [CommonDimensStyle screenWidth]/3;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, firstWidth, 45)];
    [self setContentLabel:titleLabel];
    titleLabel.text = title;
    [contentView addSubview:titleLabel];
    
    //水位
    UILabel *stageLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, firstWidth, 45)];
    [self setContentLabel:stageLabel];
    stageLabel.text = stage;
    [contentView addSubview:stageLabel];
    
    //涨幅
    UILabel *changeLabel = [[UILabel alloc]initWithFrame:CGRectMake(stageLabel.gjcf_right, 0, firstWidth, 45)];
    [self setContentLabel:changeLabel];
    
    changeLabel.text = [DataHelper stringToTwoDigitString:change];
    [contentView addSubview:changeLabel];
    
    //划线
    UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, 0.5, 45)];
    oneLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:oneLineView];
    
    UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(stageLabel.gjcf_right, 0, 0.5, 45)];
    twoLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:twoLineView];
    
    UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(0, titleLabel.gjcf_bottom-0.5, contentView.gjcf_width, 0.5)];
    fourLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:fourLineView];
    return  contentView;
}

-(void)setContentLabel:(UILabel *)lable{
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [CommonFontColorStyle I3Color];
    lable.font =[CommonFontColorStyle SmallSizeFont];
}













-(void)stageViewClick:(UITapGestureRecognizer *)sender{
    [self.delegate DDStageViewClick:STAGE];
}

-(void)flowViewClick:(UITapGestureRecognizer *)sender{
    [self.delegate DDFlowViewClick:FLOW];
}









@end
