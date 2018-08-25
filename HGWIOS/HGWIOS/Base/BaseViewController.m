//
//  BaseViewController.m
//  化运网ios
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 jiuze. All rights reserved.
//

#import "BaseViewController.h"
#import "TalkingData.h"
#import "EBBannerView.h"
#import "MyTransportViewController.h"
#import "GoodsDetailViewController.h"
#import "MyGoodsViewController.h"
@interface BaseViewController ()

/** 呼叫中心*/
//@property (nonatomic, strong) CTCallCenter *callCenter;
@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [TalkingData trackPageBegin:[NSString stringWithUTF8String:object_getClassName(self)]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [TalkingData trackPageEnd:[NSString stringWithUTF8String:object_getClassName(self)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    if (self.navigationController.viewControllers.count > 1) {
        [self setUpNav];
    }
    
}



-(void)setUpNav
{
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    
    
    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"arrow-appbar-left"] forState:UIControlStateNormal];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}


-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dealloc
{
    XXJLog(@"%@释放",[self class]);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}






///**
// 监听电话介入
// */
//- (void)monitorTelephoneCall {
//    __weak typeof(self) weakSelf = self;
//
//    // MsgAppStarting
//    // MsgAppReactivate
//    _callCenter = [[CTCallCenter alloc] init];
//    _callCenter.callEventHandler = ^(CTCall * call) {
//        if ([call.callState isEqualToString:CTCallStateDisconnected]) {// Call has been disconnected
//            NSLog(@"电话 --- 断开连接");
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                XXJLog(@"312312312312312312312312312312")
//
//            });
//
//        }
//        else if ([call.callState isEqualToString:CTCallStateConnected]) {// Call has just been connected
//            NSLog(@"电话 --- 接通");
//            // 通知 H5 当前截屏操作
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // do somethings
//
//
//            });
//
//        }
//        else if ([call.callState isEqualToString:CTCallStateIncoming]) {// Call is incoming
//            NSLog(@"电话 --- 待接通");
//        }
//        else if ([call.callState isEqualToString:CTCallStateDialing]) {// Call is Dialing
//            NSLog(@"电话 --- 拨号中");
//            // 通知 H5 当前截屏操作
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                //                [weakSelf getFeedRemarkList];
//
//            });
//
//        }
//        else {// Nothing is done"
//            NSLog(@"电话 --- 无操作");
//        }
//    };
//}



















@end
