//
//  MineTopTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScoreBlock)(void);

@interface MineTopTableViewCell : UITableViewCell

@property (nonatomic, weak) UIButton * iconButton;

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UILabel * phoneLable;

@property (nonatomic, weak) UILabel * companyLable;

@property (nonatomic, weak) UIButton * scoreButton;

@property (nonatomic, copy) ScoreBlock scoreBlock;





@end
