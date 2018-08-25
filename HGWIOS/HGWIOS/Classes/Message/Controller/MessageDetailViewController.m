//
//  MessageDetailViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetailTableViewCell.h"
#import "MessageDetailModel.h"
#import "WebViewController.h"
#import "MyTransportViewController.h"
#import "SendGoodsViewController.h"
#import "GoodsDetailViewController.h"
#import "MyGoodsViewController.h"
#import "MyTransDetailViewController.h"
@interface MessageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@end

@implementation MessageDetailViewController



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
    
    self.navigationItem.title = self.titleStr;
    
    [self setUpUI];
    
}



-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(234, 239, 245);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 300;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[MessageDetailTableViewCell class] forCellReuseIdentifier:@"MessageDetailTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.max = 20;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf messageDetailList];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf messageDetailList];
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
    MessageDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MessageDetailTableViewCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.fromTag = self.titleStr;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailModel * model = self.dataArray[indexPath.row];
    
    if (![self.titleStr isEqualToString:@"系统消息"]) {
        MessageDetailModel * model = self.dataArray[indexPath.row];
        
        WebViewController * webVc = [[WebViewController alloc]init];
        webVc.link = model.link;
        webVc.titleStr = @"详情";
        webVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVc animated:YES];
    }
    else
    {
        if ([model.type isEqualToString:@"2"]) {
//            MyTransportViewController * mytrainsportVc = [[MyTransportViewController alloc]init];
//            mytrainsportVc.fromTag = @"消息";
//            [self.navigationController pushViewController:mytrainsportVc animated:YES];
            
            
            MessageDetailModel * model = self.dataArray[indexPath.row];
            MyTransDetailViewController * myTransDetailVc = [[MyTransDetailViewController alloc]init];
            myTransDetailVc.cargo_id = model.cargo_id;
            myTransDetailVc.detail_id = model.deal_id;
            [self.navigationController pushViewController:myTransDetailVc animated:YES];
            
        }
        else if ([model.type isEqualToString:@"4"])
        {
            GoodsDetailViewController * goodsVc = [[GoodsDetailViewController alloc]init];
            goodsVc.idStr = model.cargo_id;
            
            [self.navigationController pushViewController:goodsVc animated:YES];
        }
        else if ([model.type isEqualToString:@"3"])
        {
            //
            MyGoodsViewController * vc = [[MyGoodsViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            //我的界面
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
            
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        
    }
    
}


#pragma mark -- 获取列表详情
-(void)messageDetailList
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"identity\":\"%@\",\"max\":\"%lu\",\"page\":\"%lu\",\"uid\":\"%@\"",self.identify,(unsigned long)self.max,(unsigned long)self.page,[UseInfo shareInfo].uID];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:MessageDetail URLMethod:MessageDetailMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (![result isEqual:[NSNull null]]) {
            if (![result[@"result"] isEqual:[NSNull null]]) {
                if (![result[@"result"][@"list"] isEqual:[NSNull null]]) {
                    
                    NSArray * array = [MessageDetailModel mj_objectArrayWithKeyValuesArray:result[@"result"][@"list"]];
                    
                    [self.dataArray addObjectsFromArray:array];
                    
                }
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


















@end
