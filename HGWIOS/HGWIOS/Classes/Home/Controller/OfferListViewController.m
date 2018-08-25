//
//  OfferListViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "OfferListViewController.h"

#import "OfferListTableViewCell.h"

#import "OfferListModel.h"

#import "MyTransportViewController.h"

@interface OfferListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@end

@implementation OfferListViewController

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
    
    [self setUpUI];
    
//    [self offerListRequest];
}


-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 200;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[OfferListTableViewCell class] forCellReuseIdentifier:@"OfferListTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
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
    
    [tableView.mj_header beginRefreshing];
    
    
    
    self.tableView = tableView;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfferListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OfferListTableViewCell"];
    OfferListModel * model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    
    __weak typeof(self) weakSelf = self;
    cell.offerBlock = ^(OfferListModel *model) {
        [weakSelf selectDealRequest:model];
    };
    
    return cell;
}


//报价列表
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
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"max\":\"%lu\",\"page\":\"%lu\",\"business_type\":\"%@\",\"cargo_id\":\"%@\"",[UseInfo shareInfo].access_token,(unsigned long)self.max,(unsigned long)self.page,business_type,self.cargo_id];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:OfferList URLMethod:OfferListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)

        
        if (![result[@"result"] isEqual:[NSNull null]]) {
            
            for (NSDictionary * modelDict in result[@"result"]) {
                OfferListModel * model = [OfferListModel mj_objectWithKeyValues:modelDict];
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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}

#pragma mark -- 选中报价
-(void)selectDealRequest:(OfferListModel *)model
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"cargo_id\":\"%@\",\"ship_id\":\"%@\",\"access_token\":\"%@\"",model.cargo_id,model.ship_id,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:SelectDeal URLMethod:SelectDealMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        if (result[@"result"][@"msg"]) {
            [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
        }
        else
        {
            [self.view makeToast:@"中标成功" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                
                MyTransportViewController * tranVc = [[MyTransportViewController alloc]init];
                [self.navigationController pushViewController:tranVc animated:YES];
                
            }];
            
            
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}























@end
