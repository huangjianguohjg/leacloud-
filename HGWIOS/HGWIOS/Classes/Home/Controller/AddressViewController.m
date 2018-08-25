//
//  AddressViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AddressViewController.h"

#import "AddressTableViewCell.h"
#import "AddressRightTableViewCell.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) AddressTableViewCell * preLeftCell;

@property (nonatomic, weak) AddressRightTableViewCell * preRightCell;

@property (nonatomic, strong) NSMutableArray * leftDataArray;

@property (nonatomic, strong) NSMutableArray * rightDataArray;

@property (nonatomic, weak) UITableView * leftTableView;

@property (nonatomic, weak) UITableView * rightTableView;

/**
 保存选择港口地址的id
 */
@property (nonatomic, copy) NSString * addressID;

@end

@implementation AddressViewController

-(NSMutableArray *)leftDataArray
{
    if (_leftDataArray == nil) {
        _leftDataArray = [NSMutableArray array];
    }
    return _leftDataArray;
}


-(NSMutableArray *)rightDataArray
{
    if (_rightDataArray == nil) {
        _rightDataArray = [NSMutableArray array];
    }
    return _rightDataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"选择港口/地址";
    
    [self setUpNav];
    
    [self setUpUI];
    
    
    [self getProvinceRequest];
    
    
    
    
    
    
}

-(void)setUpNav
{
    if (![self.empty isEqualToString:@"报空"]) {
        UIButton * rightButton = [[UIButton alloc]init];
        [rightButton setTitle:@"清空" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
        [rightButton sizeToFit];
        [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    
    
    
    
    
    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"arrow-appbar-left"] forState:UIControlStateNormal];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}


-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightClick
{
    if (self.addressBackBlock) {
        self.addressBackBlock(@"", @"空载港", @"", @"");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setUpUI
{
    UITableView * leftTableView = [[UITableView alloc]init];
    leftTableView.tag = 10000;
    leftTableView.backgroundColor = [UIColor whiteColor];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [leftTableView registerClass:[AddressTableViewCell class] forCellReuseIdentifier:@"AddressTableViewCell"];
    [self.view addSubview:leftTableView];
    [leftTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.bottom.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH / 2);
    }];
    self.leftTableView = leftTableView;
    
    
    UITableView * rightTableView = [[UITableView alloc]init];
    rightTableView.tag = 10001;
    rightTableView.backgroundColor = [UIColor whiteColor];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [rightTableView registerClass:[AddressRightTableViewCell class] forCellReuseIdentifier:@"AddressRightTableViewCell"];
    [self.view addSubview:rightTableView];
    [rightTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.right.bottom.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH / 2);
    }];
    self.rightTableView = rightTableView;
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10000) {
        return self.leftDataArray.count;
    }
    else
    {
        return self.rightDataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10000) {
        AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"AddressTableViewCell%ld",(long)indexPath.row]];
        
        if (cell == nil) {
            cell = [[AddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"AddressTableViewCell%ld",(long)indexPath.row]];
        }
        
        if (![cell.contentView.backgroundColor isEqual:[UIColor whiteColor]]) {
            cell.contentView.backgroundColor = XXJColor(238, 238, 238);
        }
       

        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary * dict = self.leftDataArray[indexPath.row];
        
        [cell.button setTitle:dict[@"name"] forState:UIControlStateNormal];
        
        return cell;
    }
    else
    {
        AddressRightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"AddressRightTableViewCell%ld",(long)indexPath.row]];
        
        if (cell == nil) {
            cell = [[AddressRightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"AddressRightTableViewCell%ld",(long)indexPath.row]];
        }
        
        if (![cell.contentView.backgroundColor isEqual:XXJColor(238, 238, 238)]) {
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary * dict = self.rightDataArray[indexPath.row];
        
        [cell.button setTitle:dict[@"name"] forState:UIControlStateNormal];
        
        return cell;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10000) {
        AddressTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        self.preLeftCell.button.selected = NO;
        self.preLeftCell.contentView.backgroundColor = XXJColor(238, 238, 238);
        
        cell.button.selected = YES;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        self.preLeftCell = cell;
        
        [self getCityRequest:self.leftDataArray[indexPath.row][@"id"]];
        
    }
    else
    {
        AddressRightTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        self.preRightCell.button.selected = NO;
        self.preRightCell.contentView.backgroundColor = [UIColor whiteColor];
        
        cell.button.selected = YES;
        cell.contentView.backgroundColor = XXJColor(238, 238, 238);
        
        NSDictionary * dict = self.rightDataArray[indexPath.row];

        self.preRightCell = cell;
        
        if (self.addressBackBlock) {
            self.addressBackBlock([NSString stringWithFormat:@"%@-%@",dict[@"parent_id"],dict[@"id"]], [NSString stringWithFormat:@"%@%@",dict[@"parent_name"],dict[@"name"]],dict[@"parent_id"],[NSString stringWithFormat:@"%@-%@",dict[@"parent_name"],dict[@"name"]]);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}





#pragma mark -- 获取省级列表数据
-(void)getProvinceRequest
{
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetProvince URLMethod:GetProvinceMethod parameters:nil finished:^(id result) {
        
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result)
        NSArray * listArray = result[@"result"][@"list"];
        
        [self.leftDataArray addObjectsFromArray:listArray];
        
        [self.leftTableView reloadData];
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        AddressTableViewCell * cell = [self.leftTableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.button.selected = YES;
        cell.selected = YES;
        self.preLeftCell = cell;
        
        
        [self getCityRequest:result[@"result"][@"list"][0][@"id"]];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}


#pragma mark -- 获取市级列表数据
-(void)getCityRequest:(NSString *)port_id
{
    
    if (self.rightDataArray.count > 0) {
        [self.rightDataArray removeAllObjects];
    }
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"port_id\":\"%@\"",port_id];
    
    [XXJNetManager requestPOSTURLString:GetCity URLMethod:GetCityMethod parameters:parameterstring finished:^(id result) {
        
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result)
        NSArray * listArray = result[@"result"][@"list"];
        
        [self.rightDataArray addObjectsFromArray:listArray];
        
        if ([self.fromTag isEqualToString:@"屏蔽全部"]) {
            [self.rightDataArray removeObjectAtIndex:0];
        }
        
        [self.rightTableView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        AddressRightTableViewCell * cell = [self.rightTableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = XXJColor(238, 238, 238);
        cell.button.selected = YES;
        cell.selected = YES;
        self.preRightCell = cell;
        
        [self.rightTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}









































@end
