//
//  DynamicBoatSearchModel.m
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "DynamicBoatSearchModel.h"

@implementation DynamicBoatSearchModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"locationID" : @"id"
             };
}

@end
