//
//  RecommendGoodsViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "RecommendGoodsViewController.h"
#import "MyBoatModel.h"
#import "RecommendView.h"
#import "RecommendBottomView.h"
#import "HomeGoodsTableViewCell.h"
#import "HomeBoatModel.h"
#import "HomeGoodsModel.h"
#import "ApproveViewController.h"
#import "ChooseApproveViewController.h"
#import "HomeGoodsViewController.h"
#import "GoodsDetailViewController.h"
#import "PhoneFeedbackView.h"
#import "HLPhoneInfoController.h"
#import "ShipEmptyViewController.h"
@interface RecommendGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UIButton * button;

@property (nonatomic, weak) RecommendView * recommendView;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, weak) RecommendBottomView * bottomView;

/**
 记录拨打电话的运单ID
 */
@property (nonatomic, copy) NSString * phoneCargo_id;
@property (nonatomic, copy) NSString * log_id;

@property (nonatomic, weak) PhoneFeedbackView * feedView;

@property (nonatomic, weak) UIView * coverView;

@property (nonatomic, strong) HomeBoatModel * boatDetailModel;

@end

@implementation RecommendGoodsViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneCall) name:@"PhoneCall" object:nil];
    
    self.page = 1;
    self.max = 20;
    
    self.navigationItem.title = @"报空成功,推荐货盘";
    
//    [self setUpUI:nil];
    
//    [self setUpUI];
    
    [self getBoatDetailRequest];
    
    
}


-(void)setUpUI:(HomeBoatModel *)boatDetailModel
{
    
    __weak typeof(self) weakSelf = self;
    
    //第一行图片
    UIImageView * firstImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ship_icon_ship"]];
    [self.view addSubview:firstImageView];
    [firstImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(realW(10));
        make.top.equalTo(self.view).offset(realH(20) + kStatusBarHeight + kNavigationBarHeight);
        make.size.equalTo(CGSizeMake(realW(50), realH(50)));
    }];
    
    //船名
    UILabel * boatNameLable = [UILabel lableWithTextColor:[UIColor darkGrayColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"%@ %@吨 %@",boatDetailModel.name,boatDetailModel.deadweight,boatDetailModel.ship.type_name]];
    [boatNameLable sizeToFit];
    [self.view addSubview:boatNameLable];
    [boatNameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstImageView.right).offset(realW(20));
        make.centerY.equalTo(firstImageView);
    }];
//    self.boatNameLable = boatNameLable;
    

    
    //第二行图片
    UIImageView * secondImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_k"]];
    [self.view addSubview:secondImageView];
    [secondImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(realW(10));
        make.top.equalTo(firstImageView.bottom).offset(realH(10));
        make.size.equalTo(CGSizeMake(realW(50), realH(50)));
    }];
    
    
    //地址
    UILabel * addressLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"%@",boatDetailModel.f_port]];
    [addressLable sizeToFit];
    [self.view addSubview:addressLable];
    [addressLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondImageView.right).offset(realW(20));
        make.centerY.equalTo(secondImageView);
    }];
//    self.addressLable = addressLable;
    
    
    //第三行图片
    UIImageView * thirdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cargo_ship_rq02_03"]];
    [self.view addSubview:thirdImageView];
    [thirdImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(realW(10));
        make.top.equalTo(secondImageView.bottom).offset(realH(10));
        make.size.equalTo(CGSizeMake(realW(50), realH(50)));
    }];
    
    //起始时间
    UILabel * startLable = [UILabel lableWithTextColor:XXJColor(115, 115, 115) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"%@ 至 %@",[TYDateUtils timestampSwitchTime:[boatDetailModel.n_time integerValue]],[TYDateUtils timestampSwitchTime:[boatDetailModel.e_n_time integerValue]]]];
    [startLable sizeToFit];
    [self.view addSubview:startLable];
    [startLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdImageView.right).offset(realW(20));
        make.centerY.equalTo(thirdImageView);
    }];
//    self.startLable = startLable;
    
    UIButton * button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    button.layer.borderColor = XXJColor(225, 225, 225).CGColor;
    button.layer.borderWidth = realW(4);
    [self.view addSubview:button];
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(realW(-4));
        make.top.equalTo(thirdImageView.bottom).offset(realH(10));
        make.right.equalTo(self.view).offset(realW(4));
        make.height.equalTo(realH(70));
    }];
    self.button = button;
    
    
    RecommendView * recommendView = [[RecommendView alloc]init];
//    recommendView.recommendBlock = ^(NSString *s) {
//        if ([s isEqualToString:@"刷新"]) {
//            [weakSelf refreshBoatRequest];
//        }
//        else
//        {
//            [weakSelf deleteBoatRequest];
//        }
//    };
    recommendView.alpha = 0;
    recommendView.model = boatDetailModel;
    [self.view addSubview:recommendView];
    [recommendView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(0);
    }];
    self.recommendView = recommendView;
    
    
    UIButton * deleteButton = [[UIButton alloc]init];
    [deleteButton addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deleteButton.layer.cornerRadius = realW(5);
    deleteButton.clipsToBounds = YES;
    deleteButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    deleteButton.backgroundColor = XXJColor(115, 160, 227);
    [self.view addSubview:deleteButton];
    [deleteButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(realW(-40));
        make.top.equalTo(recommendView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
//        make.bottom.equalTo(self).offset(realH(-10));
    }];
    
    
    UIButton * refeshButton = [[UIButton alloc]init];
    [refeshButton addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [refeshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [refeshButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    refeshButton.layer.cornerRadius = realW(5);
    refeshButton.clipsToBounds = YES;
    refeshButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    refeshButton.backgroundColor = XXJColor(115, 160, 227);
    [self.view addSubview:refeshButton];
    [refeshButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(deleteButton.left).offset(realW(-20));
        make.top.equalTo(recommendView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
    }];
    
    UIButton * updateButton = [[UIButton alloc]init];
    [updateButton addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [updateButton setTitle:@"修改" forState:UIControlStateNormal];
    [updateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    updateButton.layer.cornerRadius = realW(5);
    updateButton.clipsToBounds = YES;
    updateButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    updateButton.backgroundColor = XXJColor(115, 160, 227);
    [self.view addSubview:updateButton];
    [updateButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(refeshButton.left).offset(realW(-20));
        make.top.equalTo(recommendView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
    }];
    
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(242, 242, 242);
    [self.view addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(deleteButton.bottom).offset(realH(30));
        make.left.equalTo(self.view);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, realH(30)));
    }];
    
    
    
    
    UIButton * recommendButton = [[UIButton alloc]init];
    [recommendButton setTitle:@"推荐货源" forState:UIControlStateNormal];
    [recommendButton setTitleColor:XXJColor(158, 158, 158) forState:UIControlStateNormal];
    recommendButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
    recommendButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:recommendButton];
    [recommendButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(88));
    }];
    
    
    
    RecommendBottomView * bottomView = [[RecommendBottomView alloc]init];
    bottomView.recommendFindBlock = ^{

        weakSelf.tabBarController.selectedViewController = [weakSelf.tabBarController.viewControllers objectAtIndex:0];
        
        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
    };
    [self.view addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recommendButton.bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.bottomView = bottomView;
    
    
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[HomeGoodsTableViewCell class] forCellReuseIdentifier:@"HomeGoodsTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recommendButton.bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.max = 20;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf findGoodsRequest];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf findGoodsRequest];
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)){
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [tableView.mj_header beginRefreshing];
    
    self.tableView = tableView;
    
    
    
}





-(void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.recommendView updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(realH(300 - 80));
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.recommendView.alpha = 1;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            [self.recommendView updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(realH(0));
            }];
            [self.view layoutIfNeeded];
        }];
        self.recommendView.alpha = 0;
    }
    
    
}

-(void)butClick:(UIButton *)button
{
    if ([button.currentTitle isEqualToString:@"删除"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除该船盘吗" message:@"" preferredStyle:UIAlertControllerStyleAlert ];
        //取消style:UIAlertActionStyleDefault
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alertController addAction:cancelAction];
        
        //简直废话:style:UIAlertActionStyleDestructive
        UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self deleteBoatRequest];
            
        }];
        [alertController addAction:rubbishAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else if ([button.currentTitle isEqualToString:@"修改"])
    {
        __weak typeof(self) weakSelf = self;
        ShipEmptyViewController * vc = [[ShipEmptyViewController alloc]init];
        vc.emptyUpdateBlock = ^{
            for (UIView * view in self.view.subviews) {
                [view removeFromSuperview];
            }
            [weakSelf getBoatDetailRequest];
        };
        vc.updateModel = self.boatDetailModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self refreshBoatRequest];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    HomeGoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeGoodsTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HomeGoodsModel * model = self.dataArray[indexPath.row];
    
    cell.model = self.dataArray[indexPath.row];
    
    cell.phoneBlock = ^(NSString *phoneNum) {
        self.phoneCargo_id = model.cargo_id;
        
        //打电话
        [weakSelf phoneCall:phoneNum];
        
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController * goodsDetailVc = [[GoodsDetailViewController alloc] init];
    goodsDetailVc.fromTag = @"推荐";
    goodsDetailVc.hidesBottomBarWhenPushed = YES;
    HomeGoodsModel * model = self.dataArray[indexPath.row];
    goodsDetailVc.idStr = model.cargo_id;
    goodsDetailVc.offerVCModel = model;
    goodsDetailVc.parent_b = model.b_port;
    goodsDetailVc.parent_e = model.e_port;
    goodsDetailVc.freight_name = model.freight_name;
    goodsDetailVc.cargo_Type = model.cargo_type_name;
    goodsDetailVc.deliver_count = model.deliver_count;
    goodsDetailVc.negotia = model.negotia;
    
    [self.navigationController pushViewController:goodsDetailVc animated:YES];
    
}








#pragma mark -- 获取货盘详情请求
-(void)getBoatDetailRequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"shipping_id\":\"%@\",\"source\":\"2\",\"access_token\":\"%@\"",self.model.shipping.id,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:BoatDetail URLMethod:BoatDetailMothod parameters:parameterstring finished:^(id result) {
        
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (![result[@"result"][@"status"] boolValue]) {
            
            [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
            
            return ;
            
        }
        
        NSDictionary * resultDict = (NSDictionary *)result;
        NSDictionary * infoDict = resultDict[@"result"][@"info"];
        
        HomeBoatModel * boatDetailModel = [HomeBoatModel mj_objectWithKeyValues:infoDict];
        
        [self setUpUI:boatDetailModel];
        
//        [self findGoodsRequest];
        
        self.boatDetailModel = boatDetailModel;
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}






#pragma mark -- 找货请求
-(void)findGoodsRequest
{
    NSString *parameterstring = nil;
    
    parameterstring = [NSString stringWithFormat:@"\"b_port\":\"%@\",\"e_port\":\"\",\"weight\":\"%@\",\"valid_day\":\"\",\"pay_type\":\"%@\",\"bond\":\"%@\",\"max\":\"%lu\",\"page\":\"%lu\",\"access_token\":\"%@\"",
                       self.model.shipping.f_port_id,
                       @"",
                       @"",
                       @"",
                       (unsigned long)self.max,
                       (unsigned long)self.page,
                       [UseInfo shareInfo].access_token];
    

    //    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:FindGoods URLMethod:FindGoodsMethod parameters:parameterstring finished:^(id result) {
        //        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result isEqual:[NSNull null]] || result == nil || [result[@"result"] isEqual:[NSNull null]]) {
            if (self.dataArray.count > 0) {
                self.bottomView.alpha = 0;
                self.tableView.alpha = 1;
                [self.view makeToast:@"暂无更多货盘" duration:1.0 position:CSToastPositionCenter];
            }
            else
            {
                self.bottomView.alpha = 1;
                self.tableView.alpha = 0;
                [self.view makeToast:@"暂无符合条件货盘" duration:1.0 position:CSToastPositionCenter];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
        NSArray * listArray = resultDict[@"result"][@"list"];
        
        if ([listArray isEqual:[NSNull null]]) {
            if (self.dataArray.count > 0) {
                self.bottomView.alpha = 0;
                self.tableView.alpha = 1;
                [self.view makeToast:@"暂无更多货盘" duration:1.0 position:CSToastPositionCenter];
            }
            else
            {
                self.bottomView.alpha = 1;
                self.tableView.alpha = 0;
                [self.view makeToast:@"暂无符合条件货盘" duration:1.0 position:CSToastPositionCenter];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        
        for (NSDictionary * modelDict in listArray) {
            
            HomeGoodsModel * model = [HomeGoodsModel mj_objectWithKeyValues:modelDict];
            if ([model.show isEqualToString:@"1"]) {
                [self.dataArray addObject:model];
            }
            
        }
        
        if (self.dataArray.count == 0) {
            self.bottomView.alpha = 1;
            self.tableView.alpha = 0;
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
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
//                //                [GKCover hide];
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



#pragma mark -- 删除
-(void)deleteBoatRequest
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"shipping_id\":\"%@\",\"access_token\":\"%@\"",self.model.shipping.id,[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:DeleteShipEmpty URLMethod:DeleteShipEmptyMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"][@"status"] boolValue]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
        }
        
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark -- 刷新
-(void)refreshBoatRequest
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"shipping_id\":\"%@\",\"access_token\":\"%@\"",self.model.ship_id,[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:BoatRefresh URLMethod:BoatRefreshMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        if ([result[@"result"][@"status"] boolValue]) {
            
            [self.tableView.mj_header beginRefreshing];
            
        }
        else
        {
            [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
        }
        
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}










@end
