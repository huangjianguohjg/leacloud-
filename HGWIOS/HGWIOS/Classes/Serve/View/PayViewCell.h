//
//  PayViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrayLine.h"
@interface PayViewCell : UICollectionViewCell
@property(strong,nonatomic)UILabel *TitleLabel;
@property(strong,nonatomic)UILabel *baodanNumberLabel;
@property(strong,nonatomic)UILabel *YouFeiLabel;
@property(strong,nonatomic)UITextView *insuranceAddressView;
@property(strong,nonatomic)NSString *insuranceId;
@property(strong,nonatomic)UILabel *shipNameLabel;
@property(strong,nonatomic)UILabel *departureDateLabel;
@property(strong,nonatomic)UILabel *boatTrankLabel;
@property(strong,nonatomic)UILabel *baofeiLabel;
@property(strong,nonatomic)UILabel *kuaidiLabel;
@property(strong,nonatomic)UIButton *submitBt;
@property(strong,nonatomic)UILabel *okLabel;
@property(strong,nonatomic)UIImageView *okImage;
@property(strong,nonatomic)UIButton *dianzibaodanLabel;
@property(strong,nonatomic)UILabel *zhushiLabel;
@property(strong,nonatomic)GrayLine* GrayLine5;
@property(strong,nonatomic)GrayLine* GrayLine6;

-(void)initContent:(NSString *)title ShipName:(NSString *)shipName DepartureDate:(NSString *)departureDate
         BoatTrank:(NSString *)boatTrank Baofei:(NSString *)baofei Kuaidi:(NSString *)kuaidi Id:(NSString *)id baodanId:(NSString *)baodanId Status:(NSString *)status;
@end
