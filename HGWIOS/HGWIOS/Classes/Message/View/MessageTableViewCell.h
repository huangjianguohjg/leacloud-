//
//  MessageTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;
@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) MessageModel * model;

@end
