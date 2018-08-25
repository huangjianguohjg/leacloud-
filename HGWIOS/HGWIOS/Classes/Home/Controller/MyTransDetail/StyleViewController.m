//
//  StyleViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "StyleViewController.h"
#import "TransportStyleTableViewCell.h"
#import "TransportDealModel.h"

@interface StyleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation StyleViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(255, 255, 255);
    
    [self setUpUI];
    
    [self transportDealRequest];
    
}



-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = realH(120);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[TransportStyleTableViewCell class] forCellReuseIdentifier:@"TransportStyleTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    CGRect frame = CGRectMake(0, 0, 0, CGFLOAT_MIN);
    
    tableView.tableFooterView = [[UIView alloc]initWithFrame:frame];
    
    CGRect frame1 = CGRectMake(0, 0, 0, realH(40));
    
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:frame1];
    
    self.tableView = tableView;
    
    
    
    
    
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TransportStyleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TransportStyleTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}





-(void)transportDealRequest
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"deal_id\":\"%@\"",self.detail_id];
    
    [XXJNetManager requestPOSTURLString:TransportDeal URLMethod:TransportDealMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        if ([result[@"result"][@"status"] boolValue]) {
            
            NSArray * array = result[@"result"][@"data"];
            
            
            if (array.count == 0) {
                [self.view makeToast:@"暂无数据" duration:1.0 position:CSToastPositionCenter];
            }
            else
            {
                
                
                NSArray * modelArray = [TransportDealModel mj_objectArrayWithKeyValuesArray:array];
                
                [self.dataArray addObjectsFromArray:modelArray];
                
                [self.tableView reloadData];
            }
            
            
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
