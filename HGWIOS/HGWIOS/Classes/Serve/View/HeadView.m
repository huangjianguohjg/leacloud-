//
//  HeadView.m
//  haoyunhl
//
//  Created by lianghy on 16/5/12.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "HeadView.h"
#import "CommonFontColorStyle.h"
#import "UIView+Extend.h"
#import "UIView+GJCFViewFrameUitil.h"
@implementation HeadView


-(instancetype)initWithFrame:(CGRect)frame type:(int)value{
    self = [super initWithFrame:frame];
    if (self) {
    UIView *mainView = [[UIView alloc]initWithFrame:frame];
        [self addSubview:mainView];
        mainView.backgroundColor =[CommonFontColorStyle mainBackgroundColor];
        
        
        int lineHalfWidth = (self.frame.size.width - 50-20*4)/8;
        int topHeight = 15;
        int imageWidth = 20;
        int baseWidth =lineHalfWidth*2+imageWidth;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(25, 25, (frame.size.width - 50), 1)];
        lineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
        [self addSubview:lineView];
        
        //绿色
        UIView*greenlineView = [[UIView alloc]initWithFrame:CGRectMake(25, 25, (2*lineHalfWidth+20)*value, 1)];
        greenlineView.backgroundColor = [CommonFontColorStyle C7ABColor];
        [self addSubview:greenlineView];
        
        UIImageView *firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(25+lineHalfWidth,topHeight , imageWidth, imageWidth)];
        
        firstImage.image =[UIImage imageNamed:@"ins_number_01"];
        [self addSubview:firstImage];
        
        UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, (firstImage.gjcf_bottom+10), baseWidth, 14)];
        oneLabel.text = @"投保信息";
        oneLabel.textAlignment = NSTextAlignmentCenter;
        oneLabel.font = [CommonFontColorStyle SmallSizeFont];
        oneLabel.textColor = [CommonFontColorStyle C7ABColor];
        [self addSubview:oneLabel];
        //第二步
        UIImageView *secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(25+3*lineHalfWidth+20,topHeight , imageWidth, imageWidth)];
        
        [self addSubview:secondImage];
        
        UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(oneLabel.gjcf_right, secondImage.gjcf_bottom+10, baseWidth, 14)];
        twoLabel.text = @"货物信息";
        twoLabel.textAlignment = NSTextAlignmentCenter;
        twoLabel.font = [CommonFontColorStyle SmallSizeFont];
        [self addSubview:twoLabel];
        if (value >= 2) {
            secondImage.image =[UIImage imageNamed:@"ins_number_02"];
            twoLabel.textColor = [CommonFontColorStyle C7ABColor];
        }else{
            secondImage.image =[UIImage imageNamed:@"ins_number_02g"];
            twoLabel.textColor = [CommonFontColorStyle B4C4D3Color];
        }
        //第三步
        UIImageView *thirdImage = [[UIImageView alloc]initWithFrame:CGRectMake(25+5*lineHalfWidth+40,topHeight , imageWidth, imageWidth)];
        
        [self addSubview:thirdImage];
        
        UILabel *thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(twoLabel.gjcf_right, thirdImage.gjcf_bottom+10, baseWidth, 14)];
        thirdLabel.text = @"运输信息";
        thirdLabel.font = [CommonFontColorStyle SmallSizeFont];
        thirdLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:thirdLabel];

        if (value >= 3) {
            thirdImage.image =[UIImage imageNamed:@"ins_number_03"];
             thirdLabel.textColor = [CommonFontColorStyle C7ABColor];
        }else{
            thirdImage.image =[UIImage imageNamed:@"ins_number_03g"];
             thirdLabel.textColor = [CommonFontColorStyle B4C4D3Color];
        }
        //第四步
        UIImageView *fourImage = [[UIImageView alloc]initWithFrame:CGRectMake(25+7*lineHalfWidth+60,topHeight , imageWidth, imageWidth)];
        
        [self addSubview:fourImage];
        UILabel *fourLabel = [[UILabel alloc]initWithFrame:CGRectMake(thirdLabel.gjcf_right, thirdImage.gjcf_bottom+10, baseWidth, 14)];
        fourLabel.text = @"保险信息";
        fourLabel.textAlignment = NSTextAlignmentCenter;
        fourLabel.font = [CommonFontColorStyle SmallSizeFont];
        [self addSubview:fourLabel];

        if (value >= 4) {
            fourImage.image =[UIImage imageNamed:@"ins_number_04"];
            fourLabel.textColor = [CommonFontColorStyle C7ABColor];
        }else{
            fourImage.image =[UIImage imageNamed:@"ins_number_04g"];
            fourLabel.textColor = [CommonFontColorStyle B4C4D3Color];
        }
        
        
    }
    return self;
}

@end
