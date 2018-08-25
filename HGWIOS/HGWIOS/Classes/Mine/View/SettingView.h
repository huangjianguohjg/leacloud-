//
//  SettingView.h
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SetBlock)(void);

@interface SettingView : UIView

@property (nonatomic, weak) UILabel * titleLable;

@property (nonatomic, weak) UIImageView * arrowImageView;

@property (nonatomic, weak) UILabel * versionsLable;

@property (nonatomic, copy) SetBlock setBlock;

@end
