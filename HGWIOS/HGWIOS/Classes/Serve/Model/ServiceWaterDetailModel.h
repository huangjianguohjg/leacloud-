//
//  ServiceWaterDetailModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceWaterDetailModel : NSObject

@property (nonatomic,nonatomic)NSString * create_time;
@property (nonatomic,nonatomic)NSString * date;
@property (nonatomic,nonatomic)NSString * flow;
@property (nonatomic,nonatomic)NSString * flow_rise;
@property (nonatomic,nonatomic)NSString * waterID;
@property (nonatomic,nonatomic)NSString * level;
@property (nonatomic,nonatomic)NSString * level_down;
@property (nonatomic,nonatomic)NSString * level_down_rise;
@property (nonatomic,nonatomic)NSString * level_rise;
@property (nonatomic,nonatomic)NSString * level_up_rise;
@property (nonatomic,nonatomic)NSString * level_up;
@property (nonatomic,nonatomic)NSString * place;
@property (nonatomic,nonatomic)NSString * title;
@property (nonatomic,nonatomic)NSString * type;

@end
