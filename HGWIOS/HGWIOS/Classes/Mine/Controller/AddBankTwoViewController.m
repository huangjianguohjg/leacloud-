//
//  AddBankTwoViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/2.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AddBankTwoViewController.h"
#import "AddBankView.h"

#import "BankViewController.h"
#import "AgreementViewController.h"
@interface AddBankTwoViewController ()

@property (nonatomic, weak) AddBankView * typeView;

@property (nonatomic, weak) AddBankView * phoneView;

@property (nonatomic, weak) AddBankView * identifyView;

@end

@implementation AddBankTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(234, 239, 245);
    
    self.navigationItem.title = @"添加银行卡";
    
    [self setUpUI];
    
}








-(void)setUpUI
{
    AddBankView * typeView = [[AddBankView alloc]init];
    typeView.leftLabel.text = @"卡类型";
    typeView.textField.text = self.bankName;
    typeView.textField.placeholder = @"卡类型";
    typeView.textField.userInteractionEnabled = NO;
    [self.view addSubview:typeView];
    [typeView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(realH(20) + kStatusBarHeight + kNavigationBarHeight);
        make.height.equalTo(realH(100));
    }];
    self.typeView = typeView;
    
    
    
    AddBankView * phoneView = [[AddBankView alloc]init];
    phoneView.leftLabel.text = @"手机号";
    phoneView.textField.placeholder = @"请输入银行预留手机号";
    phoneView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:phoneView];
    [phoneView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(typeView.bottom).offset(realH(40));
        make.height.equalTo(realH(100));
    }];
    self.phoneView = phoneView;
    
    
    AddBankView * identifyView = [[AddBankView alloc]init];
    identifyView.leftLabel.text = @"身份证号";
    identifyView.textField.placeholder = @"请输入身份证号";
//    identifyView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:identifyView];
    [identifyView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(phoneView.bottom).offset(realH(20));
        make.height.equalTo(realH(100));
    }];
    self.identifyView = identifyView;
    
    
    UILabel * rightlable = [UILabel lableWithTextColor:XXJColor(86, 154, 163) textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:@"《服务协议》"];
    rightlable.userInteractionEnabled = YES;
    rightlable.alpha = 0;
    [rightlable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableClick)]];
    [rightlable sizeToFit];
    [self.view addSubview:rightlable];
    [rightlable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(realW(-20));
        make.top.equalTo(self.identifyView.bottom).offset(realH(20));
    }];
    
    
    UILabel * agreelable = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:@"同意"];
    [agreelable sizeToFit];
    agreelable.alpha = 0;
    [self.view addSubview:agreelable];
    [agreelable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightlable.left).offset(realW(-10));
        make.top.equalTo(self.identifyView.bottom).offset(realH(20));
    }];
    
    
    UIButton * sureButton = [[UIButton alloc]init];
    [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.backgroundColor = XXJColor(27, 69, 138);
    sureButton.layer.cornerRadius = 5;
    sureButton.clipsToBounds = YES;
    sureButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:sureButton];
    
    [sureButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(agreelable.bottom).offset(realH(40));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
    
}


#pragma mark -- 协议
-(void)lableClick
{
    AgreementViewController * agreementVc = [[AgreementViewController alloc]init];
    [self.navigationController pushViewController:agreementVc animated:YES];
}


#pragma mark -- 确定
-(void)sureClick
{
    if ([GJCFStringUitil stringIsNull: self.phoneView.textField.text]) {
//        [self showErrorMessage:@"\"手机号\"不能为空！"];
        [self.view makeToast:@"手机号不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if (![GJCFStringUitil stringISValidateMobilePhone:self.phoneView.textField.text]) {
//        [self showErrorMessage:@"\"手机号\"输入不正确！"];
        [self.view makeToast:@"手机号输入不正确" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if ([GJCFStringUitil stringIsNull: self.identifyView.textField.text] ) {
//        [self showErrorMessage:@"\"身份证号\"不能为空！"];
        [self.view makeToast:@"身份证号不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if (![GJCFStringUitil stringISValidatePersonCardNumber:self.identifyView.textField.text] ) {
//        [self showErrorMessage:@"\"身份证号\"输入不正确！"];
        [self.view makeToast:@"身份证号输入不正确" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    
    //提交
    [self submit];
    
//    //银行卡验证 bankcard    银行卡号  realname    持卡人    idcard    身份证号
//    NSString *parameterstring = [NSString stringWithFormat:@"\"bankcard\":\"%@\",\"realname\":\"%@\",\"idcard\":\"%@\"",self.cardNo,self.cardName,self.identifyView.textField.text];
//
//    [XXJNetManager requestPOSTURLString:CardVerify URLMethod:CardVerifyMethod parameters:parameterstring finished:^(id result) {
//        [SVProgressHUD dismiss];
//        
//        XXJLog(@"%@",result)
//        if ([[result[@"result"] objectForKey:@"status"]boolValue]) {
//            //status 1
//            [self.view makeToast:result[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter];
//
//            //提交
//            [self submit];
//
//        }else{
//            //status 0
//            [self.view makeToast:result[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter];
//        }
//
//
//    } errored:^(NSError *error) {
//        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
//
//        [SVProgressHUD dismiss];
//    }];
//
    
}

-(void)submit
{
    //提交
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"cardholder\":\"%@\",\"card_no\":\"%@\",\"tel_no\":\"%@\",\"id_card\":\"%@\",\"card_type\":\"%@\",\"bank_name\":\"%@\",\"bank_name_ab\":\"%@\"",[UseInfo shareInfo].access_token,
                                 self.cardName,
                                 self.cardNo,
                                 self.phoneView.textField.text,
                                 self.identifyView.textField.text,
                                 self.cardType,
                                 self.bankName,
                                 self.banknameAB
                                 ];
    
    XXJLog(@"%@",parameterstring)
           
   [XXJNetManager requestPOSTURLString:BondCard URLMethod:BondCardMethod parameters:parameterstring finished:^(id result) {
       [SVProgressHUD dismiss];
       
       if ([[result[@"result"] objectForKey:@"status"]boolValue]) {
           [self.view makeToast:@"银行卡添加成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
//               BankViewController *BankVc=[[BankViewController alloc]init];
//               [self.navigationController pushViewController:BankVc animated:YES];
//               [self.navigationController popToRootViewControllerAnimated:YES];
               
               //复制就能用
               int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
               [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
               
           }];
       }else{
           [self.view makeToast:result[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter];
       }
       
       
   } errored:^(NSError *error) {
       [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
       
       [SVProgressHUD dismiss];
   }];
    
    
}




@end
