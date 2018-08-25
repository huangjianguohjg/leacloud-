//
//  GoodsDetailViewController.h
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
@class HomeGoodsModel;

@interface GoodsDetailViewController : BaseViewController

@property (nonatomic, copy) NSString * fromTag;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, copy) NSString * idStr;

@property (nonatomic, copy) NSString * open;

@property (nonatomic, strong) HomeGoodsModel * offerVCModel;

/**
 详情没返回货物类型,父地址。。。。。。
 */
@property (nonatomic, copy) NSString * cargo_Type;
@property (nonatomic, copy) NSString * parent_b;
@property (nonatomic, copy) NSString * parent_e;
@property (nonatomic, copy) NSString * freight_name;
@property (nonatomic, copy) NSString * deliver_count;
@property (nonatomic, copy) NSString * negotia;
/**
 取消报价的id
 */
@property (nonatomic, copy) NSString * cancelID;

@end
