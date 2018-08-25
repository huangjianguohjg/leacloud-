//
//  ShipEmptyViewController.h
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
@class MyBoatModel,HomeBoatModel;

typedef void(^EmptyUpdateBlock)(void);

@interface ShipEmptyViewController : BaseViewController

@property (nonatomic, strong) MyBoatModel * model;

@property (nonatomic, strong) HomeBoatModel * updateModel;

@property (nonatomic, copy) EmptyUpdateBlock emptyUpdateBlock;

@end
