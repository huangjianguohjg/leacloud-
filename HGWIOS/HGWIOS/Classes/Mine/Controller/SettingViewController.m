//
//  SettingViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingView.h"
#import "WebViewController.h"
#import "LoginViewController.h"
@interface SettingViewController ()

@property (nonatomic, weak) SettingView * versionView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"设置";
    
    [self setUpUI];
    
    [self getVersion];
    
}

-(void)getVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    if (currentVersion.length == 3) {
        currentVersion = [currentVersion stringByAppendingString:@".0"];
    }
    
    self.versionView.versionsLable.text = currentVersion;
    XXJLog(@"%@",currentVersion)
    
}




-(void)setUpUI
{
    SettingView * aboutView = [[SettingView alloc]init];
    [aboutView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutClick)]];
    aboutView.titleLable.text = @"关于我们";
    aboutView.arrowImageView.alpha = 1;
    [self.view addSubview:aboutView];
    [aboutView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(90));
    }];
    
    
    SettingView * versionView = [[SettingView alloc]init];
    versionView.titleLable.text = @"当前版本";
    versionView.versionsLable.alpha = 1;
    [self.view addSubview:versionView];
    [versionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(90));
        make.top.equalTo(aboutView.bottom);
    }];
    self.versionView = versionView;
    
    UIButton * turnoffButton = [[UIButton alloc]init];
    [turnoffButton addTarget:self action:@selector(offClick) forControlEvents:UIControlEventTouchUpInside];
    [turnoffButton setTitle:@"退出当前用户" forState:UIControlStateNormal];
    [turnoffButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    turnoffButton.backgroundColor = XXJColor(27, 69, 138);
    turnoffButton.layer.cornerRadius = 5;
    turnoffButton.clipsToBounds = YES;
    turnoffButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:turnoffButton];
    
    [turnoffButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(versionView.bottom).offset(realH(40));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
     
}

//关于我们
-(void)aboutClick
{
    NSString *parameterstring =  @"\"catalog_identity\":\"content_about\",\"max\":\"10\",\"page\":\"1\"";
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:AboutUS URLMethod:AboutUSMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        if (![result isEqual:[NSNull null]]) {
            if (![result[@"result"] isEqual:[NSNull null]]) {
                if (![result[@"result"][@"list"] isEqual:[NSNull null]]) {
                    WebViewController * webVc = [[WebViewController alloc]init];
                    webVc.link = result[@"result"][@"list"][0][@"link"];
                    webVc.titleStr = @"详情";
                    [self.navigationController pushViewController:webVc animated:YES];
                    
                    
                }
            }
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}



//退出
-(void)offClick
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    LoginViewController * loginVc = [[LoginViewController alloc]init];
    XXJNavgationController * nav = [[XXJNavgationController alloc]initWithRootViewController:loginVc];
    
//    UITabBarController * tabbarVc = [[UITabBarController alloc]init];
//    tabbarVc.tabBar.tintColor = XXJColor(92, 114, 159);
//    tabbarVc.viewControllers = @[nav];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    
    [[UseInfo shareInfo] clearInfo];
    
}





@end
