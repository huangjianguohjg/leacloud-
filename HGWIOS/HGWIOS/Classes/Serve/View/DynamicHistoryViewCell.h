//
//  DynamicHistoryViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicHistoryViewCell : UICollectionViewCell
@property (strong, nonatomic) NSString *boatId;
@property (strong, nonatomic) UILabel *BoatNameTitle;
@property (strong, nonatomic) UILabel *BoatTimeLabel;
@property (strong, nonatomic) NSString *mmsi;

-(void)initContent:(NSString *)id BoatName:(NSString *)boatName Time:(NSString *)time Mmsi:(NSString *)mmsi;
@end
