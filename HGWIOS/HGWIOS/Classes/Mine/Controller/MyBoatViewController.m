//
//  MyBoatViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyBoatViewController.h"

#import "AddBoatViewController.h"

#import "ChangeViewController.h"

#import "AlreadyOfferViewController.h"

#import "MyBoatTableViewCell.h"

#import "MyBoatModel.h"

#import "ShipEmptyViewController.h"

#import "ApproveViewController.h"
#import "ChooseApproveViewController.h"

#import "RecommendGoodsViewController.h"

@interface MyBoatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, weak) UITableView * tableView;

@end

@implementation MyBoatViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXJColor(242, 242, 242);
    
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
    self.navigationItem.title = @"我的船舶";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    
    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"arrow-appbar-left"] forState:UIControlStateNormal];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    UIButton * rightButton = [[UIButton alloc]init];
    [rightButton addTarget:self action:@selector(rightItem) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"已报价" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
}

-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightItem
{
    AlreadyOfferViewController * alreadyVc = [[AlreadyOfferViewController alloc]init];
    [self.navigationController pushViewController:alreadyVc animated:YES];
}

-(void)setUpUI
{
    CGFloat margin = 0;
    if (isIPHONEX) {
        margin = 34;
    }
    
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 200;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[MyBoatTableViewCell class] forCellReuseIdentifier:@"MyBoatTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.bottom.equalTo(self.view).offset(realH(-140) - margin);
        make.left.right.equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.max = 20;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf myShipRequest];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf myShipRequest];
    }];
    
    [tableView.mj_header beginRefreshing];
    
    self.tableView = tableView;
    
    
    
    //添加船舶
    UIButton * addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"添加船舶" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.backgroundColor = XXJColor(27, 69, 138);
    addButton.layer.cornerRadius = 5;
    addButton.clipsToBounds = YES;
    addButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:addButton];
    
    [addButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(realH(-20) - margin);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyBoatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyBoatTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.myBoatBlock = ^(NSString *s ,NSString * ship_id) {
        if ([s isEqualToString:@"删除"]) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除吗" message:nil preferredStyle:UIAlertControllerStyleAlert ];
            //取消style:UIAlertActionStyleDefault
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                return ;
            }];
            [alertController addAction:cancelAction];
    
            //简直废话:style:UIAlertActionStyleDestructive
            UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf deleteShipRequest:ship_id];
            }];
            [alertController addAction:rubbishAction];
    
            [weakSelf presentViewController:alertController animated:YES completion:nil];
            
            
        }
        else if ([s isEqualToString:@"认证通过"])
        {
            [weakSelf.view makeToast:@"已认证船舶无法删除" duration:0.5 position:CSToastPositionCenter];
        }
        else if ([s isEqualToString:@"编辑"])
        {
            AddBoatViewController * addVc = [[AddBoatViewController alloc]init];
            addVc.model = weakSelf.dataArray[indexPath.row];
            [weakSelf.navigationController pushViewController:addVc animated:YES];
        }
        else if ([s isEqualToString:@"变更业务员"])
        {
            if ([UseInfo shareInfo].is_admin) {
                ChangeViewController * changeVc = [[ChangeViewController alloc]init];
                changeVc.model = weakSelf.dataArray[indexPath.row];
                [weakSelf.navigationController pushViewController:changeVc animated:YES];
            }
            else
            {
                [self.view makeToast:@"您不是管理员，不能执行该操作" duration:0.5 position:CSToastPositionCenter];
            }
            
        }
    };
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBoatModel * model = self.dataArray[indexPath.row];
    
    if ([model.review_status_name isEqualToString:@"待审核"] || [model.review_status_name isEqualToString:@"认证失败"]) {
        AddBoatViewController * addVc = [[AddBoatViewController alloc]init];
        addVc.model = model;
        [self.navigationController pushViewController:addVc animated:YES];
        
        return;
    }
    
    if ([model.status isEqualToString:@"1"]) {
        
        [self.view makeToast:@"船舶已禁用,需启用请联系管理员" duration:1.0 position:CSToastPositionCenter];
        
    }
    else
    {
        if ([model.shipping.shipping_status_name isEqualToString:@"未报空"]) {
            __weak typeof(self) weakSelf = self;
            
            if ([[UseInfo shareInfo].nameApprove isEqualToString:@"认证通过"])
            {
                if ([[UseInfo shareInfo].companyApprove isEqualToString:@"认证通过"]) {
                    //打电话
                    ShipEmptyViewController * emptyVc = [[ShipEmptyViewController alloc]init];
                    
                    emptyVc.model = model;
                    
                    [self.navigationController pushViewController:emptyVc animated:YES];
                    
                    return;
                }
                else
                {
                    //判断加入的公司
                    if ([[UseInfo shareInfo].joinCompanyApprove isEqualToString:@"认证通过"])
                    {
                        //打电话
                        ShipEmptyViewController * emptyVc = [[ShipEmptyViewController alloc]init];
                        
                        emptyVc.model = model;
                        
                        [self.navigationController pushViewController:emptyVc animated:YES];
                        
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
        else
        {
            RecommendGoodsViewController * goodVc = [[RecommendGoodsViewController alloc]init];

            goodVc.model = model;

            [self.navigationController pushViewController:goodVc animated:YES];
            
            
        }
    }
    
    
}


#pragma mark -- 添加船舶
-(void)addClick
{
    
    
    
    AddBoatViewController * addVc = [[AddBoatViewController alloc]init];
    [self.navigationController pushViewController:addVc animated:YES];
}


#pragma mark -- 请求我的船舶
-(void)myShipRequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"max\":\"%lu\",\"page\":\"%lu\"",[UseInfo shareInfo].access_token,(unsigned long)self.max,(unsigned long)self.page];
    
    [XXJNetManager requestPOSTURLString:MyShip URLMethod:MyShipMethod parameters:parameterstring finished:^(id result) {
        
        XXJLog(@"%@",result)
        
        if (![result[@"result"][@"status"] boolValue]) {
            
            [self.view makeToast:@"暂无数据" duration:0.5 position:CSToastPositionCenter];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
        NSArray * listArray = resultDict[@"result"][@"list"];
        
        if (listArray != nil) {
            self.dataArray = [MyBoatModel mj_objectArrayWithKeyValuesArray:resultDict[@"result"][@"list"]];
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






#pragma mark -- 删除
-(void)deleteShipRequest:(NSString *)ship_id
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"ship_id\":\"%@\",\"access_token\":\"%@\"",ship_id,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:DeleteShip URLMethod:DeleteShipMethod parameters:parameterstring finished:^(id result) {
        
        NSDictionary * resultDict = (NSDictionary *)result;
        BOOL status = resultDict[@"result"][@"status"];
        
        if (status == YES) {
            XXJLog(@"11111")
            [SVProgressHUD showWithStatus:@"删除成功"];
            [SVProgressHUD dismissWithDelay:0.5 completion:^{
                [self.tableView.mj_header beginRefreshing];
            }];
        }
        else
        {
            [SVProgressHUD showWithStatus:@"删除失败"];
            [SVProgressHUD dismissWithDelay:0.5];
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}






















@end
