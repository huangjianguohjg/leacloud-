//
//  DataHelper.m
//  haoyunhl
//
//  Created by lianghy on 16/9/2.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "DataHelper.h"
#import "GJCFStringUitil.h"
@implementation DataHelper
+(NSString *)stringToTwoDigitString:(NSString *)value{
    if ([GJCFStringUitil stringIsNull:value]) {
        return @"0.00";
    }else{
        float floatValue = [GJCFStringUitil stringToFloat:value];
        NSString *result =[NSString stringWithFormat:@"%@",@(floatValue)];
        
        return result;
    }
}
@end
