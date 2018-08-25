//
//  ChooseView.h
//  HGWIOS
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZTagList;

typedef void(^EmptyChooseBlock)(void);
typedef void(^EmptyDeleteBlock)(NSString * s);

@interface ChooseView : UIView


@property (nonatomic, weak) UIButton * chooseButton;

@property (nonatomic, weak) UIButton * typeButton;

@property (nonatomic, weak) UIButton * typeButton1;

@property (nonatomic, weak) UIButton * typeButton2;

@property (nonatomic, weak) UILabel * douhaoLable;

@property (nonatomic, weak) UILabel * douhaoLable1;

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, copy) NSString * chooseID;

@property (nonatomic, copy) NSString * chooseID1;

@property (nonatomic, copy) NSString * chooseID2;

@property (nonatomic, copy) EmptyChooseBlock emptyChooseBlock;

@property (nonatomic, copy) EmptyDeleteBlock emptyDeleteBlock;

@end
