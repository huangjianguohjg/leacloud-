//
//  HomeBoatModel.m
//  HGWIOS
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "HomeBoatModel.h"

@implementation UserBoat

@end

@implementation Ship

@end

@implementation HomeBoatModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return  @{
              @"shipping_id" : @"id"
              };
}

@end
