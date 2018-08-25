//
//  AddressViewController.h
//  HGWIOS
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^AddressBackBlock)(NSString * addressID,NSString * addressStr,NSString * parentProID,NSString * address_Str);

@interface AddressViewController : BaseViewController

@property (nonatomic, copy) AddressBackBlock addressBackBlock;

@property (nonatomic, copy) NSString * fromTag;

@property (nonatomic, copy) NSString * empty;

@end
