//
//  XXJNetManager.m
//  HGWIOS
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "XXJNetManager.h"
#import <BADataEntity.h>

@implementation XXJNetManager

//+(instancetype)shareTools
//{
//    static XXJNetManager * instance;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
////        instance = [[XXJNetManager alloc]init];
//        
//        
//        
//    });
//    
//    return instance;
//    
//}


//大兄弟，是这个这个这个这个这个这个这个这个这个这个这个这个
+ (void)requestPOSTURLString:(NSString *)URLString URLMethod:(NSString *)URLMethod parameters:(id)parameters finished:(void(^)(id result))finished errored:(void(^)(NSError * error))errored
{
    // 自定义超时设置
    BANetManagerShare.timeoutInterval = 15;
    
    // 自定义添加请求头
    NSDictionary *headerDict = @{@"Accept":@"application/json", @"Content-Type":@"application/json"};
    BANetManagerShare.httpHeaderFieldDictionary = headerDict;
    

    NSString *parase = [self parseStringParams:URLMethod RequestStringParams:parameters];
    
    NSData *dat = [parase dataUsingEncoding:NSUTF8StringEncoding];
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = URLString;
    entity.needCache = NO;
    entity.parameters = dat;
    
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
//        NSLog(@"post 请求数据结果： *** %@", response);
//        self.uploadLabel.text = @"上传完成";
//        [sender setTitle:@"上传完成" forState:UIControlStateNormal];
        finished(response);
        
    } failureBlock:^(NSError *error) {
        errored(error);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        /*! 封装方法里已经回到主线程，所有这里不用再调主线程了 */
//        self.uploadLabel.text = [NSString stringWithFormat:@"上传进度：%.2lld%%",100 * bytesProgress/totalBytesProgress];
//        [sender setTitle:@"上传中..." forState:UIControlStateNormal];
    }];
}



+ (void)UploadImageURLString:(NSString *)URLString URLMethod:(NSString *)URLMethod parameters:(id)parameters images:(NSArray *)imageArray  finished:(void(^)(id result))finished errored:(void(^)(NSError * error))errored
{
    // 自定义超时设置
    BANetManagerShare.timeoutInterval = 15;
    
    // 自定义添加请求头
    NSDictionary *headerDict = @{@"Accept":@"application/json", @"Content-Type":@"application/json"};
    BANetManagerShare.httpHeaderFieldDictionary = headerDict;
    
    
    NSString *parase = [self parseStringParams:URLMethod RequestStringParams:parameters];
    
    NSData *dat = [parase dataUsingEncoding:NSUTF8StringEncoding];
    
    
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    
    imageEntity.parameters = dat;
    
    imageEntity.imageArray = imageArray;
    
    
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}






//拼接请求body
+ (NSString *)parseStringParams:(NSString *)method RequestStringParams:(NSString *)params {
    
    NSString *requestparameter = @"";
    requestparameter=[requestparameter stringByAppendingString:@"{\"method\":\""];
    requestparameter= [requestparameter stringByAppendingString:method];
    requestparameter= [requestparameter stringByAppendingString:@"\""];
    
    
    requestparameter= [requestparameter stringByAppendingString:@",\"params\":{"];
    if (params != nil) {
        
        requestparameter= [requestparameter stringByAppendingString:params];
    }
    
    requestparameter=[requestparameter stringByAppendingString:@"}"];
    
    requestparameter= [requestparameter stringByAppendingString:@",\"id\":\""];
    NSString * timestamp = [[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] substringToIndex:8];
    requestparameter= [requestparameter stringByAppendingString:timestamp];
    requestparameter= [requestparameter stringByAppendingString:@"\""];
    requestparameter= [requestparameter stringByAppendingString:@"}"];
    //    NSLog(requestparameter,nil);
    return  requestparameter;
}


+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}





@end
