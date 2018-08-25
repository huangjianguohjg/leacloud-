//
//  BankListTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SupportBankModel;

@interface BankListTableViewCell : UITableViewCell

@property (nonatomic, weak) UIImageView * bankImageView;

@property (nonatomic, weak) UILabel * titleLable;

@property (strong, nonatomic) NSString * titleAB;

@property (nonatomic, strong) SupportBankModel * model;

@end

