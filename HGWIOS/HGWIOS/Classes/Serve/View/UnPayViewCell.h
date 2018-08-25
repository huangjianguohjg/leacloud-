//
//  UnPayViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnPayViewCell : UICollectionViewCell
@property(strong,nonatomic)NSString *id;
@property(strong,nonatomic)NSString *insuranceId;
@property(strong,nonatomic)UILabel *TitleLabel;
@property(strong,nonatomic)UILabel *shipNameLabel;
@property(strong,nonatomic)UILabel *departureDateLabel;
@property(strong,nonatomic)UILabel *boatTrankLabel;
@property(strong,nonatomic)UILabel *baofeiLabel;
@property(strong,nonatomic)UILabel *kuaidiLabel;
@property(strong,nonatomic)UIView *deleteView;//删除功能
@property(strong,nonatomic)UIView *editView;//编辑功能


-(void)initContent:(NSString *)title ShipName:(NSString *)shipName DepartureDate:(NSString *)departureDate
         BoatTrank:(NSString *)boatTrank Baofei:(NSString *)baofei Kuaidi:(NSString *)kuaidi Id:(NSString *)id;
@end
