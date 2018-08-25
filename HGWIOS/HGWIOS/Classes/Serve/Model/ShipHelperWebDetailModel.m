//
//  ShipHelperWebDetailModel.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperWebDetailModel.h"

@implementation ShipHelperWebDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"webID" : @"id"
             };
}

@end
