//
//  GJGCCommonColorStyle.h
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 14-11-3.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/***  设定字体 */
#define DDFont(size) [UIFont systemFontOfSize:size]
/***  设定字体颜色 */
#define DDColor(color) [CommonFontColorStyle colorFromHexString:color]

@interface CommonFontColorStyle : NSObject

#pragma mark - 导航栏

+ (UIFont *)navigationBarTitleViewFont;

+ (UIFont *)navigationBarItemFont;

+ (UIColor *)navigationBarTitleColor;

#pragma mark - 详情大标题

+ (UIFont *)detailBigTitleFont;

+ (UIColor *)detailBigTitleColor;

#pragma mark - 全局字号 列表标题 详情正文

+ (UIFont *)listTitleAndDetailTextFont;

+ (UIColor *)listTitleAndDetailTextColor;

#pragma mark - 基本字号 标题下的辅助文字

+ (UIFont *)baseAndTitleAssociateTextFont;

+ (UIColor *)baseAndTitleAssociateTextColor;

#pragma mark - 主题色彩  辅助色彩  页面底色

+ (UIColor *)mainThemeColor;

+ (UIColor *)mainAssociateColor;

+ (UIColor *)mainBackgroundColor;

#pragma mark - 点击态

+ (UIColor *)tapHighlightColor;

#pragma mark - 分割线

+ (UIColor *)mainSeprateLineColor;

#pragma mark - 男士 女士 年龄颜色

+ (UIColor *)manAgeColor;

+ (UIColor *)womenAgeColor;

#pragma mark - 返回一个箭头view
+ (UIImageView*)accessoryIndicatorView;

#pragma mark -重要字体颜色
+ (UIColor *)FontImportColor;
#pragma mark -普通字体颜色
+ (UIColor *)FontNormalColor;
#pragma mark -次要字体颜色
+ (UIColor *)FontSecondColor;
#pragma mark -较淡字体颜色
+ (UIColor *)FontThreeColor;

#pragma mark -重要背景
+ (UIColor *)BackImportColor;
#pragma mark -普通背景
+ (UIColor *)BackNormalColor;
#pragma mark -次要背景
+ (UIColor *)BackSecondColor;
#pragma mark -底部文字背景
+ (UIColor *)BottomTextColor;
#pragma mark -加载背景
+ (UIColor *)BackLoadingColor;
#pragma mark -提交背景
+ (UIColor *)UnSubmitColor;
#pragma mark -淡色背景
+ (UIColor *)LightbackgroudColor;
#pragma mark -淡灰色背景
+ (UIColor *)LightGraygroudColor;

#pragma mark -边界背景
+ (UIColor *)NormalBorderColor;

#pragma mark -蓝色
+ (UIColor *)BlueColor;
#pragma mark -白色
+ (UIColor *)WhiteColor;
#pragma mark -浅绿色
+ (UIColor *)LightGreenolor;
#pragma mark -深绿色
+ (UIColor *)BlackGreenolor;
#pragma mark -绿色
+ (UIColor *)Greenolor;
#pragma mark -橙色
+ (UIColor *)OrangeColor;
#pragma mark -灰色
+ (UIColor *)C9Color;
#pragma mark -黑色
+ (UIColor *)I3Color;
#pragma mark -淡蓝色
+ (UIColor *)LightBlueColor;
#pragma mark -橙色
+ (UIColor *)newOrageColor;
#pragma mark -橙色
+ (UIColor *)E1E6ECColor;
#pragma mark -红色背景
+ (UIColor *)RedColor;
#pragma mark -深蓝色背景
+ (UIColor *)DarkBlueColor;
#pragma mark -黄色背景
+ (UIColor *)YellowColor;
#pragma mark -背景
+ (UIColor *)F8F9FBColor;
+ (UIColor *)E2E6E9Color;
+ (UIColor *)C6D2DEColor;
+ (UIColor *)CFE0F2Color;
+ (UIColor *)B8CA0Color;
+ (UIColor *)EBF46Color;
+ (UIColor *)EB9EFColor;
+ (UIColor *)D0D4D7Color;
+ (UIColor *)AA0ECColor;
+ (UIColor *)A9B8B9Color;
+ (UIColor *)E2E5ECColor;
+ (UIColor *)C7ABColor;
+ (UIColor *)B4C4D3Color;
+ (UIColor *)DBE6EFColor;
+ (UIColor *)F7F9FBColor;
+ (UIColor *)FE0000Color;
+ (UIColor *)FFEDDCColor;
+ (UIColor *)F9E0C7Color;
+ (UIColor *)EBAF0Color;
+ (UIColor *)E2E2E2Color;
+ (UIColor *)B8F3Color;
+ (UIColor *)CECECEColor;
+ (UIColor *)FFA145Color;
+ (UIColor *)FFFDF4Color;
+ (UIColor *)F7F7F7Color;
+ (UIColor *)F1F4F9Color;
+ (UIColor *)b9ffColor;
+ (UIColor *)F09134Color;
+ (UIColor *)AAECColor;
+ (UIColor *)FFAE00Color;
+(UIColor *)E2F1FFColor;
+(UIColor *)E6Color;
+(UIColor *)DADF7Color;
+(UIColor *)FE5558Color;
+(UIColor *)D55CColor;
+(UIColor *)FDFColor;
+(UIColor *)C3F1Color;
+(UIColor *)EEEEEEColor;
+(UIColor *)F3F4F8Color;
+(UIColor *)D2D8Color;
+(UIColor *)EFF3F6Color;
+(UIColor *)DFE3E6Color;
+(UIColor *)DEDEDEColor;
+(UIColor *)F5F5F5Color;
+(UIColor *)F5FAFFColor;
+(UIColor *)EEF1F6Color;
+(UIColor *)C9D0D5Color;
+(UIColor *)E4E4E4Color;
+(UIColor *)FFAE02Color;
+(UIColor *)C8CFD5Color;
+(UIColor *)F08A0EColor;
+(UIColor *)CAD4DEColor;
+(UIColor *)CFCFCFColor;
+(UIColor *)DAFFColor;
+(UIColor *)DBEEFFColor;
+(UIColor *)F38E1AColor;
+(UIColor *)D9CA85Color;
+(UIColor *)D1D1D1Color;
+(UIColor *)A0AAB6Color;
+(UIColor *)D2B8Color;
+(UIColor *)F8FCFFColor;
+(UIColor *)E4E5E9Color;
+(UIColor *)A3ADColor;
+(UIColor *)E3E3E3Color;
+(UIColor *)FFE530Color;
+(UIColor *)DAFDColor;
+(UIColor *)B6EColor;
+(UIColor *)B1Color;
+(UIColor *)FECC2FColor;
+(UIColor *)C165189Color;
+(UIColor *)B2B6Color;
+(UIColor *)F2F6FCColor;
+(UIColor *)D82C1Color;
+(UIColor *)EBF0F6Color;
#pragma mark -深蓝色背景
+ (UIColor *)ebBackgroudColor;

#pragma mark -验证码不可输入
+ (UIColor *)WhiteVerUn;
#pragma mark -验证码可输入
+ (UIColor *)WhiteVerCan;
#pragma mark -搜索背景
+ (UIColor *)searchbackColor;

#pragma mark TitleTextFont字
+(UIFont *)BigTitleTextFont;
#pragma mark SmallBigTitleTextFont字
+(UIFont *)SmallBigTitleTextFont;
#pragma mark TitleTextFont字
+(UIFont *)TitleTextFont;
#pragma mark ButtonTextFont字
+(UIFont *)ButtonTextFont;
#pragma mark InputTextFont字
+(UIFont *)InputTextFont;
#pragma mark superSizeFont字
+(UIFont *)superSizeFont;
#pragma mark BigSizeFont字
+(UIFont *)BigSizeFont;
#pragma mark BigNormalSizeFont字
+(UIFont *)BigNormalSizeFont;
#pragma mark MenuSizeFont字
+(UIFont *)MenuSizeFont;
#pragma mark NormalSizeFont字
+(UIFont *)NormalSizeFont;
#pragma mark SmallSizeFont字
+(UIFont *)SmallSizeFont;
#pragma mark SecondSmallSizeFont字
+(UIFont *)SecondSmallSizeFont;
#pragma mark font13字
+(UIFont *)F13SizeFont;
#pragma mark font14号粗字
+(UIFont *)F14BoldSizeFont;
#pragma mark font15号粗字
+(UIFont *)F15BoldSizeFont;
#pragma mark font17号粗字
+(UIFont *)F17BoldSizeFont;
#pragma mark font18号粗字
+(UIFont *)F18BoldSizeFont;
#pragma mark font20号粗字
+(UIFont *)F20BoldSizeFont;

#pragma mark SuperSmallFont字
+(UIFont *)SuperSmallFont;
+(UIFont *)TwentySevenTextFont;
+ (UIColor *)LoadingColor;

+ (UIColor *)colorFromRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (UIColor *)colorFromHexString:(NSString *)hexString;
@end

