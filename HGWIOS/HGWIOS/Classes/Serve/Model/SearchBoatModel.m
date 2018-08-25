//
//  SearchBoatModel.m
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "SearchBoatModel.h"

@implementation SearchBoatModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"searchID" : @"id"
             };
}

@end
