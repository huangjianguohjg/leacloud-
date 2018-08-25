//
//  RecommendView.h
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RecommendBlock)(NSString * s);

@class HomeBoatModel;
@interface RecommendView : UIView

@property (nonatomic, strong) HomeBoatModel * model;

@property (nonatomic, copy) RecommendBlock recommendBlock;

@end
