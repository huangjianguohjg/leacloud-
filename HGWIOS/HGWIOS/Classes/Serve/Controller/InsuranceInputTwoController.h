//
//  InsuranceInputTwoController.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

#import "AFFNumericKeyboard.h"
#import "InsuranceModel.h"

@interface InsuranceInputTwoController : BaseViewController<AFFNumericKeyboardDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *GoodsMtypecollectionView;
@property (strong, nonatomic) UICollectionView *GoodsStypecollectionView;
@property (strong, nonatomic) UICollectionView *UnitcollectionView;
@property (strong, nonatomic) NSString *InsuranceId;
@property (nonatomic) Boolean isEdit;

@end
