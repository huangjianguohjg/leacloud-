//
//  ShipownerTableViewCell.h
//  HGWIOS
//
//  Created by 许小军 on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeBoatModel;

@interface ShipownerTableViewCell : UITableViewCell

@property (nonatomic, weak) UIButton * iconButton;

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UIButton * scoreButton;

@property (nonatomic, weak) UILabel * companyLable;

@property (nonatomic, weak) UILabel * timesLable;

@property (nonatomic, strong) HomeBoatModel * model;

@end
