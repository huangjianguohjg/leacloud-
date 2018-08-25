//
//  OfferListModel.h
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CargoInfo : NSObject

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * deadweight;

@property (nonatomic, copy) NSString * inspect_type;

@property (nonatomic, copy) NSString * type_name;

@end


@interface ShipUser : NSObject

@property (nonatomic, copy) NSString * score;

@property (nonatomic, copy) NSString * username;

@property (nonatomic, copy) NSString * enterprice;

@end

@class ShipUser,CargoInfo;
@interface OfferListModel : NSObject

@property (nonatomic, strong) CargoInfo * cargo;

@property (nonatomic, strong) ShipUser * ship_user;

@property (nonatomic, copy) NSString * cargo_id;

@property (nonatomic, copy) NSString * ship_id;

@property (nonatomic, copy) NSString * money;

@end
