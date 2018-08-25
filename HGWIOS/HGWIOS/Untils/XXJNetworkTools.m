//
//  XXJNetworkTools.m
//  ocAFN封装
//
//  Created by 许小军 on 2017/1/5.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "XXJNetworkTools.h"

@implementation XXJNetworkTools
+(instancetype)shareTools
{
    static XXJNetworkTools * instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XXJNetworkTools alloc]init];
        
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",@"application/x-www-form-urlencoded; charset=utf-8", nil];
        //更改解析方式
        instance.responseSerializer = [AFJSONResponseSerializer serializer];
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        
        
        //设置对证书的处理方式
        instance.securityPolicy.allowInvalidCertificates = YES;
        instance.securityPolicy.validatesDomainName = NO;
        
        
    });
    
    return instance;

}


//简历网络请求方法
-(void)request:(XXJNetworkToolsType)method URLString:(NSString *)URLString parameters:(id)parameters finished:(void(^)(id result,NSError * error))finished
{


    if (method ==GET)
    {
        [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            finished(nil,error);
        }];

    }
    else if(method == POST)
    {
        [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil,error);
        }];
    }
    else if (method == PUT)
    {
        [self PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil,error);
        }];
    }
    else if (method == DELETE)
    {
        [self DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil,error);
        }];
    }


}






////大兄弟，是这个这个这个这个这个这个这个这个这个这个这个这个
- (void)request:(XXJNetworkToolsType)method URLString:(NSString *)URLString URLMethod:(NSString *)URLMethod parameters:(id)parameters finished:(void(^)(id result,NSError * error))finished
{


    NSString * str = [parameters mj_JSONString];
    
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseStringParams:URLMethod RequestStringParams:str];
    
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString * typeStr = nil;
    if (method == POST) {
        typeStr = @"POST";
    }
    else if (method == GET)
    {
        typeStr = @"GET";
    }
    else if (method == PUT)
    {
        typeStr = @"PUT";
    }
    else if (method == DELETE)
    {
        typeStr = @"DELETE";
    }
    
    [request setHTTPMethod:typeStr];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:postData];
    
    
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            finished(nil,error);
        }
        else
        {
//            NSArray * ss = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            finished(responseObject,nil);
        }
        
    }];
    
    
    [dataTask resume];
    
}


//拼接请求body
- (NSString *)parseStringParams:(NSString *)method RequestStringParams:(NSString *)params {
    
    NSString *requestparameter = @"";
    requestparameter=[requestparameter stringByAppendingString:@"{\"method\":\""];
    requestparameter= [requestparameter stringByAppendingString:method];
    requestparameter= [requestparameter stringByAppendingString:@"\""];
    
    
    requestparameter= [requestparameter stringByAppendingString:@",\"params\":"];
    if (params != nil) {
        
        requestparameter= [requestparameter stringByAppendingString:params];
    }
    
    requestparameter=[requestparameter stringByAppendingString:@""];
    
    requestparameter= [requestparameter stringByAppendingString:@",\"id\":\""];
    NSString * timestamp = [[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] substringToIndex:8];
    requestparameter= [requestparameter stringByAppendingString:timestamp];
    requestparameter= [requestparameter stringByAppendingString:@"\""];
    requestparameter= [requestparameter stringByAppendingString:@"}"];
    //    NSLog(requestparameter,nil);
    return  requestparameter;
}











//取消请求
-(void)cancelRequest
{
    [self.tasks makeObjectsPerformSelector:@selector(cancel)];
}








@end
