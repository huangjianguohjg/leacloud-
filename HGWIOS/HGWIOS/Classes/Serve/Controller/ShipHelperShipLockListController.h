//
//  ShipHelperShipLockListController.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

@interface ShipHelperShipLockListController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSString *shipName;
@property(nonatomic,strong)NSString *shipId;
@end
