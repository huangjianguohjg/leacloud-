//
//  BankListViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BankListViewController.h"
#import "BankListTableViewCell.h"

#import "BankNameHelper.h"
#import "SupportBankModel.h"
@interface BankListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation BankListViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
        NSMutableDictionary *banks = [BankNameHelper getAll];
        for (NSString *key in [banks keyEnumerator])
        {
            SupportBankModel *supportBankModel1 = [[SupportBankModel alloc]init];
            supportBankModel1.title =[banks valueForKey:key];
            supportBankModel1.titleAb = key;
            supportBankModel1.imageurl = key;
            [_dataArray addObject:supportBankModel1];
        }
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(234, 239, 245);
    

    self.navigationItem.title = @"添加银行卡";
    
    [self setUpUI];
    
}


-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)setUpUI
{
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(234, 239, 245);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = realH(150);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[BankListTableViewCell class] forCellReuseIdentifier:@"BankListTableViewCell"];
    tableView.contentInset = UIEdgeInsetsMake(realH(20), 0, 0, 0);
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.equalTo(self.view).offset(realW(20));
        make.right.equalTo(self.view).offset(realW(-20));
        make.bottom.equalTo(self.view);
    }];
    self.tableView = tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BankListTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SupportBankModel *supportBankModel =self.dataArray[indexPath.row];
    
    cell.model = supportBankModel;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SupportBankModel *supportBankModel =self.dataArray[indexPath.row];
    
    if (self.bankSelectBlock) {
        self.bankSelectBlock(supportBankModel.title,supportBankModel.titleAb);
    }
    
    [self leftItem];
    
}


































@end
