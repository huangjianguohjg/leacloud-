//
//  ShipHelperAnnounceIndexView.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShipHelperAnnounceIndexViewDelegate <NSObject>
- (void)DDViewClick:(NSInteger)number;
@end

@interface ShipHelperAnnounceIndexView : UIView

@property(nonatomic,strong) UIScrollView * _Nullable  scrollView;
@property(nullable, nonatomic,weak)   id<ShipHelperAnnounceIndexViewDelegate> delegate;
@property(nonatomic,strong) NSMutableDictionary * _Nullable  trueDataDictionary;//整理过的数据

-(UIView *_Nullable)setContentItem:(NSString *_Nullable)time DataList:(NSMutableArray *_Nullable)dataList Y:(int)y Flag:(int)flag;

@end
