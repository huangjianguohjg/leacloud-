//
//  MessageDetailTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageDetailModel;
@interface MessageDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) MessageDetailModel * model;

@property (nonatomic, copy) NSString * fromTag;

@end
