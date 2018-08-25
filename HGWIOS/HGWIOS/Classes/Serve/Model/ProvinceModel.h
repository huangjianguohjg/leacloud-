//
//  ProvinceModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *area_name;
@property (nonatomic,strong)NSString *parent_id;
@property (nonatomic,strong)NSString *zipcode;
@end
