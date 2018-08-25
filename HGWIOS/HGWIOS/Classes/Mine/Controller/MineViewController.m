//
//  MineViewController.m
//  化运网ios
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 jiuze. All rights reserved.
//

#import "MineViewController.h"

#import "ChooseApproveViewController.h"
#import "ApproveViewController.h"
#import "MyBoatViewController.h"
#import "AdminViewController.h"

#import "BankViewController.h"
#import "SettingViewController.h"

#import "MyScoreViewController.h"

#import "ShipownerTableViewCell.h"
#import "MineTopTableViewCell.h"
#import "BoatMessageTableViewCell.h"
#import "MineTableViewCell.h"

#import "MyGoodsViewController.h"
#import "AlreadyOfferViewController.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSDictionary * infoDict;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    
    [self setUpUI];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getAllUserInfoRequest];
    
    [self getUserInfo];
    [self selfCompanyStatus];
    [self joinCompanyStatus];
}


-(void)setUpNav
{
    self.navigationItem.title = @"我的";
    
    self.navigationController.navigationBar.barTintColor = XXJColor(27, 69, 138);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}


-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 100;
//    tableView.rowHeight = 100;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView registerClass:[MineTopTableViewCell class] forCellReuseIdentifier:@"MineTopTableViewCell"];
    [tableView registerClass:[BoatMessageTableViewCell class] forCellReuseIdentifier:@"BoatMessageTableViewCell"];
    [tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    self.tableView = tableView;
    
}



#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        if ([self.infoDict[@"is_admin"] isEqualToString:@"1"]) {
            if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
            {
                return 6;
            }
            else
            {
                return 5;
            }
            
        }
        else
        {
            if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
            {
                return 5;
            }
            else
            {
                return 4;
            }
        }
       
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        MineTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MineTopTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        NSString * nameStr = [self.infoDict[@"username"] isEqual:[NSNull null]] ? @"无" : [self.infoDict[@"username"] substringToIndex:1];
        
        [cell.iconButton setTitle:nameStr forState:UIControlStateNormal];
        
        NSString * typeStr = nil;
        if ([self.infoDict[@"is_admin"] isEqual:[NSNull null]]) {
            typeStr = @"未设置";
        }
        else
        {
            typeStr = [self.infoDict[@"is_admin"] isEqualToString:@"1"] ? @"企业管理员" : @"业务员";
        }
        cell.nameLable.text = [NSString stringWithFormat:@"%@ %@",[self.infoDict[@"username"] isEqual:[NSNull null]] ? @"无" : self.infoDict[@"username"],typeStr];
        
        NSString * mobileStr = self.infoDict[@"mobile"] == nil ? @"暂未设置" : self.infoDict[@"mobile"];
        cell.phoneLable.text = mobileStr;
        
        
        cell.companyLable.text = [self.infoDict[@"company"] isEqual:[NSNull null]] ? @"无" : self.infoDict[@"company"];
        
        NSString * scoreStr = self.infoDict[@"score"] == nil ? @"无" : self.infoDict[@"score"];
        
        [cell.scoreButton setTitle:[NSString stringWithFormat:@"信任值 %@",scoreStr] forState:UIControlStateNormal];
        
        
        cell.scoreBlock = ^{
            MyScoreViewController * scoreVc = [[MyScoreViewController alloc]init];
            scoreVc.hidesBottomBarWhenPushed = YES;
            scoreVc.scoreStr = scoreStr;
            [weakSelf.navigationController pushViewController:scoreVc animated:YES];
        };
        
        return cell;
    }
    else
    {
        
        NSArray * array = nil;
        NSArray * imageArray = nil;
        if ([self.infoDict[@"is_admin"] isEqualToString:@"1"]) {
            if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
                array = @[@"认证中心",@"我的船舶",@"我的报价",@"银行卡",@"企业管理",@"设置"];
                imageArray = @[@"认证",@"盘",@"报价",@"银行卡",@"管理",@"设置"];
            }
            else
            {
                array = @[@"认证中心",@"我的货盘",@"银行卡",@"企业管理",@"设置"];
                imageArray = @[@"认证",@"盘",@"银行卡",@"管理",@"设置"];
            }
            
        }
        else
        {
            if ([[UseInfo shareInfo].identity isEqualToString:@"船东"])
            {
                array = @[@"认证中心",@"我的船舶",@"我的报价",@"银行卡",@"设置"];
                imageArray = @[@"认证",@"盘",@"报价",@"银行卡",@"设置"];
            }
            else
            {
                array = @[@"认证中心",@"我的货盘",@"银行卡",@"设置"];
                imageArray = @[@"认证",@"盘",@"银行卡",@"设置"];
            }
        }
        
        
        MineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightLable.alpha = 0;
        cell.arrowImageView.alpha = 1;
        if (indexPath.section == 1) {
            cell.leftLable.text = array[indexPath.row];
            [cell.leftImageView setImage:[UIImage imageNamed:imageArray[indexPath.row]]];
            if (indexPath.row == 0) {
                cell.approveLable.alpha = 1;
                
                if ([[UseInfo shareInfo].companyApprove isEqualToString:@"认证通过"]) {
                    cell.approveLable.text = @"企业认证通过";
                }
                else
                {
                    //判断加入的公司
                    if ([[UseInfo shareInfo].joinCompanyApprove isEqualToString:@"认证通过"])
                    {
                        cell.approveLable.text = @"加入企业认证通过";
                    }
                    else
                    {
                        cell.approveLable.text = @"未认证";
                    }
                }
            }
        }
        
       
        return cell;
    }
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoatMessageTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
//            if (![self.infoDict[@"review"] isEqualToString:@"2"]) {
                //认证中心
                ChooseApproveViewController * approveVc = [[ChooseApproveViewController alloc]init];
            
                approveVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:approveVc animated:YES];
//            }
            
        }
        else if (indexPath.row == 1)
        {
            if ([cell.leftLable.text isEqualToString:@"我的船舶"]) {
                //我的船舶
                MyBoatViewController * myBoatVc = [[MyBoatViewController alloc]init];
                myBoatVc.hidesBottomBarWhenPushed  = YES;
                [self.navigationController pushViewController:myBoatVc animated:YES];
            }
            else if ([cell.leftLable.text isEqualToString:@"我的货盘"])
            {
                //我的货盘
                XXJLog(@"我的货盘")
                MyGoodsViewController * vc = [[MyGoodsViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
//            else if ([cell.leftLable.text isEqualToString:@"银行卡"])
//            {
//                //银行卡
//                BankViewController * bankVc = [[BankViewController alloc]init];
//                bankVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:bankVc animated:YES];
//            }
            
        }
        else if (indexPath.row == 2)
        {
            if ([cell.leftLable.text isEqualToString:@"我的报价"])
            {
                //我的报价
                XXJLog(@"我的报价")
                AlreadyOfferViewController * alreadyVc = [[AlreadyOfferViewController alloc]init];
                alreadyVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:alreadyVc animated:YES];
            }
            else if ([cell.leftLable.text isEqualToString:@"银行卡"])
            {
                //银行卡
                BankViewController * bankVc = [[BankViewController alloc]init];
                bankVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:bankVc animated:YES];
            }
            
            
            
            
            
            
            
//            if ([cell.leftLable.text isEqualToString:@"设置"])
//            {
//                SettingViewController * setVc = [[SettingViewController alloc]init];
//                setVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:setVc animated:YES];
//            }
//            else if ([cell.leftLable.text isEqualToString:@"企业管理"])
//            {
//                AdminViewController * adminVc = [[AdminViewController alloc]init];
//                adminVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:adminVc animated:YES];
//            }
//            else if ([cell.leftLable.text isEqualToString:@"银行卡"])
//            {
//                //银行卡
//                BankViewController * bankVc = [[BankViewController alloc]init];
//                bankVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:bankVc animated:YES];
//            }
            
        }
        else if (indexPath.row == 3)
        {
            if ([cell.leftLable.text isEqualToString:@"设置"])
            {
                SettingViewController * setVc = [[SettingViewController alloc]init];
                setVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:setVc animated:YES];
            }
            else if ([cell.leftLable.text isEqualToString:@"企业管理"])
            {
                AdminViewController * adminVc = [[AdminViewController alloc]init];
                adminVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:adminVc animated:YES];
            }
            else if ([cell.leftLable.text isEqualToString:@"银行卡"])
            {
                //银行卡
                BankViewController * bankVc = [[BankViewController alloc]init];
                bankVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:bankVc animated:YES];
            }
        }
        else if (indexPath.row == 4)
        {
            if ([cell.leftLable.text isEqualToString:@"设置"])
            {
                SettingViewController * setVc = [[SettingViewController alloc]init];
                setVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:setVc animated:YES];
            }
            else if ([cell.leftLable.text isEqualToString:@"企业管理"])
            {
                AdminViewController * adminVc = [[AdminViewController alloc]init];
                adminVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:adminVc animated:YES];
            }
        }
        else
        {
            //设置
            SettingViewController * setVc = [[SettingViewController alloc]init];
            setVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVc animated:YES];
        }
        
    }
}


#pragma mark -- 获取用户所有数据
-(void)getAllUserInfoRequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetUserAllInfo URLMethod:GetUserAllInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"] isEqual:[NSNull null]]) {
            return ;
        }
        
        if (![result[@"result"][@"status"] boolValue]) {
            [self.view makeToast:@"获取身份信息异常" duration:1.0 position:CSToastPositionCenter];
            return ;
        }
        
        NSDictionary * authDict = result[@"result"][@"user"];
        if ([authDict[@"is_admin"] isEqualToString:@"1"]) {
            [UseInfo shareInfo].is_admin = YES;
        }
        else
        {
            [UseInfo shareInfo].is_admin = NO;
        }
        self.infoDict = authDict;
        //0=>未认证，1=>已提交， 2=>认证通过，3=>再次认证
        if ([authDict[@"review"] isEqualToString:@"0"]) {
            //未认证
            
        }

        if ([authDict[@"review"] isEqualToString:@"1"]) {
            //已提交
        }

        if ([authDict[@"review"] isEqualToString:@"2"]) {
            //认证通过
        }
        else if ([authDict[@"review"] isEqualToString:@"3"])
        {
            //再次认证
        }
        
        [self.tableView reloadData];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
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
                
                
                
                if ([infoDict[@"review"] isEqual:@1]) {
                    //待审核
                    [UseInfo shareInfo].nameApprove = @"待审核";
                }
                else if ([infoDict[@"review"] isEqual:@2])
                {
                    //已认证 通过
                    
                    [UseInfo shareInfo].nameApprove = @"认证通过";
                }
                else
                {
                    //未认证
                    [UseInfo shareInfo].nameApprove = @"未认证";
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




#pragma mark -- 获取用户企业认证信息（自己的企业认证）
-(void)selfCompanyStatus
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetCompanyInfo URLMethod:GetCompanyInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            
            if ([result[@"result"][@"status"] boolValue]) {
                NSDictionary * infoDict = result[@"result"][@"enterprise"];
                
                if (infoDict != nil) {
                    
                    
                    
                    if ([infoDict[@"review"] isEqualToString:@"1"]) {
                        //待审核
                        [UseInfo shareInfo].companyApprove = @"待审核";
                        
                    }
                    else if ([infoDict[@"review"] isEqualToString:@"2"])
                    {
                        //成功
                        [UseInfo shareInfo].companyApprove = @"认证通过";
                        
                    }
                    else if ([infoDict[@"review"] isEqualToString:@"3"])
                    {
                        //失败
                        [UseInfo shareInfo].companyApprove = @"未认证";
                    }
                }
            }
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}

//加入的企业的认证信息
-(void)joinCompanyStatus
{
    
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetCompanyStatus URLMethod:GetCompanyStatusMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result);
        
        if ([result[@"result"][@"status"] boolValue]) {
            
            //            NSDictionary * dataDict = result[@"result"][@"data"];
            
            [UseInfo shareInfo].joinCompanyApprove = @"认证通过";
        }
        else
        {
            [UseInfo shareInfo].joinCompanyApprove = @"认证未通过";
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}













@end
