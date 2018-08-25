//
//  ShaiXuanChildView.h
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShaiBlock)(NSString * str);

@interface ShaiXuanChildView : UIView

@property (nonatomic, strong) NSArray * titleArray;

@property (nonatomic, copy) ShaiBlock shaiBlock;

@end
