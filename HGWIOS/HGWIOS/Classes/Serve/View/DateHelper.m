//
//  DateHelper.m
//  haoyunhl
//
//  Created by lianghy on 16/5/7.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "DateHelper.h"
#import "GJCFStringUitil.h"
@implementation DateHelper
+(NSString *)DateStampToString:(long)date{

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:date];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+(NSString *)StringDateStampToString:(NSString *)date{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    long orderTime = [date longLongValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:orderTime];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
+(NSString *)StringDateStampToMinitesString:(NSString *)date{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    long orderTime = [date longLongValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:orderTime];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+(NSString *)StringDateStampToShortMinitesString:(NSString *)date{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    long orderTime = [date longLongValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:orderTime];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+(NSString *)StringDateStampToSecondsString:(NSString *)date{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    long orderTime = [date longLongValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:orderTime];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
+(NSString *)StringDateStampZHToString:(NSString *)date{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    long orderTime = [date longLongValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:orderTime];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
+(int)StringToInt:(NSString *)date{
    NSString *intValue = [[[date stringByReplacingOccurrencesOfString:@"年" withString:@""] stringByReplacingOccurrencesOfString:@"月" withString:@""]stringByReplacingOccurrencesOfString:@"日" withString:@""];
    
    return (int) [GJCFStringUitil stringToInt:intValue];
}
+(NSString *)DateToString:(NSDate *)date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *confromTimespStr = [formatter stringFromDate:date];
    return confromTimespStr;
}
+(NSString *)NowToZHString{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [NSDate date];
    NSString *confromTimespStr = [formatter stringFromDate:date];
    return confromTimespStr;
}

+(NSDate *)StringToDate:(NSString *)date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *resultDate = [formatter dateFromString:date];
    return resultDate;
}

+(NSDate *)DateIntervalToDate:(NSString *)date{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[GJCFStringUitil stringToInt:date]];
    return confromTimesp;
}
+(NSString *)DateStampToTimeString:(long)date{
    if (date<60) {
        return [NSString stringWithFormat:@"00:00 %ld",date];
    }else if(date >= 60 && date < 3600){
        return [NSString stringWithFormat:@"00:%ld",date/60];
    }else{
        return [NSString stringWithFormat:@"%ld:%ld",date/3600,date%3600/60];
    }
}
@end
