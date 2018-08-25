//
//  ServiceWaterDetailModel.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ServiceWaterDetailModel.h"

@implementation ServiceWaterDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"waterID" : @"id"
             };
}

@end
