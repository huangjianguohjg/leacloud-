//
//  WaitUnloadViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "WaitUnloadViewController.h"
#import "TransportTableViewCell.h"
#import "AlreadyOfferModel.h"

#import "MyTransDetailViewController.h"

#import "UploadBillViewController.h"
#import "DiscussOtherViewController.h"
#import "PayBondViewController.h"
#import "UploadContractViewController.h"


@interface WaitUnloadViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) BOOL isHandle;

@end

@implementation WaitUnloadViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.isHandle = NO;
    
    self.page = 1;
    
    self.max = 20;
    
    [self setUpUI];
    
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if (self.isHandle) {
        [self.tableView.mj_header beginRefreshing];
        self.isHandle = NO;
    }
}


-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 250;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[TransportTableViewCell class] forCellReuseIdentifier:@"TransportTableViewCell"];
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
        [weakSelf transPortRequest];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf transPortRequest];
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
    TransportTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TransportTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.fromTag = @"待卸货";
    cell.model = self.dataArray[indexPath.row];
    
    AlreadyOfferModel * model = self.dataArray[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.transportBlock = ^(NSString *s) {
        if ([s isEqualToString:@"上传发货单"] || [s isEqualToString:@"上传收货单"]) {
            UploadBillViewController * billVc = [[UploadBillViewController alloc]init];
            billVc.titleStr = s;
            billVc.cargo_id = model.id;
            [weakSelf.navigationController pushViewController:billVc animated:YES];
        }
        else if ([s isEqualToString:@"支付履约保证金"])
        {
            PayBondViewController * bondVc = [[PayBondViewController alloc]init];
            bondVc.titleStr = s;
            bondVc.cargo_id = model.id;
            [weakSelf.navigationController pushViewController:bondVc animated:YES];
        }
        else if ([s isEqualToString:@"支付预付运费"] || [s isEqualToString:@"支付结算运费"])
        {
            PayBondViewController * bondVc = [[PayBondViewController alloc]init];
            bondVc.titleStr = s;
            bondVc.cargo_id = model.id;
            
            [weakSelf.navigationController pushViewController:bondVc animated:YES];
        }
        else if ([s isEqualToString:@"评价对方"])
        {
            DiscussOtherViewController * disscussVc = [[DiscussOtherViewController alloc]init];
            disscussVc.titleStr = s;
            disscussVc.cargo_id = model.id;
            [weakSelf.navigationController pushViewController:disscussVc animated:YES];
        }
        else if ([s isEqualToString:@"上传合同"])
        {
            UploadContractViewController * uploadVc = [[UploadContractViewController alloc]init];
            uploadVc.titleStr = s;
            uploadVc.cargo_id = model.id;
            [weakSelf.navigationController pushViewController:uploadVc animated:YES];
        }
        
        weakSelf.isHandle = YES;
        
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlreadyOfferModel * model = self.dataArray[indexPath.row];
    MyTransDetailViewController * myTransDetailVc = [[MyTransDetailViewController alloc]init];
    myTransDetailVc.cargo_id = model.cargo_id;
    myTransDetailVc.detail_id = model.id;
    [self.navigationController pushViewController:myTransDetailVc animated:YES];
}

-(void)transPortRequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"deal_status\":\"%@\",\"max\":\"%lu\",\"page\":\"%lu\",\"access_token\":\"%@\"",@"2",(unsigned long)self.max,(unsigned long)self.page,[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetTransport URLMethod:GetTransportMethod parameters:parameterstring finished:^(id result) {
        
        XXJLog(@"%@",result);
        
        if (![result[@"result"][@"status"] boolValue]) {
            [self.view makeToast:result[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        NSArray * array = result[@"result"][@"list"];
        
        if (![array isEqual:[NSNull null]]) {
            
            if (array.count > 0) {
                
                NSArray * modelArray = [AlreadyOfferModel mj_objectArrayWithKeyValuesArray:result[@"result"][@"list"]];
                
                [self.dataArray addObjectsFromArray:modelArray];
            }
            else
            {
                if (self.dataArray.count > 0) {
                    [self.view makeToast:@"暂无更多数据" duration:1.0 position:CSToastPositionCenter];
                }
                else
                {
                    [self.view makeToast:@"暂无数据" duration:1.0 position:CSToastPositionCenter];
                }
            }
        }
        else
        {
            if (self.dataArray.count > 0) {
                [self.view makeToast:@"暂无更多数据" duration:1.0 position:CSToastPositionCenter];
            }
            else
            {
                [self.view makeToast:@"暂无数据" duration:1.0 position:CSToastPositionCenter];
            }
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } errored:^(NSError *error) {
        
        [self.view makeToast:@"请求异常" duration:1.0 position:CSToastPositionCenter];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}



@end
