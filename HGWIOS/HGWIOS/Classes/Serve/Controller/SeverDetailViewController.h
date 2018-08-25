//
//  SeverDetailViewController.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
#import "ServerWaterView.h"

@interface SeverDetailViewController : BaseViewController<ServerWaterViewDelegate>

@property (nonatomic, copy) NSString * titleStr;

@end
