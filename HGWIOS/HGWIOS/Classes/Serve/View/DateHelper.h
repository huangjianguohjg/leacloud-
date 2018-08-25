//
//  DateHelper.h
//  haoyunhl
//
//  Created by lianghy on 16/5/7.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject
+(NSString *)DateStampToString:(long)date;
+(NSString *)DateToString:(NSDate *)date;
+(NSString *)StringDateStampToString:(NSString *)date;
+(NSString *)StringDateStampToMinitesString:(NSString *)date;
+(NSString *)StringDateStampToSecondsString:(NSString *)date;
+(NSString *)StringDateStampZHToString:(NSString *)date;
+(NSString *)StringDateStampToShortMinitesString:(NSString *)date;
+(int)StringToInt:(NSString *)date;
+(NSString *)NowToZHString;
+(NSDate *)StringToDate:(NSString *)date;
+(NSDate *)DateIntervalToDate:(NSString *)date;
+(NSString *)DateStampToTimeString:(long)date;
@end
