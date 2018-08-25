//
//  InsuranceAddressListController.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

@interface InsuranceAddressListController : BaseViewController
@property (strong, nonatomic) UICollectionView *AddressCollectionView;
@property (strong, nonatomic) NSMutableArray *addressList;
@property (strong, nonatomic) NSString *InsuranceId;
@property ( nonatomic) Boolean isFour;//是否添加的时候跳转过来
@end
