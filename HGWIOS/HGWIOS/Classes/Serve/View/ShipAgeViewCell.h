//
//  ShipAgeViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShipAgeViewCell : UICollectionViewCell
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *shipId;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *choosedView;


-(void) initwithContent:(NSString *)name Id:(NSString *)id;
@end
