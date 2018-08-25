//
//  RecommendBottomView.h
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RecommendFindBlock)(void);

@interface RecommendBottomView : UIView

@property (nonatomic, copy) RecommendFindBlock recommendFindBlock;

-(void)changeTitle:(NSString *)title DetailTitle:(NSString *)detailTitle ButtonTitle:(NSString *)buttonTitle;

@end
