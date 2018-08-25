//
//  LocalData.h
//  haoyunhl
//
//  Created by lianghy on 16/1/15.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalData : NSObject
+(void)Save:(NSString *)key Value:(NSString *)value;
+(NSString *)Get:(NSString *)key;
+(void)DeleteAll;
+(long) GetMloginid:(NSString *)shipId;
+(void) SaveMloginId:(NSString *)shipId loginId:(long) mloginId;
//获得当前页书 
+(int) GetNowPage;
@end
