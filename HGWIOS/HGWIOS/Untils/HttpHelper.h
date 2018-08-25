//
//  HttpHelper.h
//  haoyunhl
//
//  Created by lianghy on 16/1/12.
//  Copyright © 2016年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HttpHelper : NSObject<NSURLConnectionDelegate>

+ (void)post:(NSString *)Url RequestMethod:(NSString *)method  RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;//post请求封装
+ (void)post:(NSString *)URL RequestMethod:(NSString *)method RequestDictionaryParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;
//图片请求
+ (void)post:(NSString *)URL RequestMethod:(NSString *)method RequestParams:(NSDictionary *)params FileStream:(NSData *)file FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;
//参数为字符串
+ (void)post:(NSString *)URL RequestMethod:(NSString *)method RequestStringParams:(NSString *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;

//参数为字符串 返回为所得值
+ (void)post:(NSString *)URL RequestMethod:(NSString *)method RequestStringParams:(NSString *)params OriginalFinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;
@end
