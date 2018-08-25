//
//  AdminViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AdminViewController.h"
#import "AdminTableViewCell.h"
@interface AdminViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * infoArray;

@property (nonatomic, weak) UITableView * tableView;

@end

@implementation AdminViewController

-(NSMutableArray *)infoArray
{
    if (_infoArray == nil) {
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(255, 255, 255);
    
    self.navigationItem.title = @"业务管理员";
    
    [self setUpUI];
    
    [self approvalList];
    
}





-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = realH(100);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[AdminTableViewCell class] forCellReuseIdentifier:@"AdminTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.bottom.right.equalTo(self.view);
    }];
    self.tableView = tableView;
}




#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdminTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AdminTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * dict = self.infoArray[indexPath.row];
    
    cell.nameLable.text = dict[@"username"];
    cell.numberLable.text = dict[@"mobile"];
    __weak typeof(self) weakSelf = self;
    cell.adminBlock = ^(NSString *str) {
        if ([str isEqualToString:@"通过"]) {
            [weakSelf passrequest:dict[@"id"]];
        }
        else
        {
            [weakSelf rejectrequest:dict[@"id"]];
        }
    };
    
    return cell;
}



-(void)approvalList
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:ApprovalList URLMethod:ApprovalListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
//        
//        if ([result[@"result"] isEqual:[NSNull null]]) {
//            [self.view makeToast:@"暂无数据" duration:1.0 position:CSToastPositionCenter];
//            return;
//        }
//        
//        if ([result[@"result"][@"status"] boolValue]) {
//            self.infoArray = result[@"result"];
//            if (![self.infoArray isEqual:[NSNull null]]) {
//                [self.tableView reloadData];
//            }
//        }
//        else
//        {
//            [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
//        }
        
        [self.infoArray removeAllObjects];
        id rr = result[@"result"];
        if ([rr isKindOfClass:[NSString class]]) {
            [self.view makeToast:result[@"result"] duration:1.0 position:CSToastPositionCenter];
            
            [self.tableView reloadData];
        }
        else
        {
            [self.infoArray addObjectsFromArray:result[@"result"]];
            if (![self.infoArray isEqual:[NSNull null]]) {
                [self.tableView reloadData];
            }
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}


#pragma mark -- 通过/驳回
-(void)passrequest:(NSString *)Id
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"Id\":\"%@\"",Id];
    
    [XXJNetManager requestPOSTURLString:AdoptCompany URLMethod:AdoptCompanyMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        
        
        [self approvalList];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}

-(void)rejectrequest:(NSString *)Id
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"Id\":\"%@\"",Id];
    
    [XXJNetManager requestPOSTURLString:RejectCompany URLMethod:RejectCompanyMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        [self approvalList];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}















@end
