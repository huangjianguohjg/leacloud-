//
//  ShipHelperLockDetailController.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

@interface ShipHelperLockDetailController : BaseViewController<UISearchBarDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSString *place;

@end
