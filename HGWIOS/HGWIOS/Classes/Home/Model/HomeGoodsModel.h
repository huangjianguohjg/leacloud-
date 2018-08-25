//
//  HomeGoodsModel.h
//  HGWIOS
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface User : NSObject
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

@interface HomeGoodsModel : NSObject

/**
 姓名
 */
@property (nonatomic, copy) NSString * username;

/**
 用户信息
 */
@property (nonatomic, strong) User * user;

/**
 倒计时时间
 */
@property (nonatomic, copy) NSString * valid_data;

@property (nonatomic, copy) NSString * open_time;

/**
 出发地
 */
@property (nonatomic, copy) NSString * b_port;
@property (nonatomic, copy) NSString * b_port_address;
@property (nonatomic, copy) NSString * b_time;
/**
 出发时间,时间戳
 */
@property (nonatomic, copy) NSString * c_time;

/**
 目的地
 */
@property (nonatomic, copy) NSString * e_port;
@property (nonatomic, copy) NSString * e_port_address;
@property (nonatomic, copy) NSString * e_time;
/**
 目的时间，时间戳
 */
@property (nonatomic, copy) NSString * valid_time;

/**
 材料
 */
@property (nonatomic, copy) NSString * cargo_type;
@property (nonatomic, copy) NSString * cargo_type_name;

/**
 重量 吨
 */
@property (nonatomic, copy) NSString * weight;

/**
 重量 偏差
 */
@property (nonatomic, copy) NSString * weight_num;


/**
 货盘详情 id
 */
@property (nonatomic, copy) NSString * cargo_id;

/**
 周边
 */
@property (nonatomic, copy) NSString * around;

/***********************货盘详情用************************/

/**
 姓
 */
@property (nonatomic, copy) NSString * surname;

/**
 信用分
 */
@property (nonatomic, copy) NSString * score;

/**
 公司
 */
@property (nonatomic, copy) NSString * enterprise;

/**
 电话
 */
@property (nonatomic, copy) NSString * mobile;


/**
 询价类型
 */
@property (nonatomic, copy) NSString * cons_type;

/**
 合理损耗
 */
@property (nonatomic, copy) NSString * loss;

/**
 装卸期限
 */
@property (nonatomic, copy) NSString * dock_day;

/**
 滞留费用
 */
@property (nonatomic, copy) NSString * demurrage;

/**
 履约保证金
 */
@property (nonatomic, copy) NSString * bond;


/**
 结算方式
 */
@property (nonatomic, copy) NSString * pay_type;

/**
 付款方式
 */
@property (nonatomic, copy) NSString * freight;

/**
 付款方式名称
 */
@property (nonatomic, copy) NSString * freight_show;

/**
 包含费用
 */
@property (nonatomic, copy) NSString * contain_price;


/**
 参考报价
 */
@property (nonatomic, copy) NSString * a_cargo_price;

/**
 备注
 */
@property (nonatomic, copy) NSString * remark;


/**
 是否显示 1显示 0不显示
 */
@property (nonatomic, copy) NSString * show;


/**
 
 */
@property (nonatomic, copy) NSString * freight_name;


/**
 起运港 交接方式
 */
@property (nonatomic, copy) NSString * b_hand_type;

/**
 目的港 交接方式
 */
@property (nonatomic, copy) NSString * e_hand_type;

/**
 滞期费用  单位
 */
@property (nonatomic, copy) NSString * demurrage_unit;


/**
 累计发货次
 */
@property (nonatomic, copy) NSString * deliver_count;

/**
 本单洽谈次
 */
@property (nonatomic, copy) NSString * negotia;


@end
