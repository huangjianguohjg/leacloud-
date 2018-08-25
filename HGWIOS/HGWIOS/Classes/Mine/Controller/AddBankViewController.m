//
//  AddBankViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AddBankViewController.h"
#import "BankListViewController.h"
#import "AddBankTwoViewController.h"

@interface AddBankViewController ()

@property (nonatomic, weak) UIButton * boatButton;

@property (nonatomic, weak) UIButton * goodButton;

@property (nonatomic, weak) UIButton * preButton;

@property (nonatomic, weak) UITextField * bankTextField;

@property (nonatomic, weak) UITextField * personTextField;

@property (nonatomic, weak) UITextField * numberTextField;

@property (nonatomic, copy) NSString * bankNameAB;

@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXJColor(234, 239, 245);
    

    self.navigationItem.title = @"添加银行卡";
    
    [self setUpUI];
}






-(void)setUpUI
{
    //银行卡
    UIView *bankNameview = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight , SCREEN_WIDTH, realH(100))];
    bankNameview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bankNameview];
    
    UITapGestureRecognizer *bankNameGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bankNameclick)];
    bankNameGesture1.numberOfTapsRequired=1;
    bankNameview.userInteractionEnabled = YES;
    [bankNameview addGestureRecognizer:bankNameGesture1];
    
    UILabel *bankNameLabel = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"银行卡"];
    [bankNameLabel sizeToFit];
    [bankNameview addSubview:bankNameLabel];
    [bankNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bankNameview).offset(realW(20));
        make.centerY.equalTo(bankNameview);
    }];
    
    
    UITextField * bankTextField = [[UITextField alloc]init];
    bankTextField.placeholder = @"选择银行";
    bankTextField.textAlignment = NSTextAlignmentLeft;
    bankTextField.textColor = [UIColor blackColor];
    bankTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(30)];
    bankTextField.userInteractionEnabled = NO;
    [bankNameview addSubview:bankTextField];
    [bankTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bankNameLabel.right).offset(realW(20));
        make.centerY.equalTo(bankNameview);
    }];
    self.bankTextField = bankTextField;
    
    UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"form_icon_arrow"]];
    [bankNameview addSubview:arrowImageView];
    [arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bankNameview).offset(realW(-40));
        make.centerY.equalTo(bankNameview);
    }];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(245, 245, 245);
    [bankNameview addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bankNameview);
        make.bottom.equalTo(bankNameview).offset(realH(-2));
        make.height.equalTo(realH(1));
    }];
    
    UIView * buttonView = [[UIView alloc]init];
    buttonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonView];
    [buttonView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankNameview.bottom);
        make.right.left.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    
    
    UIButton * boatButton = [[UIButton alloc]init];
    boatButton.selected = YES;
    self.preButton = boatButton;
    [boatButton addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
    [boatButton setImage:[UIImage imageNamed:@"form_choose_no"] forState:UIControlStateNormal];
    [boatButton setImage:[UIImage imageNamed:@"form_choose_yes"] forState:UIControlStateSelected];
    [boatButton setTitle:@"信用卡" forState:UIControlStateNormal];
    boatButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(30)];
    [boatButton setTitleColor:XXJColor(107, 107, 107) forState:UIControlStateNormal];
    [boatButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [boatButton sizeToFit];
    [buttonView addSubview:boatButton];
    [boatButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonView);
        make.right.equalTo(buttonView.centerX).offset(realW(-50));
    }];
    self.boatButton = boatButton;
    
    UIButton * goodButton = [[UIButton alloc]init];
    [goodButton addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
    [goodButton setImage:[UIImage imageNamed:@"form_choose_no"] forState:UIControlStateNormal];
    [goodButton setImage:[UIImage imageNamed:@"form_choose_yes"] forState:UIControlStateSelected];
    [goodButton setTitle:@"储蓄卡" forState:UIControlStateNormal];
    goodButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(30)];
    [goodButton setTitleColor:XXJColor(107, 107, 107) forState:UIControlStateNormal];
    [goodButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [goodButton sizeToFit];
    [buttonView addSubview:goodButton];
    [goodButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonView);
        make.left.equalTo(buttonView.centerX).offset(realW(50));
    }];
    self.goodButton = goodButton;
    
    
    
    UIView *personview = [[UIView alloc]init];
    personview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:personview];
    [personview makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(buttonView.bottom).offset(realH(20));
        make.height.equalTo(realH(100));
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    UILabel *personLabel = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"持卡人"];
    [personLabel sizeToFit];
    [personview addSubview:personLabel];
    [personLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personview).offset(realW(20));
        make.centerY.equalTo(personview);
    }];
    
    
    UITextField * personTextField = [[UITextField alloc]init];
    personTextField.placeholder = @"持卡人姓名";
    personTextField.textAlignment = NSTextAlignmentLeft;
    personTextField.textColor = [UIColor blackColor];
    personTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(30)];
    [personview addSubview:personTextField];
    [personTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personLabel.right).offset(realW(20));
        make.right.equalTo(personview);
//        make.width.equalTo(realW(200));
        make.centerY.equalTo(personview);
    }];
    self.personTextField = personTextField;
    
    
    UIView *numberview = [[UIView alloc]init];
    numberview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:numberview];
    [numberview makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(personview.bottom).offset(realH(20));
        make.height.equalTo(realH(100));
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    UILabel *numberLabel = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"卡号"];
    [numberLabel sizeToFit];
    [numberview addSubview:numberLabel];
    [numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberview).offset(realW(20));
        make.centerY.equalTo(numberview);
    }];
    
    
    UITextField * numberTextField = [[UITextField alloc]init];
//    numberTextField.keyboardType = UIKeyboardTypeDecimalPad;
    numberTextField.placeholder = @"请输入银行卡号";
    numberTextField.textAlignment = NSTextAlignmentLeft;
    numberTextField.textColor = [UIColor blackColor];
    numberTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(30)];
    [numberview addSubview:numberTextField];
    [numberTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberLabel.right).offset(realW(20));
        make.right.equalTo(numberview);
        make.centerY.equalTo(numberview);
    }];
    self.numberTextField = numberTextField;
    
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
        make.top.equalTo(numberview.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
    
    
}


-(void)bankNameclick
{
    BankListViewController * bankListVc = [[BankListViewController alloc]init];
    __weak typeof(self) weakSelf = self;
    bankListVc.bankSelectBlock = ^(NSString *name, NSString *ab) {
        weakSelf.bankTextField.text = name;
        weakSelf.bankNameAB = ab;
    };
    [self.navigationController pushViewController:bankListVc animated:YES];
}

-(void)chooseClick:(UIButton *)button
{
    self.preButton.selected = NO;
    button.selected = YES;
    self.preButton = button;
}



-(void)nextClick
{
    if ([GJCFStringUitil stringIsNull: self.bankTextField.text]) {
        [self.view makeToast:@"请先选择银行" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if ([GJCFStringUitil stringIsNull: self.personTextField.text]) {
        [self.view makeToast:@"请填写持卡人" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if ([GJCFStringUitil stringIsNull: self.numberTextField.text]) {
        [self.view makeToast:@"请输入银行卡号" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    

    NSString *parameterstring = [NSString stringWithFormat:@"\"card_no\":\"%@\"",self.numberTextField.text];

    [XXJNetManager requestPOSTURLString:BankBond URLMethod:BankBondMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];

        XXJLog(@"%@",result)
        if ([[result[@"result"] objectForKey:@"status"]boolValue])
        {
            //status返回1
            [self.view makeToast:@"此银行卡已经绑定" duration:0.5 position:CSToastPositionCenter];
        }
        else
        {
            //status返回0
//            XXJLog(@"1111")
            AddBankTwoViewController * addBankTwoVc = [[AddBankTwoViewController alloc]init];
            addBankTwoVc.cardNo = self.numberTextField.text;
            addBankTwoVc.cardName = self.personTextField.text;
            addBankTwoVc.bankName = self.bankTextField.text;
            addBankTwoVc.banknameAB = self.bankNameAB;
            addBankTwoVc.cardType = self.boatButton.selected == YES ? @"0" : @"1";
            [self.navigationController pushViewController:addBankTwoVc animated:YES];
        }


    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}





@end
