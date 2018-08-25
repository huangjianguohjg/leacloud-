//
//  MyBoatTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBoatBlock)(NSString * s,NSString * ship_id);

@class MyBoatModel;

@interface MyBoatTableViewCell : UITableViewCell

@property (nonatomic, strong) MyBoatModel * model;

@property (nonatomic, copy) MyBoatBlock myBoatBlock;

@end
