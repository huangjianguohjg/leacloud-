//
//  PayBondViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "PayBondViewController.h"

@interface PayBondViewController ()

@property (nonatomic, weak) UITextField * textField;

@end

@implementation PayBondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(242, 242, 242);
    

    self.navigationItem.title = self.titleStr;
    
    [self setUpUI];
    
}



-(void)setUpUI
{
    UIView * topView = [[UIView alloc]init];
    topView.alpha = 0;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(80));
    }];
    
    
    UILabel * bondLable = [UILabel lableWithTextColor:XXJColor(117, 117, 117) textFontSize:realFontSize(40) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"对方已支付履约保证金%@元。",self.payBond]];
    bondLable.alpha = 0;
    [bondLable sizeToFit];
    [topView addSubview:bondLable];
    [bondLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(topView).offset(realW(20));
    }];
    
    if (self.payBond) {
        topView.alpha = 1;
        bondLable.alpha = 1;
    }
    
    
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView makeConstraints:^(MASConstraintMaker *make) {
        if (self.payBond) {
            make.top.equalTo(topView.bottom);
        }
        else
        {
            make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        }
        
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(150));
    }];
    
    NSString * payStr = [self.titleStr substringFromIndex:2];
    
    
    UILabel * payLable = [UILabel lableWithTextColor:XXJColor(117, 117, 117) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"%@:",payStr]];
    [payLable sizeToFit];
    [backView addSubview:payLable];
    [payLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.left.equalTo(backView).offset(realW(20));
    }];
    
    UITextField * textField = [[UITextField alloc]init];
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    textField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    textField.placeholder = [NSString stringWithFormat:@"请输入已%@金额",self.titleStr];
    textField.layer.borderColor = XXJColor(247, 247, 247).CGColor;
    textField.layer.borderWidth = realW(1);
    [backView addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(realW(200));
        make.centerY.equalTo(backView);
        make.right.equalTo(backView).offset(realW(-20));
        make.height.equalTo(realH(60));
    }];
    self.textField = textField;
    
    UILabel * remindLable = [UILabel lableWithTextColor:[UIColor lightGrayColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"履约保证金退回可在运单状态中查看"];
    remindLable.numberOfLines = 0;
    remindLable.lineBreakMode = NSLineBreakByCharWrapping;
    remindLable.textAlignment = NSTextAlignmentCenter;
    [remindLable sizeToFit];
    [self.view addSubview:remindLable];
    [remindLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.bottom).offset(realH(10));
        make.centerX.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH - realW(40));
    }];
    
    
    
    UIButton * addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"提交" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.backgroundColor = XXJColor(27, 69, 138);
    addButton.layer.cornerRadius = 5;
    addButton.clipsToBounds = YES;
    addButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:addButton];
    [addButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(remindLable.bottom).offset(realH(40));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
}

-(void)addClick
{
    if (self.textField.text.length == 0) {
        [self.view makeToast:@"请输入已支付金额" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if ([self.titleStr containsString:@"履约"]) {
        [self bondPay];
    }
    else
    {
        [self freightPay];
    }
    
    
    
}

//支付履约保证金
-(void)bondPay
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"business_type\":\"%@\",\"bond\":\"%@\",\"deal_id\":\"%@\"",
                                 [UseInfo shareInfo].access_token,
                                 [[UseInfo shareInfo].identity isEqual:@"船东"] ? @"1" : @"0",
                                 self.textField.text,
                                 self.cargo_id
                                 ];
    
    [XXJNetManager requestPOSTURLString:TransportDeal URLMethod:PayBondMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"][@"status"] boolValue]) {
            [self.view makeToast:@"提交成功" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [self.view makeToast:@"提交失败" duration:1.0 position:CSToastPositionCenter];
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}



//支付预付结算
-(void)freightPay
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"money\":\"%@\",\"deal_id\":\"%@\",\"type\":\"%@\"",
                                 [UseInfo shareInfo].access_token,
                                 self.textField.text,
                                 self.cargo_id,
                                 [self.titleStr containsString:@"预付"] ? @"1" : @"2"
                                 ];
    
    [XXJNetManager requestPOSTURLString:TransportDeal URLMethod:payment_freight parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"][@"status"] boolValue]) {
            [self.view makeToast:@"提交成功" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [self.view makeToast:@"提交失败" duration:1.0 position:CSToastPositionCenter];
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}








@end
