//
//  HomeTableViewCell.h
//  HGWIOS
//
//  Created by 许小军 on 2018/5/14.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeBoatModel;

typedef void(^PhoneBlock)(NSString * phoneNum);

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, copy) PhoneBlock phoneBlock;

@property (nonatomic, strong) HomeBoatModel * model;

@property (nonatomic, weak) UIView * topLineView;

@end
