//
//  ShipHelperChangJiangController.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
#import "ShipHelperChangJiangView.h"
@interface ShipHelperChangJiangController : BaseViewController<ShipHelperChangJiangViewDelegate>
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *changjiangTitle;

@property (nonatomic, copy) NSString * fromTag;




@end
