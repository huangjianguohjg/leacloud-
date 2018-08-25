//
//  InsuranceInputThreeController.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
#import "AFFNumericHoriKeyboard.h"
#import "InsuranceModel.h"
@interface InsuranceInputThreeController : BaseViewController<AFFNumericHoriKeyboardDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) NSString *InsuranceId;
@property (strong, nonatomic) UICollectionView *BoatAgeCollectionView;
@property (strong, nonatomic) UICollectionView *DepartureDateCollectionView;
@property (strong, nonatomic) UICollectionView *BoatNamecollectionView;
@property (nonatomic) Boolean isEdit;
@end
