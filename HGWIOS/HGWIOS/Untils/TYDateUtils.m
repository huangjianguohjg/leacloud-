//
//  TYDateUtils.m
//  funsole
//
//  Created by gagakj on 2017/12/8.
//  Copyright © 2017年 gagakj. All rights reserved.
//

#import "TYDateUtils.h"

@implementation TYDateUtils

/**
 获取当前日期
 返回 2017-12-08
 */
+(NSString *)getCurentDate{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
   
    return currentDateStr;
}

/**
 传入日期格式
 获取当前时间
 返回 时间字符串
 */
+(NSString *)getCurentDateWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return currentDateStr;
}

/**
 把某一格式的日期字符串转成指定格式的日期字符串
 */
+(NSString *)getFormatDateWithDateString:(NSString *)oldDate withOldFormat:(NSString *)oldFormat ToNewFormat:(NSString *)newformat{
    NSDate *date = [self getFormatDate:oldDate withFormat:oldFormat];
    NSString *dateStr = [self getDateString:date withFormat:newformat];
    return dateStr;
}

/**
 获取今天开始几天后的日期
 */
+(NSString *)getDateAfterDays:(NSInteger)days withFormat:(NSString *)format{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval oneDay = 24*60*60*1;
    
    NSDate *resultDate = [nowDate initWithTimeIntervalSinceNow: + oneDay * (days -1) ];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *resultDateStr = [dateFormatter stringFromDate:resultDate];
    
    return resultDateStr;
}

/**
 获取某个日期开始几天后的日期
 */
+(NSString *)getDateAfterDays:(NSInteger)days startDate:(NSDate *)startDate withFormat:(NSString *)format{
//    NSDate *nowDate = [NSDate date];
    NSTimeInterval oneDay = 24*60*60*1;
    
//    NSDate *resultDate = [startDate initWithTimeIntervalSinceNow: + oneDay * days ];
    NSDate *resultDate = [startDate initWithTimeInterval:oneDay * (days - 1) sinceDate:startDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSString *resultDateStr = [dateFormatter stringFromDate:resultDate];
    
    return resultDateStr;
}



/**
 获取一段时间之间的所有时间
 */
+(NSMutableArray *)getAllDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSMutableArray *dates = [NSMutableArray array];
    long long nowTime = [startDate timeIntervalSince1970], //开始时间
    endTime = [endDate timeIntervalSince1970],//结束时间
    
    dayTime = 24*60*60,
    time = nowTime - nowTime%dayTime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    while (time <= endTime) {
        NSString *showOldDate = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
        [dates addObject:showOldDate];
        time += dayTime;
    }
    
    return dates;
}

#pragma mark -以下是内部方法
/**
 把某一格式的日期字符串转成NSDate
 */
+(NSDate *)getFormatDate:(NSString *)DateStr withFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSDate *date = [dateFormatter dateFromString:DateStr];
    return date;
}
/**
 把NSDate转成某一格式的日期字符串
 */
+ (NSString *)getDateString:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}




#pragma mark - 将某个时间戳转化成 时间
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    //    NSLog(@"1296035591  = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}

+ (NSString *)timestampSwitchTime:(NSInteger)timestamp Format:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    //    NSLog(@"1296035591  = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}








#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    
    
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    
    
    return timeSp;
    
}


#pragma mark - 获取当前时间的 时间戳

+(NSInteger)getNowTimestamp{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    
    
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    //时间转时间戳的方法:
    
    
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    
    
    
    NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    
    
    
    return timeSp;
    
}







#pragma mark -- 比较日期的大小
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate formate:(NSString *)dateFormate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:dateFormate];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedAscending)
    {
        //bDate比aDate小
        aa=1;
    }else if (result == NSOrderedDescending)
    {
        //bDate比aDate大
        aa=-1;
        
    }
    
    
    return aa;
}







@end
