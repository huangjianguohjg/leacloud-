//
//  TypeView.h
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OkBlock)(NSString * ss);

@interface TypeView : UIView

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, copy) OkBlock okBlock;

@property (nonatomic, copy) NSString * clear;

@end
