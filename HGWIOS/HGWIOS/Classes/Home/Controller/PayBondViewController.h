//
//  PayBondViewController.h
//  HGWIOS
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

@interface PayBondViewController : BaseViewController

@property (nonatomic, copy) NSString * titleStr;

/**
 运单id
 */
@property (nonatomic, copy) NSString * cargo_id;

/**
 已支付的履约保证金
 */
@property (nonatomic, copy) NSString * payBond;













@end
