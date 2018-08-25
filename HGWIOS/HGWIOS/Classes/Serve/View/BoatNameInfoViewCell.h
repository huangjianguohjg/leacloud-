//
//  BoatNameInfoViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoatNameInfoViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) NSString *boatId;
-(void)setName:(NSString *)name;
-(void)setBoatName:(NSString *)name;
-(void)setBoatName:(NSString *)name Id:(NSString *)boatId;
@end
