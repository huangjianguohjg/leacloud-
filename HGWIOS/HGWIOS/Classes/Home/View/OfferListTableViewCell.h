//
//  OfferListTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OfferListModel;

typedef void(^OfferBlock)(OfferListModel * model);
@interface OfferListTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel * companyLable;

@property (nonatomic, strong) OfferListModel * model;

@property (nonatomic, copy) OfferBlock offerBlock;

@end
