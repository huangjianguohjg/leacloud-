//
//  GJGCCommonColorStyle.m
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 14-11-3.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "CommonFontColorStyle.h"

@implementation CommonFontColorStyle

#pragma mark - 导航栏

+ (UIFont *)navigationBarTitleViewFont
{
    return [UIFont boldSystemFontOfSize:19];
}

+ (UIFont *)navigationBarItemFont
{
    return [UIFont boldSystemFontOfSize:16];
}

+ (UIColor *)navigationBarTitleColor
{
    return [UIColor whiteColor];
}

#pragma mark - 详情大标题

+ (UIFont *)detailBigTitleFont
{
    return [UIFont systemFontOfSize:16];
}

+ (UIColor *)detailBigTitleColor
{
   return [self colorFromRed:38 green:38 blue:38];
}

#pragma mark - 全局字号 列表标题 详情正文

+ (UIFont *)listTitleAndDetailTextFont
{
    return [UIFont systemFontOfSize:14];
}

+ (UIColor *)listTitleAndDetailTextColor
{
    return [CommonFontColorStyle detailBigTitleColor];
}

#pragma mark - 基本字号 标题下的辅助文字

+ (UIFont *)baseAndTitleAssociateTextFont
{
    return [UIFont systemFontOfSize:12];
}

+ (UIColor *)baseAndTitleAssociateTextColor
{
     return [self colorFromRed:153 green:153 blue:153];
}

#pragma mark - 主题色彩  辅助色彩  页面底色

+ (UIColor *)mainThemeColor
{
    return [self colorFromHexString:@"13a2dd"];
}

+ (UIColor *)mainAssociateColor
{
    return [self colorFromRed:255 green:114 blue:0];
}

+ (UIColor *)mainBackgroundColor
{
    return [self colorFromHexString:@"efefef"];
}

#pragma mark - 点击态

+ (UIColor *)tapHighlightColor
{
    return [self colorFromRed:229 green:229 blue:229];
}

#pragma mark - 分割线

+ (UIColor *)mainSeprateLineColor
{
    
    return [self colorFromRed:216 green:216 blue:216];
}

#pragma mark - 男士 女士 年龄颜色

+ (UIColor *)manAgeColor
{
    return [self colorFromHexString:@"7ecef4"];
}

+ (UIColor *)womenAgeColor
{
    return [self colorFromHexString:@"ffa9c5"];
}

#pragma mark - 返回一个箭头view
+ (UIImageView*)accessoryIndicatorView
{
    UIImageView *res = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"按钮箭头"]];
    res.frame = CGRectMake(0, 0, 7, 12);
    return res;
}

+ (UIColor *)colorFromRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    if (hexString == nil) {
        return nil;
    }
    
    unsigned hexNum;
    if ( ![[NSScanner scannerWithString:hexString] scanHexInt:&hexNum] ) {
        return nil;
    }
    
    return [UIColor colorWithRed:((float)((hexNum & 0xFF0000) >> 16))/255.0 green:((float)((hexNum & 0xFF00) >> 8))/255.0 blue:((float)(hexNum & 0xFF))/255.0 alpha:1.0];
}


#pragma mark -重要字体
+ (UIColor *)FontImportColor{
     return [self colorFromHexString:@"222222"];
}
#pragma mark -普通字体
+ (UIColor *)FontNormalColor{
      return [self colorFromHexString:@"666666"];
}
#pragma mark -次要字体
+ (UIColor *)FontSecondColor{
      return [self colorFromHexString:@"b3b3b3"];
}
+ (UIColor *)FontThreeColor{
      return [self colorFromHexString:@"C2C2C2"];
}

#pragma mark -重要背景
+ (UIColor *)BackImportColor{
      return [self colorFromHexString:@"efefef"];
}

#pragma mark -普通背景
+ (UIColor *)BackNormalColor{
    return [self colorFromHexString:@"eaeaea"];
}

#pragma mark -次要背景
+ (UIColor *)BackSecondColor{
       return [self colorFromHexString:@"d7d7d7"];
}


#pragma mark -蓝色
+ (UIColor *)BlueColor{
     return [self colorFromHexString:@"4097e6"];
}

+ (UIColor *)WhiteColor{
     return [self colorFromHexString:@"ffffff"];
}

+ (UIColor *)OrangeColor{
    return [self colorFromHexString:@"FF9533"];
}
#pragma mark -验证码不可输入
+ (UIColor *)WhiteVerUn{
     return [self colorFromHexString:@"B0B0B0"];
}
#pragma mark -验证码可输入
+ (UIColor *)WhiteVerCan{
     return [self colorFromHexString:@"FF9533"];
}
#pragma mark InputTextFont字
+(UIFont *)InputTextFont{
 return [UIFont systemFontOfSize:17];
}
#pragma mark BigSizeFont字
+(UIFont *)BigSizeFont{
    return [UIFont systemFontOfSize:18];
}
#pragma mark BigNormalSizeFont字
+(UIFont *)BigNormalSizeFont{
    return [UIFont systemFontOfSize:17];
}
#pragma mark MenuSizeFont字
+(UIFont *)MenuSizeFont{
    return [UIFont systemFontOfSize:17];
}
#pragma mark NormalSizeFont字
+(UIFont *)NormalSizeFont{
    return [UIFont systemFontOfSize:15];
}
#pragma mark SmallSizeFont字
+(UIFont *)SmallSizeFont{
    return [UIFont systemFontOfSize:14];
}
#pragma mark SecondSmallSizeFont字
+(UIFont *)SecondSmallSizeFont{
    return [UIFont systemFontOfSize:17];
}
#pragma mark SuperSmallFont字
+(UIFont *)SuperSmallFont{
    return [UIFont systemFontOfSize:12];
}

#pragma mark -浅绿色
+ (UIColor *)LightGreenolor{
        return [self colorFromHexString:@"90c654"];
}
#pragma mark -深绿色
+ (UIColor *)BlackGreenolor{
 return [self colorFromHexString:@"74c34c"];
}
#pragma mark -加载背景
+ (UIColor *)LoadingColor{
return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}
+(UIFont *)superSizeFont{
 return [UIFont systemFontOfSize:20];
}
+(UIFont *)TitleTextFont{
 return [UIFont systemFontOfSize:20];
}
+(UIFont *)SmallBigTitleTextFont{
 return [UIFont systemFontOfSize:22];
}
+(UIFont *)BigTitleTextFont{
return [UIFont systemFontOfSize:30];
}
+(UIFont *)F13SizeFont{
return [UIFont systemFontOfSize:13];
}
#pragma mark ButtonTextFont字
+(UIFont *)ButtonTextFont{
    return [UIFont systemFontOfSize:19];
}
#pragma mark -搜索背景
+ (UIColor *)searchbackColor{
return [self colorFromHexString:@"c3c3c3"];
}
#pragma mark -提交背景
+ (UIColor *)UnSubmitColor{
return [self colorFromHexString:@"B9B9B9"];
}
#pragma mark -底部文字背景
+ (UIColor *)BottomTextColor{
return [self colorFromHexString:@"999999"];
}

+ (UIColor *)NormalBorderColor{
return [self colorFromHexString:@"cacaca"];
}
+(UIFont *)TwentySevenTextFont{
return [UIFont systemFontOfSize:27];
}
+ (UIColor *)C9Color{
return [self colorFromHexString:@"c9c9c9"];
}
+ (UIColor *)I3Color{
return [self colorFromHexString:@"333333"];
}
+ (UIColor *)LightBlueColor{
return [self colorFromHexString:@"EDF6FF"];
}
+ (UIColor *)Greenolor{
return [self colorFromHexString:@"75C34C"];
}
+ (UIColor *)newOrageColor{
return [self colorFromHexString:@"FF7E00"];
}
#pragma mark -淡色背景
+ (UIColor *)LightbackgroudColor{
return [self colorFromHexString:@"F6F6F6"];
}
#pragma mark -淡灰色背景
+ (UIColor *)LightGraygroudColor{
return [self colorFromHexString:@"F9F9F9"];
}
+ (UIColor *)E1E6ECColor{
return [self colorFromHexString:@"e1e6ec"];
}
#pragma mark -红色背景
+ (UIColor *)RedColor{
    return [self colorFromHexString:@"fd5557"];
}
#pragma mark -深蓝色背景
+ (UIColor *)DarkBlueColor{
return [self colorFromHexString:@"2980ce"];
}
+ (UIColor *)ebBackgroudColor{
return [self colorFromHexString:@"ebf0f6"];
}
+ (UIColor *)YellowColor{
return [self colorFromHexString:@"f38911"];
}
+ (UIColor *)F8F9FBColor{
    return [self colorFromHexString:@"f8f9fb"];
}
+ (UIColor *)E2E6E9Color{
 return [self colorFromHexString:@"e2e6e9"];
}
+ (UIColor *)C6D2DEColor{
 return [self colorFromHexString:@"c6d2de"];
}
+ (UIColor *)CFE0F2Color{
return [self colorFromHexString:@"CFE0F2"];
}
+ (UIColor *)B8CA0Color{
return [self colorFromHexString:@"7b8ca0"];
}
+ (UIColor *)EBF46Color{
return [self colorFromHexString:@"2ebf46"];
}
+ (UIColor *)EB9EFColor{
//return [self colorFromHexString:@"7eb9ef"];
    return [self colorFromHexString:@"2dabff"];
}
+ (UIColor *)D0D4D7Color{
return [self colorFromHexString:@"d0d4d7"];
}
+ (UIColor *)AA0ECColor{
return [self colorFromHexString:@"7aa0ec"];
}
+ (UIColor *)A9B8B9Color{
return [self colorFromHexString:@"a9b8b9"];
}
+ (UIColor *)E2E5ECColor{
    return [self colorFromHexString:@"e2e5ec"];
}
+ (UIColor *)C7ABColor{
    return [self colorFromHexString:@"56C7AB"];
}
+ (UIColor *)B4C4D3Color{
    return [self colorFromHexString:@"b4c4d3"];
}
+ (UIColor *)DBE6EFColor{
    return [self colorFromHexString:@"dbe6ef"];
}
+ (UIColor *)F7F9FBColor{
    return [self colorFromHexString:@"f7f9fb"];
}
+ (UIColor *)FE0000Color{
    return [self colorFromHexString:@"fe0000"];
}
+ (UIColor *)FFEDDCColor{
    return [self colorFromHexString:@"ffeddc"];
}
+ (UIColor *)F9E0C7Color{
    return [self colorFromHexString:@"f9e0c7"];
}
+ (UIColor *)EBAF0Color{
    return [self colorFromHexString:@"7ebaf0"];
}
+ (UIColor *)E2E2E2Color{
    return [self colorFromHexString:@"e2e2e2"];
}
+ (UIColor *)B8F3Color{
    return [self colorFromHexString:@"74b8f3"];
}
+ (UIColor *)CECECEColor{
    return [self colorFromHexString:@"cecece"];
}
+ (UIColor *)FFA145Color{
    return [self colorFromHexString:@"ffa145"];
}
+ (UIColor *)FFFDF4Color{
    return [self colorFromHexString:@"fffdf4"];
}
+ (UIColor *)F7F7F7Color{
    return [self colorFromHexString:@"f7f7f7"];
}
+ (UIColor *)F1F4F9Color{
    return [self colorFromHexString:@"f1f4f9"];
}
+ (UIColor *)b9ffColor{
return [self colorFromHexString:@"63b9ff"];
}
+ (UIColor *)F09134Color{
return [self colorFromHexString:@"f09134"];
}
+ (UIColor *)AAECColor{
return [self colorFromHexString:@"63aaec"];
}
+ (UIColor *)FFAE00Color{
    return [self colorFromHexString:@"ffae00"];
}
+(UIColor *)E2F1FFColor{
    return [self colorFromHexString:@"e2f1ff"];
}
+(UIColor *)E6Color{
    return [self colorFromHexString:@"4097e6"];
}
+(UIColor *)DADF7Color{
    return [self colorFromHexString:@"4dadf7"];
}
+(UIColor *)FE5558Color{
    return [self colorFromHexString:@"fe5558"];
}
+(UIColor *)D55CColor{
    return [self colorFromHexString:@"80d55c"];
}
+(UIColor *)FDFColor{
    return [self colorFromHexString:@"857fdf"];
}
+(UIColor *)C3F1Color{
    return [self colorFromHexString:@"58c3f1"];
}
+(UIColor *)EEEEEEColor{
    return [self colorFromHexString:@"eeeeee"];
}
+(UIColor *)F3F4F8Color{
    return [self colorFromHexString:@"f3f4f8"];
}
+(UIColor *)D2D8Color{
    return [self colorFromHexString:@"67d2d8"];
}
+(UIColor *)EFF3F6Color{
    return [self colorFromHexString:@"eff3f6"];
}
+(UIColor *)DFE3E6Color{
    return [self colorFromHexString:@"dfe3e6"];
}
+(UIColor *)DEDEDEColor{
    return [self colorFromHexString:@"dedede"];
}
+(UIColor *)F5F5F5Color{
    return [self colorFromHexString:@"f5f5f5"];
}
+(UIColor *)F5FAFFColor{
    return [self colorFromHexString:@"f5faff"];
}
+(UIColor *)EEF1F6Color{
    return [self colorFromHexString:@"eef1f6"];
}
+(UIColor *)C9D0D5Color{
    return [self colorFromHexString:@"c9d0d5"];
}
+ (UIColor *)BackLoadingColor{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
}
+(UIColor *)E4E4E4Color{
return [self colorFromHexString:@"e4e4e4"];
}

+(UIFont *)F14BoldSizeFont{
    return [UIFont fontWithName:@"Helvetica-Bold" size:14];
}
+(UIFont *)F15BoldSizeFont{
    return [UIFont fontWithName:@"Helvetica-Bold" size:15];
}
+(UIFont *)F17BoldSizeFont{
    return [UIFont fontWithName:@"Helvetica-Bold" size:17];
}
+(UIFont *)F18BoldSizeFont{
    return [UIFont fontWithName:@"Helvetica-Bold" size:18];
}

+(UIFont *)F20BoldSizeFont{
    return [UIFont fontWithName:@"Helvetica-Bold" size:20];
}

+(UIColor *)FFAE02Color{
    return [self colorFromHexString:@"ffae02"];
}
+(UIColor *)C8CFD5Color{
    return [self colorFromHexString:@"c8cfd5"];
}
+(UIColor *)F08A0EColor{
    return [self colorFromHexString:@"f08a0e"];
}
+(UIColor *)CAD4DEColor{
    return [self colorFromHexString:@"cad4de"];
}
+(UIColor *)CFCFCFColor{
    return [self colorFromHexString:@"cfcfcf"];
}
+(UIColor *)DAFFColor{
    return [self colorFromHexString:@"83daff"];
}
+(UIColor *)DBEEFFColor{
    return [self colorFromHexString:@"dbeeff"];
}
+(UIColor *)F38E1AColor{
    return [self colorFromHexString:@"f38e1a"];
}
+(UIColor *)D9CA85Color{
    return [self colorFromHexString:@"d9ca85"];
}
+(UIColor *)D1D1D1Color{
    return [self colorFromHexString:@"d1d1d1"];
}
+(UIColor *)A0AAB6Color{
    return [self colorFromHexString:@"a0aab6"];
}
+(UIColor *)D2B8Color{
    return [self colorFromHexString:@"67d2d8"];
}
+(UIColor *)F8FCFFColor{
    return [self colorFromHexString:@"f8fcff"];
}
+(UIColor *)E4E5E9Color{
    return [self colorFromHexString:@"e4e5e9"];
}
+(UIColor *)A3ADColor{
    return [self colorFromHexString:@"99a3ad"];
}
+(UIColor *)E3E3E3Color{
    return [self colorFromHexString:@"e3e3e3"];
}
+(UIColor *)FFE530Color{
    return [self colorFromHexString:@"ffe530"];
}
+(UIColor *)DAFDColor{
    return [self colorFromHexString:@"00dafd"];
}
+(UIColor *)B6EColor{
    return [self colorFromHexString:@"033b6e"];
}
+(UIColor *)B1Color{
    return [self colorFromHexString:@"1366b1"];
}
+(UIColor *)FECC2FColor{
    return [self colorFromHexString:@"fecc2f"];
}
+(UIColor *)C165189Color{
    return [self colorFromHexString:@"165189"];
}
+(UIColor *)B2B6Color{
    return [self colorFromHexString:@"04b2b6"];
}
+(UIColor *)F2F6FCColor{
    return [self colorFromHexString:@"f2f6fc"];
}
+(UIColor *)D82C1Color{
    return [self colorFromHexString:@"3d82c1"];
}
+(UIColor *)EBF0F6Color{
    return [self colorFromHexString:@"ebf0f6"];
}
@end
