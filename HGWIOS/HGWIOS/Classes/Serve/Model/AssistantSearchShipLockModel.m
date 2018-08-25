//
//  AssistantSearchShipLockModel.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AssistantSearchShipLockModel.h"

@implementation AssistantSearchShipLockModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"lockID" : @"id"
             };
}

@end
