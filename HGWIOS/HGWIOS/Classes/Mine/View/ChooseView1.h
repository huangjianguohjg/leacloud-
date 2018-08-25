//
//  ChooseView1.h
//  HGWIOS
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseHeightBlock)(CGFloat height);

typedef void(^EmptyChooseBlock)(void);
typedef void(^EmptyDeleteBlock)(NSString * s);

@class ChooseLableView;

@interface ChooseView1 : UIView

@property (nonatomic, weak) UIButton * chooseButton;

@property (nonatomic, weak) ChooseLableView * typeLable1;

@property (nonatomic, weak) ChooseLableView * typeLable2;

@property (nonatomic, weak) ChooseLableView * typeLable3;

@property (nonatomic, weak) UIView * lineView;

@property (nonatomic, copy) NSString * lable3;

@property (nonatomic, copy) NSString * lable2;

@property (nonatomic, copy) NSString * lable1;

@property (nonatomic, copy) ChooseHeightBlock chooseHeightBlock;

@property (nonatomic, copy) EmptyChooseBlock emptyChooseBlock;

@property (nonatomic, copy) EmptyDeleteBlock emptyDeleteBlock;

@property (nonatomic, copy) NSString * chooseID1;

@property (nonatomic, copy) NSString * chooseID2;

@property (nonatomic, copy) NSString * chooseID3;


@end
