//
//  InviteViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InviteViewController.h"

#import "InviteTableViewCell.h"

#import <BRStringPickerView.h>

@interface InviteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITextField * textField;

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * historyArray;

@end

@implementation InviteViewController

-(NSMutableArray *)historyArray
{
    if (_historyArray == nil) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(236, 239, 246);
    
    [self setUpNav];
    
    
    [self setUpUI];
    
    //已报价列表
    [self inviteList];
    
    //历史邀请报价人员请求
    [self inviteUserRequest];
    
}

-(void)setUpNav
{
    self.navigationItem.title = @"邀请报价";

    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"arrow-appbar-left"] forState:UIControlStateNormal];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];

    
    UIButton * rightButton = [[UIButton alloc]init];
    [rightButton addTarget:self action:@selector(rightItem) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"历史邀请" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rightButton setImage:[UIImage imageNamed:@"arrow-appbar-left"] forState:UIControlStateNormal];
    [rightButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [rightButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    

}

-(void)leftItem
{
    if ([self.fromTag isEqualToString:@"指定发货"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)rightItem
{
    if (self.historyArray.count == 0) {
        [self.view makeToast:@"暂无历史记录" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"历史邀请记录" dataSource:self.historyArray defaultSelValue:nil resultBlock:^(id selectValue) {
        
        NSString * str = [selectValue componentsSeparatedByString:@" "][1];
        
        [weakSelf inviteRequest:str];
        
    }];
    
}

-(void)setUpUI
{
    UILabel * phoneLable = [UILabel lableWithTextColor:XXJColor(110, 113, 120) textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"手机号码"];
    [phoneLable sizeToFit];
    [self.view addSubview:phoneLable];
    [phoneLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(realW(120));
        make.top.equalTo(self.view).offset(realH(40) + kStatusBarHeight + kNavigationBarHeight);
    }];
    
    UITextField * textField = [[UITextField alloc]init];
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    textField.backgroundColor = [UIColor whiteColor];
    textField.tintColor = [UIColor redColor];
    textField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(36)];
    textField.layer.cornerRadius = realW(5);
    textField.clipsToBounds = YES;
    [self.view addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLable.right).offset(realW(20));
        make.centerY.equalTo(phoneLable);
        make.width.equalTo(realW(320));
    }];
    self.textField = textField;
    

    UIButton * inviteButton = [[UIButton alloc]init];
    [inviteButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [inviteButton setTitle:@"提交邀请" forState:UIControlStateNormal];
    inviteButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [inviteButton setBackgroundColor:XXJColor(116, 159, 228)];
    inviteButton.layer.cornerRadius = realW(10);
    inviteButton.clipsToBounds = YES;
    [inviteButton sizeToFit];
    [self.view addSubview:inviteButton];
    [inviteButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(realH(150) + kStatusBarHeight + kNavigationBarHeight);
        make.width.equalTo(CGSizeMake(realW(150), realH(32)));
    }];


    UIView * lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = XXJColor(226, 226, 226);
    [self.view addSubview:lineView1];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(realH(250) + kStatusBarHeight + kNavigationBarHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(10));
    }];



    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"姓名"];
    [nameLable sizeToFit];
    [self.view addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(realW(70));
        make.top.equalTo(lineView1.bottom).offset(realH(20));
    }];


    UILabel * numberLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"手机号"];
    [numberLable sizeToFit];
    [self.view addSubview:numberLable];
    [numberLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(lineView1.bottom).offset(realH(20));
    }];

    UILabel * timeLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"邀请时间"];
    [timeLable sizeToFit];
    [self.view addSubview:timeLable];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(realW(-70));
        make.top.equalTo(lineView1.bottom).offset(realH(20));
    }];

    UIView * lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = XXJColor(226, 226, 226);
    [self.view addSubview:lineView2];
    [lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLable.bottom).offset(realH(20));
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(10));
    }];
    
    
    
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(236, 239, 246);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = realH(120);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[InviteTableViewCell class] forCellReuseIdentifier:@"InviteTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.bottom).offset(realH(20));
        make.left.right.bottom.equalTo(self.view);
    }];
    self.tableView = tableView;
    

}


#pragma mark -- 邀请报价
-(void)buttonClick
{
    if (self.textField.text.length == 0) {
        
        [self.view makeToast:@"请填写手机号" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    
    [self inviteRequest:self.textField.text];

}


-(void)inviteRequest:(NSString *)phoneNum
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"mobile\":\"%@\",\"cargo_id\":\"%@\"",phoneNum,self.cargo_id];
    
    [XXJNetManager requestPOSTURLString:AppointPrice URLMethod:AppointPriceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
        
        if ([result[@"result"][@"status"] boolValue]) {
            [self inviteList];
            [self inviteUserRequest];
            
            self.textField.text = nil;
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}



#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InviteTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * dict = self.dataArray[indexPath.row];
    
    cell.nameLable.text = dict[@"username"];
    
    cell.numberLable.text = dict[@"mobile"];
    
    cell.timeLable.text = [NSString stringWithFormat:@"%@\n%@",[dict[@"c_time"] componentsSeparatedByString:@" "][0],[dict[@"c_time"] componentsSeparatedByString:@" "][1]];
    
    return cell;
}


#pragma mark -- 报价人员列表
-(void)inviteList
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"cargo_id\":\"%@\"",self.cargo_id];
    
    [XXJNetManager requestPOSTURLString:InvitationUser URLMethod:InvitationUserMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        self.dataArray = result[@"result"];

        if (![self.dataArray isEqual:[NSNull null]]) {
            [self.tableView reloadData];
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        [SVProgressHUD dismiss];
    }];
}


#pragma mark -- 历史报价人员列表
-(void)inviteUserRequest
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"cargo_id\":\"%@\",\"access_token\":\"%@\"",self.cargo_id,[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:InvitationUser URLMethod:InvitationUserMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (![result isEqual:[NSNull null]]) {
            NSArray * array = result[@"result"];
            if (![array isEqual:[NSNull null]]) {
                for (NSDictionary * dict in array) {
                    NSString * str = [NSString stringWithFormat:@"%@ %@",dict[@"username"],dict[@"mobile"]];
                    [self.historyArray addObject:str];
                }
            }
            
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        [SVProgressHUD dismiss];
    }];
}



















@end
