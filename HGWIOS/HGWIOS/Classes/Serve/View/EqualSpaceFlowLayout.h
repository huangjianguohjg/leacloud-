//
//  EqualSpaceFlowLayout.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  EqualSpaceFlowLayoutDelegate<UICollectionViewDelegateFlowLayout>
@end
@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,weak) id<EqualSpaceFlowLayoutDelegate> delegate;
@end
