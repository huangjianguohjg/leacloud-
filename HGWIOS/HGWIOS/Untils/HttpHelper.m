//
//  HttpHelper.m
//  haoyunhl
//
//  Created by lianghy on 16/1/12.
//  Copyright © 2016年 ZYProSoft. All rights reserved.
//

#import "HttpHelper.h"
#import <AFURLSessionManager.h>

@implementation HttpHelper


//post异步请求封装函数
+ (void)post:(NSString *)URL RequestMethod:(NSString *)method RequestParams:(NSArray *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
    //把传进来的URL字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:URL];
   
//    NSLog(URL);
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            
        }
    }
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseParams:method RequestParams:params];
//    NSLog(parseParamsResult);
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    [request setHTTPBody:postData];
    
//    //创建一个新的队列（开启新线程）
//    NSOperationQueue *queue = [NSOperationQueue new];
//    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:queue
//                           completionHandler:block];

    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // 加上这行代码，https ssl 验证。
     if ([[URL substringToIndex:5] rangeOfString:@"https"].location != NSNotFound) {
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:block];
    
    [dataTask resume];
    
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSString *)method RequestParams:(NSArray *)params {
    
    NSString *requestparameter = @"";
    requestparameter=[requestparameter stringByAppendingString:@"{\"method\":\""];
    requestparameter= [requestparameter stringByAppendingString:method];
    requestparameter= [requestparameter stringByAppendingString:@"\""];
    
    if (params != NULL && params.count > 0) {
        
        requestparameter= [requestparameter stringByAppendingString:@",\"params\":{"];
        for (NSString *item in params) {
            NSArray *strarray = [item componentsSeparatedByString:@":"];
            NSMutableArray *strarrayT = [[NSMutableArray alloc]initWithCapacity:2];
            strarrayT[0] = strarray[0];
            if (strarray.count > 2) {
                NSString *combineString = @"";
                for (int i = 1; i<(strarray.count-1); i++) {
                    combineString = [combineString stringByAppendingString:[strarray[i] stringByAppendingString:@":"]];
                }
                strarrayT[1] = [combineString stringByAppendingString:strarray[strarray.count-1]];
            }else{
             strarrayT[1] = strarray[1];
            }
            
            requestparameter=[requestparameter stringByAppendingString:@"\""];
            
            requestparameter= [requestparameter stringByAppendingString:strarrayT[0]];
            
            requestparameter= [requestparameter stringByAppendingString:@"\":\""];
            
            requestparameter= [requestparameter stringByAppendingString:strarrayT[1]];
            
            requestparameter= [requestparameter stringByAppendingString:@"\","];
        }
        
        long thislength =[requestparameter length];
        requestparameter = [requestparameter substringToIndex:(thislength-1)];
        requestparameter=[requestparameter stringByAppendingString:@"}"];
    } else {
        requestparameter=[requestparameter stringByAppendingString:@",\"params\":{}"];
    }
    requestparameter= [requestparameter stringByAppendingString:@",\"id\":\""];
    NSString * timestamp = [[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] substringToIndex:8];
    requestparameter= [requestparameter stringByAppendingString:timestamp];
    requestparameter= [requestparameter stringByAppendingString:@"\""];
    requestparameter= [requestparameter stringByAppendingString:@"}"];
    return  requestparameter;
}

+ (void)post:(NSString *)URL RequestMethod:(NSString *)method RequestStringParams:(NSString *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{

    //把传进来的URL字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:URL];
    
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            
        }
    }
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseStringParams:method RequestStringParams:params];
//    NSLog([NSString stringWithFormat: @"请求地址：%@",URL],nil);
//    NSLog([NSString stringWithFormat: @"请求数据：%@",parseParamsResult],nil);
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    [request setHTTPBody:postData];
    
//    //创建一个新的队列（开启新线程）
//    NSOperationQueue *queue = [NSOperationQueue new];
//
//    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:queue
//                           completionHandler:block];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // 加上这行代码，https ssl 验证。
     if ([[URL substringToIndex:5] rangeOfString:@"https"].location != NSNotFound) {
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:block];
    
    [dataTask resume];
    
    
}

+ (void)post:(NSString *)URL RequestMethod:(NSString *)method RequestStringParams:(NSString *)params OriginalFinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
    //把传进来的URL字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:URL];
    
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            
        }
    }
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseStringParams:method RequestStringParams:params];
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    [request setHTTPBody:postData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // 加上这行代码，https ssl 验证。
    if ([[URL substringToIndex:5] rangeOfString:@"https"].location != NSNotFound) {
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:block];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    [dataTask resume];
}



+ (void)post:(NSString *)URL RequestMethod:(NSString *)method RequestDictionaryParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
    //把传进来的URL字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:URL];
    
//    NSLog(URL);
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            
        }
    }
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseDictionaryParams:method RequestParams:params];
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    [request setHTTPBody:postData];
    
//    //创建一个新的队列（开启新线程）
//    NSOperationQueue *queue = [NSOperationQueue new];
//    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:queue
//                           completionHandler:block];
   
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // 加上这行代码，https ssl 验证。
     if ([[URL substringToIndex:5] rangeOfString:@"https"].location != NSNotFound) {
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:block];
    
    [dataTask resume];
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseDictionaryParams:(NSString *)method RequestParams:(NSDictionary *)params {
    
    NSString *requestparameter = @"";
    requestparameter=[requestparameter stringByAppendingString:@"{\"method\":\""];
    requestparameter= [requestparameter stringByAppendingString:method];
    requestparameter= [requestparameter stringByAppendingString:@"\""];
    
    if (params != NULL && params.count > 0) {
        
        requestparameter= [requestparameter stringByAppendingString:@",\"params\":{"];
        NSArray *keys = [params allKeys];
        for (NSString *keyitem in keys) {
            requestparameter=[requestparameter stringByAppendingString:@"\""];
            
            requestparameter= [requestparameter stringByAppendingString:keyitem];
            
            requestparameter= [requestparameter stringByAppendingString:@"\":\""];
            
            requestparameter= [requestparameter stringByAppendingString:[params objectForKey:keyitem]];
            
            requestparameter= [requestparameter stringByAppendingString:@"\","];
        }
        
        long thislength =[requestparameter length];
        requestparameter = [requestparameter substringToIndex:(thislength-1)];
        requestparameter=[requestparameter stringByAppendingString:@"}"];
    } else {
        requestparameter=[requestparameter stringByAppendingString:@",\"params\":{}"];
    }
    requestparameter= [requestparameter stringByAppendingString:@",\"id\":\""];
    NSString * timestamp = [[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] substringToIndex:8];
    requestparameter= [requestparameter stringByAppendingString:timestamp];
    requestparameter= [requestparameter stringByAppendingString:@"\""];
    requestparameter= [requestparameter stringByAppendingString:@"}"];
//    NSLog(requestparameter,nil);
    return  requestparameter;
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

//图片请求
+ (void)post:(NSString *)URL RequestMethod:(NSString *)method RequestParams:(NSDictionary *)params FileStream:(NSData *)file FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
     if ([[URL substringToIndex:5] rangeOfString:@"https"].location != NSNotFound) {
        URL = [URL stringByReplacingOccurrencesOfString:@"https" withString:@"http" ];
    }
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    NSString *urlthe =[NSString stringWithFormat:@"%@/%@",URL,method];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlthe]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
//    UIImage *image=[params objectForKey:@"pic"];
//    //得到图片的data
//    NSData* data = UIImagePNGRepresentation(image);
    NSData* data  =file;
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        if(![key isEqualToString:@"pic"])
        {
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            //添加字段的值
            [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        }
    }
    
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"uploadfile\"; filename=\"test.jpg\"\r\n"];
    //声明上传文件的格式
//    [body appendFormat:@"Content-Type: application/octet-stream; charset=UTF-8\r\n\r\n"];
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    //去掉cookie
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:urlthe]];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            
        }
    //建立连接，设置代理
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    //设置接受response的data
//    if (conn) {
//        _mResponseData = [[NSMutableData alloc] init];
//    }
//    
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:block];
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    // 加上这行代码，https ssl 验证。
//    [manager setSecurityPolicy:[self customSecurityPolicy]];
//    
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:block];
//    
//    [dataTask resume];
    
    
    
//    NSHTTPURLResponse *urlResponese = nil;
//    NSError *error = [[NSError alloc]init];
//    NSData* resultData = [NSURLConnection sendSynchronousRequest:request   returningResponse:&urlResponese error:&error];
//    NSString* result= [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
//    if([urlResponese statusCode] >=200&&[urlResponese statusCode]<300){
//        NSLog(@"返回结果=====%@",result);
//    }else{
//        NSLog(@"没有返回数据");
//    }
}



#pragma mark -Https请求
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    static CFArrayRef certs;
    if (!certs) {
//        NSString *testpad =  [[NSBundle mainBundle] pathForResource:@"911d74d7895a1aff" ofType:@"crt"];
        NSString *thePath = [[NSBundle mainBundle] pathForResource:@"1234567890.cer" ofType:nil];
        NSData *certData = [[NSData alloc] initWithContentsOfFile:thePath];
        
        //        NSData*certData =[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"123" ofType:@"cer"]];
        SecCertificateRef rootcert =SecCertificateCreateWithData(kCFAllocatorDefault,CFBridgingRetain(certData));
        const void *array[1] = { rootcert };
        certs = CFArrayCreate(NULL, array, 1, &kCFTypeArrayCallBacks);
        CFRelease(rootcert);    // for completeness, really does not matter
    }
    
    SecTrustRef trust = [[challenge protectionSpace] serverTrust];
    int err;
    SecTrustResultType trustResult = 0;
    err = SecTrustSetAnchorCertificates(trust, certs);
    if (err == noErr) {
        err = SecTrustEvaluate(trust,&trustResult);
    }
    CFRelease(trust);
    BOOL trusted = (err == noErr) && ((trustResult == kSecTrustResultProceed)||(trustResult == kSecTrustResultConfirm) || (trustResult == kSecTrustResultUnspecified));
    
    if (trusted) {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }else{
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"1234567890" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}

@end
