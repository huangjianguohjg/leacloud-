//
//  HomeGoodsTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeGoodsModel;

typedef void(^PhoneBlock)(NSString * phoneNum);

@interface HomeGoodsTableViewCell : UITableViewCell

@property (nonatomic, copy) PhoneBlock phoneBlock;

@property (nonatomic, strong) HomeGoodsModel * model;

@end
