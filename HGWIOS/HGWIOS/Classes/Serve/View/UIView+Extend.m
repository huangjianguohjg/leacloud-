//
//  UIView+Extend.m
//  haoyunhl
//
//  Created by lianghy on 16/3/25.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "UIView+Extend.h"
#import "CommonFontColorStyle.h"
#import "UIImage+Extend.h"
#import "CommonDimensStyle.h"
#import "UIView+GJCFViewFrameUitil.h"
@implementation UIView(Extend)

+(UIView *) GetTitle:(NSString *)title{
    UIView *loading =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, [CommonDimensStyle screenWidth], 80)];
    [loading  setBackgroundColor:[CommonFontColorStyle LoadingColor]];
    
    
    UIView *headback = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [CommonDimensStyle screenWidth ], 20)];
    [headback setBackgroundColor:[CommonFontColorStyle BlueColor]];
    [loading addSubview:headback];
    
    //返回按钮
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [CommonDimensStyle screenWidth], 60)];
    [head setBackgroundColor:[CommonFontColorStyle BlueColor]];
    [loading addSubview:head];
    //标题
    UILabel *headtitle = [[UILabel alloc]init];
    [headtitle setText:title];
    [headtitle setFont:[CommonFontColorStyle TitleTextFont]];
    [headtitle setTextColor:[CommonFontColorStyle WhiteColor]];
    headtitle.frame = CGRectMake(0, 10, [CommonDimensStyle screenWidth], 40) ;
    [headtitle setTextAlignment:NSTextAlignmentCenter];
    [head addSubview:headtitle];
    
    //返回按钮
    UIView *backView =  [[UIView alloc]initWithFrame:CGRectMake(20, 10, 80, 40)];
    [head addSubview:backView];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
    backImage.image = [UIImage imageNamed:@"arrow_top_l.png"];
    [backView addSubview:backImage];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(backImage.gjcf_right, 10, 50, 20)];
    backLabel.text = @"返回";
    backLabel.textColor = [CommonFontColorStyle WhiteColor];
    backLabel.font = [CommonFontColorStyle BigSizeFont];
    [backView addSubview:backLabel];
    
    UITapGestureRecognizer *backGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitevent:)];
    backGesture.numberOfTapsRequired=1;
    [backView addGestureRecognizer:backGesture];
    
    return  loading;
}
@end
