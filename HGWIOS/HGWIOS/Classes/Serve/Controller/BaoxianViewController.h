//
//  BaoxianViewController.h
//  HGWIOS
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
//#import <UIKit/UIKit.h>
#import "AFFNumericHoriKeyboard.h"
#import "InsuranceModel.h"
@interface BaoxianViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,AFFNumericHoriKeyboardDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSString *insuranceId;
@property (strong, nonatomic) InsuranceModel *oldInsuranceModel;

@property (nonatomic) Boolean isEdit;

@property (nonatomic, assign) BOOL isServeVC;

@end
