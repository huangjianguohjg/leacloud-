//
//  GoodsTopTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PhoneBlock)(NSString * phoneStr);

@class HomeGoodsModel;

@interface GoodsTopTableViewCell : UITableViewCell

@property (nonatomic, weak) UIButton * iconButton;

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UIButton * scoreButton;

@property (nonatomic, weak) UILabel * companyLable;

@property (nonatomic, weak) UILabel * timesLable;

@property (nonatomic, weak) UIButton * phoneButton;

@property (nonatomic, strong) HomeGoodsModel * model;

@property (nonatomic, copy) PhoneBlock phoneBlock;

@end
