//
//  MessageViewController.m
//  化运网ios
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 jiuze. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageDetailViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, weak) UITableView * tableView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setUpNav];
    
    [self setUpUI];
    
    [self getMessageRequest];
    
}
-(void)setUpNav
{
    self.navigationItem.title = @"消息";
    
    self.navigationController.navigationBar.barTintColor = XXJColor(27, 69, 138);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    
}

-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"MessageTableViewCell"];
    tableView.rowHeight = realH(150);
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMessageRequest];
    }];
    
    
    self.tableView = tableView;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MessageModel * model = self.dataArray[indexPath.row];
    
    
    cell.model = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel * model = self.dataArray[indexPath.row];
    
    MessageDetailViewController * messageDetailVc = [[MessageDetailViewController alloc]init];
    
    messageDetailVc.titleStr = model.class_name;
    
    messageDetailVc.class_id = model.class_id;
    
    messageDetailVc.identify = model.identify;
    
    messageDetailVc.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:messageDetailVc animated:YES];
    
}



-(void)getMessageRequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    
    [XXJNetManager requestPOSTURLString:MessageCenter URLMethod:MessageCenterMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        self.dataArray = [MessageModel mj_objectArrayWithKeyValuesArray:result[@"result"][@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
        
        [self.tableView.mj_header endRefreshing];
    }];
    
}










@end
