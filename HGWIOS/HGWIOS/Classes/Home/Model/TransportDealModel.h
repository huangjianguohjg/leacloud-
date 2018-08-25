//
//  TransportDealModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransportDealModel : NSObject

/**
 流水id
 */
@property (nonatomic, copy) NSString * flow_id;

@property (nonatomic, copy) NSString * red_uid;

@property (nonatomic, copy) NSString * red_time;

@property (nonatomic, copy) NSString * event;

@property (nonatomic, copy) NSString * event_no;

@property (nonatomic, copy) NSString * red_uid_type;

@property (nonatomic, copy) NSString * username;

@property (nonatomic, copy) NSString * date;

@end
