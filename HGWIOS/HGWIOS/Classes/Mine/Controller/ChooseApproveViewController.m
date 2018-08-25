//
//  ChooseApproveViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ChooseApproveViewController.h"

#import "ApproveViewController.h"

@interface ChooseApproveViewController ()

@end

@implementation ChooseApproveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(239, 239, 239);
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@认证",[UseInfo shareInfo].identity];
    
    [self setUpUI];
    
}






-(void)setUpUI
{
    UIImageView * upImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"company_auth"]];
    upImageView.tag = 20000;
    upImageView.userInteractionEnabled = YES;
    [upImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)]];
    [self.view addSubview:upImageView];
    [upImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(realH(50) + kStatusBarHeight + kNavigationBarHeight);
        make.size.equalTo(CGSizeMake(realW(359), realH(256)));
    }];
    
    UILabel * approveLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"企业认证"];
    [approveLable sizeToFit];
    [self.view addSubview:approveLable];
    [approveLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upImageView.bottom).offset(realH(80));
        make.centerX.equalTo(self.view);
    }];
    
    UILabel * approveDetailLable = [UILabel lableWithTextColor:XXJColor(158, 158, 158) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"通过企业认证后，您的手机号即成为该\n企业的管理员账号，具备全部功能权限"];
    approveDetailLable.numberOfLines = 0;
    [approveDetailLable sizeToFit];
    [self.view addSubview:approveDetailLable];
    [approveDetailLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(approveLable.bottom).offset(realH(50));
        make.centerX.equalTo(self.view);
    }];
    
    
    
    UIImageView * downImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"company"]];
    downImageView.tag = 20001;
    downImageView.userInteractionEnabled = YES;
    [downImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)]];
    [self.view addSubview:downImageView];
    [downImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(approveDetailLable).offset(realH(120));
        make.size.equalTo(CGSizeMake(realW(257), realH(256)));
    }];
    
    UILabel * joinLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"加入企业"];
    [joinLable sizeToFit];
    [self.view addSubview:joinLable];
    [joinLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(downImageView.bottom).offset(realH(80));
        make.centerX.equalTo(self.view);
    }];
    
    UILabel * joinDetailLable = [UILabel lableWithTextColor:XXJColor(158, 158, 158) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"通过企业后，您的手机号拥有货盘管理、\n运单管理等功能权限，但企业管理除外"];
    joinDetailLable.numberOfLines = 0;
    [joinDetailLable sizeToFit];
    [self.view addSubview:joinDetailLable];
    [joinDetailLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(joinLable.bottom).offset(realH(50));
        make.centerX.equalTo(self.view);
    }];
    
    
    
    
}



-(void)imageClick:(UITapGestureRecognizer *)tap
{
    
    UIView * view = tap.view;
    
    ApproveViewController * approveVc = [[ApproveViewController alloc]init];
    if (view.tag == 20000) {
        approveVc.chooseStr = @"企业认证";
    }
    else
    {
        approveVc.chooseStr = @"加入企业";
    }
    [self.navigationController pushViewController:approveVc animated:YES];
}





































@end
