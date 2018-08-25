//
//  ShipTracksController.h
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

@interface ShipTracksController : BaseViewController<BMKMapViewDelegate>
@property (strong,nonatomic)NSString *shipId;
@property (strong,nonatomic)NSString *mmsi;
@property (strong,nonatomic)NSString *lat;
@property (strong,nonatomic)NSString *lot;
@end
