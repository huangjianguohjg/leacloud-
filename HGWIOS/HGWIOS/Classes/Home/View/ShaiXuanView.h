//
//  ShaiXuanView.h
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShaiChooseBlock)(NSString * str, NSString * weightStr, NSString * cashStr, NSString * payStr, NSString * typeStr);

@interface ShaiXuanView : UIView

@property (nonatomic, copy) NSString * fromTag;

@property (nonatomic, copy) ShaiChooseBlock shaiChooseBlock;

-(void)setFromTag:(NSString *)fromTag Array:(NSArray *)array;

@end
