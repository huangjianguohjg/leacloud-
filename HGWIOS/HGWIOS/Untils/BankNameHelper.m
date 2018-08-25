//
//  BankNameHelper.m
//  haoyunhl
//
//  Created by lianghy on 16/6/25.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "BankNameHelper.h"
@implementation BankNameHelper

+(NSString *)getName:(NSString *)ab{
    NSMutableDictionary *allDictionary =  [self getAll];
    return [allDictionary valueForKey:ab];
}
+(NSString *)getImageUrl:(NSString *)ab{
    return [NSString stringWithFormat:@"%@", ab];
}

+(NSMutableDictionary *)getAll{
    NSMutableDictionary *allDictionary = [[NSMutableDictionary alloc]init];
    [allDictionary setObject:@"中国工商银行" forKey:@"ICBC"];//
    [allDictionary setObject:@"中国农业银行" forKey:@"ABC"];//
    [allDictionary setObject:@"中国银行" forKey:@"BOC"];//
    [allDictionary setObject:@"中国建设银行" forKey:@"CCB"];//
    [allDictionary setObject:@"交通银行" forKey:@"BCOM"];//
    [allDictionary setObject:@"中国邮政储蓄银行" forKey:@"PSBC"];//
//    [allDictionary setObject:@"中信银行" forKey:@"CITIC"];
    [allDictionary setObject:@"中国光大银行" forKey:@"CEB"];//
//    [allDictionary setObject:@"华夏银行" forKey:@"HXB"];
    [allDictionary setObject:@"中国民生银行" forKey:@"CMBC"];//
//    [allDictionary setObject:@"广发银行" forKey:@"GDB"];
    [allDictionary setObject:@"招商银行" forKey:@"CMB"];//
    [allDictionary setObject:@"兴业银行" forKey:@"CIB"];//
    [allDictionary setObject:@"浦发银行" forKey:@"SPDB"];//
//    [allDictionary setObject:@"平安银行" forKey:@"PAB"];
//    [allDictionary setObject:@"恒丰银行" forKey:@"HFB"];
//    [allDictionary setObject:@"渤海银行" forKey:@"CBHB"];
    [allDictionary setObject:@"浙商银行" forKey:@"CZB"];//
    [allDictionary setObject:@"北京银行" forKey:@"BOB"];//
    [allDictionary setObject:@"上海银行" forKey:@"BOS"];//
    return allDictionary;
}
@end
