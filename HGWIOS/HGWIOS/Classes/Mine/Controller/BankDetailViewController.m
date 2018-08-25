//
//  BankDetailViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/2.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BankDetailViewController.h"
#import "AddBankView.h"
#import "BankModel.h"
@interface BankDetailViewController ()

@property (nonatomic, weak) UIImageView * imageView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *detailLabel;

@end

@implementation BankDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(234, 239, 245);
    

    self.navigationItem.title = @"银行卡详情";
    
    [self setUpUI];
}





-(void)setUpUI
{
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView setImage:[UIImage imageNamed:self.model.bank_name_ab]];
    [self.view addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(realW(40));
        make.top.equalTo(self.view).offset(realH(40)+ kStatusBarHeight + kNavigationBarHeight);
        make.size.equalTo(CGSizeMake(realW(70), realH(70)));
    }];
    self.imageView = imageView;
    
    UILabel *nameLabel = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:self.model.bank_name];
    [nameLabel sizeToFit];
    [self.view addSubview:nameLabel];
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.right).offset(realW(40));
        make.top.equalTo(self.view).offset(realH(20)+ kStatusBarHeight + kNavigationBarHeight);
    }];
    self.nameLabel = nameLabel;
    
    
    NSString * cardTypeStr = nil;
    if ([self.model.card_type isEqualToString:@"1"]) {
        cardTypeStr = @"储蓄卡";
    }
    else
    {
        cardTypeStr = @"信用卡";
    }
    
    UILabel *detailLabel = [UILabel lableWithTextColor:[UIColor grayColor] textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"尾号%@ %@",self.model.last_card_no,cardTypeStr]];
    [detailLabel sizeToFit];
    [self.view addSubview:detailLabel];
    [detailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.right).offset(realW(40));
        make.top.equalTo(nameLabel.bottom).offset(realH(20));
    }];
    self.detailLabel = detailLabel;
    
    AddBankView * firstView = [[AddBankView alloc]init];
    firstView.leftLabel.text = @"银行卡卡号:";
    
    firstView.textField.text = self.model.card_no;
    firstView.textField.userInteractionEnabled = NO;
    [self.view addSubview:firstView];
    [firstView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
//        make.width.equalTo(SCREEN_WIDTH);
        make.top.equalTo(detailLabel.bottom).offset(realH(20) );
        make.height.equalTo(realH(100));
    }];
    
    AddBankView * secondView = [[AddBankView alloc]init];
    secondView.leftLabel.text = @"预留手机号:";
    secondView.textField.text = self.model.tel_no;
    secondView.textField.userInteractionEnabled = NO;
    [self.view addSubview:secondView];
    [secondView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(firstView.bottom);
        make.height.equalTo(realH(100));
    }];
    
    UIButton * sureButton = [[UIButton alloc]init];
    [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"解除绑定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.backgroundColor = XXJColor(27, 69, 138);
    sureButton.layer.cornerRadius = 5;
    sureButton.clipsToBounds = YES;
    sureButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:sureButton];
    
    [sureButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(secondView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
}


#pragma mark -- 解除绑定
-(void)sureClick
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否确定解除" message:@"" preferredStyle:UIAlertControllerStyleAlert ];
    //取消style:UIAlertActionStyleDefault
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alertController addAction:cancelAction];
    
    //简直废话:style:UIAlertActionStyleDestructive
    UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"card_no\":\"%@\",\"tel_no\":\"%@\"",[UseInfo shareInfo].access_token,self.model.card_no,self.model.tel_no];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:UnBondCard URLMethod:UnBondCardMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            if ([[result[@"result"] objectForKey:@"status"]boolValue]) {
                [self.view makeToast:@"解绑银行卡成功" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
            }else{
                [self.view makeToast:@"解绑银行卡失败" duration:1.0 position:CSToastPositionCenter];
            }
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
    }];
    [alertController addAction:rubbishAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    
    
    
    
    
    
    
    
}

















@end
