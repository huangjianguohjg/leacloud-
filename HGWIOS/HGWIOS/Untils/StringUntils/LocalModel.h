//
//  LocalModel.h
//  haoyunhl
//
//  Created by lianghy on 16/1/15.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalModel : UIView
+(NSString *)ID;
+(NSString *)MOBILE;
+(NSString *)ACCESSTOKEN;
+(NSString *)EXPIRESIN;
+(NSString *)REFRESHTOKEN;
+(NSString *)CREATEDATE;
+(NSString *)LOGINIDS;
+(NSString *)USERNAME;
+(NSString *)PASSWORD;
+(NSString *)BUSINESSTYPE;
+(NSString *)BUSINESSTYPENAME;

//验证码以及过期时间
+(NSString *)VALIDATECODE;
+(NSString *)VALIDATECODETime;
+(NSString *)MONITORLIST;
+(NSString *)SELECTEDITEM;
+(NSString *)UPPayResult;//银联支付结果

+(NSString *)NOWPAGE;//现在处于页书

+(NSString *)ISFIRST;//是否第一次加载

+(NSString *)DEVICETOKEN;//是否第一次加载
@end
