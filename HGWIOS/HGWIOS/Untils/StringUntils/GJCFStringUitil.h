//
//  GJCFStringUitil.h
//  GJCommonFoundation
//
//  Created by ZYVincent QQ:1003081775 on 14-10-16.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GJCFStringUitil : NSObject

//判断是否为空
+ (BOOL)stringIsNull:(NSString *)string;
//为空判断
+ (BOOL)stringIsAllWhiteSpace:(NSString *)string;
//字符串转bool
+ (BOOL)stringToBool:(NSString*)sourceString;
//字符串转int
+ (NSInteger)stringToInt:(NSString*)sourceString;
//字符串转Float
+ (CGFloat)stringToFloat:(NSString*)sourceString;
//字符串转double
+ (double)stringToDouble:(NSString*)sourceString;
//bool转字符串
+ (NSString *)boolToString:(BOOL)boolValue;
//int转字符串
+ (NSString *)intToString:(NSInteger)intValue;
//Float转字符串
+ (NSString *)floatToString:(CGFloat)floatValue;
//double转字符串
+ (NSString *)doubleToString:(double)doubleValue;
//是否为email地址
+ (BOOL)stringIsValidateEmailAddress:(NSString *)string;
//是否为手机号码
+ (BOOL)stringISValidateMobilePhone:(NSString *)string;
//是否为电话号码
+ (BOOL)stringIsValidatePhone:(NSString *)string;
//是否为邮政编码
+ (BOOL)stringIsValidateMailCode:(NSString *)string;
//是否为汉字
+ (BOOL)stringIsAllChineseWord:(NSString *)string;
//是否为车牌号
+ (BOOL)stringISValidateCarNumber:(NSString *)string;
//是否为网址
+ (BOOL)stringIsValidateUrl:(NSString *)string;
//是否为身份证
+ (BOOL)stringISValidatePersonCardNumber:(NSString *)string;
//是否只为数字和字母
+ (BOOL)stringJustHasNumberAndCharacter:(NSString *)string;
//是否只有数字
+ (BOOL)stringJustHasNumber:(NSString *)string;

+ (BOOL)stringChineseNumberCharacterOnly:(NSString *)string;
//正则表达式判断
+ (BOOL)sourceString:(NSString*)sourceString regexMatch:(NSString *)regexString;
//获取文件内容
+ (NSString*)stringFromFile:(NSString*)path;
//当前时间字符串
+ (NSString*)currentTimeStampString;

+ (NSString *)unarchieveFromPath:(NSString *)filePath;
//转化为md5
+ (NSString *)MD5:(NSString *)string;
//去掉开头的空格
+ (NSString *)stringByTrimingLeadingWhiteSpace:(NSString *)string;
//去掉结尾的空格
+ (NSString *)stringByTrimingTailingWhiteSpace:(NSString *)string;
//去掉空格
+ (NSString *)stringByTrimingWhiteSpace:(NSString *)string;

+ (NSString *)urlEncode:(id)object;

+ (NSString *)encodeStringFromDict:(NSDictionary *)dict;

+ (NSRange)stringRange:(NSString *)string;
//去掉末尾的0
+ (NSString *)stringCutEndZero:(NSString *)string;
//时间转字符串
+ (NSString *)stringFromDate:(NSDate *)date;
//字符串转时间
+ (NSDate *)dateFromString:(NSString *)dateString;
//获得字符串中的数字组合
+(NSString *)numberFromString:(NSString *)value;
//如果为nil 范围空
+(NSString *)nilStringToString:(NSString *)value;
@end
