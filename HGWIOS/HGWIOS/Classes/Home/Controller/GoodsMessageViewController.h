//
//  GoodsMessageViewController.h
//  HGWIOS
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"


@interface GoodsMessageViewController : BaseViewController

@property (nonatomic, strong) NSString * cargo_id;

//询价类型
@property (nonatomic, copy) NSString * cons_type;
//开标时间
@property (nonatomic, copy) NSString * open_time;
//报价人数
@property (nonatomic, copy) NSString * count;

//是否失效
@property (nonatomic, copy) NSString * open;

/**
 详情没返回货物类型,父地址
 */
@property (nonatomic, copy) NSString * cargo_Type;
@property (nonatomic, copy) NSString * parent_b;
@property (nonatomic, copy) NSString * parent_e;
@property (nonatomic, copy) NSString * freight_name;
@property (nonatomic, copy) NSString * deliver_count;
@property (nonatomic, copy) NSString * negotia;

@end
