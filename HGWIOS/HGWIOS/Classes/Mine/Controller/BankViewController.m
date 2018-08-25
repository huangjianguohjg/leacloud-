//
//  BankViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BankViewController.h"
#import "AddBankViewController.h"
#import "BankTableViewCell.h"
#import "BankModel.h"
#import "BankDetailViewController.h"
@interface BankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation BankViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(234, 239, 245);
    

    self.navigationItem.title = @"银行卡";
    
    [self setUpUI];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getBankList];
}





-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(234, 239, 245);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = realH(150);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[BankTableViewCell class] forCellReuseIdentifier:@"BankTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.bottom.right.equalTo(self.view);
    }];
    self.tableView = tableView;
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return self.dataArray.count;
//    }
//    else
//    {
//        return 1;
//    }
    
    return self.dataArray.count == 0 ? 1 : self.dataArray.count + 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BankTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count == 0) {
        BankModel * mode = [[BankModel alloc]init];
        mode.bank_name_ab = @"wallet_icon_add";
        mode.bank_name = @"添加银行卡";
        
        cell.model = mode;
        return cell;
    }
    
    if (indexPath.row < self.dataArray.count) {
        
        BankModel * model = self.dataArray[indexPath.row];
        cell.model = model;
        
        return cell;
    }
    else if (indexPath.row == self.dataArray.count)
    {
        BankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BankTableViewCell"];
        
        BankModel * mode = [[BankModel alloc]init];
        mode.bank_name_ab = @"wallet_icon_add";
        mode.bank_name = @"添加银行卡";
        
        cell.model = mode;
        
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankModel * model = nil;
    
    if (self.dataArray.count != 0)
    {
        
        if (indexPath.row < self.dataArray.count) {
            model = self.dataArray[indexPath.row];
            BankDetailViewController * bankVc = [[BankDetailViewController alloc]init];
            bankVc.model = model;
            [self.navigationController pushViewController:bankVc animated:YES];
        }
        else
        {
            AddBankViewController * addBankVc = [[AddBankViewController alloc]init];
            [self.navigationController pushViewController:addBankVc animated:YES];
        }
    }
    else
    {
        AddBankViewController * addBankVc = [[AddBankViewController alloc]init];
        [self.navigationController pushViewController:addBankVc animated:YES];
    }
    
    
    
}



-(void)getBankList
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:BankList URLMethod:BankListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
               
        [self.dataArray removeAllObjects];
        
        if ([[result[@"result"] objectForKey:@"status"]boolValue])
        {
            //status返回1
            NSArray * array = [BankModel mj_objectArrayWithKeyValuesArray:result[@"result"][@"list"]];
            
            if ([array isEqual:[NSNull null]]) {
                [self.dataArray removeAllObjects];
            }
            else
            {
                [self.dataArray addObjectsFromArray:array];
            }
            
            
            
        }
        else
        {
//            if (self.dataArray.count > 1) {
//                BankModel * model = [self.dataArray lastObject];
//                [self.dataArray removeAllObjects];
//                [self.dataArray addObject:model];
//            }
            
            [self.dataArray removeAllObjects];
            
            [self.view makeToast:@"暂未绑定银行卡" duration:0.5 position:CSToastPositionCenter];
        }
        
        [self.tableView reloadData];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}
























@end
