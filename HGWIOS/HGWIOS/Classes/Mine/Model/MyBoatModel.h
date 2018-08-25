//
//  MyBoatModel.h
//  HGWIOS
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShippingModel;

@interface ShippingModel : NSObject

/**
 报空状态
 */
@property (nonatomic, copy) NSString * shipping_status_name;

@property (nonatomic, copy) NSString * f_port;

@property (nonatomic, copy) NSString * c_time;

@property (nonatomic, copy) NSString * valid_time;

@property (nonatomic, copy) NSString * remark;

@property (nonatomic, copy) NSString * cargo_ton;

@property (nonatomic, copy) NSString * cargo_ton_num;

@property (nonatomic, copy) NSString * f_port_id;

@property (nonatomic, copy) NSString * id;

@end


@interface MyBoatModel : NSObject

/**
 船名
 */
@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * mmsi;

/**
 参考重量
 */
@property (nonatomic, copy) NSString * deadweight;

/**
 是否禁用
 */
@property (nonatomic, copy) NSString * status;

/**
 是否认证
 */
@property (nonatomic, copy) NSString * review_status_name;

/**
 船舶类型
 */
@property (nonatomic, copy) NSString * type_name;
@property (nonatomic, copy) NSString * type_id;

/**
 船舶检查类型
 */
@property (nonatomic, copy) NSString * inspect_type;

/**
 是否是管理员
 */
@property (nonatomic, copy) NSString * is_admin;

/**
 船长
 */
@property (nonatomic, copy) NSString * length;


/**
 船宽
 */
@property (nonatomic, copy) NSString * width;

/**
 满载吃水深度
 */
@property (nonatomic, copy) NSString * draught;


/**
 当前业务员
 */

@property (nonatomic, copy) NSString * contact_person;

/**
 当前业务员电话
 */
@property (nonatomic, copy) NSString * contact_phone;


/**
 船舶航区
 */
@property (nonatomic, copy) NSString * sailing_area;


/**
 建成日期
 */
@property (nonatomic, copy) NSString * complete_time;


/**
 船舶id
 */
@property (nonatomic, copy) NSString * ship_id;


/**
 shipping
 */
@property (nonatomic, strong) ShippingModel * shipping;

/**
  船舶舱容
 */
@property (nonatomic, copy) NSString * storage;

@end
