//
//  MyScoreViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/9.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyScoreViewController.h"
#import "ScoreView.h"

#import "ChooseApproveViewController.h"
#import "MyBoatViewController.h"

#import "SendGoodsViewController.h"
@interface MyScoreViewController ()

@property (nonatomic, weak) UILabel * timeLable;

@property (nonatomic, weak) UIButton * scoreButton;

@property (nonatomic, weak) UILabel * scoreLable;

@end

@implementation MyScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"我的信任值";
    
    [self setUpUI];
    
    [self getUserScore];
    
}



-(void)setUpUI
{
    UILabel * timeLable = [UILabel lableWithTextColor:XXJColor(146, 146, 146) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"更新时间:2018年5月7日"];
//    timeLable.alpha = 0;
    [timeLable sizeToFit];
    [self.view addSubview:timeLable];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(realW(40) + kStatusBarHeight + kNavigationBarHeight);
        make.left.equalTo(self.view).offset(realW(20));
    }];
    self.timeLable = timeLable;
    
    
    UIButton * scoreButton = [[UIButton alloc]init];
    [scoreButton setTitle:@"124\n信任值较高" forState:UIControlStateNormal];
    scoreButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    scoreButton.titleLabel.numberOfLines = 0;
    [scoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    scoreButton.backgroundColor = XXJColor(100, 152, 232);
    scoreButton.layer.cornerRadius = realW(125);
    scoreButton.clipsToBounds = YES;
    scoreButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(36)];
    [self.view addSubview:scoreButton];
    [scoreButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(timeLable.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(250), realH(250)));
    }];
    self.scoreButton = scoreButton;
    
    
    UILabel * scoreLable = [UILabel lableWithTextColor:XXJColor(146, 146, 146) textFontSize:realFontSize(30) fontFamily:PingFangSc_Regular text:@"信任值初始评分为80"];
    [scoreLable sizeToFit];
    [self.view addSubview:scoreLable];
    [scoreLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scoreButton.bottom).offset(realW(40));
        make.centerX.equalTo(self.view);
    }];
    self.scoreLable = scoreLable;
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(237, 237, 237);
    [self.view addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scoreLable.bottom).offset(realH(20));
        make.right.left.equalTo(self.view);
        make.height.equalTo(realH(10));
    }];
    
    UILabel * vipLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"当前特权"];
    [vipLable sizeToFit];
    [self.view addSubview:vipLable];
    [vipLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(realW(40));
        make.left.equalTo(self.view).offset(realW(20));
    }];
    
    
    UIView * secondLineView = [[UIView alloc]init];
    secondLineView.backgroundColor = XXJColor(237, 237, 237);
    [self.view addSubview:secondLineView];
    [secondLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipLable.bottom).offset(realH(20));
        make.left.equalTo(self.view).offset(realW(40));
        make.right.equalTo(self.view).offset(realW(-40));
        make.height.equalTo(realH(2));
    }];
    
    NSArray * titleArray = @[@"生日礼物",@"特惠优先推送",@"产品优先体验"];
    NSArray * imageArray = @[@"sr",@"yh",@"yx"];
    
    CGFloat w = (SCREEN_WIDTH - realW(0)) / 3;
    CGFloat h = realH(200);
    for (NSInteger i = 0; i < 3; i++) {
        UIButton * button = [[UIButton alloc]init];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:realH(20)];
        [self.view addSubview:button];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(secondLineView.bottom).offset(realH(40));
            make.left.equalTo(self.view).offset(w * i + realW(0));
            make.size.equalTo(CGSizeMake(w, h));
        }];
        
        
    }
    
    
    
    UIView * thirdLineView = [[UIView alloc]init];
    thirdLineView.backgroundColor = XXJColor(237, 237, 237);
    [self.view addSubview:thirdLineView];
    [thirdLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipLable.bottom).offset(realH(240) + realH(40));
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(realH(10));
    }];
    
    
    
    UILabel * mijiLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"升分秘籍"];
    [mijiLable sizeToFit];
    [self.view addSubview:mijiLable];
    [mijiLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLineView.bottom).offset(realW(40));
        make.left.equalTo(self.view).offset(realW(20));
    }];
    
    
    UIView * fourthLineView = [[UIView alloc]init];
    fourthLineView.backgroundColor = XXJColor(237, 237, 237);
    [self.view addSubview:fourthLineView];
    [fourthLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mijiLable.bottom).offset(realH(20));
        make.left.equalTo(self.view).offset(realW(40));
        make.right.equalTo(self.view).offset(realW(-40));
        make.height.equalTo(realH(2));
    }];
    
    
    
    ScoreView * scoreView = [[ScoreView alloc]init];
    
    if ([[UseInfo shareInfo].companyApprove isEqualToString:@"认证通过"]) {
//        cell.approveLable.text = @"企业认证通过";
        [scoreView.chooseButton setTitle:@"企业认证通过" forState:UIControlStateNormal];
        [scoreView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        
    }
    else
    {
        //判断加入的公司
        NSString * s = nil;
        if ([[UseInfo shareInfo].joinCompanyApprove isEqualToString:@"认证通过"])
        {
            s = @"加入企业认证通过";
        }
        else
        {
            s = @"未认证";
        }
        [scoreView.chooseButton setTitle:s forState:UIControlStateNormal];
        [scoreView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    }
    
    
    [scoreView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(renzhengTap)]];
    [scoreView.imageView setImage:[UIImage imageNamed:@"rz"]];
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
    {
        scoreView.leftLable.text = @"船东认证";
    }
    else
    {
        scoreView.leftLable.text = @"货主认证";
    }
    
    [self.view addSubview:scoreView];
    [scoreView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fourthLineView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(120));
    }];
    
    
    ScoreView * emptyView = [[ScoreView alloc]init];
    [emptyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(baokongTap)]];
    [emptyView.imageView setImage:[UIImage imageNamed:@"bk"]];
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
        emptyView.leftLable.text = @"船舶报空";
    }
    else
    {
        emptyView.leftLable.text = @"货盘发布";
    }
    [self.view addSubview:emptyView];
    [emptyView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scoreView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(120));
    }];
}





-(void)renzhengTap
{
    ChooseApproveViewController * approveVc = [[ChooseApproveViewController alloc]init];
    approveVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:approveVc animated:YES];
}


-(void)baokongTap
{
    __weak typeof(self) weakSelf = self;
    
    if ([[UseInfo shareInfo].nameApprove isEqualToString:@"认证通过"])
    {
        if ([[UseInfo shareInfo].companyApprove isEqualToString:@"认证通过"]) {
            
            if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
            {
                MyBoatViewController * myBoatVc = [[MyBoatViewController alloc]init];
                myBoatVc.hidesBottomBarWhenPushed  = YES;
                [self.navigationController pushViewController:myBoatVc animated:YES];
            }
            else
            {
                SendGoodsViewController * sendGoodsVc = [[SendGoodsViewController alloc]init];
                sendGoodsVc.hidesBottomBarWhenPushed  = YES;
                [self.navigationController pushViewController:sendGoodsVc animated:YES];
            }
            
            return;
        }
        else
        {
            //判断加入的公司
            if ([[UseInfo shareInfo].joinCompanyApprove isEqualToString:@"认证通过"])
            {
                if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
                {
                    MyBoatViewController * myBoatVc = [[MyBoatViewController alloc]init];
                    myBoatVc.hidesBottomBarWhenPushed  = YES;
                    [self.navigationController pushViewController:myBoatVc animated:YES];
                }
                else
                {
                    SendGoodsViewController * sendGoodsVc = [[SendGoodsViewController alloc]init];
                    sendGoodsVc.hidesBottomBarWhenPushed  = YES;
                    [self.navigationController pushViewController:sendGoodsVc animated:YES];
                }
                
                return;
            }
            
        }
    }
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"化运网是实名制平台，请认证后再操作" message:@"" preferredStyle:UIAlertControllerStyleAlert ];
    //取消style:UIAlertActionStyleDefault
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alertController addAction:cancelAction];
    
    //简直废话:style:UIAlertActionStyleDestructive
    UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"认证" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        ChooseApproveViewController * approveVc = [[ChooseApproveViewController alloc]init];
        approveVc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:approveVc animated:YES];
        
    }];
    [alertController addAction:rubbishAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}



-(void)getUserScore
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetUserAllInfo URLMethod:creditvalue parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"][@"status"] boolValue]) {
            self.timeLable.text = [NSString stringWithFormat:@"更新时间:%@",result[@"result"][@"update_score_time"]];
            
            NSString * msg = result[@"result"][@"msg"];
            
//            if ([msg containsString:@"较高"]) {
//                [self.scoreButton setTitle:[NSString stringWithFormat:@"%@\n信任值较高",self.scoreStr] forState:UIControlStateNormal];
//            }
//            else
//            {
//                [self.scoreButton setTitle:[NSString stringWithFormat:@"%@\n信任值较低",self.scoreStr] forState:UIControlStateNormal];
//            }
            
            [self.scoreButton setTitle:[NSString stringWithFormat:@"%@\n%@",self.scoreStr,msg] forState:UIControlStateNormal];
            
            
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}
































@end
