//
//  MyGoodsView.h
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlreadyOfferModel;

//typedef void(^BIDBlock)(void);

typedef void(^RefreshBlock)(NSString * s);

typedef void(^HandleBlock)(NSString * str,AlreadyOfferModel * model);

@interface MyGoodsView : UIView

//@property (nonatomic, copy) BIDBlock bidBlock;

/**
 点击刷新
 */
@property (nonatomic, copy) RefreshBlock refreshBlock;
/**
 配船/修改
 */
@property (nonatomic, copy) HandleBlock handleBlock;

@property (nonatomic, copy) NSString * fromTag;





@end
