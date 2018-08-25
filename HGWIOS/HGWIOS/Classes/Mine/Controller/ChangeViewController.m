//
//  ChangeViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ChangeViewController.h"
#import "MyBoatModel.h"
#import <BRStringPickerView.h>
@interface ChangeViewController ()

@property (nonatomic, weak) UITextField * textField;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation ChangeViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXJColor(236, 239, 246);
    

    self.navigationItem.title = @"变更业务员";
    
    [self setUpUI];
    
    [self getPersonList];
}




-(void)setUpUI
{
    UILabel * currentLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(40) fontFamily:PingFangSc_Regular text:@"当前业务员:"];
    [currentLable sizeToFit];
    [self.view addSubview:currentLable];
    [currentLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(realW(40));
        make.top.equalTo(self.view).offset(realH(80) + kStatusBarHeight + kNavigationBarHeight);
    }];
    
    
    UILabel * nameLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:self.model.contact_person];
    [nameLable sizeToFit];
    [self.view addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentLable.right).offset(realW(60));
        make.centerY.equalTo(currentLable);
    }];
    
    
    UILabel * newLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(40) fontFamily:PingFangSc_Regular text:@"新业务员:"];
    [newLable sizeToFit];
    [self.view addSubview:newLable];
    [newLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(realW(40));
        make.top.equalTo(currentLable.bottom).offset(realH(100));
    }];
    
    UIView * borderView = [[UIView alloc]init];
    borderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:borderView];
    [borderView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newLable.right).offset(realW(10));
        make.centerY.equalTo(newLable);
        make.height.equalTo(realH(60));
        make.right.equalTo(self.view).offset(realW(-40));
    }];
    
    UITextField * textField = [[UITextField alloc]init];
//    textField.userInteractionEnabled = NO;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    textField.placeholder = @"请填写新的业务员手机号码";
    textField.tintColor = XXJColor(27, 69, 138);
    [textField addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTap)]];
    [borderView addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(borderView).offset(realW(40));
        make.centerY.equalTo(borderView);
    }];
    self.textField = textField;
    
    //提交新业务员
    UIButton * commitButton = [[UIButton alloc]init];
    commitButton.alpha = 0;
//    [commitButton addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setTitle:@"提交新业务员" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = XXJColor(27, 69, 138);
    commitButton.layer.cornerRadius = 5;
    commitButton.clipsToBounds = YES;
    commitButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:commitButton];
    [commitButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(borderView.bottom).offset(realH(100));
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(100)) , realH(100)));
    }];
    
    
}


#pragma mark -- 提交
-(void)commitClick:(NSString *)phone
{
//    if (self.textField.text.length == 0) {
//        [self.view makeToast:@"请先输入号码" duration:0.5 position:CSToastPositionCenter];
//        return;
//    }
//
//    if (![NSString isValidatePhoneNum:self.textField.text]) {
//        [self.view makeToast:@"请先输入正确的号码" duration:0.5 position:CSToastPositionCenter];
//        return;
//    }
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"ship_id\":\"%@\",\"access_token\":\"%@\",\"mobile\":\"%@\"",self.model.ship_id,[UseInfo shareInfo].access_token,phone];
    
    [XXJNetManager requestPOSTURLString:ChangeContact URLMethod:ChangeContactMethod parameters:parameterstring finished:^(id result) {
        XXJLog(@"%@",result)
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
        [SVProgressHUD showWithStatus:resultDict[@"result"][@"msg"]];
        [SVProgressHUD dismissWithDelay:1.0 completion:^{
            self.textField.text = nil;
        }];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}

-(void)setModel:(MyBoatModel *)model
{
    _model = model;
}





-(void)getPersonList
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetUserAllInfo URLMethod:@"enterprise_personnel" parameters:parameterstring finished:^(id result) {
        XXJLog(@"%@",result)
        [SVProgressHUD dismiss];
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
//        [SVProgressHUD showWithStatus:resultDict[@"result"][@"msg"]];
//        [SVProgressHUD dismissWithDelay:1.0 completion:^{
//            self.textField.text = nil;
//        }];
        
        if ([resultDict[@"result"][@"status"] boolValue])
        {
            NSArray * array = resultDict[@"result"][@"list"];
            
            for (NSDictionary * dict in array) {
                NSString * s = [NSString stringWithFormat:@"%@ %@",dict[@"username"],dict[@"mobile"]];
                [self.dataArray addObject:s];
            }
            
        }
        else
        {
            [self.view makeToast:@"暂无业务员" duration:1.0 position:CSToastPositionCenter];
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}

-(void)chooseTap
{
    [BRStringPickerView showStringPickerWithTitle:@"选择业务员" dataSource:self.dataArray defaultSelValue:@"" isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
        
        NSString * phone = [selectValue componentsSeparatedByString:@" "][1];
        
        [self commitClick:phone];
        
    } cancelBlock:^{
        NSLog(@"点击了背景视图或取消按钮");
    }];
}
















@end
