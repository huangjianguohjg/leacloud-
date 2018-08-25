//
//  MyTransportMainViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyTransportMainViewController.h"
#import "AllViewController.h"
#import "WaitLoadViewController.h"
#import "WaitUnloadViewController.h"
#import "WaitPayViewController.h"
#import "WaitDiscussViewController.h"

@interface MyTransportMainViewController ()

@end

@implementation MyTransportMainViewController

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
    
    self.tabBar.itemTitleColor = [UIColor colorWithHexString:@"#1a1a1a"];
    self.tabBar.itemTitleSelectedColor = [UIColor colorWithHexString:@"#1a1a1a"];
    
    self.tabBar.itemTitleFont = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    self.tabBar.itemTitleSelectedFont = [UIFont fontWithName:PingFangSc_Medium size:realFontSize(32)];
    
    self.tabBar.itemFontChangeFollowContentScroll = YES;//左右切换有变大效果
    //    self.tabBar.itemSelectedBgScrollFollowContent = YES;//左右切换颜色渐变
    
    self.tabBar.indicatorScrollFollowContent = YES;
    [self.tabBar setIndicatorColor:XXJColor(27, 69, 138)];
    [self.tabBar setIndicatorWidthFixTextAndMarginTop:realH(78) marginBottom:0 widthAdditional:0 tapSwitchAnimated:YES];
    
    
    
    //    [self setContentScrollEnabledAndTapSwitchAnimated:NO];//切换动画
    [self setContentScrollEnabled:YES tapSwitchAnimated:YES];
    self.loadViewOfChildContollerWhileAppear = NO;//滑到的时候再加载
    
    
    
    //    self.defaultSelectedControllerIndex = 2;
    
    [self addchildVC];
}




-(void)addchildVC
{
    AllViewController * allVc = [[AllViewController alloc]init];
    allVc.yp_tabItemTitle = @"  全部  ";
    
    WaitLoadViewController * loadVc = [[WaitLoadViewController alloc]init];
    loadVc.yp_tabItemTitle = @"待装货";
    
    WaitUnloadViewController * unLoadVc = [[WaitUnloadViewController alloc]init];
    unLoadVc.yp_tabItemTitle = @"待卸货";
    
    WaitPayViewController * payVc = [[WaitPayViewController alloc]init];
    payVc.yp_tabItemTitle = @"待结算";
    
    WaitDiscussViewController * discussVc = [[WaitDiscussViewController alloc]init];
    discussVc.yp_tabItemTitle = @"待评价";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:allVc,loadVc,unLoadVc,payVc,discussVc, nil];
}

































@end
