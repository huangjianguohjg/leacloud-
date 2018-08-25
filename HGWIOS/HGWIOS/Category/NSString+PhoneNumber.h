//
//  NSString+PhoneNumber.h
//  lineroad
//
//  Created by gagakj on 2017/8/29.
//  Copyright © 2017年 田宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PhoneNumber)

//手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;//有问题
+ (BOOL)isValidatePhoneNum:(NSString *)PhoneNum;//...


//身份证号
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard;
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;


#pragma mark - 将某个时间戳转化成 时间
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp;

@end
