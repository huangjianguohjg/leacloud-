//
//  AssistantSearchShipModel.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AssistantSearchShipModel.h"

@implementation AssistantSearchShipModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"searchID" : @"id"
             };
}

@end