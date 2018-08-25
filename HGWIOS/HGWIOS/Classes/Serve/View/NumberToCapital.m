
//
//  NumberToCapital.m
//  haoyunhl
//
//  Created by lianghy on 16/6/16.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "NumberToCapital.h"
typedef NS_ENUM(NSInteger, GradeType) {
    GradeTypeGe = 0,
    GradeTypeWan,
    GradeTypeYi
};//枚举：数字级别：整数部分的分级(个级，万级，亿级)
@implementation NumberToCapital
-(NSString *)getUperDigit:(NSString *)inputStr
{
    NSRange range = [inputStr rangeOfString:@"."];
    if (range.length != 0) {
        NSArray *tmpArray = [inputStr componentsSeparatedByString:@"."];
        int zhengShu = [[tmpArray objectAtIndex:0]intValue];
        NSString* xiaoShu = [tmpArray lastObject];
        NSString *zhengShuStr = [self getIntPartUper:zhengShu];
        if ([zhengShuStr isEqualToString:@"元"]) {   //整数部分为零，小数部分不为零的情况
            return [NSString stringWithFormat:@"%@",[self getPartAfterDot:xiaoShu]];
        }
        return [NSString stringWithFormat:@"%@%@",[self getIntPartUper:zhengShu],[self getPartAfterDot:xiaoShu]];
    }else
    {
        int zhengShu = [inputStr intValue];
        NSString *tmpStr = [self getIntPartUper:zhengShu];
        if ([tmpStr isEqualToString:@"元"]) {
            return [NSString stringWithFormat:@"零元整"];
        }
        else
        {
            return [NSString stringWithFormat:@"%@整",[self getIntPartUper:zhengShu]];
        }
        
    }
}
//得到整数部分
-(NSString *)getIntPartUper:(int)digit
{
    int geGrade = digit%10000;
    int wanGrade = digit/10000%10000;
    int yiGrade = digit/100000000;
    NSString *geGradeStr = [self dealWithDigit:geGrade grade:GradeTypeGe];
    NSString *wanGradeStr = [self dealWithDigit:wanGrade grade:GradeTypeWan];
    NSString *yiGradeStr = [self dealWithDigit:yiGrade grade:GradeTypeYi];
    NSMutableString *tmpStr = [NSMutableString stringWithFormat:@"%@%@%@元",yiGradeStr,wanGradeStr,geGradeStr];
    if ([[tmpStr substringToIndex:1]isEqualToString:@"零"]) {
        NSString *str1 = [tmpStr substringFromIndex:1];
        if ([[str1 substringToIndex:2]isEqualToString:@"壹拾"]) {
            return [str1 substringFromIndex:1];
        }
        else
        {
            return str1;
        }
    }
    else
    {
        return tmpStr;
    }
}

//整数部分的分级(个级，万级，亿级)处理方法
-(NSString *)dealWithDigit:(int)digit grade:(GradeType)grade
{
    if (digit > 0) {
        NSArray *uperArray = @[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
        NSArray *uperUnitArray = @[@"",@"拾",@"佰",@"仟"];
        
        NSString *ge = [NSString stringWithFormat:@"%d",digit%10];
        NSString *shi = [NSString stringWithFormat:@"%d",digit%100/10];
        NSString *bai = [NSString stringWithFormat:@"%d",digit%1000/100];
        NSString *qian = [NSString stringWithFormat:@"%d",digit/1000];
        NSArray *tmpArray = @[ge,shi,bai,qian];
        NSMutableArray *saveStrArray = [NSMutableArray array];
        BOOL lastIsZero = YES;
        for (int i = 0; i<tmpArray.count; i++) {
            int tmp = [[tmpArray objectAtIndex:i]intValue];
            if (tmp == 0) {
                if (lastIsZero == NO) {
                    [saveStrArray addObject:@"零"];
                    lastIsZero = YES;
                }
            }
            else
            {
                [saveStrArray addObject:[NSString stringWithFormat:@"%@%@",[uperArray objectAtIndex:tmp],[uperUnitArray objectAtIndex:i]]];
                lastIsZero = NO;
            }
        }
        NSMutableString *destStr = [[NSMutableString alloc]init];
        for (int i=saveStrArray.count - 1; i >= 0; i --) {
            [destStr appendString:[saveStrArray objectAtIndex:i]];
        }
        if (grade == GradeTypeGe)
        {
            return destStr;//个级
        }else if(grade == GradeTypeWan)
        {
            return [NSString stringWithFormat:@"%@万",destStr];//万级
        }
        else
        {
            return [NSString stringWithFormat:@"%@亿",destStr];//亿级
        }
    }
    else
    {
        return @"";//这个级别的数字都是“零”
    }
}
//小数点后的处理方法（这个方法可以优化，不过匆忙做项目，没来得及优化，呵呵）
-(NSString *)getPartAfterDot:(NSString *)digitStr
{
    if (digitStr.length > 0) {
        NSArray *uperArray = @[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
        NSString *digitStr1 = nil;
        if (digitStr.length == 1) {
            digitStr1 = [NSString stringWithFormat:@"%@0",digitStr];
            int digit = [[digitStr1 substringToIndex:2]intValue];
            int one = digit/10;
            int two = digit%10;
            if (one != 0 && two != 0) {
                return [NSString stringWithFormat:@"%@角%@分",[uperArray objectAtIndex:one],[uperArray objectAtIndex:two]];
            }
            else if(one == 0 && two != 0) {
                return [NSString stringWithFormat:@"%@分",[uperArray objectAtIndex:two]];
            }if(one != 0 && two == 0) {
                return [NSString stringWithFormat:@"%@角",[uperArray objectAtIndex:one]];
            }
            else
            {
                return @"";
            }
        }
        else
        {
            int digit = [[digitStr substringToIndex:2]intValue];
            int one = digit/10;
            int two = digit%10;
            if (one != 0 && two != 0) {
                return [NSString stringWithFormat:@"%@角%@分",[uperArray objectAtIndex:one],[uperArray objectAtIndex:two]];
            }
            else if(one == 0 && two != 0) {
                return [NSString stringWithFormat:@"%@分",[uperArray objectAtIndex:two]];
            }if(one != 0 && two == 0) {
                return [NSString stringWithFormat:@"%@角",[uperArray objectAtIndex:one]];
            }
            else
            {
                return @"";
            }
        }
    }
    else{
        return @"";
    }
}
        
@end
