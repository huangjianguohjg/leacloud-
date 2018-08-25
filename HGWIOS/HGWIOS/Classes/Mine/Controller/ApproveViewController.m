//
//  ApproveViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ApproveViewController.h"

#import "JoinCompanyViewController.h"
#import "ApproveCompanyViewController.h"
#import "ApproveMessageView.h"
@interface ApproveViewController ()

@property (nonatomic, weak) UIButton * nextButton;

@property (nonatomic, weak) ApproveMessageView * identityView;

@property (nonatomic, weak) ApproveMessageView * nameView;

@property (nonatomic, weak) UILabel * alreadyLable;

@property (nonatomic, weak) UILabel * messageLable;

@property (nonatomic, strong) NSDictionary * infoDict;

@end

@implementation ApproveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"企业认证";
    
    [self setUpUI];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserInfo];
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
    [companyButton setTitle:self.chooseStr forState:UIControlStateNormal];
    [companyButton setTitleColor:XXJColor(99, 99, 99) forState:UIControlStateNormal];
    [companyButton setImage:[UIImage imageNamed:@"ins_number_02g"] forState:UIControlStateNormal];
    [companyButton setImage:[UIImage imageNamed:@"ins_number_02"] forState:UIControlStateSelected];
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
    
    
    
    //真实姓名
    ApproveMessageView * nameView = [[ApproveMessageView alloc]init];
    nameView.textField.placeholder = @"请填写您的真实姓名";
    [self.view addSubview:nameView];
    [nameView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.bottom).offset(realH(40));
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    self.nameView = nameView;
    
    //身份证号
    ApproveMessageView * identityView = [[ApproveMessageView alloc]init];
    identityView.leftLable.text = @"身份证号";
    identityView.textField.placeholder = @"请填写您的身份证号";
//    identityView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:identityView];
    [identityView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    self.identityView = identityView;
    
    
    UILabel * alreadyLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"已认证\n恭喜您,实名认证已通过!"];
    alreadyLable.textAlignment = NSTextAlignmentCenter;
    alreadyLable.alpha = 0;
    alreadyLable.numberOfLines = 0;
    [alreadyLable sizeToFit];
    [self.view addSubview:alreadyLable];
    [alreadyLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(identityView.bottom).offset(realW(60));
        make.centerX.equalTo(self.view);
        make.height.equalTo(realH(130));
        make.width.equalTo(SCREEN_WIDTH);
    }];
    self.alreadyLable = alreadyLable;
    
    
    
    UILabel * messageLable = [UILabel lableWithTextColor:XXJColor(136, 136, 136) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"请填写手机号实名登记的身份证信息。智慧油运的每位用户都是实名加入，我们承诺绝不泄露用户的任何信息。"];
    messageLable.numberOfLines = 0;
    [messageLable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [messageLable setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    messageLable.preferredMaxLayoutWidth = SCREEN_WIDTH - realW(100);
    [self.view addSubview:messageLable];
    [messageLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(identityView.bottom).offset(realW(100));
        make.right.equalTo(self.view).offset(realW(-50));
        make.left.equalTo(self.view).offset(realW(50));
    }];
    self.messageLable = messageLable;
    
    
    //下一步
    UIButton * nextButton = [[UIButton alloc]init];
    [nextButton addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.backgroundColor = XXJColor(27, 69, 138);
    nextButton.layer.cornerRadius = 5;
    nextButton.clipsToBounds = YES;
    nextButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:nextButton];
    [nextButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(messageLable.bottom).offset(realH(40));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    self.nextButton = nextButton;
    
    
    
    
    
    
    
    
    
    
    
}


#pragma mark -- 获取用户实名认证
-(void)getUserInfo
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    
    [XXJNetManager requestPOSTURLString:GetUserInfo URLMethod:GetUserInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        if ([result[@"result"][@"status"] boolValue]) {
            NSDictionary * infoDict = result[@"result"][@"users_authentication"];
            
            if (![infoDict isEqual:[NSNull null]]) {
                
                self.infoDict = infoDict;
                
                if ([infoDict[@"review"] isEqual:@1]) {
                    //待审核
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.alreadyLable.alpha = 1;
                        self.alreadyLable.text = @"正在审核中...";
                        [self.messageLable updateConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(self.identityView.bottom).offset(realW(230));
                        }];
                    });
                    
                    self.nameView.textField.text = infoDict[@"name"];
                    self.nameView.textField.userInteractionEnabled = NO;
                    self.identityView.textField.text = infoDict[@"id_no"];
                    self.identityView.textField.userInteractionEnabled = NO;
                }
                else if ([infoDict[@"review"] isEqual:@2])
                {
                    //已认证 通过
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.alreadyLable.alpha = 1;
                        
                        [self.messageLable updateConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(self.identityView.bottom).offset(realW(230));
                        }];
                    });
                    
                    self.nameView.textField.text = infoDict[@"name"];
                    self.nameView.textField.userInteractionEnabled = NO;
                    self.identityView.textField.text = infoDict[@"id_no"];
                    self.identityView.textField.userInteractionEnabled = NO;
                    
                    
//                    [self.view makeToast:@"实名认证已通过" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                    
//                    }];
                }
                else
                {
                    //未认证
                }
            }
            
            
        }
        else
        {
            [self.view makeToast:@"获取实名认证信息失败" duration:0.5 position:CSToastPositionCenter];
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}




#pragma mark -- 下一步
-(void)nextClick
{
    

    if ([self.infoDict[@"review"] isEqual:@2] || [self.infoDict[@"review"] isEqual:@1]) {
        if ([self.chooseStr isEqualToString:@"企业认证"]) {
            ApproveCompanyViewController * approveVc = [[ApproveCompanyViewController alloc]init];
            [self.navigationController pushViewController:approveVc animated:YES];
        }
        else
        {
            JoinCompanyViewController * joinVc = [[JoinCompanyViewController alloc]init];
            [self.navigationController pushViewController:joinVc animated:YES];
        }

        return;
    }
    
   
    
    
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"name\":\"%@\",\"idcard\":\"%@\"",[UseInfo shareInfo].access_token,self.nameView.textField.text,self.identityView.textField.text];
    
    [XXJNetManager requestPOSTURLString:SubmitUserInfo URLMethod:SubmitUserInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (![result[@"result"] isEqual:[NSNull null]]) {
            if ([result[@"result"][@"state"] isEqual:@2]) {
                [self.view makeToast:result[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                    if ([self.chooseStr isEqualToString:@"企业认证"]) {
                        ApproveCompanyViewController * approveVc = [[ApproveCompanyViewController alloc]init];
                        [self.navigationController pushViewController:approveVc animated:YES];
                    }
                    else
                    {
                        JoinCompanyViewController * joinVc = [[JoinCompanyViewController alloc]init];
                        [self.navigationController pushViewController:joinVc animated:YES];
                    }
                }];
            }
            else
            {
                [self.view makeToast:result[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        }
        
        
        
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    

    
    
    
    
}

















@end
