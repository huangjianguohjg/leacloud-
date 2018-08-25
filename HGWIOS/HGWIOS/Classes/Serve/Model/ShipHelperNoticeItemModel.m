//
//  ShipHelperNoticeItemModel.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperNoticeItemModel.h"

@implementation ShipHelperNoticeItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"noticeID" : @"id"
             };
}

@end
