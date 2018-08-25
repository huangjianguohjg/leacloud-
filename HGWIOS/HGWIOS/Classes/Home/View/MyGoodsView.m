//
//  MyGoodsView.m
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyGoodsView.h"

#import "AlreadyOfferModel.h"

#import "MyGoodsTableViewCell.h"

#import "OfferMessageTableViewCell.h"

@interface MyGoodsView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation MyGoodsView

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateClick) name:@"UpdateSuccess" object:nil];
        
        self.page = 1;
        self.max = 20;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSuccess) name:@"update" object:nil];
        
        [self setUpUI];
        
    }
    return self;
}


-(void)updateSuccess
{
    [self.tableView.mj_header beginRefreshing];
}

-(void)updateClick
{
    [self.tableView.mj_header beginRefreshing];
}


-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight)];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.estimatedRowHeight = 200;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [tableView registerClass:[MyGoodsTableViewCell class] forCellReuseIdentifier:@"MyGoodsTableViewCell"];
    [tableView registerClass:[OfferMessageTableViewCell class] forCellReuseIdentifier:@"OfferMessageTableViewCell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    
    self.tableView = tableView;
    
    __weak typeof(self) weakSelf = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        weakSelf.max = 20;
        [weakSelf.dataArray removeAllObjects];
        
        [weakSelf getMyCargoRequest];
        
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        weakSelf.page += 1;
        
        [weakSelf getMyCargoRequest];
    }];
    
    [tableView.mj_header beginRefreshing];
    
    
    
    
}



#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    if ([self.fromTag isEqualToString:@"报价信息"]) {
        OfferMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OfferMessageTableViewCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    NSString * identifier = [NSString stringWithFormat:@"MyGoodsTableViewCell%ld",indexPath.row];
    
    MyGoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    
    if (cell == nil) {
        cell = [[MyGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.typeLable.alpha = 1;
    
    cell.fromTag = @"我的货盘";
    
    AlreadyOfferModel * model = self.dataArray[indexPath.row];
    
    cell.model = self.dataArray[indexPath.row];
    
    cell.offerBlock = ^(NSString *str) {
        if ([str isEqualToString:@"删除"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除吗" message:@"" preferredStyle:UIAlertControllerStyleAlert ];
            //取消style:UIAlertActionStyleDefault
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                return ;
            }];
            [alertController addAction:cancelAction];
    
            //简直废话:style:UIAlertActionStyleDestructive
            UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf deleteCargoRequest:model.qp_id];
            }];
            [alertController addAction:rubbishAction];
    
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            
            
        }
        else if ([str isEqualToString:@"修改"])
        {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(@"修改",model);
            }
        }
        else if ([str isEqualToString:@"无法修改"])
        {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(@"无法修改",model);
            }
        }
        else if ([str isEqualToString:@"刷新"])
        {
            [weakSelf refreshCargoRequest:model.qp_id];
        }
        else if ([str isEqualToString:@"配船"])
        {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(@"配船",model);
            }
        }
        else if ([str isEqualToString:@"邀请"])
        {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(@"邀请",model);
            }
        }
        else if ([str isEqualToString:@"关闭"])
        {
            [weakSelf closeCargoRequest:model.qp_id];
        }
    };
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlreadyOfferModel * model = self.dataArray[indexPath.row];
    
    if (self.handleBlock) {
        self.handleBlock(@"cell点击", model);
    }
}



#pragma mark -- 删除
-(void)deleteCargoRequest:(NSString *)cargo_id
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"cargo_id\":\"%@\",\"access_token\":\"%@\"",cargo_id,[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:DeleteCargo URLMethod:DeleteCargoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        [self.tableView.mj_header beginRefreshing];
        
    } errored:^(NSError *error) {
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark -- 刷新
-(void)refreshCargoRequest:(NSString *)cargo_id
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"cargo_id\":\"%@\",\"access_token\":\"%@\"",cargo_id,[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:RefreshCargo URLMethod:RefreshCargoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        [self.tableView.mj_header beginRefreshing];
        [self makeToast:@"刷新成功" duration:0.5 position:CSToastPositionCenter];
        
    } errored:^(NSError *error) {
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}

#pragma mark -- 获取我的货盘列表
-(void)getMyCargoRequest
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"max\":\"%lu\",\"page\":\"%lu\",\"access_token\":\"%@\"",(unsigned long)self.max,(unsigned long)self.page,[UseInfo shareInfo].access_token];
    
    
    [XXJNetManager requestPOSTURLString:MyCargo URLMethod:MyCargoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result);
        
        
        
        NSArray * array = [AlreadyOfferModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
        
        [self.dataArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
    } errored:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark -- 关闭货盘
-(void)closeCargoRequest:(NSString *)cargo_id
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"cargo_id\":\"%@\"",cargo_id];
    
    [XXJNetManager requestPOSTURLString:Close URLMethod:CloseMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        [self.tableView.mj_header beginRefreshing];
        
        
        
        
    } errored:^(NSError *error) {
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
