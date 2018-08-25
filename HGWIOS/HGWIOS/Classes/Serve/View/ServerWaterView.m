//
//  ServerWaterView.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ServerWaterView.h"
#import "DottedLineView.h"
#import "ServiceWaterModel.h"
#import "NullContentView.h"
@implementation ServerWaterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
        
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    [self addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    self.scrollView = scrollView;
    
    
    
    
    
    
    
    
}

/**
 *  展示模块单元
 *
 *  @param time     时间
 *  @param dataList 内容
 *  @param y        模块开始高度
 *  @param flag     标志  1、开始   2、中间   3、结束
 *
 *  @return 模块单元视图
 */
-(UIView * _Nullable)setContentItem:(NSString * _Nullable)time DataList:(NSMutableArray * _Nullable)dataList Y:(int)y Flag:(int)flag
{
    UIView *contentView;
    if (![dataList isEqual:[NSNull null]] && dataList.count > 0)
    {
        long listCount = dataList.count;
        long viewHeight = listCount * realH(90) + realH(10);
        contentView = [[UIView alloc]initWithFrame:CGRectMake(0, y, [CommonDimensStyle screenWidth], viewHeight)];
        contentView.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        //时间
        time = [NSString stringWithFormat:@"%@年\n%@月%@日",[time componentsSeparatedByString:@"-"][0],[time componentsSeparatedByString:@"-"][1],[time componentsSeparatedByString:@"-"][2]];
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 68, 40)];
        timeLabel.font = [CommonFontColorStyle NormalSizeFont];
        timeLabel.textColor = [CommonFontColorStyle E6Color];
        timeLabel.text = time;
        timeLabel.numberOfLines = 0;
        [contentView addSubview:timeLabel];
        
        //圆圈
        int circleImageWidth = realW(24);
        UIImageView *circleImage = [[UIImageView alloc]initWithFrame:CGRectMake(timeLabel.gjcf_right, (45-circleImageWidth)/2, circleImageWidth, circleImageWidth)];
        circleImage.image = [UIImage imageNamed:@"aide_line_time"];
        [contentView addSubview:circleImage];
        
        //下拉线
        //上面高度
        if (flag != 0) {
            DottedLineView *dottedLinetopView = [[DottedLineView alloc]initWithFrame:CGRectMake(timeLabel.gjcf_right+5.5, 0, 1, circleImage.gjcf_top)];
            dottedLinetopView.lineColor = [CommonFontColorStyle E6Color];
            [contentView addSubview:dottedLinetopView];
        }
        
        DottedLineView *dottedLineView = [[DottedLineView alloc]initWithFrame:CGRectMake(timeLabel.gjcf_right+5.5, circleImage.gjcf_bottom, 1, contentView.gjcf_height-27)];
        dottedLineView.lineColor = [CommonFontColorStyle E6Color];
        [contentView addSubview:dottedLineView];
        
        //内容
        int contentStartX =circleImage.gjcf_right + 20;
        for (int i = 0; i<listCount; i++)
        {
            ServiceWaterModel *waterFlowModel  = (ServiceWaterModel *) dataList[i];
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom ];
            view.frame = CGRectMake(contentStartX, i*45, [CommonDimensStyle screenWidth]- contentStartX, 45);
            
            view.tag = y+i;
            [self.trueDataDictionary setObject:waterFlowModel forKey:[NSString stringWithFormat:@"%d",y+i]];
            [view addTarget:self action:@selector(viewClick:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *viewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.gjcf_width - 33, view.gjcf_height)];
            viewLabel.textColor = [CommonFontColorStyle FontNormalColor];
            viewLabel.font = [CommonFontColorStyle NormalSizeFont];
            
            
            NSString *showText =waterFlowModel.title;
            if ([waterFlowModel.title containsString:@"日"]) {
                showText =[waterFlowModel.title componentsSeparatedByString:@"日"][1];
//                showText = [self.fromTag isEqualToString:@"长江水位"] ? @"长江水位情况" : @"长江流量情况";
                if ([self.fromTag isEqualToString:@"长江流量"]) {
                    XXJLog(@"%@",showText)
                    showText = [showText stringByReplacingOccurrencesOfString:@"水位" withString:@"流量"];
                    
                    XXJLog(@"%@",showText)
                }
            }
            viewLabel.text = showText;
            [view addSubview:viewLabel];
            
            
            UIImageView *viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(viewLabel.gjcf_right +10, 16, 13, 13)];
            viewImage.image =[UIImage imageNamed:@"arrow01_gray"];
            [view addSubview:viewImage];
            
            
            UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, view.gjcf_width, 0.5)];
            viewLine.backgroundColor = [CommonFontColorStyle E4E5E9Color];
            [view addSubview:viewLine];
            [contentView addSubview:view];
            
        }
        
    }

    return contentView;
}


-(void)viewClick:(UIButton *)sender{
    
    [self.delegate DDViewClick:sender.tag];
}










































@end
