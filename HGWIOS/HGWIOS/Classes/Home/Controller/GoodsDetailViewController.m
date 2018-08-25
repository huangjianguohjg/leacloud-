//
//  GoodsDetailViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "GoodsDetailViewController.h"

#import "OfferViewController.h"

#import "InviteViewController.h"

#import "GoodsTopTableViewCell.h"
#import "BoatMessageTableViewCell.h"

#import "HomeGoodsModel.h"
#import "ApproveViewController.h"
#import "ChooseApproveViewController.h"
#import "PhoneFeedbackView.h"
#import "HLPhoneInfoController.h"
@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HomeGoodsModel * model;
/**
 记录拨打电话的运单ID
 */
@property (nonatomic, copy) NSString * log_id;

@property (nonatomic, weak) PhoneFeedbackView * feedView;

@property (nonatomic, weak) UIView * coverView;

@end

@implementation GoodsDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(242, 242, 242);
    
    
    self.navigationItem.title = @"货盘详情";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneCall) name:@"PhoneCall" object:nil];
    
    
    [self getGoodsDetailRequest];
}



-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 100;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[GoodsTopTableViewCell class] forCellReuseIdentifier:@"GoodsTopTableViewCell"];
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
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else if (section == 2)
    {
        return 5;
    }
    else if (section == 3)
    {
        return 4;
    }
    else if (section == 4)
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
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        GoodsTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsTopTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self.fromTag isEqualToString:@"未报价"]) {
            cell.phoneButton.alpha = 0;
        }
        cell.phoneBlock = ^(NSString *phoneStr) {
            [weakSelf phoneCall:phoneStr];
        };
        
        cell.model = self.model;
        cell.timesLable.text = [NSString stringWithFormat:@"累计发货%@次/本单洽谈%@次",self.model.deliver_count,self.model.negotia];
        return cell;
    }
    else
    {
        NSArray * array0 = @[@"询价类型"];
        NSArray * array1 = @[@"货物类型",@"货物重量",@"起运港",@"目的港",@"受载期"];
        
        NSArray * array2 = @[@"交接方式",@"合理损耗",@"装卸作业时间",@"滞期费用"];
        
        NSArray * array3 = nil;
        if ([self.model.cons_type isEqualToString:@"1"]) {
            //公开询价
            array3 = @[@"履约保证金",@"结算方式",@"付款方式",@"包含费用",@"参考报价",@"过期时间"];
        }
        else
        {
            //指定询价
            array3 = @[@"履约保证金",@"结算方式",@"付款方式",@"包含费用",@"参考报价",@"开标时间"];
        }
        
        
        NSArray * arrayTitle1 = nil;
        NSArray * arrayTitle2 = nil;
        NSArray * arrayTitle3 = nil;
        if (self.model) {
            
//            NSString * startStr = nil;
//            NSString * endStr = nil;
//            if ([self.fromTag isEqualToString:@"已报价"] || [self.fromTag isEqualToString:@"推荐"]) {
//                startStr = self.parent_b;
//                endStr = self.parent_e;
//            }
//            else
//            {
//                startStr = self.parent_b != nil ? [NSString stringWithFormat:@"%@%@",self.parent_b,self.model.b_port] : self.offerVCModel.b_port;
//                endStr = self.parent_e != nil ? [NSString stringWithFormat:@"%@%@",self.parent_e,self.model.e_port] : self.offerVCModel.e_port;
//            }
            
            arrayTitle1 = @[
                            self.model.cargo_type,//self.cargo_Type
                              [NSString stringWithFormat:@"%@吨 ±%@%@",self.model.weight,self.model.weight_num,@"%"],
                              self.model.b_port,//startStr
                              self.model.e_port,//endStr
                              [NSString stringWithFormat:@"%@ 至 %@",[self timestampSwitchTime:[self.model.b_time integerValue]],
                               [self timestampSwitchTime:[self.model.e_time integerValue]]]
                          ];
            arrayTitle2 = @[
                              [NSString stringWithFormat:@"起运港 %@ - 目的港 %@",self.model.b_hand_type,self.model.e_hand_type],
                              [NSString stringWithFormat:@"%@‰",self.model.loss],
                              [NSString stringWithFormat:@"%@小时",self.model.dock_day],
                              [NSString stringWithFormat:@"%@%@",self.model.demurrage,self.model.demurrage_unit]
                          ];
            arrayTitle3 = @[
                              [self.model.bond isEqualToString:@"0"] ? @"无需支付" : @"双方支付",
                              [self.model.pay_type isEqualToString:@"0"] ? @"线下结算" : @"平台结算",
                              self.model.freight_show,//self.freight_name
                              [self.model.contain_price isEqual:[NSNull null]] ? @"暂无" : self.model.contain_price,
                              [NSString stringWithFormat:@"%@元/吨",self.model.a_cargo_price],
                              [self.model.cons_type isEqualToString:@"1"] ? [self timestampSwitchTime:[self.model.valid_time integerValue] Format:@"YYYY-MM-dd HH:mm:ss"] : [self timestampSwitchTime:[self.model.open_time integerValue] Format:@"YYYY-MM-dd HH:mm:ss"]
                           ];
        }
        
        BoatMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BoatMessageTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 1) {
            cell.leftLable.text = array0[indexPath.row];
            cell.rightLable.text = [self.model.cons_type isEqualToString:@"1"] ? @"公开询价" : @"指定询价";
        }
        else if (indexPath.section == 2)
        {
            cell.leftLable.text = array1[indexPath.row];
            cell.rightLable.text = arrayTitle1[indexPath.row];
        }
        else if (indexPath.section == 3)
        {
            cell.leftLable.text = array2[indexPath.row];
            cell.rightLable.text = arrayTitle2[indexPath.row];
        }
        else if (indexPath.section == 4)
        {
            cell.leftLable.text = array3[indexPath.row];
            cell.rightLable.text = arrayTitle3[indexPath.row];
        }
        else
        {
            cell.leftLable.text = @"备注";
            cell.rightLable.text = self.model.remark;
        }
        return cell;
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return realH(20);
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
    
    return headerView;
}

#pragma mark -- 组头不悬停
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = realH(20);
    CGFloat sectionFooterHeight = realH(0);
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    } else if (offsetY >= sectionHeaderHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    } else if (offsetY >= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height) {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight), 0);
    }
}




#pragma mark -- 底部按钮视图
-(void)setUpBottomView:(NSString *)title
{
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, realH(150))];
    
    
    UIButton * offerButton = [[UIButton alloc]init];
    [offerButton addTarget:self action:@selector(offerClick:) forControlEvents:UIControlEventTouchUpInside];
    [offerButton setTitle:title forState:UIControlStateNormal];
    [offerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    offerButton.backgroundColor = XXJColor(27, 69, 138);
    offerButton.layer.cornerRadius = 5;
    offerButton.clipsToBounds = YES;
    offerButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [bottomView addSubview:offerButton];
    
    [offerButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.centerY.equalTo(bottomView);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
//    if ([self.open isEqualToString:@"正常"]) {
        self.tableView.tableFooterView = bottomView;
//    }
    
}


#pragma mark -- 我要报价
-(void)offerClick:(UIButton *)button
{
    __weak typeof(self) weakSelf = self;

    if ([[UseInfo shareInfo].nameApprove isEqualToString:@"认证通过"])
    {
        if ([[UseInfo shareInfo].companyApprove isEqualToString:@"认证通过"]) {
            if ([button.currentTitle isEqualToString:@"邀请报价"]) {
                InviteViewController * inviteVc = [[InviteViewController alloc]init];
                inviteVc.cargo_id = self.idStr;
                [self.navigationController pushViewController:inviteVc animated:YES];
            }
            else if ([button.currentTitle isEqualToString:@"我要报价"])
            {
                OfferViewController * offerVc = [[OfferViewController alloc]init];
                offerVc.model = self.model;
                [self.navigationController pushViewController:offerVc animated:YES];
            }
            else if ([button.currentTitle isEqualToString:@"取消报价"])
            {
                [self cancelOfferRequest:self.cancelID];
            }
            
            return;
        }
        else
        {
            //判断加入的公司
            if ([[UseInfo shareInfo].joinCompanyApprove isEqualToString:@"认证通过"])
            {
                if ([button.currentTitle isEqualToString:@"邀请报价"]) {
                    InviteViewController * inviteVc = [[InviteViewController alloc]init];
                    inviteVc.cargo_id = self.idStr;
                    [self.navigationController pushViewController:inviteVc animated:YES];
                }
                else if ([button.currentTitle isEqualToString:@"我要报价"])
                {
                    OfferViewController * offerVc = [[OfferViewController alloc]init];
                    offerVc.model = self.model;
                    [self.navigationController pushViewController:offerVc animated:YES];
                }
                else if ([button.currentTitle isEqualToString:@"取消报价"])
                {
                    [self cancelOfferRequest:self.cancelID];
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

#pragma mark -- 取消报价
-(void)cancelOfferRequest:(NSString * )qp_id
{
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"qp_id\":\"%@\",\"access_token\":\"%@\"",qp_id,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:CancelOffer URLMethod:CancelOfferMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"][@"status"] boolValue]) {
            
            [self.view makeToast:@"取消报价成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
  
        }
        else
        {
            [self.view makeToast:@"取消报价失败" duration:0.5 position:CSToastPositionCenter];
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}


#pragma mark -- 获取货盘详情请求
-(void)getGoodsDetailRequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"cargo_id\":\"%@\",\"source\":\"2\",\"access_token\":\"%@\"",self.idStr,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GoodDetail URLMethod:GoodDetailMethod parameters:parameterstring finished:^(id result) {
        
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
        if (![resultDict[@"result"][@"status"] boolValue]) {
            
            [self.view makeToast:@"获取详情失败" duration:1.0 position:CSToastPositionCenter];
            
            return ;
        }
        
        NSDictionary * infoDict = resultDict[@"result"][@"info"];
        
        self.model = [HomeGoodsModel mj_objectWithKeyValues:infoDict];
        
//        [self.dataArray addObject:model];
        
        [self setUpUI];
//        //设置底部按钮视图
//        if ([self.fromTag isEqualToString:@"货主查看货盘信息"])
//        {
//            
//        }
//        else if([self.fromTag isEqualToString:@"找货"])
//        {
//            [self setUpBottomView:@"我要报价"];
//        }
        
        
        
        
        
//        [self.tableView reloadData];
        
        if ([self.fromTag isEqualToString:@"货主查看货盘信息"])
        {
            if ([self.model.cons_type isEqualToString:@"0"]) {
                NSString * openTime = [TYDateUtils timestampSwitchTime:[self.model.open_time integerValue] Format:@"YYYY-MM-dd hh:mm:ss"];
                if ([TYDateUtils compareDate:openTime withDate:[TYDateUtils getCurentDateWithFormat:@"YYYY-MM-dd hh:mm:ss"] formate:@"YYYY-MM-dd hh:mm:ss"] == -1) {
                    [self setUpBottomView:@"邀请报价"];
                }
                
            }
        }
        else if([self.fromTag isEqualToString:@"找货"])
        {
            [self setUpBottomView:@"我要报价"];
        }
        else if ([self.fromTag isEqualToString:@"已报价"])
        {
            [self setUpBottomView:@"取消报价"];
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
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
    vc.appLogEvent = 5;
    
    vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:vc animated:YES completion:nil];
    
    

}



#pragma mark -- 电话反馈
-(void)checkPhone:(NSString *)phone
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"device\":\"%@\",\"access_token\":\"%@\",\"channel\":\"%i\",\"event\":\"%i\",\"error\":\"%i\",\"obj\":\"%@\"",[[[UIDevice currentDevice] identifierForVendor] UUIDString],[UseInfo shareInfo].access_token,0,4,0,self.model.cargo_id];
    
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


#pragma mark -- 获取反馈列表
-(void)getFeedRemarkList
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"event\":\"%d\"",4];
    
    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:GetAppLogRemarkMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result);
        
        NSDictionary * boatresult = result;
        
        if ([boatresult[@"result"][@"status"] boolValue]) {
            //            NSArray * lsitArray = boatresult[@"result"][@"data"];
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}




#pragma mark -- 反馈
-(void)feedbackRequest:(NSString *)s
{
    
    [SVProgressHUD show];
    //deal_id  运单id  access_token  score 评价分数
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"log_id\":\"%ld\",\"remark\":\"%@\"",[UseInfo shareInfo].access_token,(long)self.log_id,s];
    
    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:FeedBackMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result);
        
        NSDictionary * boatresult = result;
        
        if ([boatresult[@"result"][@"status"] boolValue]) {
            [self.view makeToast:@"提交成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {

                
                
                [self.coverView removeFromSuperview];
                [self.feedView removeFromSuperview];
                self.coverView = nil;
                self.feedView = nil;
                
            }];
        }
        else
        {
            [self.view makeToast:@"提交失败，请重试" duration:0.5 position:CSToastPositionCenter];
        }
        
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

- (NSString *)timestampSwitchTime:(NSInteger)timestamp Format:(NSString *)format
{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
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
    [[NSNotificationCenter defaultCenter]removeObserver:self];;
}



@end
