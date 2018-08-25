//
//  TransportTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TransportBlock)(NSString * s);

@class AlreadyOfferModel;
@interface TransportTableViewCell : UITableViewCell

@property (nonatomic, strong) AlreadyOfferModel * model;

@property (nonatomic, copy) NSString * fromTag;

@property (nonatomic, copy) TransportBlock transportBlock;

@end
