//
//  ShipHelperChangJiangView.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShipHelperChangJiangViewDelegate <NSObject>
- (void)DDStageViewClick:(NSInteger)number;
- (void)DDFlowViewClick:(NSInteger)number;
@end

@interface ShipHelperChangJiangView : UIView
@property(nullable, nonatomic,weak)   id<ShipHelperChangJiangViewDelegate> delegate;

@property(nonatomic,strong) UIScrollView * _Nullable  stagescrollView;
@property(nonatomic,strong) UIScrollView * _Nullable  flowscrollView;
@property(nonatomic,strong) UIView * _Nullable  navView;
@property(nonatomic,strong) UILabel * _Nullable  stageLable;
@property(nonatomic,strong) UIView * _Nullable  stageBlueView;
@property(nonatomic,strong) UILabel * _Nullable  flowLable;
@property(nonatomic,strong) UIView * _Nullable  flowBlueView;

-(UIView * _Nullable)getHead;
-(UIView * _Nullable)getflowHead;
-(UIView * _Nullable)getTableItem:(NSString * _Nullable)title Stage:(NSString * _Nullable)stage Change:(NSString * _Nullable)change Y:(int)y;

@end
