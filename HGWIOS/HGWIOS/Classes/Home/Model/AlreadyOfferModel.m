//
//  AlreadyOfferModel.m
//  HGWIOS
//
//  Created by mac on 2018/5/28.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AlreadyOfferModel.h"

@implementation CargoModel


@end

@implementation AlreadyOfferModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return  @{
              @"qp_id" : @"id"
              };
}

@end
