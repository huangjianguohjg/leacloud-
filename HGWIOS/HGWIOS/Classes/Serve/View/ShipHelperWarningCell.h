//
//  ShipHelperWarningCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShipHelperWarningCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *detailTime;
@property(nonatomic,strong)UILabel *detailTitle;
@property(nonatomic,strong)UIImageView *detailImage;
@property(nonatomic,strong)NSString *cellId;
-(void)setContent:(NSString *)cellId  Title:(NSString *)title Date:(NSString *)date;
@end
