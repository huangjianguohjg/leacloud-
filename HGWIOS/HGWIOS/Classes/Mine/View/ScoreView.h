//
//  ScoreView.h
//  HGWIOS
//
//  Created by mac on 2018/6/9.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScoreBlock)(NSString * s);

@interface ScoreView : UIView

@property (nonatomic, weak) UIImageView * imageView;

@property (nonatomic, weak) UILabel * leftLable;

@property (nonatomic, weak) UIButton * chooseButton;

@property (nonatomic, copy) ScoreBlock scoreBlock;

@end
