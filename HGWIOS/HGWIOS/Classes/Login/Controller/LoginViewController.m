//
//  LoginViewController.m
//  化运网ios
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 jiuze. All rights reserved.
//

#import "LoginViewController.h"
#import "InputView.h"

#import "HomeViewController.h"
#import "HomeGoodsViewController.h"
#import "ServeViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

#import "WebViewController.h"

@interface LoginViewController ()

@property (nonatomic, weak) InputView * phoneView;

@property (nonatomic, weak) InputView * codeView;

@property (nonatomic, weak) UIButton * boatButton;

@property (nonatomic, weak) UIButton * goodButton;

@property (nonatomic, weak) UIButton * loginButton;

@property (nonatomic, weak) UIButton * preButton;

@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,assign)int countDown; // 倒数计时用

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    


    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
    
    //界面初始化
    [self setUPUI];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)setUPUI
{
    
    UIImageView * topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_launcher"]];
    [self.view addSubview:topImageView];
    [topImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        if (isIPHONEX) {
            make.top.equalTo(self.view).offset(realH(320));
        }
        else
        {
            make.top.equalTo(self.view).offset(realH(220));
        }
        make.size.equalTo(CGSizeMake(realW(282), realH(282)));
    }];
    
    
    
    __weak typeof(self) weakSelf = self;
    //输入手机号
    InputView * phoneView = [[InputView alloc]init];
    phoneView.layer.cornerRadius = 10;
    phoneView.clipsToBounds = YES;
    phoneView.layer.borderWidth = realW(1);
    phoneView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:phoneView];
    [phoneView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.bottom).offset(realH(80));
        make.left.equalTo(self.view).offset(realW(40));
        make.right.equalTo(self.view).offset(realW(-40));
        make.height.equalTo(realH(120));
    }];
    self.phoneView = phoneView;
    
    
    //输入验证码
    InputView * codeView = [[InputView alloc]init];
    codeView.codeBlock = ^{
        
//        if (![NSString isValidatePhoneNum:weakSelf.phoneView.nameTextField.text]) {
        
//            [weakSelf.view makeToast:@"请输入正确的号码" duration:0.5 position:CSToastPositionCenter];
//            return ;
        
//        }
        
        //获取验证码
        [weakSelf getCode];
        
    };
    codeView.codeButton.alpha = 1;
    codeView.layer.cornerRadius = 10;
    codeView.clipsToBounds = YES;
    codeView.layer.borderWidth = realW(1);
    codeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [codeView.headImageView setImage:[UIImage imageNamed:@"login_icon_code"]];
    codeView.nameTextField.placeholder = @"请输入验证码";
    [self.view addSubview:codeView];
    [codeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.bottom).offset(realH(40));
        make.left.equalTo(self.view).offset(realW(40));
        make.right.equalTo(self.view).offset(realW(-40));
        make.height.equalTo(realH(120));
    }];
    self.codeView = codeView;
    
    
    UIButton * boatButton = [[UIButton alloc]init];
    boatButton.alpha = 0;
    [boatButton addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
    [boatButton setImage:[UIImage imageNamed:@"form_choose_no"] forState:UIControlStateNormal];
    [boatButton setImage:[UIImage imageNamed:@"form_choose_yes"] forState:UIControlStateSelected];
    [boatButton setTitle:@"船东" forState:UIControlStateNormal];
    boatButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(30)];
    [boatButton setTitleColor:XXJColor(107, 107, 107) forState:UIControlStateNormal];
    [boatButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [boatButton sizeToFit];
    [self.view addSubview:boatButton];
    [boatButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView.bottom).offset(realH(40));
        make.right.equalTo(self.view.centerX).offset(realW(-20));
    }];
    self.boatButton = boatButton;
    
    UIButton * goodButton = [[UIButton alloc]init];
    goodButton.alpha = 0;
    [goodButton addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
    [goodButton setImage:[UIImage imageNamed:@"form_choose_no"] forState:UIControlStateNormal];
    [goodButton setImage:[UIImage imageNamed:@"form_choose_yes"] forState:UIControlStateSelected];
    [goodButton setTitle:@"货主" forState:UIControlStateNormal];
    goodButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(30)];
    [goodButton setTitleColor:XXJColor(107, 107, 107) forState:UIControlStateNormal];
    [goodButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [goodButton sizeToFit];
    [self.view addSubview:goodButton];
    [goodButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(boatButton);
        make.left.equalTo(self.view.centerX).offset(realW(20));
    }];
    self.goodButton = goodButton;
    
    //登录
    UIButton * loginButton = [[UIButton alloc]init];
    [loginButton setTitle:@"登   录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Medium size:realFontSize(36)];
    loginButton.backgroundColor = XXJColor(27, 69, 138);
    loginButton.layer.cornerRadius = 5;
    loginButton.clipsToBounds = YES;
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.view);
        make.top.equalTo(codeView.bottom).offset(realH(60));
        make.right.left.equalTo(codeView);
        make.height.equalTo(realH(100));
    }];
    self.loginButton = loginButton;
    
    UILabel * bottomLable = [UILabel lableWithTextColor:[UIColor lightGrayColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"登录即代表您同意"];
    [bottomLable sizeToFit];
    [self.view addSubview:bottomLable];
    [bottomLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.bottom).offset(realH(60));
        make.centerX.equalTo(loginButton.centerX).offset(realW(-70));
    }];
    
    UILabel * vipLable = [UILabel lableWithTextColor:XXJColor(27, 69, 138) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"平台服务协议"];
    vipLable.userInteractionEnabled = YES;
    [vipLable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vipClick)]];
    [vipLable sizeToFit];
    [self.view addSubview:vipLable];
    [vipLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.bottom).offset(realH(60));
        make.left.equalTo(bottomLable.right);
    }];
    
    

}


#pragma mark -- 会员协议
-(void)vipClick
{
    [self aboutClick];
}

#pragma mark -- 获取验证码
-(void)getCode
{
    
    
//    NSDictionary * para = @{
//                            @"telephone" : self.phoneView.nameTextField.text
//                            };
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"telephone\":\"%@\"",self.phoneView.nameTextField.text];
    
    [SVProgressHUD show];
    
    
    [XXJNetManager requestPOSTURLString:PhoneCode URLMethod:PhoneCodeMethod parameters:parameterstring finished:^(id result) {
        XXJLog(@"%@",result)
        [SVProgressHUD dismiss];
        NSDictionary * dataDict = (NSDictionary *)result;
//        BOOL status = dataDict[@"result"][@"status"];
        if (![dataDict[@"result"][@"status"] boolValue]) {
            [self.view makeToast:dataDict[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
        }
        else
        {
            // 重置计时
            _countDown = 60;
            // 需要加入手动RunLoop，需要注意的是在NSTimer工作期间self是被强引用的
            _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
            // 使用NSRunLoopCommonModes才能保证RunLoop切换模式时，NSTimer能正常工作。
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];

}


#pragma mark -- 倒计时事件
-(void)timerFired:(NSTimer *)timer
{
    if (_countDown == 0) {
        [self stopTimer];
        [self.codeView.codeButton setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    else
    {
        _countDown -=1;
        
        [self.codeView.codeButton setTitle:[NSString stringWithFormat:@"%ds",_countDown] forState:UIControlStateNormal];
    }
}

#pragma mark -- 停止倒计时
- (void)stopTimer
{
    if (_timer) {
        [_timer invalidate];
    }
}







#pragma mark -- 登录按钮点击
-(void)loginClick
{
    if (self.phoneView.nameTextField.text.length == 0) {
        [self.view makeToast:@"请输入手机号" duration:0.5 position:CSToastPositionCenter];
        return ;
    }

    if (self.codeView.nameTextField.text.length == 0) {
        [self.view makeToast:@"请输入验证码" duration:0.5 position:CSToastPositionCenter];
        return ;
    }





    if (self.boatButton.selected == YES || self.goodButton.selected == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请确认选择该身份" message:@"选择之后无法修改" preferredStyle:UIAlertControllerStyleAlert ];
        //取消style:UIAlertActionStyleDefault
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alertController addAction:cancelAction];

        //简直废话:style:UIAlertActionStyleDestructive
        UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self chooseIdentifyRequest];
        }];
        [alertController addAction:rubbishAction];

        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        
        
        [self loginRequest];
    }

    
    
    
    
//    [self loginHome:@"找船"];
    
    
    
    
}



#pragma mark -- 登陆请求
-(void)loginRequest
{
//    NSDictionary * para = @{
//                            @"telephone" : self.phoneView.nameTextField.text,
//                            @"code" : self.codeView.nameTextField.text,
//                            @"client_id" : @"appclient",
//                            @"client_secret" : @"appsecret",
//                            @"source" : @"2"
//                            };
    [SVProgressHUD show];
    for (NSInteger i = 0; i<10000; i++) {
        
        if ([UseInfo shareInfo].cliendID) {
            XXJLog(@"有值了有值了有值了有值了有值了有值了%@",[UseInfo shareInfo].cliendID)
            break;
        }
        
    }
    
    
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"telephone\":\"%@\",\"code\":\"%@\",\"client_id\":\"appclient\",\"client_secret\":\"appsecret\",\"source\":\"2\",\"device_id\":\"%@\"",self.phoneView.nameTextField.text,
                                 self.codeView.nameTextField.text,[UseInfo shareInfo].cliendID];
    

    
    XXJLog(@"%@",parameterstring);
    

    
    
    [XXJNetManager requestPOSTURLString:LoginURL URLMethod:LoginURLMethod parameters:parameterstring finished:^(id result) {

        [SVProgressHUD dismiss];
        XXJLog(@"%@",result)
        NSDictionary * resultDict = (NSDictionary *)result;
        if (![resultDict[@"result"][@"status"] boolValue])
        {
            if ([resultDict[@"result"][@"msg"] isEqual:[NSNull null]]) {
                [self.view makeToast:@"登录失败" duration:0.5 position:CSToastPositionCenter];
            }
            else
            {
               [self.view makeToast:resultDict[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
            
            return ;
        }
        
        
        [UseInfo shareInfo].access_token = [self GetAccessToken:resultDict[@"result"][@"data"][@"id"]];
        
        [UseInfo shareInfo].uID = resultDict[@"result"][@"data"][@"id"];
        
        if ([resultDict[@"result"][@"data"][@"bussiness_type"] isEqualToString:@"-1"]) {
            //未选择身份
            //选择按钮的出现
            [self.view makeToast:@"首次登录请先选择身份" duration:0.5 position:CSToastPositionCenter];
            self.boatButton.alpha = 1;
            self.goodButton.alpha = 1;
            [self.loginButton updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.codeView.bottom).offset(realH(140));
            }];
        }
        else if ([resultDict[@"result"][@"data"][@"bussiness_type"] isEqualToString:@"1"])
        {
            //船东
            XXJLog(@"船东%@",resultDict[@"result"][@"data"][@"bussiness_type"])
            [UseInfo shareInfo].identity = @"船东";
            [self loginHome:@"找货"];
        }
        else if ([resultDict[@"result"][@"data"][@"bussiness_type"] isEqualToString:@"2"])
        {
            //货主
            XXJLog(@"货主%@",resultDict[@"result"][@"data"][@"bussiness_type"])
            [UseInfo shareInfo].identity = @"货主";
            [self loginHome:@"找船"];
        }
        


    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}



#pragma mark -- 选择身份
-(void)chooseIdentifyRequest
{
    NSString * idStr = nil;
    if (self.boatButton.selected) {
        idStr = @"1";
    }
    else if (self.goodButton.selected)
    {
        idStr = @"2";
    }
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"identity\":\"%@\"",[UseInfo shareInfo].access_token,idStr];
    
    [SVProgressHUD show];
    [XXJNetManager requestPOSTURLString:ChooseIdentity URLMethod:ChooseIdentityMethod parameters:parameterstring finished:^(id result) {
        XXJLog(@"%@",result)
        
        NSDictionary * resultDict = (NSDictionary *)result;
//        [SVProgressHUD showWithStatus:resultDict[@"result"][@"msg"]];
        [SVProgressHUD dismissWithDelay:1.0];
        if ([resultDict[@"result"] isEqual:[NSNull null]]) {
            self.boatButton.selected = NO;
            self.goodButton.selected = NO;
            return ;
        }
        
        if ([resultDict[@"result"][@"status"] boolValue]) {
            //进入首页
            if (self.boatButton.selected) {
                //找船
                [self loginHome:@"找货"];
                [UseInfo shareInfo].identity = @"船东";
            }
            else if (self.goodButton.selected)
            {
                //找货
                [self loginHome:@"找船"];
                [UseInfo shareInfo].identity = @"货主";
            }
            
            
            self.boatButton.selected = NO;
            self.goodButton.selected = NO;
        }
        else
        {
            [self.view makeToast:resultDict[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}





-(void)loginHome:(NSString * )status
{
    XXJNavgationController *homeNAV = nil;
    if ([status isEqualToString:@"找船"]) {
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
    
//    /********************/
//    XXJNavgationController * homeNAV = [[XXJNavgationController alloc]initWithRootViewController:[[HomeViewController alloc]init]];
//    homeNAV.tabBarItem.title = @"找船";
//    homeNAV.tabBarItem.image = [[UIImage imageNamed:@"zc_false"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    homeNAV.tabBarItem.selectedImage = [[UIImage imageNamed:@"zc_true"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//
//
//
//    XXJNavgationController * homeNAV1 = [[XXJNavgationController alloc]initWithRootViewController:[[HomeGoodsViewController alloc]init]];
//    homeNAV1.tabBarItem.title = @"找货";
//    homeNAV1.tabBarItem.image = [[UIImage imageNamed:@"zh_false"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    homeNAV1.tabBarItem.selectedImage = [[UIImage imageNamed:@"zh_true"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//     /********************/
    
    
    
    
    
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
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarVc;
}





#pragma mark -- 按钮选择
-(void)chooseClick:(UIButton *)button
{
    self.preButton.selected = NO;
    button.selected = YES;
    self.preButton = button;
}



- (NSString *)GetAccessToken:(NSString *)userId{
    NSString *result = [[NSString alloc]init];
    NSString *key = @"9ced44bd";
    //用户名加密
    if (userId == nil || userId.length <1) {
        return @"";
    }
    NSString *username = userId;
    long useridLength = [username length];
    if (useridLength < 10) {
        long othermi = 10 - useridLength;
        for (int i = 0; i < othermi; i++) {
            username =[username stringByAppendingString: @"*"];
        }
        username =[username stringByAppendingString: @"456"];
    }
    Crypt *crypt = [[Crypt alloc]init];
    NSString *useridencode= [crypt encryptUseDES:username key:key];
    
    //时间戳加密
    NSTimeInterval intervalsince =[[NSDate date] timeIntervalSince1970];
    
    NSString *timeinput = [NSString stringWithFormat:@"%d",(int)intervalsince];
    NSString *timeencode= [crypt encryptUseDES:timeinput key:key];
    
    NSString *oldValue = [NSString stringWithFormat:@"%@%@%@",userId,timeinput,@"haoyunhl"];    //md5加密
    NSString *md5Value = [MD5 md5HexDigest:oldValue];
    result = [NSString stringWithFormat:@"%@%@%@",useridencode,timeencode,md5Value];    //md5加密
    return  result;
}



-(void)aboutClick
{
    NSString *parameterstring =  @"\"catalog_identity\":\"content_member\",\"max\":\"10\",\"page\":\"1\"";
    
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

























@end
