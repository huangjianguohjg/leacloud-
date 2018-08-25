//
//  MyInsurancesController.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
#import "EqualSpaceFlowLayout.h"
#define payStyle 1
#define upPayStyle 2
@interface MyInsurancesController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,EqualSpaceFlowLayoutDelegate>
@property (strong, nonatomic) UICollectionView *UnPayCollectionView;
@property (strong, nonatomic) UICollectionView *PayCollectionView;

@property (nonatomic, assign) BOOL isInputOneVc;

@end
