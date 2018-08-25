//
//  BoatDeatilBottomView.h
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailBlock)(NSString * s);

@interface BoatDeatilBottomView : UIView

@property (nonatomic, copy) DetailBlock detailBlock;

@end
