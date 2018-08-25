//
//  BankListViewController.h
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^BankSelectBlcok)(NSString * name, NSString * ab);

@interface BankListViewController : BaseViewController

@property (nonatomic, copy) BankSelectBlcok bankSelectBlock;

@end
