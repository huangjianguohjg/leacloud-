//
//  PublishGoodsView.h
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddBoatView;

typedef void(^ChooseAddressBlock)(NSString * addressStr);

typedef void(^NameApproveBlock)(void);

typedef void(^PublishSuccessBlock)(NSDictionary * dict);

/**
 指定询价 发货成功
 */
typedef void(^InviteSuccessBlock)(NSString * cargo_id);

@interface PublishGoodsView : UIView

@property (nonatomic, copy) ChooseAddressBlock chooseAddressBlock;

@property (nonatomic, copy) NameApproveBlock nameApproveBlock;

@property (nonatomic, copy) PublishSuccessBlock publishSuccessBlock;

@property (nonatomic, copy) InviteSuccessBlock inviteSuccessBlock;

@property (nonatomic, weak) AddBoatView * priceTypeView;

@property (nonatomic, weak) AddBoatView * goodsTypeView;

@property (nonatomic, weak) AddBoatView * weightView;

@property (nonatomic, weak) AddBoatView * startView;

@property (nonatomic, weak) AddBoatView * endView;

@property (nonatomic, weak) AddBoatView * dateView;

@property (nonatomic, weak) AddBoatView * changeView;

@property (nonatomic, weak) AddBoatView * lossView;

@property (nonatomic, weak) AddBoatView * installView;

@property (nonatomic, weak) AddBoatView * retentionView;

@property (nonatomic, weak) AddBoatView * agreeView;

@property (nonatomic, weak) AddBoatView * closeView;

@property (nonatomic, weak) AddBoatView * payView;

@property (nonatomic, weak) AddBoatView * includeView;

@property (nonatomic, weak) AddBoatView * referView;

@property (nonatomic, weak) AddBoatView * bidOpenView;

@property (nonatomic, weak) AddBoatView * bidOutView;

@property (nonatomic, weak) AddBoatView * attentionView;

@property (nonatomic, weak) UIButton * publishButton;

@property (nonatomic, copy) NSString * fromTag;
@property (nonatomic, copy) NSString * updateCargo_id;

/**
 记录付款方式的字典
 */
//@property (nonatomic, strong) NSMutableDictionary * payDictionary;

/**
 记录起运港ID
 */
@property (nonatomic, copy) NSString * b_port_id;
/**
 记录目的港ID
 */
@property (nonatomic, copy) NSString * e_port_id;
/**
 起运具体地址
 */
@property (nonatomic, copy) NSString * b_port_address;
/**
 目的具体地址
 */
@property (nonatomic, copy) NSString * e_port_address;
/**
 出发地省地点id
 */
@property (nonatomic, copy) NSString * parent_b_port_id;
/**
 目的地省地点id
 */
@property (nonatomic, copy) NSString * parent_e_port_id;

/**
 记录询价类型
 */
@property (nonatomic, copy) NSString * priceStr;
/**
 记录履约保证金
 */
@property (nonatomic, copy) NSString * bondStr;
/**
 记录支付方式
 */
@property (nonatomic, copy) NSString * payStyleStr;
/**
 记录货物类型
 */
@property (nonatomic, copy) NSString * goodsStyleID;

/**
 记录付款方式
 */
@property (nonatomic, copy) NSString * payStr;
/**
 记录包含费用
 */
@property (nonatomic, copy) NSString * containsStr;
@end
