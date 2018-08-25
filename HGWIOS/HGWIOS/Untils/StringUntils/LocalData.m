//
//  LocalData.m
//  haoyunhl
//
//  Created by lianghy on 16/1/15.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "LocalData.h"
#import "LocalModel.h"
#import "GJCFQuickCacheMacrocDefine.h"
#import "GJCFStringUitil.h"
@implementation LocalData

+(void)Save:(NSString *)key Value:(NSString *)value{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)Get:(NSString *)key{
    id  value =[[NSUserDefaults standardUserDefaults] valueForKey:key];
    if (value == NULL) {
        return @"";
    }else{
        int count = [value length];
        return [(NSString *)value substringToIndex:count];
    }
    
}
+(void)DeleteAll{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel ID]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel MOBILE]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel ACCESSTOKEN]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel EXPIRESIN]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel REFRESHTOKEN]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel CREATEDATE]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel LOGINIDS]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel USERNAME]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel PASSWORD]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel VALIDATECODE]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel VALIDATECODETime]];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[LocalModel MONITORLIST]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//获得loginId
+(long) GetMloginid:(NSString *)sn{
    long result = 0;
    NSString *value =(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:LocalModel.LOGINIDS];
    if (!GJCFUDFEmptyValue(value)) {
        if ([value containsString:sn]) {
            NSArray *valueArray = [value componentsSeparatedByString:@"&"];
            for (NSString *item in valueArray) {
                if ([item containsString:sn]) {
                    NSString *mloginid =  [item componentsSeparatedByString:@":"][1];
                    long mloginidlong =  (long)[mloginid longLongValue];
                    return mloginidlong;
                }
            }
        }
    }
    
    return result;
}

//保存loginid
+(void) SaveMloginId:(NSString *)sn loginId:(long) mloginId{
    NSString *value =(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:LocalModel.LOGINIDS];
    NSString *newValue = @"";
    if (!GJCFUDFEmptyValue(value)) {
        //先去掉原来的值
        if ([self GetMloginid:sn] != 0){
            int start =[value indexOfAccessibilityElement:sn];
            int length = [[value substringFromIndex:start] indexOfAccessibilityElement:@"&"];
            NSRange range = {start,length};
            newValue = [value substringWithRange:range];
        }else{
            newValue = value;
        }
    }
    newValue  = [NSString stringWithFormat:@"%@%@:%ld&",newValue,sn,mloginId];
    [[NSUserDefaults standardUserDefaults] setObject:newValue forKey:LocalModel.LOGINIDS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(int) GetNowPage{
    int result = 0;
    if (!GJCFUDFEmptyValue(LocalModel.NOWPAGE)) {
         NSString *value =(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:LocalModel.NOWPAGE];
        result = (int)[GJCFStringUitil stringToInt:value];
    }
    
    return result;
}
@end
