//
//  HomeBoatModel.h
//  HGWIOS
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserBoat,Ship;

@interface UserBoat : NSObject
/**
 姓
 */
@property (nonatomic, copy) NSString * surname;
/**
 电话
 */
@property (nonatomic, copy) NSString * mobile;
/**
 信用分
 */
@property (nonatomic, copy) NSString * total_comment_sroce;


@end



@interface Ship : NSObject
/**
 重量
 */
@property (nonatomic, copy) NSString * deadweight;
/**
 电话
 */
@property (nonatomic, copy) NSString * mobile;
/**
 船舶级别
 */
@property (nonatomic, copy) NSString * type_name;

/**
 船舶属性
 */
@property (nonatomic, copy) NSString * ship_prop_show;

/**
 建造年份 时间戳
 */
@property (nonatomic, copy) NSString * complete_time;

/**
 公司
 */
@property (nonatomic, copy) NSString * enterprise;

@end




@interface HomeBoatModel : NSObject

/**
 意向重量
 */
@property (nonatomic, copy) NSString * cargo_ton;
@property (nonatomic, copy) NSString * cargo_ton_num;

/**
 空载港
 */
@property (nonatomic, copy) NSString * f_port;
@property (nonatomic, copy) NSString * f_port_id;

/**
 船名
 */
@property (nonatomic, copy) NSString * name;

/**
 姓名
 */
@property (nonatomic, copy) NSString * username;

/**
 倒计时时间
 */
@property (nonatomic, copy) NSString * valid_data;


/**
 港口
 */
@property (nonatomic, copy) NSString * n_port;
@property (nonatomic, copy) NSString * n_port_id;
/**
 出发时间,时间戳
 */
@property (nonatomic, copy) NSString * n_time;

/**
 截止时间，时间戳
 */
@property (nonatomic, copy) NSString * e_n_time;


/**
 船盘详情 id
 */
@property (nonatomic, copy) NSString * shipping_id;


/**
 船主信息
 */
@property (nonatomic, strong) UserBoat * user;


/**
 船舶信息
 */
@property (nonatomic, strong) Ship * ship;

/**
 周边
 */
@property (nonatomic, copy) NSString * around;

/*******************船盘详情补充**********************/


/**
 信用分
 */
@property (nonatomic, copy) NSString * score;



/**
 报空次
 */
@property (nonatomic, copy) NSString * vacant;

/**
 洽谈次
 */
@property (nonatomic, copy) NSString * negotia;


/**
 前载货物
 */
@property (nonatomic, copy) NSString * before_cargo;
@property (nonatomic, copy) NSString * before_cargo_id;
/**
 意向货量
 */
//@property (nonatomic, copy) NSString * cargo_ton;


/**
 重量
 */
@property (nonatomic, copy) NSString * deadweight;

/**
 备注信息
 */
@property (nonatomic, copy) NSString * remark;


/**
 船的id
 */
@property (nonatomic, copy) NSString * ship_id;

/**
 船舶舱容
 */
@property (nonatomic, copy) NSString * storage;


@end
