//
//  ServerWaterView.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ServerWaterViewDelegate <NSObject>

- (void)DDViewClick:(NSInteger)number;

@end

@interface ServerWaterView : UIView

@property(nonatomic,weak) UIScrollView * scrollView;

@property(nonatomic,strong)NSMutableDictionary * trueDataDictionary;//整理过的数据
@property(nullable, nonatomic,weak)   id<ServerWaterViewDelegate> delegate;

-(UIView * _Nullable)setContentItem:(NSString * _Nullable)time DataList:(NSMutableArray * _Nullable) dataList Y:(int)y Flag:(int)flag;

@property (nonatomic, copy) NSString * fromTag;

@end
