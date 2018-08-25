//
//  WebBottomView.h
//  HGWIOS
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WebBlock)(NSString * s);

@interface WebBottomView : UIView

@property (nonatomic, copy) WebBlock webBlock;

@property (nonatomic, weak) UIButton * backButton;

@property (nonatomic, weak) UIButton * goButton;
@end
