//
//  InsuranceAddAddressController.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
#import "AFFNumericHoriKeyboard.h"
@interface InsuranceAddAddressController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,AFFNumericHoriKeyboardDelegate>
@property (strong, nonatomic) UICollectionView *ProviceCollectionView;
@property (strong, nonatomic) UICollectionView *CityCollectionView;
@property (strong, nonatomic) UICollectionView *CountyCollectionView;
@property (strong, nonatomic) UICollectionView *expresscompanyCollectionView;
@property (strong, nonatomic) NSString  *addressId;
@property (strong, nonatomic) NSString  *insuranceId;
@property ( nonatomic) int fromPage;//是否添加的时候跳转过来   1来自第四个界面  2来自列表界面  3来自编辑的修改界面
@end
