//
//  AdminTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AdminBlock)(NSString * str);

@interface AdminTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UILabel * numberLable;

@property (nonatomic, copy) AdminBlock adminBlock;

@end
