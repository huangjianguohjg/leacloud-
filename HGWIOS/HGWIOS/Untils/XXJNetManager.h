//
//  XXJNetManager.h
//  HGWIOS
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <BANetManager/BANetManager.h>

@interface XXJNetManager : BANetManager

////定义 HTTP 请求枚举类型
//typedef enum : NSUInteger{
//    GET=0,
//    POST=1,
//    PUT,
//    DELETE
//}XXJNetworkToolsType;


//大兄弟，是这个这个这个这个这个这个这个这个这个这个这个这个
+ (void)requestPOSTURLString:(NSString *)URLString URLMethod:(NSString *)URLMethod parameters:(id)parameters finished:(void(^)(id result))finished errored:(void(^)(NSError * error))errored;


@end
