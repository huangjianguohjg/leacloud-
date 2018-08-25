//
//  TYDateUtils.h
//  funsole
//
//  Created by gagakj on 2017/12/8.
//  Copyright © 2017年 gagakj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYDateUtils : NSObject


/**
 把某一格式的日期字符串转成NSDate
 */
+(NSDate *)getFormatDate:(NSString *)DateStr withFormat:(NSString *)format;

/**
 把NSDate转成某一格式的日期字符串
 */
+ (NSString *)getDateString:(NSDate *)date withFormat:(NSString *)format;

/**
 获取当前日期
 返回 2017-12-08
 */
+(NSString *)getCurentDate;
/**
 传入日期格式
 获取当前时间
 返回 时间字符串
 */
+(NSString *)getCurentDateWithFormat:(NSString *)format;
/**
 把某一格式的日期字符串转成指定格式的日期字符串
 */
+(NSString *)getFormatDateWithDateString:(NSString *)oldDate withOldFormat:(NSString *)oldFormat ToNewFormat:(NSString *)newformat;
/**
 获取今天开始几天后的日期
 */
+(NSString *)getDateAfterDays:(NSInteger)days withFormat:(NSString *)format;


/**
 获取某个日期开始几天后的日期
 */
+(NSString *)getDateAfterDays:(NSInteger)days startDate:(NSDate *)startDate withFormat:(NSString *)format;


/**
 获取一段时间之间的所有时间
 */
+(NSMutableArray *)getAllDate:(NSDate *)startDate endDate:(NSDate *)endDate;



/**
 将某个时间戳 转化成 时间
 */
+(NSString *)timestampSwitchTime:(NSInteger)timestamp;
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp Format:(NSString *)format;

/**
 将某个时间 转化成 时间戳
 */
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/**
 获取当前时间的 时间戳
 */
+(NSInteger)getNowTimestamp;


/**
 比较两个时间的大小
 */
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate formate:(NSString *)dateFormate;



@end





















