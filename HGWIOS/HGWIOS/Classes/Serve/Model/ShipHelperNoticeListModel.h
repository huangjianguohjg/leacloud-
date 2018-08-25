//
//  ShipHelperNoticeListModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShipHelperNoticeItemModel.h"
@interface ShipHelperNoticeListModel : NSObject
@property (nonatomic,nonatomic)NSString *date;
@property (nonatomic,nonatomic)NSString *date_format;
@property (nonatomic,nonatomic)NSMutableArray<ShipHelperNoticeItemModel *> *list;
@end
