//
//  ServeViewController.m
//  化运网ios
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 jiuze. All rights reserved.
//

#import "ServeViewController.h"
#import "SeverDetailViewController.h"
#import "ShipHelperAnnounceIndexController.h"
#import "ShipHelperWarningIndexController.h"
#import "ShipHelperWeatherIndexController.h"
#import "ShipHelperLockIndexController.h"
#import "LocationViewController.h"
#import "ServeView.h"
#import "WebViewController.h"
#import "BaoxianViewController.h"

@interface ServeViewController ()

@end

@implementation ServeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    
    [self setUpUI];
}

-(void)setUpNav
{
    self.navigationItem.title = @"服务";
    
    self.navigationController.navigationBar.barTintColor = XXJColor(27, 69, 138);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
   
    
}


-(void)setUpUI
{

    __weak typeof(self) weakSelf = self;
    
//    NSArray * topTitleArray = @[@"港口代理",@"船舶加油",@"船舶洗舱",@"货运保险",@"船员劳务",@"船舶加水",@"船员培训",@"船舶修理",];
//    NSArray * topImageArray = @[@"gk",@"jy",@"xc",@"bx",@"lw",@"sz",@"px",@"xl"];
    
    NSArray * topTitleArray = @[@"港口代理",@"船舶加油",@"船舶洗舱",@"船员劳务",@"船舶加水",@"船员培训",@"船舶修理",];
    NSArray * topImageArray = @[@"gk",@"jy",@"xc",@"lw",@"sz",@"px",@"xl"];
    
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = XXJColor(242, 242, 242);
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kTabBarHeight);
    }];
    
    ServeView * topView = [[ServeView alloc]init];
    topView.serveButtonBlock = ^(NSString *title) {
        if ([title isEqualToString:@"货运保险"]) {
            BaoxianViewController * baoxianVc = [[BaoxianViewController alloc]init];
            baoxianVc.hidesBottomBarWhenPushed = YES;
            baoxianVc.isServeVC = YES;
            [weakSelf.navigationController pushViewController:baoxianVc animated:YES];
            
        }
        else if ([title isEqualToString:@"船舶加油"])
        {
            WebViewController * webVc = [[WebViewController alloc]init];
//            webVc.link = @"http://yytest.jiuze9.com/zyhl/index.php?s=Home/Publicapp/ship_oil";
            //http://www.e-huayun.com/zyhl/index.php/Api2/
            webVc.link = @"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/ship_oil/2";
            webVc.hidesBottomBarWhenPushed = YES;
            webVc.titleStr = @"船舶加油";
            [weakSelf.navigationController pushViewController:webVc animated:YES];
        }
        else if ([title isEqualToString:@"船员劳务"])
        {
            WebViewController * webVc = [[WebViewController alloc]init];
            webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/labour_services/uid/%@/type/2",[UseInfo shareInfo].uID];
            webVc.hidesBottomBarWhenPushed = YES;
            webVc.titleStr = @"船员劳务";
            [weakSelf.navigationController pushViewController:webVc animated:YES];
        }
        else if ([title isEqualToString:@"船员培训"])
        {
            WebViewController * webVc = [[WebViewController alloc]init];
            webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/crew_training/uid/%@/type/2",[UseInfo shareInfo].uID];
            webVc.hidesBottomBarWhenPushed = YES;
            webVc.titleStr = @"船员培训";
            [weakSelf.navigationController pushViewController:webVc animated:YES];
        }
        else if ([title isEqualToString:@"船舶加水"])
        {
            WebViewController * webVc = [[WebViewController alloc]init];
            webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/ship_water/uid/%@/type/2",[UseInfo shareInfo].uID];
            webVc.hidesBottomBarWhenPushed = YES;
            webVc.titleStr = @"船舶加水";
            [weakSelf.navigationController pushViewController:webVc animated:YES];
        }
        else if ([title isEqualToString:@"船舶洗舱"])
        {
            WebViewController * webVc = [[WebViewController alloc]init];
            webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/ship_wching/uid/%@/type/2",[UseInfo shareInfo].uID];
            webVc.hidesBottomBarWhenPushed = YES;
            webVc.titleStr = @"船舶洗舱";
            [weakSelf.navigationController pushViewController:webVc animated:YES];
        }
        else if ([title isEqualToString:@"船舶修理"])
        {
            WebViewController * webVc = [[WebViewController alloc]init];
            webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/ship_repair/uid/%@/type/2",[UseInfo shareInfo].uID];
            webVc.hidesBottomBarWhenPushed = YES;
            webVc.titleStr = @"船舶修理";
            [weakSelf.navigationController pushViewController:webVc animated:YES];
        }
        else if ([title isEqualToString:@"港口代理"])
        {
            WebViewController * webVc = [[WebViewController alloc]init];
            webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/port_agent/uid/%@/type/2",[UseInfo shareInfo].uID];
            webVc.hidesBottomBarWhenPushed = YES;
            webVc.titleStr = @"港口代理";
            [weakSelf.navigationController pushViewController:webVc animated:YES];
        }
    };
    [topView setTitleArray:topTitleArray ImageArray:topImageArray Title:@"增值服务"];
    topView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:topView];
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scrollView);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH / 2 + realH(88)));
    }];
    
    
//    NSArray * downTitleArray = @[@"船舶定位",@"视频监控",@"长江水位",@"长江流量",@"安全预警",@"气象预告",@"过闸信息",@"航道通告"];
//
//    NSArray * downImageArray = @[@"dw",@"jk",@"sw",@"ll",@"aq",@"tq",@"gz",@"tg"];
    
    
    NSArray * downTitleArray = @[@"船舶定位",@"长江水位",@"长江流量",@"安全预警",@"气象预告",@"过闸信息",@"航道通告"];
    
    NSArray * downImageArray = @[@"dw",@"sw",@"ll",@"aq",@"tq",@"gz",@"tg"];
    
    
    ServeView * bottomView = [[ServeView alloc]init];
    bottomView.serveButtonBlock = ^(NSString *title) {
        if ([title isEqualToString:@"船舶定位"]) {
            LocationViewController * locationVc = [[LocationViewController alloc]init];
            locationVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:locationVc animated:YES];
        }
        else if ([title isEqualToString:@"视频监控"])
        {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"projectB:"]];
        }
        else if ([title isEqualToString:@"长江水位"])
        {
            SeverDetailViewController * detailVc = [[SeverDetailViewController alloc]init];
            detailVc.hidesBottomBarWhenPushed = YES;
            detailVc.titleStr = @"长江水位";
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        }
        else if ([title isEqualToString:@"长江流量"])
        {
            SeverDetailViewController * detailVc = [[SeverDetailViewController alloc]init];
            detailVc.hidesBottomBarWhenPushed = YES;
            detailVc.titleStr = @"长江流量";
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        }
        else if ([title isEqualToString:@"安全预警"])
        {
            ShipHelperWarningIndexController * detailVc = [[ShipHelperWarningIndexController alloc]init];
            detailVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        }
        else if ([title isEqualToString:@"气象预告"])
        {
            ShipHelperWeatherIndexController * detailVc = [[ShipHelperWeatherIndexController alloc]init];
            detailVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        }
        else if ([title isEqualToString:@"过闸信息"])
        {
            //https://pages.ship56.net/info/lockage/index
            
            WebViewController * webVc = [[WebViewController alloc]init];
            webVc.link = @"https://pages.ship56.net/info/lockage/index";
            webVc.hidesBottomBarWhenPushed = YES;
            webVc.titleStr = @"过闸信息";
            [weakSelf.navigationController pushViewController:webVc animated:YES];
            
            
//            ShipHelperLockIndexController * detailVc = [[ShipHelperLockIndexController alloc]init];
//            detailVc.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        }
        else if ([title isEqualToString:@"航道通告"])
        {
            ShipHelperAnnounceIndexController * detailVc = [[ShipHelperAnnounceIndexController alloc]init];
            detailVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        }
    };
    [bottomView setTitleArray:downTitleArray ImageArray:downImageArray Title:@"航运信息"];
    bottomView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.top.equalTo(topView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH / 2 + realH(88)));
    }];
    

}


























@end
