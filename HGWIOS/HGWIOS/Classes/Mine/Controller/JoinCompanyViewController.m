//
//  JoinCompanyViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "JoinCompanyViewController.h"

#import "ApproveCompanyViewController.h"

#import "ApproveMessageView.h"
@interface JoinCompanyViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) ApproveMessageView * phoneView;

@property (nonatomic, weak) ApproveMessageView * nameView;

@property (nonatomic, weak) UILabel * alreadyLable;

@property (nonatomic, weak) UIButton * applyButton;

@end

@implementation JoinCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    
    [self setUpUI];
    
    [self companyStatus];
}


-(void)setUpNav
{
    self.navigationItem.title = @"加入企业";
    
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
//    [self.navigationController popToRootViewControllerAnimated:YES];
    //复制就能用
    int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
    
//
//    [self.navigationController popToViewController:self.viewControllers.count - 2 animated:YES];
}



-(void)setUpUI
{
    //实名认证
    UIButton * nameButton = [[UIButton alloc]init];
    [nameButton setTitle:@"实名认证" forState:UIControlStateNormal];
    [nameButton setTitleColor:XXJColor(99, 99, 99) forState:UIControlStateNormal];
    [nameButton setImage:[UIImage imageNamed:@"ins_number_01"] forState:UIControlStateNormal];
    [nameButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:realH(20)];
    nameButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [nameButton sizeToFit];
    [self.view addSubview:nameButton];
    [nameButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(realH(100) + kStatusBarHeight + kNavigationBarHeight);
        make.right.equalTo(self.view.centerX).offset(realW(-80));
    }];
    
    //企业认证
    UIButton * companyButton = [[UIButton alloc]init];
    [companyButton setTitle:@"加入企业" forState:UIControlStateNormal];
    [companyButton setTitleColor:XXJColor(99, 99, 99) forState:UIControlStateNormal];
//    [companyButton setImage:[UIImage imageNamed:@"ins_number_02g"] forState:UIControlStateNormal];
    [companyButton setImage:[UIImage imageNamed:@"ins_number_02"] forState:UIControlStateNormal];
    [companyButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:realH(20)];
    companyButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [companyButton sizeToFit];
    [self.view addSubview:companyButton];
    [companyButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(realH(100) + kStatusBarHeight + kNavigationBarHeight);
        make.left.equalTo(self.view.centerX).offset(realW(80));
    }];
    
    UIView * centerLine = [[UIView alloc]init];
    centerLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:centerLine];
    [centerLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(nameButton);
        make.size.equalTo(CGSizeMake(realW(100), realH(1)));
    }];
    
    UIView * bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = XXJColor(245, 245, 245);
    [self.view addSubview:bottomLine];
    [bottomLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(nameButton.bottom).offset(realH(80));
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - realW(100), realH(1)));
    }];
    
    
    
    //管理员手机号
    ApproveMessageView * phoneView = [[ApproveMessageView alloc]init];
    phoneView.leftLable.text = @"管理员手机号";
    phoneView.textField.placeholder = @"请填公司管理员手机号";
    phoneView.textField.delegate = self;
    [self.view addSubview:phoneView];
    [phoneView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.bottom).offset(realH(40));
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    self.phoneView = phoneView;
    
    //身份证号
    ApproveMessageView * nameView = [[ApproveMessageView alloc]init];
    nameView.leftLable.text = @"公司名称";
    nameView.textField.placeholder = @"输入管理员号码后，自动查询";
    nameView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:nameView];
    [nameView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    self.nameView = nameView;
    
    UILabel * alreadyLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"您已是该企业成员"];
    alreadyLable.textAlignment = NSTextAlignmentCenter;
    alreadyLable.alpha = 0;
    alreadyLable.numberOfLines = 0;
    [alreadyLable sizeToFit];
    [self.view addSubview:alreadyLable];
    [alreadyLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.bottom).offset(realW(60));
        make.centerX.equalTo(self.view);
        make.height.equalTo(realH(130));
        make.width.equalTo(SCREEN_WIDTH);
    }];
    self.alreadyLable = alreadyLable;
    
    
    //立即申请
    UIButton * applyButton = [[UIButton alloc]init];
    [applyButton addTarget:self action:@selector(applyClick) forControlEvents:UIControlEventTouchUpInside];
    [applyButton setTitle:@"立即申请" forState:UIControlStateNormal];
    [applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    applyButton.backgroundColor = XXJColor(27, 69, 138);
    applyButton.layer.cornerRadius = 5;
    applyButton.clipsToBounds = YES;
    applyButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:applyButton];
    [applyButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(nameView.bottom).offset(realH(40));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    self.applyButton = applyButton;
}



-(void)companyStatus
{
 
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetCompanyStatus URLMethod:GetCompanyStatusMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result);
        
        if ([result[@"result"][@"status"] boolValue]) {
            
            id x = result[@"result"][@"data"];
            if (![x isKindOfClass:[NSString class]]) {
                NSDictionary * dataDict = result[@"result"][@"data"];
                
                self.alreadyLable.alpha = 1;
                self.applyButton.alpha = 0;
                if (dataDict) {
                    self.phoneView.textField.text = dataDict[@"mobile"];
                    self.nameView.textField.text = dataDict[@"enterprise"];
                }
                
                
                self.phoneView.textField.userInteractionEnabled = NO;
                self.nameView.textField.userInteractionEnabled = NO;
            }
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
    
}







-(void)applyClick
{
    if (self.phoneView.textField.text.length == 0) {
        [self.view makeToast:@"请填写手机号" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    if (self.nameView.textField.text.length == 0) {
        [self.view makeToast:@"请填写公司名称" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"mobilephone\":\"%@\",\"enterprisename\":\"%@\"",[UseInfo shareInfo].access_token,self.phoneView.textField.text,self.nameView.textField.text];
    
    [XXJNetManager requestPOSTURLString:JoinCompany URLMethod:JoinCompanyMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result);
        
        [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"mobile\":\"%@\"",self.phoneView.textField.text];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:CompanyName URLMethod:CompanyNameMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
        if (result[@"result"][@"data"]) {
            self.nameView.textField.text = result[@"result"][@"data"];
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}






@end
