//
//  AppDelegate.m
//  HGWIOS
//
//  Created by Developer on 2018/5/14.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "HomeGoodsViewController.h"
#import "ServeViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
#import "MyBoatViewController.h"
#import "AlreadyOfferViewController.h"
#import "AdminViewController.h"
#import "WebViewController.h"
#import "TalkingData.h"
#import <GTSDK/GeTuiSdk.h>
#import "EBBannerView.h"
#import "KSGuaidViewManager.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#import "MyTransportViewController.h"
#import "GoodsDetailViewController.h"
#import "MyGoodsViewController.h"

#import "MyTransDetailViewController.h"
@interface AppDelegate ()<GeTuiSdkDelegate,UNUserNotificationCenterDelegate>
@property(strong,nonatomic) BMKMapManager* mapManager;
// 用来判断是否是通过点击通知栏开启（唤醒）APP
@property (nonatomic) BOOL isLaunchedByNotification;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerDidClick:) name:EBBannerViewDidClickNotification object:nil];
    
    
//    //1.APP在未运行，已杀死进程的状态，远程推送过来消息
//    NSDictionary *remoteDic = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    XXJLog(@"remoteDic= = %@", remoteDic);
//    if (remoteDic) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSDictionary * playloadDict = remoteDic[@"payload"];
//            NSString * type = playloadDict[@"type"];
//
//            [self jumpToVcType:type CargoID:playloadDict[@"cargo_id"] Dict:playloadDict];
//
//        });
//
//    }
    
    
    
  
    
    NSString * firstLogin = [UseInfo shareInfo].firstLogin;
    if (firstLogin == nil) {
        [UseInfo shareInfo].firstLogin = @"是";
        
        KSGuaidManager.images = @[[UIImage imageNamed:@"guid1"],
                                  [UIImage imageNamed:@"guid2"],
                                  [UIImage imageNamed:@"guid3"],
                                  ];
//        KSGuaidManager.shouldDismissWhenDragging = YES;
      
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        
        KSGuaidManager.dismissButtonImage = [UIImage imageNamed:@"hidden"];
        
        KSGuaidManager.dismissButtonCenter = CGPointMake(size.width / 2, size.height - 40);
        
        KSGuaidManager.pageIndicatorTintColor = [UIColor clearColor];
        KSGuaidManager.currentPageIndicatorTintColor = [UIColor clearColor];
        
        [KSGuaidManager begin];
    }
    else
    {
        if ([firstLogin isEqualToString:@"是"]) {
            [UseInfo shareInfo].firstLogin = @"不是";
        }
    }
    
    
    
    //个推配置
    // [ GTSdk ]：是否运行电子围栏Lbs功能和是否SDK主动请求用户定位
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    
    // [ GTSdk ]：自定义渠道
    [GeTuiSdk setChannelId:@"GT-Channel"];
    
    // [ GTSdk ]：使用APPID/APPKEY/APPSECRENT启动个推
    [GeTuiSdk startSdkWithAppId:@"qcGFwTHvDE7IabINjNJHc4" appKey:@"HIjKRXwSUR65OIaxQc2qR4" appSecret:@"5dB40i4qCH7SoHqhRuMKm" delegate:self];
    
    // 注册APNs - custom method - 开发者自定义的方法
    [self registerRemoteNotification];
    
    //Talking Data APPID
    //2C3641372D704EB98C06B3BC9410E6C5
    [TalkingData sessionStarted:@"2C3641372D704EB98C06B3BC9410E6C5" withChannelId:@"AppStore"];
    
    
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    
    //请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"0q1eTSP3jh9K5bXE2OuCssY1VFanypTN"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    if ([UseInfo shareInfo].access_token) {
        XXJNavgationController *homeNAV = nil;
        if ([[UseInfo shareInfo].identity isEqualToString:@"货主"]) {
            homeNAV = [[XXJNavgationController alloc]initWithRootViewController:[[HomeViewController alloc]init]];
            homeNAV.tabBarItem.title = @"找船";
            homeNAV.tabBarItem.image = [[UIImage imageNamed:@"zc_false"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            homeNAV.tabBarItem.selectedImage = [[UIImage imageNamed:@"zc_true"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        else
        {
            homeNAV = [[XXJNavgationController alloc]initWithRootViewController:[[HomeGoodsViewController alloc]init]];
            homeNAV.tabBarItem.title = @"找货";
            homeNAV.tabBarItem.image = [[UIImage imageNamed:@"zh_false"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            homeNAV.tabBarItem.selectedImage = [[UIImage imageNamed:@"zh_true"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        
        
        XXJNavgationController * serveNAV = [[XXJNavgationController alloc]initWithRootViewController:[[ServeViewController alloc] init]];
        serveNAV.tabBarItem.title = @"服务";
        serveNAV.tabBarItem.image = [[UIImage imageNamed:@"fw_false"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        serveNAV.tabBarItem.selectedImage = [[UIImage imageNamed:@"fw_true"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        
        XXJNavgationController * messageNAV = [[XXJNavgationController alloc]initWithRootViewController:[[MessageViewController alloc] init]];
        messageNAV.tabBarItem.title = @"消息";
        messageNAV.tabBarItem.image = [[UIImage imageNamed:@"xx_false"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        messageNAV.tabBarItem.selectedImage = [[UIImage imageNamed:@"xx_true"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        XXJNavgationController * mineNAV = [[XXJNavgationController alloc]initWithRootViewController:[[MineViewController alloc] init]];
        mineNAV.tabBarItem.title = @"我的";
        mineNAV.tabBarItem.image = [[UIImage imageNamed:@"wd_false"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        mineNAV.tabBarItem.selectedImage = [[UIImage imageNamed:@"wd_true"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarController * tabbarVc = [[UITabBarController alloc]init];
        tabbarVc.tabBar.tintColor = XXJColor(92, 114, 159);
        tabbarVc.viewControllers = @[homeNAV,serveNAV,messageNAV,mineNAV];
        self.window.rootViewController = tabbarVc;
        
    }
    else
    {
        LoginViewController * loginVc = [[LoginViewController alloc]init];
        XXJNavgationController * nav = [[XXJNavgationController alloc]initWithRootViewController:loginVc];
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = nav;
    }
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(void)applicationWillResignActive:(UIApplication *)application
{
    
    
    
}


#pragma mark - 用户通知(推送) _自定义方法

/** 注册远程通知 */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            center.delegate = self;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
                if (!error) {
                    NSLog(@"request authorization succeeded!");
                }
            }];
        } else {
            // Fallback on earlier versions
        }
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}
#pragma mark - 远程通知(推送)回调

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    // [ GTSdk ]：向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    [_viewController logMsg:[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]]];
    
    NSLog(@"---个推注册失败---");
    //注册失败通知个推服务器
    [GeTuiSdk registerDeviceToken:@""];
}

#pragma mark - iOS 10中收到推送消息

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"APP_ENTER_IN_FOREGROUND");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"APP_ENTER_IN_FOREGROUND" object:nil];
    [application setApplicationIconBadgeNumber:0];
    //角标复位
    [GeTuiSdk resetBadge];
}







/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId
{
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@">>>[GeTuiSdk RegisterClient]:----%@", clientId);
    // 将clientId写入本地
//    [USER_DEFAULT setObject:clientId forKey:kPushClientId];
    [UseInfo shareInfo].cliendID = clientId;
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error
{
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>[GTSdk error]:%@\n\n", [error localizedDescription]);
}


/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    
    
//    NSString * payloadStr = [[NSString alloc]initWithData:payloadData encoding:NSUTF8StringEncoding];
//    NSData * data = [payloadStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * payloadDict = [NSJSONSerialization JSONObjectWithData:payloadData options:NSJSONReadingMutableContainers error:nil];
    
    
    XXJLog(@"%@XXXXXXXX%@",payloadData,payloadDict)
    
    [UseInfo shareInfo].getuiDict = payloadDict;
    
    if (offLine) {
        
    }
    else
    {
        [EBBannerView showWithContent:payloadDict[@"content"]];
        [EBBannerView clearMemories];
    }
    
    
    
    
//    // 1.创建本地通知
//    UILocalNotification *localNote = [[UILocalNotification alloc] init];
//
//    // 2.设置本地通知的内容
//    // 2.1.设置通知发出的时间
//    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
//    // 2.2.设置通知的内容
//    localNote.alertBody = payloadDict[@"content"];
//    // 2.3.设置滑块的文字（锁屏状态下：滑动来“解锁”）
////    localNote.alertAction = @"解锁";
//    // 2.4.决定alertAction是否生效
//    localNote.hasAction = NO;
//    // 2.7.设置有通知时的音效
////    localNote.soundName = @"buyao.wav";
//
//    // 2.8.设置额外信息
//    localNote.userInfo = payloadDict[@"payload"];
//    // 3.调用通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
    
    
    
}


-(void)bannerDidClick:(NSNotification*)noti
{
    XXJLog(@"31312312312312%@========%@*********%@",[self currentViewController],noti.object,[UseInfo shareInfo].getuiDict)
    
    NSDictionary * dict = [UseInfo shareInfo].getuiDict;
    
    NSString * type = dict[@"payload"][@"type"];
    
    if ([UseInfo shareInfo].identity == nil) {
        [[self currentViewController].view makeToast:@"请先登录" duration:1.0 position:CSToastPositionCenter];
    }
    else
    {
        [self jumpToVcType:type CargoID:dict[@"payload"][@"cargo_id"] Dict:dict[@"payload"]];
    }
    
    
    

    
}



#pragma mark -- 点击通知出发的方法

//ios 8 - 10  点击本地推送 触发的方法
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    XXJLog(@"noti:%@",notification);
//    NSDictionary *dic = notification.userInfo;

//    [[[[UIApplication sharedApplication] delegate] window].rootViewController.view makeToast:@"点击了" duration:1.0 position:CSToastPositionCenter];

}

//*iOS 8 - 10   点击远程消息推送 *
/** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台)  */
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
//{
//    //此时 App 在后台点击通知栏进去前台 这里可做进入前台操作
//    //app 进去前台 icon角标显示数为0 并且发送个推服务器
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    [GeTuiSdk setBadge:0];
//
//    // [ GTSdk ]：将收到的APNs信息传给个推统计
//    [GeTuiSdk handleRemoteNotification:userInfo];
//    // [4-EXT]:处理APN
//    NSString *record = [NSString stringWithFormat:@"App运行在后台/App运行在前台[APN]%@, %@", [NSDate date], userInfo];
//    NSLog(@"%@", record);
//
//    completionHandler(UIBackgroundFetchResultNewData);
//    self.isLaunchedByNotification = YES;
//
//
//    // 应用在前台。
//    if (application.applicationState == UIApplicationStateActive) {
//        {
//        }
//    }
//    //后台状态下，直接跳转到跳转页面。
//    if (application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground)
//    {
//        //后端推送
//
//        NSDictionary * playloadDict = userInfo[@"payload"];
//        NSString * type = playloadDict[@"type"];
//
//        [self jumpToVcType:type CargoID:playloadDict[@"cargo_id"] Dict:playloadDict];
//
//    }
//
//
//}


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//  *iOS10 之后点击远程推送的方法 包括本地推送 *
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    
    
    //角标复位
    [GeTuiSdk resetBadge];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    
    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    completionHandler();
    
    //获取消息中传递的参数
    NSDictionary * dict = [[NSDictionary alloc]initWithDictionary:response.notification.request.content.userInfo];
    
    NSDictionary * playloadDict = dict[@"payload"];
    NSString * type = playloadDict[@"type"];
    
    if ([UseInfo shareInfo].identity) {
        [self jumpToVcType:type CargoID:playloadDict[@"cargo_id"] Dict:playloadDict];
    }
    
    
    
}

////  iOS 10: App在前台获取到通知
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
//
//    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
//
//    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
//    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
//
//    //获取消息中传递的参数
//    NSDictionary * dict = [[NSDictionary alloc]initWithDictionary:notification.request.content.userInfo];
//
//}
//


#endif


-(void)applicationWillTerminate:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}






#pragma mark -- 界面跳转
-(void)jumpToVcType:(NSString *)type CargoID:(NSString *)cargoID Dict:(NSDictionary *)dict
{
    if ([type isEqualToString:@"2"]) {
//        MyTransportViewController * mytrainsportVc = [[MyTransportViewController alloc]init];
//        //            mytrainsportVc.fromTag = @"消息";
//        mytrainsportVc.hidesBottomBarWhenPushed = YES;
//        [[self currentViewController].navigationController pushViewController:mytrainsportVc animated:YES];
        
        MyTransDetailViewController * myTransDetailVc = [[MyTransDetailViewController alloc]init];
        myTransDetailVc.cargo_id = cargoID;
        myTransDetailVc.detail_id = dict[@"payload"][@"deal_id"];
        myTransDetailVc.hidesBottomBarWhenPushed = YES;
        [[self currentViewController].navigationController pushViewController:myTransDetailVc animated:YES];
        
    }
    else if ([type isEqualToString:@"4"])
    {
        GoodsDetailViewController * goodsVc = [[GoodsDetailViewController alloc]init];
//        goodsVc.idStr = dict[@"payload"][@"cargo_id"];
        goodsVc.idStr = cargoID;
        goodsVc.fromTag = @"找货";
        goodsVc.hidesBottomBarWhenPushed = YES;
        [[self currentViewController].navigationController pushViewController:goodsVc animated:YES];
    }
    else if ([type isEqualToString:@"3"])
    {
        //
        MyGoodsViewController * vc = [[MyGoodsViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [[self currentViewController].navigationController pushViewController:vc animated:YES];
    }
    else if ([type isEqualToString:@"5"])
    {
        //我的船舶
        MyBoatViewController * myBoatVc = [[MyBoatViewController alloc]init];
        myBoatVc.hidesBottomBarWhenPushed = YES;
        [[self currentViewController].navigationController pushViewController:myBoatVc animated:YES];
    }
    else if ([type isEqualToString:@"6"])
    {
        //我的报价
        AlreadyOfferViewController * vc = [[AlreadyOfferViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [[self currentViewController].navigationController pushViewController:vc animated:YES];
    }
    else if ([type isEqualToString:@"7"])
    {
        //加油
        WebViewController * webVc = [[WebViewController alloc]init];
        webVc.link = @"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/ship_oil/2";
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.titleStr = @"船舶加油";
        [[self currentViewController].navigationController pushViewController:webVc animated:YES];
    }
    else if ([type isEqualToString:@"8"])
    {
        //加水
        WebViewController * webVc = [[WebViewController alloc]init];
        webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/ship_water/uid/%@/type/2",[UseInfo shareInfo].uID];
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.titleStr = @"船舶加水";
        [[self currentViewController].navigationController pushViewController:webVc animated:YES];
    }
    else if ([type isEqualToString:@"9"])
    {
        //洗舱
        WebViewController * webVc = [[WebViewController alloc]init];
        webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/ship_wching/uid/%@/type/2",[UseInfo shareInfo].uID];
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.titleStr = @"船舶洗舱";
        [[self currentViewController].navigationController pushViewController:webVc animated:YES];
    }
    else if ([type isEqualToString:@"10"])
    {
        //修船订单
        WebViewController * webVc = [[WebViewController alloc]init];
        webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/ship_repair/uid/%@/type/2",[UseInfo shareInfo].uID];
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.titleStr = @"船舶修理";
        [[self currentViewController].navigationController pushViewController:webVc animated:YES];
    }
    else if ([type isEqualToString:@"11"])
    {
        //代理订单
        WebViewController * webVc = [[WebViewController alloc]init];
        webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/port_agent/uid/%@/type/2",[UseInfo shareInfo].uID];
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.titleStr = @"港口代理";
        [[self currentViewController].navigationController pushViewController:webVc animated:YES];
    }
    else if ([type isEqualToString:@"12"])
    {
        //船员劳务订单
        WebViewController * webVc = [[WebViewController alloc]init];
        webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/labour_services/uid/%@/type/2",[UseInfo shareInfo].uID];
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.titleStr = @"船员劳务";
        [[self currentViewController].navigationController pushViewController:webVc animated:YES];
    }
    else if ([type isEqualToString:@"13"])
    {
        //船员培训订单
        WebViewController * webVc = [[WebViewController alloc]init];
        webVc.link = [NSString stringWithFormat:@"http://www.e-huayun.com/zyhl/index.php?s=Home/Publicapp/crew_training/uid/%@/type/2",[UseInfo shareInfo].uID];
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.titleStr = @"船员培训";
        [[self currentViewController].navigationController pushViewController:webVc animated:YES];
    }
    else if ([type isEqualToString:@"14"])
    {
        //企业管理
        AdminViewController * adminVc = [[AdminViewController alloc]init];
        adminVc.hidesBottomBarWhenPushed = YES;
        [[self currentViewController].navigationController pushViewController:adminVc animated:YES];
    }
    else
    {
        //我的界面
        [self currentViewController].tabBarController.selectedViewController = [[self currentViewController].tabBarController.viewControllers objectAtIndex:3];
        
        [[self currentViewController].navigationController popToRootViewControllerAnimated:NO];
    }
}



@end
