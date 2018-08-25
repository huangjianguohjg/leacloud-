//
//  RecommendViewController.h
//  HGWIOS
//
//  Created by mac on 2018/5/29.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

@class AlreadyOfferModel;

@interface RecommendViewController : BaseViewController

@property (nonatomic, strong) AlreadyOfferModel * model;

@property (nonatomic, strong) NSDictionary * dataDict;

//发货成功后，跳转推荐界面，返回直接到首页
@property (nonatomic, copy) NSString * fromTag;

@end
