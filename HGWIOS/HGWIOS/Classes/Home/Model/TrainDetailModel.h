//
//  TrainDetailModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainDetailModel : NSObject

/**
 状态
 */
@property (nonatomic, copy) NSString * status_name;

/**
 编号
 */
@property (nonatomic, copy) NSString * deal_no;
/**
 承运价格
 */
@property (nonatomic, copy) NSString * first_money;
/**
 货物名称
 */
@property (nonatomic, copy) NSString * cargo_type_name;
/**
 货物重量
 */
@property (nonatomic, copy) NSString * weight;
@property (nonatomic, copy) NSString * weight_num;
/**
 起运港
 */
@property (nonatomic, copy) NSString * b_port;
/**
 目的港
 */
@property (nonatomic, copy) NSString * e_port;
/**
 装载日期
 */
@property (nonatomic, copy) NSString * b_time;
@property (nonatomic, copy) NSString * e_time;

/**
 合理损耗
 */
@property (nonatomic, copy) NSString * loss;
/**
 装卸期限
 */
@property (nonatomic, copy) NSString * dock_day;
/**
 滞期费用
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
@property (nonatomic, copy) NSString * freight_show;
/**
 包含费用
 */
@property (nonatomic, copy) NSString * contain_price;
/**
 船舶名称
 */
@property (nonatomic, copy) NSString * name;
/**
 船舶类型
 */
@property (nonatomic, copy) NSString * ship_type_name;
/**
 船舶载重
 */
@property (nonatomic, copy) NSString * deadweight;
/**
 船舶属性 船长
 */
@property (nonatomic, copy) NSString * length;
/**
 船舶属性 船宽
 */
@property (nonatomic, copy) NSString * width;
/**
 船舶属性 吃水深度
 */
@property (nonatomic, copy) NSString * draught;

/**
 建造年份
 */
@property (nonatomic, copy) NSString * complete_time;

/**
 货主电话
 */
@property (nonatomic, copy) NSString * s_mobile;

@property (nonatomic, copy) NSString * c_mobile;

/**
 交接方式 起运港
 */
@property (nonatomic, copy) NSString * b_hand_type;

/**
 交接方式 目的港
 */
@property (nonatomic, copy) NSString * e_hand_type;

/**
 滞期费用单位
 */
@property (nonatomic, copy) NSString * demurrage_unit;

/**
 船舶舱容
 */
@property (nonatomic, copy) NSString * storage;

@property (nonatomic, copy) NSString * cargo_id;

/**
 装货图片
 */
@property (nonatomic, copy) NSString * loading_image_url;
/**
 卸货图片
 */
@property (nonatomic, copy) NSString * unloading_image_url;

/**
 船东合同
 */
@property (nonatomic, strong) NSArray * s_contract_file;
/**
 货主合同
 */
@property (nonatomic, strong) NSArray * c_contract_file;

/**
 船东分数
 */
@property (nonatomic, copy) NSString * req_comment_score;
/**
 货主分数
 */
@property (nonatomic, copy) NSString * confirm_comment_score;
@end
