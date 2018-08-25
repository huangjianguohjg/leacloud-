//
//  LocationViewController.h
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

@interface LocationViewController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate,UITextFieldDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) UICollectionView *searchcollectionView;
@property (strong, nonatomic) UICollectionView *historycollectionView;
@property (strong, nonatomic) UICollectionView *chuanbocollectionView;

@property (nonatomic, strong) NSMutableArray * chuanboArray;
@end
