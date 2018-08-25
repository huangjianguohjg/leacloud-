//
//  DetailMainViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "DetailMainViewController.h"
#import "DetailViewController.h"
#import "StyleViewController.h"
@interface DetailMainViewController ()

@end

@implementation DetailMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setSize];
    
}

-(void)setSize
{
    CGRect frame = self.view.frame;
    frame.origin.y = kStatusBarHeight + kNavigationBarHeight + realH(82);
    frame.size.height = SCREEN_HEIGHT - frame.origin.y;
    //    if(isIPHONEX){
    //        frame.size.height -= 34;
    //    }
    
    //设置标题栏和底部滚动范围
    [self setTabBarFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREEN_WIDTH, realH(82)) contentViewFrame:frame];
    
    self.tabBar.itemTitleColor = [UIColor blackColor];
    self.tabBar.itemTitleSelectedColor = XXJColor(74, 157, 227);
    
    self.tabBar.itemTitleFont = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    self.tabBar.itemTitleSelectedFont = [UIFont fontWithName:PingFangSc_Medium size:realFontSize(32)];
    
//    self.tabBar.leadAndTrailSpace = 0;
    
    self.tabBar.itemFontChangeFollowContentScroll = YES;//左右切换有变大效果
    //    self.tabBar.itemSelectedBgScrollFollowContent = YES;//左右切换颜色渐变
    
    self.tabBar.indicatorScrollFollowContent = YES;
    [self.tabBar setIndicatorColor:XXJColor(74, 157, 227)];
    [self.tabBar setIndicatorWidthFixTextAndMarginTop:realH(78) marginBottom:0 widthAdditional:realW(240) tapSwitchAnimated:YES];
    
    
    
    //    [self setContentScrollEnabledAndTapSwitchAnimated:NO];//切换动画
    [self setContentScrollEnabled:YES tapSwitchAnimated:YES];
    self.loadViewOfChildContollerWhileAppear = NO;//滑到的时候再加载
    
    
    
    //    self.defaultSelectedControllerIndex = 2;
    
    [self addchildVC];
}




-(void)addchildVC
{
    DetailViewController * detailVc = [[DetailViewController alloc]init];
    detailVc.cargo_id = self.cargo_id;
    detailVc.weight_num = self.weight_num;
    detailVc.yp_tabItemTitle = @"运单详情";
    
    StyleViewController * styleVc = [[StyleViewController alloc]init];
    styleVc.detail_id = self.detail_id;
    styleVc.yp_tabItemTitle = @"运单状态";
    
    
    
    self.viewControllers = [NSMutableArray arrayWithObjects:detailVc,styleVc, nil];
}
@end
