//
//  RecommendViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/29.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "RecommendViewController.h"

#import "RecommendTableViewCell.h"
#import "HomeTableViewCell.h"
#import "HomeBoatModel.h"
#import "AlreadyOfferModel.h"
#import "ApproveViewController.h"
#import "ChooseApproveViewController.h"
#import "RecommendBottomView.h"
#import "HomeBoatModel.h"
#import "PhoneFeedbackView.h"

#import "HLPhoneInfoController.h"
@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, weak) RecommendBottomView * bottomView;

/**
 记录拨打电话的运单ID
 */
@property (nonatomic, copy) NSString * phoneCargo_id;
@property (nonatomic, copy) NSString * log_id;

@property (nonatomic, weak) PhoneFeedbackView * feedView;

@property (nonatomic, weak) UIView * coverView;

@end

@implementation RecommendViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneCall) name:@"PhoneCall" object:nil];
    
    self.page = 1;
    self.max = 20;
    
    [self setUpNav];
    
    [self setUpUI];
    
    [self findBoatRequest];
    
}

-(void)setUpNav
{
    self.navigationItem.title = @"发布成功,推荐船舶";
    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneCall) name:@"PhoneCall" object:nil];
    
    
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
    if ([self.fromTag isEqualToString:@"发货"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



-(void)setUpUI
{
    UIImageView * firstImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"locationUpdate"]];
    [self.view addSubview:firstImageView];
    [firstImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(realW(20));
        make.top.equalTo(self.view).offset(realH(40) + kStatusBarHeight + kNavigationBarHeight);
    }];
    
    
    UILabel * startlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:self.model != nil ? [NSString stringWithFormat:@"%@%@",self.model.parent_b,self.model.b_port] : self.dataDict[@"b_port"]];
    [startlable sizeToFit];
    [self.view addSubview:startlable];
    [startlable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstImageView).offset(realW(50));
        make.top.equalTo(self.view).offset(realH(40) + kStatusBarHeight + kNavigationBarHeight);
        make.height.equalTo(realH(36));
    }];
//    self.startlable = startlable;
    
    UIImageView * arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"to_rightUpdate"]];
    [arrowImageView sizeToFit];
    [self.view addSubview:arrowImageView];
    [arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(startlable);
        make.left.equalTo(startlable.right).offset(realW(10));
        make.height.equalTo(realH(38));
        make.width.equalTo(realW(38));
    }];
    
    
    
    UILabel * endlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:self.model != nil ? [NSString stringWithFormat:@"%@%@",self.model.parent_e,self.model.e_port] : self.dataDict[@"e_port"]];
    [endlable sizeToFit];
    [self.view addSubview:endlable];
    [endlable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrowImageView.right).offset(realW(10));
        make.centerY.equalTo(arrowImageView);
        make.height.equalTo(realH(36));
    }];
//    self.endlable = endlable;
    
    UIImageView * secondImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_hm_03"]];
    [self.view addSubview:secondImageView];
    [secondImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(realW(20));
        make.top.equalTo(firstImageView.bottom).offset(realH(20));
    }];
    
    UILabel * weightlable = [UILabel lableWithTextColor:XXJColor(107, 107, 107) textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:self.model != nil ? [NSString stringWithFormat:@"%@ %@吨 ±%@%@",self.model.cargo_type,self.model.weight,self.model.weight_num,@"%"] : self.dataDict[@"weight"]];
    [weightlable sizeToFit];
    [self.view addSubview:weightlable];
    [weightlable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(secondImageView);
        //        make.left.equalTo(self.contentView).offset(realW(50));
        make.left.equalTo(secondImageView.right).offset(realW(20));
        make.height.equalTo(realH(36));
    }];
//    self.weightlable = weightlable;
    
    
    UIImageView * thirdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_rq02_03"]];
    [self.view addSubview:thirdImageView];
    [thirdImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(realW(20));
        make.top.equalTo(secondImageView.bottom).offset(realH(20));
    }];
    
    UILabel * startDatelable = [UILabel lableWithTextColor:XXJColor(107, 107, 107) textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:self.model != nil ? [NSString stringWithFormat:@"%@ 至 %@",[TYDateUtils timestampSwitchTime:[self.model.c_time integerValue]],[TYDateUtils timestampSwitchTime:[self.model.valid_time integerValue]]] : self.dataDict[@"time"]];
    [startDatelable sizeToFit];
    [self.view addSubview:startDatelable];
    [startDatelable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(thirdImageView);
        make.left.equalTo(thirdImageView.right).offset(realW(20));
        make.height.equalTo(realH(36));
    }];
//    self.startDatelable = startDatelable;
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(242, 242, 242);
    [self.view addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startDatelable.bottom).offset(realH(30));
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(20));
    }];
    
    UILabel * recommendLable = [UILabel lableWithTextColor:XXJColor(161, 161, 161) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"推荐船舶"];
    [recommendLable sizeToFit];
    [self.view addSubview:recommendLable];
    [recommendLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(realH(30));
        make.centerX.equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    RecommendBottomView * bottomView = [[RecommendBottomView alloc]init];
    [bottomView changeTitle:@"没有符合条件的船舶" DetailTitle:@"现在就去找船吧" ButtonTitle:@"现在去找船"];
    bottomView.recommendFindBlock = ^{
        
        
        
        weakSelf.tabBarController.selectedViewController = [weakSelf.tabBarController.viewControllers objectAtIndex:0];
        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
    };
    [self.view addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recommendLable.bottom).offset(realH(30));
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.bottomView = bottomView;
    
    
    
    UITableView * tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 200;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[RecommendTableViewCell class] forCellReuseIdentifier:@"RecommendTableViewCell"];
    [tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recommendLable.bottom).offset(realH(30));
        make.left.bottom.right.equalTo(self.view);
    }];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.max = 20;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf findBoatRequest];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf findBoatRequest];
    }];
    
//    [tableView.mj_header beginRefreshing];
    
    self.tableView = tableView;
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    __weak typeof(self) weakSelf = self;
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HomeBoatModel * model = self.dataArray[indexPath.row];
    
    if (indexPath.row == 0) {
        [cell.topLineView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(realH(1));
        }];
    }
    cell.phoneBlock = ^(NSString *phoneNum) {
        
        weakSelf.phoneCargo_id = model.ship_id;
        
        //打电话
        [weakSelf phoneCall:phoneNum];
    };
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
    
}




#pragma mark -- 找船界面请求
-(void)findBoatRequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"n_port\":\"\",\"weight\":\"\",\"has_cover\":\"\",\"cover_port\":\"\",\"max\":\"%lu\",\"page\":\"%lu\",\"access_token\":\"%@\"",(unsigned long)self.max,(unsigned long)self.page,[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:FindBoat URLMethod:FindBoatMethod parameters:parameterstring finished:^(id result) {
        
        XXJLog(@"%@",result)
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
        NSArray * listArray = resultDict[@"result"][@"list"];
        
        if (![listArray isEqual:[NSNull null]]) {
            
            if (listArray.count == 0) {
                self.bottomView.alpha = 1;
                self.tableView.alpha = 0;
            }
            else
            {
                self.bottomView.alpha = 0;
                self.tableView.alpha = 1;
                
                self.dataArray = [HomeBoatModel mj_objectArrayWithKeyValuesArray:resultDict[@"result"][@"list"]];
                
                [self.tableView reloadData];
                
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }
            
        }
        
    } errored:^(NSError *error) {
        
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}



#pragma mark -- 打电话
-(void)phoneCall:(NSString *)phone
{

    
    
    __weak typeof(self) weakSelf = self;
    
    
    if ([[UseInfo shareInfo].nameApprove isEqualToString:@"认证通过"])
    {
        if ([[UseInfo shareInfo].companyApprove isEqualToString:@"认证通过"]) {
            //打电话
//            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
//            UIWebView * callWebview = [[UIWebView alloc] init];
//            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//            [self.view addSubview:callWebview];
            
            [self checkPhone:phone];
            
            return;
        }
        else
        {
            //判断加入的公司
            if ([[UseInfo shareInfo].joinCompanyApprove isEqualToString:@"认证通过"])
            {
                //打电话
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
                UIWebView * callWebview = [[UIWebView alloc] init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebview];
                
//                [self checkPhone:phone];
                
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


#pragma mark - ************************************************ (监听电话相关)
-(void)phoneCall
{
    HLPhoneInfoController * vc = [[HLPhoneInfoController alloc]init];
    vc.logId = [self.log_id integerValue];
    vc.appLogEvent = 4;
    
    vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
    
//    UIView * coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    coverView.backgroundColor = [UIColor blackColor];
//    coverView.alpha = 0.4;
//    [self.view addSubview:coverView];
//    self.coverView = coverView;
//
//    __weak typeof(self) weakSelf = self;
//    PhoneFeedbackView * feedView = [[PhoneFeedbackView alloc]init];
//    feedView.feedBlock = ^(NSString *s) {
//        if ([s isEqualToString:@"取消"]) {
//
//
//            [weakSelf.coverView removeFromSuperview];
//
//            [weakSelf.feedView removeFromSuperview];
//            weakSelf.coverView = nil;
//            weakSelf.feedView = nil;
//
//
//        }
//        else
//        {
//            [weakSelf feedbackRequest:s];
//        }
//
//    };
//    [self.view addSubview:feedView];
//    [feedView makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - realW(150), SCREEN_WIDTH  - realW(140)));
//        make.centerX.centerY.equalTo(self.view);
//    }];
//    self.feedView = feedView;
}



#pragma mark -- 电话反馈
-(void)checkPhone:(NSString *)phone
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"device\":\"%@\",\"access_token\":\"%@\",\"channel\":\"%i\",\"event\":\"%i\",\"error\":\"%i\",\"obj\":\"%@\"",[[[UIDevice currentDevice] identifierForVendor] UUIDString],[UseInfo shareInfo].access_token,0,4,0,self.phoneCargo_id];
    
    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:AddAppLogMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result);
        
        NSDictionary * boatresult = result;
        
        if ([boatresult[@"result"][@"status"] boolValue]) {
            self.log_id = boatresult[@"result"][@"id"];
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
            
        }
        else
        {
            [self.view makeToast:boatresult[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter];
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}


//#pragma mark -- 获取反馈列表
//-(void)getFeedRemarkList
//{
//    NSString *parameterstring = [NSString stringWithFormat:@"\"event\":\"%d\"",4];
//
//    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:GetAppLogRemarkMethod parameters:parameterstring finished:^(id result) {
//        [SVProgressHUD dismiss];
//        XXJLog(@"%@",result);
//
//        NSDictionary * boatresult = result;
//
//        if ([boatresult[@"result"][@"status"] boolValue]) {
//            //            NSArray * lsitArray = boatresult[@"result"][@"data"];
//        }
//
//    } errored:^(NSError *error) {
//        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
//
//        [SVProgressHUD dismiss];
//    }];
//}
//
//
//
//
//#pragma mark -- 反馈
//-(void)feedbackRequest:(NSString *)s
//{
//
//    [SVProgressHUD show];
//    //deal_id  运单id  access_token  score 评价分数
//    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"log_id\":\"%ld\",\"remark\":\"%@\"",[UseInfo shareInfo].access_token,(long)self.log_id,s];
//
//    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:FeedBackMethod parameters:parameterstring finished:^(id result) {
//        [SVProgressHUD dismiss];
//        XXJLog(@"%@",result);
//
//        NSDictionary * boatresult = result;
//
//        if ([boatresult[@"result"][@"status"] boolValue]) {
//            [self.view makeToast:@"提交成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
////                [GKCover hide];
//
//                [self.coverView removeFromSuperview];
//                [self.feedView removeFromSuperview];
//                self.coverView = nil;
//                self.feedView = nil;
//
//            }];
//        }
//        else
//        {
//            [self.view makeToast:@"提交失败，请重试" duration:0.5 position:CSToastPositionCenter];
//        }
//
//    } errored:^(NSError *error) {
//        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
//
//        [SVProgressHUD dismiss];
//    }];
//
//}








@end
