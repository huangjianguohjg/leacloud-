//
//  AlreadyOfferViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/28.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AlreadyOfferViewController.h"

#import "MyGoodsTableViewCell.h"
#import "AlreadyOfferModel.h"

#import "GoodsDetailViewController.h"
@interface AlreadyOfferViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation AlreadyOfferViewController

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
    
    self.page = 1;
    self.max = 20;
    
    [self setUpNav];
    
    [self setUpUI];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)setUpNav
{
    self.navigationItem.title = @"已报价信息";

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
    if ([self.fromTag isEqualToString:@"返回首页"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



-(void)setUpUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.estimatedRowHeight = 200;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[MyGoodsTableViewCell class] forCellReuseIdentifier:@"MyGoodsTableViewCell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.max = 20;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf offerListRequest];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf offerListRequest];
    }];
    
    
    
    
    self.tableView = tableView;
    
}



#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyGoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyGoodsTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.alreadyLable.alpha = 0;
    
    cell.cancelButton.alpha = 1;
    cell.ingButton.alpha = 1;
    
    AlreadyOfferModel * model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    __weak typeof(self) weakSelf = self;
    
    cell.offerBlock = ^(NSString *str) {
        if ([str isEqualToString:@"取消报价"]) {
            
            [weakSelf cancelView:model.qp_id];
        }
        else if ([str isEqualToString:@"删除报价"])
        {
            [weakSelf deleteOfferRequest:model.qp_id];
        }
    };
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController * goodsDetailVc = [[GoodsDetailViewController alloc] init];
    goodsDetailVc.fromTag = @"已报价";
//    goodsDetailVc.hidesBottomBarWhenPushed = YES;
    AlreadyOfferModel * model = self.dataArray[indexPath.row];
    goodsDetailVc.idStr = model.cargo_id;
    goodsDetailVc.offerVCModel = nil;
    goodsDetailVc.cargo_Type = model.cargo.cargo_type;
    goodsDetailVc.freight_name = model.cargo.freight_name;
    goodsDetailVc.parent_b = model.cargo.b_port;
    goodsDetailVc.parent_e = model.cargo.e_port;
    goodsDetailVc.cancelID = model.qp_id;
    
    goodsDetailVc.deliver_count = model.cargo.deliver_count;
    goodsDetailVc.negotia = model.cargo.negotia;
    
    [self.navigationController pushViewController:goodsDetailVc animated:YES];
}




#pragma mark -- 已报价列表
-(void)offerListRequest
{
    NSString * business_type = nil;
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
        business_type = @"1";
    }
    else if ([[UseInfo shareInfo].identity isEqualToString:@"货主"])
    {
        business_type = @"2";
    }

    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"max\":\"%lu\",\"page\":\"%lu\",\"business_type\":\"%@\",\"cargo_id\":\"%@\"",[UseInfo shareInfo].access_token,(unsigned long)self.max,(unsigned long)self.page,business_type,@""];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:OfferList URLMethod:OfferListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (![result[@"result"] isEqual:[NSNull null]]) {
            
            for (NSDictionary * modelDict in result[@"result"]) {
                AlreadyOfferModel * model = [AlreadyOfferModel mj_objectWithKeyValues:modelDict];
                [self.dataArray addObject:model];
            }
        }
        else
        {
            if (self.dataArray.count > 0) {
                [self.view makeToast:@"暂无更多数据" duration:0.5 position:CSToastPositionCenter];
            }
            else
            {
                [self.view makeToast:@"暂无数据" duration:0.5 position:CSToastPositionCenter];
            }
        }
        
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark -- 取消报价

-(void)cancelView:(NSString * )qp_id
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定取消报价？" message:@"" preferredStyle:UIAlertControllerStyleAlert ];
    //取消style:UIAlertActionStyleDefault
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alertController addAction:cancelAction];
    
    //简直废话:style:UIAlertActionStyleDestructive
    UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf cancelOfferRequest:qp_id];
        
    }];
    [alertController addAction:rubbishAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)cancelOfferRequest:(NSString * )qp_id
{
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"qp_id\":\"%@\",\"access_token\":\"%@\"",qp_id,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:CancelOffer URLMethod:CancelOfferMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"][@"status"] boolValue]) {
            [self.tableView.mj_header beginRefreshing];
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



#pragma mark -- 删除报价
-(void)deleteOfferRequest:(NSString *)qp_id
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"qp_id\":\"%@\",\"access_token\":\"%@\"",qp_id,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:DeleteOffer URLMethod:DeleteOfferMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
               
        [self offerListRequest];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}















@end
