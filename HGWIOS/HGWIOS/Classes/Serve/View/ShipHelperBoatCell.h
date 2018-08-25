//
//  ShipHelperBoatCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShipHelperBoatCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)NSString *cellId;
-(void)setContent:(NSString *)cellId  Title:(NSString *)title;
@end
