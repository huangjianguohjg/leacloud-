//
//  SelectTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock)(NSString * ss);
@interface SelectTableViewCell : UITableViewCell

@property (nonatomic, weak) UIButton * selectButton;

@property (nonatomic, copy) SelectBlock selectBlock;

@end
