//
//  OfferViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "OfferViewController.h"
#import "HomeGoodsModel.h"
#import <BRStringPickerView.h>
#import "AlreadyOfferViewController.h"
@interface OfferViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) UILabel * startlable;

@property (nonatomic, weak) UILabel * endlable;

@property (nonatomic, weak) UILabel * messagelable;

@property (nonatomic, weak) UILabel * nameLable;

@property (nonatomic, weak) UITextField * textField;

@property (nonatomic, copy) NSString * ship_id;

@property (nonatomic, copy) NSString * priceStr;

@end

@implementation OfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(235, 240, 246);
    
    self.navigationItem.title = @"船主填写报价";
    

    
    [self setUpUI];
    
    
}



-(void)setUpUI
{
    UIImageView * toImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"to_rightUpdate"]];
    toImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [toImageView sizeToFit];
    [self.view addSubview:toImageView];
    [toImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight + realH(40));
        make.centerX.equalTo(self.view);
        make.height.equalTo(realH(38));
        make.width.equalTo(realW(38));
    }];
    
    UILabel * startlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:self.model.b_port];
    [startlable sizeToFit];
    [self.view addSubview:startlable];
    [startlable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(toImageView.left).offset(realW(-10));
        make.centerY.equalTo(toImageView);
        make.height.equalTo(realH(36));
    }];
    self.startlable = startlable;
    
    UILabel * endlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:self.model.e_port];
    [endlable sizeToFit];
    [self.view addSubview:endlable];
    [endlable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toImageView.right).offset(realW(10));
        make.centerY.equalTo(toImageView);
        make.height.equalTo(realH(36));
    }];
    self.endlable = endlable;
    
    
    UILabel * messagelable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"%@ %@吨",self.model.cargo_type,self.model.weight]];
    [messagelable sizeToFit];
    [self.view addSubview:messagelable];
    [messagelable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startlable.bottom).offset(realH(30));
        make.centerX.equalTo(self.view);
        make.height.equalTo(realH(36));
    }];
    self.messagelable = messagelable;
    
    
    UILabel * chooselable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(38) fontFamily:PingFangSc_Regular text:@"请选择船舶："];
    [chooselable sizeToFit];
    [self.view addSubview:chooselable];
    [chooselable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(messagelable.bottom).offset(realW(70));
        make.left.equalTo(self.view).offset(realW(40));
        make.height.equalTo(realH(38));
    }];

    UIView * chooseView = [[UIView alloc]init];
    [chooseView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameClick)]];
    chooseView.backgroundColor = [UIColor whiteColor];
    chooseView.layer.cornerRadius = 5;
    chooseView.clipsToBounds = YES;
    [self.view addSubview:chooseView];
    [chooseView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chooselable.right).offset(realW(10));
        make.right.equalTo(self.view).offset(realW(-40));
        make.centerY.equalTo(chooselable);
        make.height.equalTo(realH(70));
    }];
    
    
    UILabel * nameLable = [UILabel lableWithTextColor:XXJColor(203, 204, 208) textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"请选择船舶"];
    [nameLable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameClick)]];
    [nameLable sizeToFit];
    [self.view addSubview:nameLable];
    [nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chooseView);
        make.left.equalTo(chooseView).offset(realW(20));
    }];
    self.nameLable = nameLable;
    
    
    
    
    
    UIView * moneyView = [[UIView alloc]init];
    moneyView.backgroundColor = [UIColor whiteColor];
    moneyView.layer.cornerRadius = 5;
    moneyView.clipsToBounds = YES;
    [self.view addSubview:moneyView];
    [moneyView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chooseView);
        make.top.equalTo(chooseView.bottom).offset(realH(100));
        make.height.equalTo(realH(70));
        make.width.equalTo(realW(250));
    }];
    
    
    UILabel * logolable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(60) fontFamily:PingFangSc_Medium text:@"￥"];
    [logolable sizeToFit];
    [self.view addSubview:logolable];
    [logolable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyView);
        make.right.equalTo(chooseView.left).offset(realW(-10));
    }];
    
    
    UITextField * textField = [[UITextField alloc]init];
    textField.delegate = self;
    [textField addTarget:self action:@selector(textEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    textField.placeholder = @"请填写报价";
    textField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(36)];
    textField.tintColor = [UIColor redColor];
    [moneyView addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(moneyView);
        make.left.equalTo(moneyView).offset(realW(20));
    }];
    self.textField = textField;
    
    UILabel * weightlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"/吨"];
    [weightlable sizeToFit];
    [self.view addSubview:weightlable];
    [weightlable makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyView);
        make.left.equalTo(moneyView.right).offset(realW(20));
    }];
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(225, 227, 225);
    [self.view addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView.bottom).offset(realH(40));
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH
                                     , realH(10)));
    }];
    
    
    UILabel * explainlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"报价说明"];
    [explainlable sizeToFit];
    [self.view addSubview:explainlable];
    [explainlable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(lineView.bottom).offset(realW(80));
    }];
    
    
    UILabel * oneLable = [UILabel lableWithTextColor:XXJColor(94, 99, 103) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"1、以上报价包含船舶运输费、港建费、码头费"];
    oneLable.numberOfLines = 0;
    [oneLable sizeToFit];
    [self.view addSubview:oneLable];
    [oneLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(explainlable.bottom).offset(realH(40));
        make.left.equalTo(self.view).offset(realW(50));
        make.right.equalTo(self.view).offset(realW(-50));
    }];
    
    
    UILabel * twoLable = [UILabel lableWithTextColor:XXJColor(94, 99, 103) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"2、报价全部是含税价"];
    [twoLable sizeToFit];
    [self.view addSubview:twoLable];
    [twoLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(oneLable.bottom).offset(realH(10));
        make.left.equalTo(self.view).offset(realW(50));
    }];
    
    
    CGFloat margin = 0;
    if (isIPHONEX) {
        margin = 34;
    }
    
    UIButton * offerButton = [[UIButton alloc]init];
    [offerButton addTarget:self action:@selector(offerClick) forControlEvents:UIControlEventTouchUpInside];
    [offerButton setTitle:@"提交报价" forState:UIControlStateNormal];
    [offerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    offerButton.backgroundColor = XXJColor(27, 69, 138);
    offerButton.layer.cornerRadius = 5;
    offerButton.clipsToBounds = YES;
    offerButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:offerButton];
    
    [offerButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(realH(-20) - margin);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
    
}

-(void)textEditingChanged:(UITextField *)textField
{
    
    
    if ([textField.text containsString:@"."]) {
        NSString * s = [textField.text componentsSeparatedByString:@"."][1];
        
        if (s.length == 2) {
            self.priceStr = textField.text;
        }
        
        if (s.length > 2) {
            textField.text = self.priceStr;
        }
        
        
    }
    
    
//    if ([textField.text floatValue] == 1000) {
//        self.priceStr = textField.text;
//    }
//    if ([textField.text floatValue] > 1000) {
//        textField.text = self.priceStr;
//    }
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text containsString:@"."]) {
        NSArray * array = [textField.text componentsSeparatedByString:@"."];
        XXJLog(@"%@",array)
        
        if ([array[1] isEqualToString:@""]) {
            textField.text = array[0];
        }
    }
}




#pragma mark -- 请选择船舶
-(void)nameClick
{
    [self.textField resignFirstResponder];
    
    [self selectShipRequest];
}

#pragma mark -- 我要报价
-(void)offerClick
{
    [self quotePriceRequest];
}



-(void)setModel:(HomeGoodsModel *)model
{
    _model = model;
    
    self.startlable.text = model.b_port;
    
    self.endlable.text = model.e_port;
    
    self.messagelable.text = [NSString stringWithFormat:@"%@ %@吨",model.cargo_type_name,model.weight];
    
}



#pragma mark -- 选择船舶
-(void)selectShipRequest
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:SelelctShip URLMethod:SelectShipMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (![result[@"result"][@"status"] boolValue]) {
            
            [self.view makeToast:@"暂无船舶选择" duration:1.0 position:CSToastPositionCenter];
            
            return;
        }
        
        NSMutableArray * nameArray = [NSMutableArray array];
        
        
        for (NSDictionary * dict in result[@"result"][@"list"]) {
            [nameArray addObject:dict[@"name"]];
        }
        
        
        //类型选择
        [BRStringPickerView showStringPickerWithTitle:@"选择船舶" dataSource:nameArray defaultSelValue:@"" isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
            
            self.nameLable.textColor = [UIColor blackColor];
            self.nameLable.text = selectValue;
            
            
            for (NSDictionary * dict in result[@"result"][@"list"]) {
                if ([selectValue isEqualToString:dict[@"name"]]) {
                    self.ship_id = dict[@"id"];
                    break;
                }
            }
            
            
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}


#pragma mark -- 船主报价
-(void)quotePriceRequest
{
    
    if ([self.nameLable.text isEqualToString:@"请选择船舶"]) {
        [self.view makeToast:@"请先选择船舶" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    if (self.textField.text.length == 0) {
        [self.view makeToast:@"请先填写报价" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    if ([self.textField.text floatValue] > 1000) {
        [self.view makeToast:@"报价不能超过1000元" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"cargo_id\":\"%@\",\"ship_id\":\"%@\",\"money\":\"%@\",\"access_token\":\"%@\",\"pay_type\":\"%@\"",self.model.cargo_id,self.ship_id,self.textField.text,[UseInfo shareInfo].access_token,self.model.pay_type];
    
    
    [XXJNetManager requestPOSTURLString:QuotePrice URLMethod:QuotePriceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result);
        
        NSString * msg = result[@"result"][@"msg"];
        
        if (msg != nil) {
            [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
        }
        else
        {
            self.priceStr = nil;
            
            [self.view makeToast:@"报价成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                
                AlreadyOfferViewController * alreadyVc = [[AlreadyOfferViewController alloc]init];
                alreadyVc.fromTag = @"返回首页";
                [self.navigationController pushViewController:alreadyVc animated:YES];
                
            }];
            self.nameLable.text = @"请选择船舶";
            self.nameLable.textColor = XXJColor(203, 204, 208);
            self.textField.text = nil;
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
}












@end
