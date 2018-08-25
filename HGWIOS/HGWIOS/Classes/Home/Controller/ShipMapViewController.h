//
//  ShipMapViewController.h
//  HGWIOS
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

@interface ShipMapViewController : BaseViewController

@property (nonatomic, copy) NSString * boatId;

@property (nonatomic, copy) NSString * shipName;

@property (strong,nonatomic)NSString *mmsi;

@property (strong,nonatomic)LocationHelper *locationHelper;
@property (strong,nonatomic)UIView *popView;
@end
