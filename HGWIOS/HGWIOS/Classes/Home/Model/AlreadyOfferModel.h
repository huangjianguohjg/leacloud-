//
//  AlreadyOfferModel.h
//  HGWIOS
//
//  Created by mac on 2018/5/28.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  CargoModel;

@interface CargoModel : NSObject
/**
 货盘编号
 */
@property (nonatomic, copy) NSString * no;

/**
 出发地
 */
@property (nonatomic, copy) NSString * b_port;

/**
 出发时间,时间戳
 */
@property (nonatomic, copy) NSString * c_time;

/**
 目的地
 */
@property (nonatomic, copy) NSString * e_port;

/**
 目的时间，时间戳
 */
@property (nonatomic, copy) NSString * valid_time;

/**
 材料
 */
@property (nonatomic, copy) NSString * cargo_type;

/**
 重量 吨
 */
@property (nonatomic, copy) NSString * weight;

/**
 重量 偏差
 */
@property (nonatomic, copy) NSString * weight_num;

@property (nonatomic, copy) NSString * freight_name;

@property (nonatomic, copy) NSString * contain_price;

@property (nonatomic, copy) NSString * deliver_count;

@property (nonatomic, copy) NSString * negotia;

@end


@interface AlreadyOfferModel : NSObject

@property (nonatomic, strong) CargoModel * cargo;

@property (nonatomic, copy) NSString * id;


@property (nonatomic, copy) NSString * open;

/**
 报价
 */
@property (nonatomic, copy) NSString * money;

/**
 报价状态
 */
@property (nonatomic, copy) NSString * type_name;

/**
 报价记录id
 */
@property (nonatomic, copy) NSString * qp_id;

/**
 状态
 */
@property (nonatomic, copy) NSString * status_name;

/**
 多少人报价
 */
@property (nonatomic, copy) NSString * count;

/**
 中标船舶
 */
@property (nonatomic, copy) NSString * ship_name;

/**
 中标价格
 */
@property (nonatomic, copy) NSString * money_show;




/**********************我的货盘中有的*******************************/

/**
 货盘编号
 */
@property (nonatomic, copy) NSString * no;

/**
 出发地
 */
@property (nonatomic, copy) NSString * b_port;
@property (nonatomic, copy) NSString * b_port_id;
@property (nonatomic, copy) NSString * parent_b;
@property (nonatomic, copy) NSString * parent_b_port_id;
@property (nonatomic, copy) NSString * b_port_address;

/**
 出发时间,时间戳
 */
@property (nonatomic, copy) NSString * c_time;

/**
 目的地
 */
@property (nonatomic, copy) NSString * e_port;
@property (nonatomic, copy) NSString * e_port_id;
@property (nonatomic, copy) NSString * parent_e;
@property (nonatomic, copy) NSString * parent_e_port_id;
@property (nonatomic, copy) NSString * e_port_address;

/**
 目的时间，时间戳
 */
@property (nonatomic, copy) NSString * valid_time;

/**
 材料
 */
@property (nonatomic, copy) NSString * cargo_type;
@property (nonatomic, copy) NSString * cargo_type_id;


/**
 重量 吨
 */
@property (nonatomic, copy) NSString * weight;

/**
 重量 偏差
 */
@property (nonatomic, copy) NSString * weight_num;

/**
 询价类型
 */
@property (nonatomic, copy) NSString * cons_type;

/**
 合理损耗
 */
@property (nonatomic, copy) NSString * loss;

/**
 付款方式
 */
@property (nonatomic, copy) NSString * freight;

/**
 付款方式名称
 */
@property (nonatomic, copy) NSString * freight_name;

/**
 滞期费用
 */
@property (nonatomic, copy) NSString * demurrage;
@property (nonatomic, copy) NSString * demurrage_unit;
/**
 履约保证金
 */
@property (nonatomic, copy) NSString * bond;

/**
 结算方式
 */
@property (nonatomic, copy) NSString * pay_type;

/**
 装卸时间
 */
@property (nonatomic, copy) NSString * dock_day;


/**
 包含费用
 */
@property (nonatomic, copy) NSString * contain_price;

/**
 参考费用
 */
@property (nonatomic, copy) NSString * a_cargo_price;


/**
 开标时间
 */
@property (nonatomic, copy) NSString * open_time;

/**
 备注
 */
@property (nonatomic, copy) NSString * remark;


/**
 累计发货次
 */
@property (nonatomic, copy) NSString * deliver_count;

/**
 本单洽谈次
 */
@property (nonatomic, copy) NSString * negotia;



/***************************我的运单补充********************************/
@property (nonatomic, copy) NSString * deal_status;
@property (nonatomic, copy) NSString * parent_b_port_name;
//@property (nonatomic, copy) NSString * b_port;
@property (nonatomic, copy) NSString * parent_e_port_name;
//@property (nonatomic, copy) NSString * e_port;
@property (nonatomic, copy) NSString * b_time;
@property (nonatomic, copy) NSString * e_time;
@property (nonatomic, copy) NSString * cargo_type_name;
@property (nonatomic, copy) NSString * deal_no;
@property (nonatomic, copy) NSString * cargo_id;

/**
 船东签订合同时间
 */
@property (nonatomic, copy) NSString * c_sign_time;
/**
 货主签订合同时间
 */
@property (nonatomic, copy) NSString * s_sign_time;
/**
 船东签订合同图片
 */
@property (nonatomic, copy) NSString * s_contract_file;
/**
 货主签订合同图片
 */
@property (nonatomic, copy) NSString * c_contract_file;
/**
 船东给的评价
 */
@property (nonatomic, copy) NSString * req_comment_time;
/**
 货主给的评价
 */
@property (nonatomic, copy) NSString * confirm_comment_time;
/**
 我已装货时间（上传发货单）
 */
@property (nonatomic, copy) NSString * loading_time;
/**
 我已卸货时间（上传收货单）
 */
@property (nonatomic, copy) NSString * unloading_time;
/**
 船东支付履约保证金时间
 */
@property (nonatomic, copy) NSString * s_payment_time;
@property (nonatomic, copy) NSString * s_payment_bond;//具体金额
/**
 货主支付履约保证金时间
 */
@property (nonatomic, copy) NSString * c_payment_time;
@property (nonatomic, copy) NSString * c_payment_bond;
/**
 支付预付运费时间
 */
@property (nonatomic, copy) NSString * payment_advance_time;
/**
 支付结算运费时间
 */
@property (nonatomic, copy) NSString * payment_settlement_time;

/**
 平台确认货主支付履约保证金时间
 */
@property (nonatomic, copy) NSString * p_c_payment_time;
/**
 平台确认船东支付履约保证金时间
 */
@property (nonatomic, copy) NSString * p_s_payment_time;

/**
货主实际支付履约保证金
 */
@property (nonatomic, copy) NSString * p_c_payment_money;
/**
 船东实际支付履约保证金金额
 */
@property (nonatomic, copy) NSString * p_s_payment_money;



@property (nonatomic, copy) NSString * b_hand_type;

@property (nonatomic, copy) NSString * e_hand_type;

//公司
@property (nonatomic, copy) NSString * enterprise;



@end
