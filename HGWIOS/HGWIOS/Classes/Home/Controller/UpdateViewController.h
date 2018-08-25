//
//  UpdateViewController.h
//  HGWIOS
//
//  Created by mac on 2018/5/29.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

@class AlreadyOfferModel;

@interface UpdateViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray * payArray;

//付款方式的字典
@property (nonatomic, strong) NSMutableDictionary * payDictionary;

@property (nonatomic, strong) AlreadyOfferModel * model;



@end
