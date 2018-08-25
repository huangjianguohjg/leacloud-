//
//  MyBoatModel.m
//  HGWIOS
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyBoatModel.h"

@implementation ShippingModel



@end

@implementation MyBoatModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return  @{
              @"ship_id" : @"id"
              };
}

@end
