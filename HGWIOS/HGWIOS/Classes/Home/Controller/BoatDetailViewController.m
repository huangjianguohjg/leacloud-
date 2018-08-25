//
//  BoatDetailViewController.m
//  HGWIOS
//
//  Created by 许小军 on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BoatDetailViewController.h"

#import "ShipownerTableViewCell.h"
#import "BoatMessageTableViewCell.h"

#import "BoatDeatilBottomView.h"

#import "HomeBoatModel.h"

#import "ShipMapViewController.h"

#import "ApproveViewController.h"
#import "ChooseApproveViewController.h"
#import "PhoneFeedbackView.h"
#import "HLPhoneInfoController.h"
@interface BoatDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) HomeBoatModel * model;

/**
 记录拨打电话的运单ID
 */
@property (nonatomic, copy) NSString * log_id;

@property (nonatomic, weak) PhoneFeedbackView * feedView;

@property (nonatomic, weak) UIView * coverView;

@end

@implementation BoatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(242, 242, 242);

    self.navigationItem.title = @"船盘详情";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneCall) name:@"PhoneCall" object:nil];
    
//    [self setUpUI];
    
//    //设置底部按钮视图
//    [self setUpBottomView];
    
    [self getBoatDetailRequest];
    
}


-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 100;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[ShipownerTableViewCell class] forCellReuseIdentifier:@"ShipownerTableViewCell"];
    [tableView registerClass:[BoatMessageTableViewCell class] forCellReuseIdentifier:@"BoatMessageTableViewCell"];
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
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 4;
    }
    else if (section == 2)
    {
        return 6;
    }
    else
    {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ShipownerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShipownerTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = self.model;
        
        return cell;
    }
    else
    {
        NSArray * array1 = @[@"可放空地",@"空载日期",@"前载货物",@"意向货量"];
        NSArray * array2 = @[@"船舶名称",@"船舶类型",@"参考载量",@"船舶舱容",@"船舶属性",@"建造年份"];
        NSArray * arrayTitle1 = nil;
        NSArray * arrayTitle2 = nil;
        if (self.model) {
            arrayTitle1 = @[
                            self.model.n_port,
                            [NSString stringWithFormat:@"%@ 至 %@",[self timestampSwitchTime:[self.model.n_time integerValue]],[self timestampSwitchTime:[self.model.e_n_time integerValue]]],
                            self.model.before_cargo,
                            [NSString stringWithFormat:@"%@吨",self.model.cargo_ton]
                            ];
            
            arrayTitle2 = @[
                            self.model.name,
                            self.model.ship.type_name,
                            [NSString stringWithFormat:@"%@吨",self.model.deadweight],
                            [NSString stringWithFormat:@"%@立方米",self.model.storage],
                            self.model.ship.ship_prop_show,
                            self.model.ship.complete_time
                            ];
        }
        
        
        
        BoatMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BoatMessageTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 1) {
            cell.leftLable.text = array1[indexPath.row];
            cell.rightLable.text = arrayTitle1[indexPath.row];
        }
        else if (indexPath.section == 2)
        {
            cell.leftLable.text = array2[indexPath.row];
            cell.rightLable.text = arrayTitle2[indexPath.row];
        }
        else
        {
            cell.leftLable.text = @"备注信息";
            cell.rightLable.text = self.model.remark;
        }
        return cell;
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return realH(50);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = XXJColor(242, 242, 242);
    UILabel * lable = [[UILabel alloc]init];
    lable.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
    lable.textColor = XXJColor(137, 137, 137);
    [lable sizeToFit];
    [headerView addSubview:lable];
    [lable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.left).offset(realW(20));
        make.centerY.equalTo(headerView);
    }];
    if (section == 0) {
        lable.text = @"船东信息";
    }
    else if (section == 1)
    {
        lable.text = @"船期信息";
    }
    else if (section == 2)
    {
        lable.text = @"船舶信息";
    }
    else
    {
        lable.text = @"备注信息";
    }
    
    return headerView;
}



#pragma mark -- 底部按钮视图
-(void)setUpBottomView
{
    __weak typeof(self) weakSelf = self;
    BoatDeatilBottomView * bottomView = [[BoatDeatilBottomView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, realH(150))];
    bottomView.detailBlock = ^(NSString *s) {
        if ([s isEqualToString:@"定位船舶"]) {
            [weakSelf.view makeToast:@"定位船舶" duration:0.5 position:CSToastPositionCenter];
            ShipMapViewController * shipmapVc = [[ShipMapViewController alloc]init];
            shipmapVc.boatId = weakSelf.model.ship_id;
            shipmapVc.shipName = weakSelf.model.name;
            [weakSelf.navigationController pushViewController:shipmapVc animated:YES];
        }
        else if ([s isEqualToString:@"联系船东"])
        {
            [weakSelf phoneCall:weakSelf.model.user.mobile];
        }
    };
    self.tableView.tableFooterView = bottomView;
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
//                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
//                UIWebView * callWebview = [[UIWebView alloc] init];
//                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//                [self.view addSubview:callWebview];
                
                [self checkPhone:phone];
                
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
    NSString *parameterstring = [NSString stringWithFormat:@"\"device\":\"%@\",\"access_token\":\"%@\",\"channel\":\"%i\",\"event\":\"%i\",\"error\":\"%i\",\"obj\":\"%@\"",[[[UIDevice currentDevice] identifierForVendor] UUIDString],[UseInfo shareInfo].access_token,0,4,0,self.model.ship_id];
    
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




#pragma mark -- 获取货盘详情请求
-(void)getBoatDetailRequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"shipping_id\":\"%@\",\"source\":\"2\",\"access_token\":\"%@\"",self.idStr,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:BoatDetail URLMethod:BoatDetailMothod parameters:parameterstring finished:^(id result) {
        
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        NSDictionary * resultDict = (NSDictionary *)result;
        NSDictionary * infoDict = resultDict[@"result"][@"info"];
        
        self.model = [HomeBoatModel mj_objectWithKeyValues:infoDict];
        
        [self setUpUI];
        
        //设置底部按钮视图
        [self setUpBottomView];
        
//        [self.tableView reloadData];
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}


#pragma mark - 将某个时间戳转化成 时间
- (NSString *)timestampSwitchTime:(NSInteger)timestamp{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    //    NSLog(@"1296035591  = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
