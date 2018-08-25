//
//  ShipEmptyViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipEmptyViewController.h"

#import "AddBoatView.h"

#import "ChooseView.h"
#import "ChooseView1.h"

#import <BRStringPickerView.h>

#import "AddressViewController.h"

#import <BRAddressPickerView.h>

#import "MyBoatModel.h"
#import "HomeBoatModel.h"
#import "ChooseLableView.h"

@interface ShipEmptyViewController ()

@property (nonatomic, weak) AddBoatView * shipNameView;

@property (nonatomic, weak) AddBoatView * weightView;

@property (nonatomic, weak) AddBoatView * dateView;

@property (nonatomic, weak) AddBoatView * addressView;

@property (nonatomic, weak) AddBoatView * typeView;

@property (nonatomic, weak) ChooseView * addressView1;

@property (nonatomic, weak) ChooseView * typeView1;

@property (nonatomic, weak) AddBoatView * attentionView;

@property (nonatomic, weak) ChooseView1 * typeView2;

@property (nonatomic, copy) NSString * addressID;

@property (nonatomic, copy) NSString * goodsStyleID;

@end

@implementation ShipEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXJColor(242, 242, 242);
    
    self.navigationItem.title = @"船舶报空";
    
    [self setUpUI];
}





-(void)setUpUI
{
    __weak typeof(self) weakSelf = self;
    
    AddBoatView * shipNameView = [[AddBoatView alloc]init];
    shipNameView.leftLable.text = self.model.name;
    shipNameView.emptyTextField.alpha = 1;
    shipNameView.emptyTextField.userInteractionEnabled = NO;
    shipNameView.emptyTextField.text = [NSString stringWithFormat:@"%@吨",self.model.deadweight];
    [self.view addSubview:shipNameView];
    [shipNameView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(120));
    }];
    self.shipNameView = shipNameView;
    
    //货物重量
    AddBoatView * weightView = [[AddBoatView alloc]init];
    weightView.percentLable.alpha = 1;
    weightView.percentTextField.alpha = 1;
    weightView.percentTextField.keyboardType = UIKeyboardTypeDecimalPad;
    weightView.percentTextField.placeholder = @"货量偏差";
    weightView.errorLable.alpha = 1;
    weightView.dunLable.alpha = 1;
    weightView.dunTextField.alpha = 1;
    weightView.dunTextField.keyboardType = UIKeyboardTypeDecimalPad;
    weightView.dunTextField.placeholder = @"填写意向货量";
    weightView.leftLable.text = @"意向货量";
    [self.view addSubview:weightView];
    [weightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shipNameView.bottom).offset(realH(20));
        make.left.equalTo(shipNameView);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, realH(120)));
    }];
    self.weightView = weightView;
    
    
    //受载期
    AddBoatView * dateView = [[AddBoatView alloc]init];
    
    NSString * startStr = [TYDateUtils getCurentDate];
    dateView.publishDate = ^(NSString *s) {
        
        
        [self.weightView.dunTextField resignFirstResponder];
        [self.weightView.percentTextField resignFirstResponder];
        [self.attentionView.textView resignFirstResponder];
        
        if ([s isEqualToString:@"end"]) {
            //结束时间
            XXJLog(@"end")
            
            
            
            NSDate * startDate = [TYDateUtils getFormatDate:startStr withFormat:@"yyyy-MM-dd"];
            
            NSString * endStr = [TYDateUtils getDateAfterDays:25 withFormat:@"yyyy-MM-dd"];
            
            NSDate * endDate = [TYDateUtils getFormatDate:endStr withFormat:@"yyyy-MM-dd"];
            
            NSMutableArray * aa = [TYDateUtils getAllDate:startDate endDate:endDate];
            
            [BRStringPickerView showStringPickerWithTitle:@"时间选择" dataSource:aa defaultSelValue:startDate resultBlock:^(id selectValue) {
                
                weakSelf.dateView.endDateTextField.text = selectValue;
                
            }];
            
            
        }
        else
        {
            //开始时间
            XXJLog(@"start")
//            NSString * startStr = [TYDateUtils getCurentDate];
            
            NSDate * startDate = [TYDateUtils getFormatDate:startStr withFormat:@"yyyy-MM-dd"];
            
            NSString * endStr = [TYDateUtils getDateAfterDays:15 withFormat:@"yyyy-MM-dd"];
            
            NSDate * endDate = [TYDateUtils getFormatDate:endStr withFormat:@"yyyy-MM-dd"];
            
            NSMutableArray * aa = [TYDateUtils getAllDate:startDate endDate:endDate];
            
            [BRStringPickerView showStringPickerWithTitle:@"时间选择" dataSource:aa defaultSelValue:startDate resultBlock:^(id selectValue) {
                
                weakSelf.dateView.startDateTextField.text = selectValue;
                
            }];
        }
    };
    dateView.startDateTextField.alpha = 1;
    dateView.startDateTextField.text = startStr;
    dateView.toLable.alpha = 1;
    dateView.endDateTextField.alpha = 1;
    NSString * endStr = [TYDateUtils getDateAfterDays:7 withFormat:@"yyyy-MM-dd"];
    dateView.endDateTextField.text = endStr;
    dateView.leftLable.text = @"空载期";
    [self.view addSubview:dateView];
    [dateView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weightView.bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.dateView = dateView;
    
    
    ChooseView * addressView1 = [[ChooseView alloc]init];
    [addressView1.chooseButton setTitle:@"请选择空载地(最多三个)" forState:UIControlStateNormal];
    [addressView1.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    addressView1.emptyChooseBlock = ^{
        
        //类型选择
        AddressViewController * addressVc = [[AddressViewController alloc]init];
        addressVc.empty = @"报空";
        addressVc.fromTag = @"屏蔽全部";
        addressVc.addressBackBlock = ^(NSString *addressID, NSString *addressStr, NSString *parentProID,NSString * address_Str ) {
            
            
            
            if (weakSelf.addressView1.typeButton2.currentTitle.length > 0) {
                [weakSelf.view makeToast:@"最多只能选择三个" duration:0.5 position:CSToastPositionCenter];
                return;
            }
            
            
            if (weakSelf.addressView1.typeButton.currentTitle.length == 0) {
                
                [weakSelf.addressView1.typeButton setTitle:addressStr forState:UIControlStateNormal];
                [weakSelf.addressView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
                weakSelf.addressView1.typeButton.alpha = 1;
//                weakSelf.addressView1.douhaoLable.alpha = 0;
                
                NSArray * idArray = [addressID componentsSeparatedByString:@"-"];
                
                weakSelf.addressView1.chooseID = idArray[1];
            }
            else if (weakSelf.addressView1.typeButton1.currentTitle.length == 0)
            {
                if (![addressStr isEqualToString:weakSelf.addressView1.typeButton.currentTitle]) {
                    [weakSelf.addressView1.typeButton1 setTitle:addressStr forState:UIControlStateNormal];
                    [weakSelf.addressView1.typeButton1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
                    weakSelf.addressView1.typeButton1.alpha = 1;
//                    weakSelf.addressView1.douhaoLable.alpha = 1;
                    
                    NSArray * idArray = [addressID componentsSeparatedByString:@"-"];
                    
                    weakSelf.addressView1.chooseID1 = idArray[1];
                }
                
                
            }
            else if (weakSelf.addressView1.typeButton2.currentTitle.length == 0)
            {
                if (![addressStr isEqualToString:weakSelf.addressView1.typeButton.currentTitle] && ![addressStr isEqualToString:weakSelf.addressView1.typeButton1.currentTitle])
                {
                    [weakSelf.addressView1.typeButton2 setTitle:addressStr forState:UIControlStateNormal];
                    [weakSelf.addressView1.typeButton2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
                    weakSelf.addressView1.typeButton2.alpha = 1;
//                    weakSelf.addressView1.douhaoLable.alpha = 1;
//                    weakSelf.addressView1.douhaoLable1.alpha = 1;
                    
                    NSArray * idArray = [addressID componentsSeparatedByString:@"-"];
                    
                    weakSelf.addressView1.chooseID2 = idArray[1];
                }
                
                
            }
            
            
            
        };
        [weakSelf.navigationController pushViewController:addressVc animated:YES];
    };
    
    addressView1.emptyDeleteBlock = ^(NSString *s) {
//        NSString * choose_id = [weakSelf.addressView1.chooseID mutableCopy];
//        NSString * choose_id1 = [weakSelf.addressView1.chooseID1 mutableCopy];
//        NSString * choose_id2 = [weakSelf.addressView1.chooseID2 mutableCopy];
//
//        NSString * title = [weakSelf.addressView1.typeButton.currentTitle mutableCopy];
//        NSString * title1 = [weakSelf.addressView1.typeButton1.currentTitle mutableCopy];
//        NSString * title2 = [weakSelf.addressView1.typeButton2.currentTitle mutableCopy];
//
//        weakSelf.addressView1.chooseID = nil;
//        weakSelf.addressView1.chooseID1 = nil;
//        weakSelf.addressView1.chooseID2 = nil;
        
        
        
        if ([s isEqualToString:@"0"]) {
//            if (title2.length > 0) {
//
//                [weakSelf.addressView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
//                weakSelf.addressView1.typeButton2.alpha = 0;
////                weakSelf.addressView1.douhaoLable1.alpha = 0;
//
//
//                [weakSelf.addressView1.typeButton1 setTitle:title2 forState:UIControlStateNormal];
//                weakSelf.addressView1.chooseID1 = choose_id2;
//
//                [weakSelf.addressView1.typeButton setTitle:title1 forState:UIControlStateNormal];
//                weakSelf.addressView1.chooseID = choose_id1;
//            }
//            else if (title1.length > 0)
//            {
//                [weakSelf.addressView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
//                [weakSelf.addressView1.typeButton1 setTitle:@"" forState:UIControlStateNormal];
//                weakSelf.addressView1.typeButton2.alpha = 0;
//                weakSelf.addressView1.typeButton1.alpha = 0;
//
////                weakSelf.addressView1.douhaoLable1.alpha = 0;
////                weakSelf.addressView1.douhaoLable.alpha = 0;
//
//                [weakSelf.addressView1.typeButton setTitle:title1 forState:UIControlStateNormal];
//                weakSelf.addressView1.chooseID = choose_id1;
//            }
//            else
//            {
//                [weakSelf.addressView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
//                [weakSelf.addressView1.typeButton1 setTitle:@"" forState:UIControlStateNormal];
//                [weakSelf.addressView1.typeButton setTitle:@"" forState:UIControlStateNormal];
//
////                weakSelf.addressView1.douhaoLable1.alpha = 0;
////                weakSelf.addressView1.douhaoLable.alpha = 0;
//
//                weakSelf.addressView1.typeButton2.alpha = 0;
//                weakSelf.addressView1.typeButton1.alpha = 0;
//                weakSelf.addressView1.typeButton.alpha = 0;
//
//
//            }
            
            
            [weakSelf.addressView1.typeButton setTitle:@"" forState:UIControlStateNormal];
            weakSelf.addressView1.typeButton.alpha = 0;
            weakSelf.addressView1.chooseID = nil;
            
        }
        else if ([s isEqualToString:@"1"])
        {
//            if (title2.length > 0) {
//
//                [weakSelf.addressView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
//                weakSelf.addressView1.typeButton2.alpha = 0;
//
////                weakSelf.addressView1.douhaoLable1.alpha = 0;
//
//
//                [weakSelf.addressView1.typeButton1 setTitle:title2 forState:UIControlStateNormal];
//                weakSelf.addressView1.chooseID1 = choose_id2;
//
//                weakSelf.addressView1.chooseID = choose_id;
//            }
//            else
//            {
//                [weakSelf.addressView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
//                [weakSelf.addressView1.typeButton1 setTitle:@"" forState:UIControlStateNormal];
//
//                weakSelf.addressView1.typeButton2.alpha = 0;
//                weakSelf.addressView1.typeButton1.alpha = 0;
//
//
////                weakSelf.addressView1.douhaoLable1.alpha = 0;
////                weakSelf.addressView1.douhaoLable.alpha = 0;
//
//                weakSelf.addressView1.chooseID = choose_id;
//            }
            
            [weakSelf.addressView1.typeButton1 setTitle:@"" forState:UIControlStateNormal];
            weakSelf.addressView1.typeButton1.alpha = 0;
            weakSelf.addressView1.chooseID1 = nil;
        }
        else if ([s isEqualToString:@"2"])
        {
            [weakSelf.addressView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
            weakSelf.addressView1.typeButton2.alpha = 0;
            weakSelf.addressView1.chooseID2 = nil;
            
//            weakSelf.addressView1.douhaoLable1.alpha = 0;
            
//            weakSelf.addressView1.chooseID = choose_id;
//            weakSelf.addressView1.chooseID1 = choose_id1;
        }
        
        [weakSelf.addressView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        [weakSelf.addressView1.typeButton1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        [weakSelf.addressView1.typeButton2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        
        
    };
    [self.view addSubview:addressView1];
    [addressView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateView.bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(160));
    }];
    self.addressView1 = addressView1;
    
    
    //空载地
    AddBoatView * addressView = [[AddBoatView alloc]init];
    addressView.alpha = 0;
    addressView.chooseBlock = ^{
        
        [self.weightView.dunTextField resignFirstResponder];
        [self.weightView.percentTextField resignFirstResponder];
        [self.attentionView.textView resignFirstResponder];
        
        //类型选择
        AddressViewController * addressVc = [[AddressViewController alloc]init];
        addressVc.empty = @"报空";
        addressVc.fromTag = @"屏蔽全部";
        addressVc.addressBackBlock = ^(NSString *addressID, NSString *addressStr, NSString *parentProID,NSString * address_Str ) {
            if ([weakSelf.addressView.chooseButton.currentTitle isEqualToString:@"请选择空载地(最多三个)"]) {
                [weakSelf.addressView.chooseButton setTitle:addressStr forState:UIControlStateNormal];
                
                NSArray * idArray = [addressID componentsSeparatedByString:@"-"];
                
                weakSelf.addressID = idArray[1];
            }
            else
            {
                NSArray *array = [weakSelf.addressView.chooseButton.currentTitle componentsSeparatedByString:@","];
                if (array.count == 3) {
                    [weakSelf.view makeToast:@"最多只能选择三个地址" duration:0.5 position:CSToastPositionCenter];
                    return ;
                }
                
                NSString * str = [NSString stringWithFormat:@"%@,%@",weakSelf.addressView.chooseButton.currentTitle,addressStr];
                
                [weakSelf.addressView.chooseButton setTitle:str forState:UIControlStateNormal];
                
                weakSelf.addressID = [NSString stringWithFormat:@"%@,%@",weakSelf.addressID,[addressID componentsSeparatedByString:@"-"][1]];
                
                
            }
            
            [weakSelf.addressView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        };
        [weakSelf.navigationController pushViewController:addressVc animated:YES];
    };
    addressView.deleteBlock = ^{
        [weakSelf.addressView.chooseButton setTitle:@"请选择空载地(最多三个)" forState:UIControlStateNormal];
        [weakSelf.addressView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        weakSelf.addressID = nil;
    };
    addressView.chooseButton.alpha = 1;
    addressView.leftLable.text = @"清除清除";
    addressView.leftLable.alpha = 0;
    addressView.deleteButton.alpha = 1;
    [addressView.chooseButton setTitle:@"请选择空载地(最多三个)" forState:UIControlStateNormal];
    [addressView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [self.view addSubview:addressView];
    [addressView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateView.bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.addressView = addressView;
    
    ChooseView1 * typeView2 = [[ChooseView1 alloc]init];
    [typeView2.chooseButton setTitle:@"请选择前载货物(最多三个)" forState:UIControlStateNormal];
    typeView2.chooseHeightBlock = ^(CGFloat height) {
        [weakSelf.typeView2 updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(realH(180) + height - 24 - 10);
        }];
    };
    typeView2.emptyChooseBlock = ^{
        [self.weightView.dunTextField resignFirstResponder];
        [self.weightView.percentTextField resignFirstResponder];
        [self.attentionView.textView resignFirstResponder];
        
        //类型选择
        [weakSelf getCargoListRequest2];
    };
    
    typeView2.emptyDeleteBlock = ^(NSString *s) {
        if ([s isEqualToString:@"1"])
        {
            weakSelf.typeView2.lable1 = @"";
            weakSelf.typeView2.chooseID1 = nil;
        }
        else if ([s isEqualToString:@"2"])
        {
            weakSelf.typeView2.lable2 = @"";
            weakSelf.typeView2.chooseID2 = nil;
        }
        else if ([s isEqualToString:@"3"])
        {
            weakSelf.typeView2.lable3 = @"";
            weakSelf.typeView2.chooseID3 = nil;
        }
    };
    [self.view addSubview:typeView2];
    [typeView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressView1.bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(180));
    }];
    self.typeView2 = typeView2;
    
    
    ChooseView * typeView1 = [[ChooseView alloc]init];
    typeView1.alpha = 0;
    typeView1.emptyChooseBlock = ^{
        [self.weightView.dunTextField resignFirstResponder];
        [self.weightView.percentTextField resignFirstResponder];
        [self.attentionView.textView resignFirstResponder];
        
        //类型选择
        [weakSelf getCargoListRequest1];
    };
    typeView1.emptyDeleteBlock = ^(NSString *s) {
        NSString * choose_id = [weakSelf.typeView1.chooseID mutableCopy];
        NSString * choose_id1 = [weakSelf.typeView1.chooseID1 mutableCopy];
        NSString * choose_id2 = [weakSelf.typeView1.chooseID2 mutableCopy];
        
        NSString * title = [weakSelf.typeView1.typeButton.currentTitle mutableCopy];
        NSString * title1 = [weakSelf.typeView1.typeButton1.currentTitle mutableCopy];
        NSString * title2 = [weakSelf.typeView1.typeButton2.currentTitle mutableCopy];
        
        weakSelf.typeView1.chooseID = nil;
        weakSelf.typeView1.chooseID1 = nil;
        weakSelf.typeView1.chooseID2 = nil;
        
        
        
        if ([s isEqualToString:@"0"]) {
            if (title2.length > 0) {
                
                [weakSelf.typeView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
                weakSelf.typeView1.typeButton2.alpha = 0;
                weakSelf.typeView1.douhaoLable1.alpha = 0;
                
                [weakSelf.typeView1.typeButton1 setTitle:title2 forState:UIControlStateNormal];
                weakSelf.typeView1.chooseID1 = choose_id2;
                
                [weakSelf.typeView1.typeButton setTitle:title1 forState:UIControlStateNormal];
                weakSelf.typeView1.chooseID = choose_id1;
            }
            else if (title1.length > 0)
            {
                [weakSelf.typeView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
                [weakSelf.typeView1.typeButton1 setTitle:@"" forState:UIControlStateNormal];
                weakSelf.typeView1.typeButton2.alpha = 0;
                weakSelf.typeView1.typeButton1.alpha = 0;
                weakSelf.typeView1.douhaoLable1.alpha = 0;
                weakSelf.typeView1.douhaoLable.alpha = 0;
                
                [weakSelf.typeView1.typeButton setTitle:title1 forState:UIControlStateNormal];
                weakSelf.typeView1.chooseID = choose_id1;
            }
            else
            {
                [weakSelf.typeView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
                [weakSelf.typeView1.typeButton1 setTitle:@"" forState:UIControlStateNormal];
                [weakSelf.typeView1.typeButton setTitle:@"" forState:UIControlStateNormal];
                
                weakSelf.typeView1.douhaoLable1.alpha = 0;
                weakSelf.typeView1.douhaoLable.alpha = 0;
               
                weakSelf.typeView1.typeButton2.alpha = 0;
                weakSelf.typeView1.typeButton1.alpha = 0;
                weakSelf.typeView1.typeButton.alpha = 0;
                
                weakSelf.typeView1.typeButton.alpha = 0;
                weakSelf.typeView1.douhaoLable.alpha = 0;
            }
        }
        else if ([s isEqualToString:@"1"])
        {
            if (title2.length > 0) {
                
                [weakSelf.typeView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
                weakSelf.typeView1.typeButton2.alpha = 0;
                
                weakSelf.typeView1.douhaoLable1.alpha = 0;
                
                [weakSelf.typeView1.typeButton1 setTitle:title2 forState:UIControlStateNormal];
                weakSelf.typeView1.chooseID1 = choose_id2;
                
                weakSelf.typeView1.chooseID = choose_id;
            }
            else
            {
                [weakSelf.typeView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
                [weakSelf.typeView1.typeButton1 setTitle:@"" forState:UIControlStateNormal];
                
                weakSelf.typeView1.douhaoLable1.alpha = 0;
                weakSelf.typeView1.douhaoLable.alpha = 0;
                
                weakSelf.typeView1.typeButton2.alpha = 0;
                weakSelf.typeView1.typeButton1.alpha = 0;
                
                
                weakSelf.typeView1.douhaoLable1.alpha = 0;
                weakSelf.typeView1.douhaoLable.alpha = 0;
                
                weakSelf.typeView1.chooseID = choose_id;
            }
        }
        else if ([s isEqualToString:@"2"])
        {
            [weakSelf.typeView1.typeButton2 setTitle:@"" forState:UIControlStateNormal];
            weakSelf.typeView1.typeButton2.alpha = 0;
         
            weakSelf.typeView1.douhaoLable1.alpha = 0;
            
            weakSelf.typeView1.chooseID = choose_id;
            weakSelf.typeView1.chooseID1 = choose_id1;
        }
        
        CGFloat contentWidth = 0;
        if (weakSelf.typeView1.typeButton1.currentTitle.length > 0) {
            contentWidth = weakSelf.typeView1.typeButton.frame.origin.x + weakSelf.typeView1.typeButton.frame.size.width +  weakSelf.typeView1.typeButton1.frame.size.width + realW(40);
        }
        if (weakSelf.typeView1.typeButton2.currentTitle.length > 0)
        {
            contentWidth = weakSelf.typeView1.typeButton.frame.origin.x + weakSelf.typeView1.typeButton.frame.size.width +  weakSelf.typeView1.typeButton1.frame.size.width +  weakSelf.typeView1.typeButton2.frame.size.width + realW(80);
        }
        
        [weakSelf.addressView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        [weakSelf.addressView1.typeButton1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        [weakSelf.addressView1.typeButton2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.typeView1.scrollView setContentSize:CGSizeMake(contentWidth, 0)];
        });
        
        
        
    };
    [typeView1.chooseButton setTitle:@"请选择前载货物(最多三个)" forState:UIControlStateNormal];
    [typeView1.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [self.view addSubview:typeView1];
    [typeView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressView1.bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(180));
    }];
    self.typeView1 = typeView1;
    
    
    //前载物
    AddBoatView * typeView = [[AddBoatView alloc]init];
    typeView.alpha = 0;
    typeView.chooseBlock = ^{

        [self.weightView.dunTextField resignFirstResponder];
        [self.weightView.percentTextField resignFirstResponder];
        [self.attentionView.textView resignFirstResponder];

        //类型选择
        [weakSelf getCargoListRequest];

    };
    typeView.deleteBlock = ^{
        [weakSelf.typeView.chooseButton setTitle:@"请选择前载货物(最多三个)" forState:UIControlStateNormal];
        [weakSelf.typeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        weakSelf.goodsStyleID = nil;
    };
    typeView.chooseButton.alpha = 1;
    typeView.leftLable.text = @"清除清除";
    typeView.leftLable.alpha = 0;
    typeView.deleteButton.alpha = 1;
    [typeView.chooseButton setTitle:@"请选择前载货物(最多三个)" forState:UIControlStateNormal];
    [typeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [self.view addSubview:typeView];
    [typeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressView.bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.typeView = typeView;
    
    
    //备注
    AddBoatView * attentionView = [[AddBoatView alloc]init];
    attentionView.textView.alpha = 1;
    attentionView.placeholderLable.alpha = 1;
    attentionView.leftLable.alpha = 0;
    attentionView.attentionLable.alpha = 1;
    attentionView.attentionLable.text = @"备注";
    [self.view addSubview:attentionView];
    [attentionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeView2.bottom).offset(realH(20));
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(200));
    }];
    self.attentionView = attentionView;
    

    
    //确认发布
    UIButton * publishButton = [[UIButton alloc]init];
    [publishButton addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
    [publishButton setTitle:@"确认报空" forState:UIControlStateNormal];
    [publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishButton.backgroundColor = XXJColor(27, 69, 138);
    publishButton.layer.cornerRadius = 5;
    publishButton.clipsToBounds = YES;
    publishButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:publishButton];
    [publishButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(attentionView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
        
    }];
    
    
    
    if (self.updateModel) {
        shipNameView.leftLable.text = self.updateModel.name;
        shipNameView.emptyTextField.text = [NSString stringWithFormat:@"%@吨",self.updateModel.deadweight];
        weightView.dunTextField.text = self.updateModel.cargo_ton;
        weightView.percentTextField.text = self.updateModel.cargo_ton_num;
        dateView.startDateTextField.text = [TYDateUtils timestampSwitchTime:[self.updateModel.n_time integerValue]];
        dateView.endDateTextField.text = [TYDateUtils timestampSwitchTime:[self.updateModel.e_n_time integerValue]];
        
//        [addressView.chooseButton setTitle:[self.updateModel.n_port stringByReplacingOccurrencesOfString:@"-" withString:@""] forState:UIControlStateNormal];
//        [addressView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        
        NSString * address = [self.updateModel.n_port stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSArray * addressArray = [address componentsSeparatedByString:@","];
        if (addressArray.count == 1) {
            [addressView1.typeButton setTitle:addressArray[0] forState:UIControlStateNormal];
            [addressView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            addressView1.typeButton.alpha = 1;
            
        }
        else if (addressArray.count == 2)
        {
            [addressView1.typeButton setTitle:addressArray[0] forState:UIControlStateNormal];
            [addressView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            addressView1.typeButton.alpha = 1;
            
            [addressView1.typeButton1 setTitle:addressArray[1] forState:UIControlStateNormal];
            [addressView1.typeButton1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            addressView1.typeButton1.alpha = 1;
            addressView1.douhaoLable.alpha = 1;
        }
        else if (addressArray.count == 3)
        {
            [addressView1.typeButton setTitle:addressArray[0] forState:UIControlStateNormal];
            [addressView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            addressView1.typeButton.alpha = 1;
            
            [addressView1.typeButton1 setTitle:addressArray[1] forState:UIControlStateNormal];
            [addressView1.typeButton1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            addressView1.typeButton1.alpha = 1;
            
            [addressView1.typeButton2 setTitle:addressArray[2] forState:UIControlStateNormal];
            [addressView1.typeButton2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            addressView1.typeButton2.alpha = 1;
            
            addressView1.douhaoLable.alpha = 1;
            addressView1.douhaoLable1.alpha = 1;
        }
        
        
        
        
//        [typeView.chooseButton setTitle:self.updateModel.before_cargo forState:UIControlStateNormal];
//        [typeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        
        
        NSArray * typeArray = [self.updateModel.before_cargo componentsSeparatedByString:@","];
        if (typeArray.count == 1) {
//            [typeView1.typeButton setTitle:typeArray[0] forState:UIControlStateNormal];
//            [typeView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
//            typeView1.typeButton.alpha = 1;
            
            
            typeView2.lable1 = typeArray[0];
            
        }
        else if (typeArray.count == 2)
        {
//            [typeView1.typeButton setTitle:typeArray[0] forState:UIControlStateNormal];
//            [typeView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
//            typeView1.typeButton.alpha = 1;
//
//            [typeView1.typeButton1 setTitle:typeArray[1] forState:UIControlStateNormal];
//            [typeView1.typeButton1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
//            typeView1.typeButton1.alpha = 1;
//
//            typeView1.douhaoLable.alpha = 1;
            
            typeView2.lable1 = typeArray[0];
            typeView2.lable2 = typeArray[1];
        }
        else if (typeArray.count == 3)
        {
//            [typeView1.typeButton setTitle:typeArray[0] forState:UIControlStateNormal];
//            [typeView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
//            typeView1.typeButton.alpha = 1;
//
//            [typeView1.typeButton1 setTitle:typeArray[1] forState:UIControlStateNormal];
//            [typeView1.typeButton1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
//            typeView1.typeButton1.alpha = 1;
//
//            [typeView1.typeButton2 setTitle:typeArray[2] forState:UIControlStateNormal];
//            [typeView1.typeButton2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
//            typeView1.typeButton2.alpha = 1;
//
//            typeView1.douhaoLable.alpha = 1;
//            typeView1.douhaoLable1.alpha = 1;
            
            typeView2.lable1 = typeArray[0];
            typeView2.lable2 = typeArray[1];
            typeView2.lable3 = typeArray[2];
        }
        
        
        

        attentionView.textView.text = self.updateModel.remark;
        [publishButton setTitle:@"确认修改" forState:UIControlStateNormal];
        
        
        self.addressID = self.updateModel.n_port_id;
        self.goodsStyleID = self.updateModel.before_cargo_id;
        
        NSArray * addressIDArray = [self.updateModel.n_port_id componentsSeparatedByString:@","];
        if (addressIDArray.count == 1) {
            addressView1.chooseID = addressIDArray[0];
        }
        else if (addressIDArray.count == 2)
        {
            addressView1.chooseID = addressIDArray[0];
            addressView1.chooseID1 = addressIDArray[1];
        }
        else if (addressIDArray.count == 3)
        {
            addressView1.chooseID = addressIDArray[0];
            addressView1.chooseID1 = addressIDArray[1];
            addressView1.chooseID2 = addressIDArray[2];
        }
        
        
        
        NSArray * typeIDArray = [self.updateModel.before_cargo_id componentsSeparatedByString:@","];
        
        if (typeIDArray.count == 1) {
            typeView2.chooseID1 = typeIDArray[0];
        }
        else if (typeIDArray.count == 2)
        {
            typeView2.chooseID1 = typeIDArray[0];
            typeView2.chooseID2 = typeIDArray[1];
        }
        else if (typeIDArray.count == 3)
        {
            typeView2.chooseID1 = typeIDArray[0];
            typeView2.chooseID2 = typeIDArray[1];
            typeView2.chooseID3 = typeIDArray[2];
        }
    }
    
    
    
}

#pragma mark -- 货物类型
-(void)getCargoListRequest2
{
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\"",@""];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetCagoList URLMethod:GetCagoListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        
        NSArray * dataArray = result[@"result"][@"data"];
        
        NSMutableArray * pppArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i < dataArray.count; i++) {
            
            //            NSMutableDictionary * qqq = [NSMutableDictionary dictionary];
            //
            //            NSMutableDictionary * sss = [NSMutableDictionary dictionary];
            
            NSMutableDictionary * ppp = [NSMutableDictionary dictionary];
            
            NSMutableArray * sssArray = [NSMutableArray array];
            
            //            NSMutableArray * qqqArray = [NSMutableArray array];
            
            NSDictionary * dict = dataArray[i];
            
            if ([dict[@"f_level"] isEqual:[NSNull null]]) {
                
            }
            else
            {
                NSArray * f_levelArray = dict[@"f_level"];
                for (NSInteger a = 0; a < f_levelArray.count; a++) {
                    NSDictionary * adict = f_levelArray[a];
                    
                    NSMutableArray * qqqArray = [NSMutableArray array];
                    NSMutableDictionary * sss = [NSMutableDictionary dictionary];
                    
                    if ([adict[@"s_level"] isEqual:[NSNull null]]) {
                        
                    }
                    else
                    {
                        NSArray * s_levelArray = adict[@"s_level"];
                        for (NSInteger b = 0; b < s_levelArray.count; b++) {
                            
                            NSMutableDictionary * qqq = [NSMutableDictionary dictionary];
                            
                            NSDictionary * bDict = s_levelArray[b];
                            
                            [qqq setObject:bDict[@"id"] forKey:@"code"];
                            [qqq setObject:bDict[@"name"] forKey:@"name"];
                            [qqq setObject:[NSString stringWithFormat:@"%ld",b] forKey:@"index"];
                            
                            [qqqArray addObject:qqq];
                        }
                    }
                    
                    [sss setObject:adict[@"id"] forKey:@"code"];
                    [sss setObject:adict[@"name"] forKey:@"name"];
                    [sss setObject:[NSString stringWithFormat:@"%ld",a] forKey:@"index"];
                    [sss setObject:qqqArray forKey:@"arealist"];
                    
                    [sssArray addObject:sss];
                }
            }
            
            [ppp setObject:dict[@"id"] forKey:@"code"];
            [ppp setObject:dict[@"name"] forKey:@"name"];
            [ppp setObject:[NSString stringWithFormat:@"%ld",i] forKey:@"index"];
            [ppp setObject:sssArray forKey:@"citylist"];
            [pppArray addObject:ppp];
            
        }
        
        NSArray * dataSource = [NSArray arrayWithArray:pppArray];
        
        BRAddressPickerView *addressView = [[BRAddressPickerView alloc]init];
        addressView.fromTag = @"特列";
        
        __weak typeof(self) weakSelf = self;
        [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:nil isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            
            XXJLog(@"%@  %@  %@",province.name,city.name,area.name)
            
            if (area.name.length <= 0) {
                //                return ;
                
                NSDictionary * dict = dataSource[0][@"citylist"][0][@"arealist"];
                if (dict.count > 0) {
                    dict = dataSource[0][@"citylist"][0][@"arealist"][0];
                    if (dict.count > 0) {
                        area.name = dict[@"name"];
                        area.code = dict[@"code"];
                        area.index = [dict[@"index"] integerValue];
                    }
                }
            }
            
            
            NSString * goodsStyleStr = nil;
            NSString * goodsStyleID = nil;
            if (![area.name isEqualToString:@" "] && ![area.name isEqual:[NSNull null]] && area.name != nil) {
                goodsStyleStr = area.name;
                goodsStyleID = area.code;
            }
            else if (![city.name isEqualToString:@" "] && ![city.name isEqual:[NSNull null]] && city.name != nil)
            {
                goodsStyleStr = city.name;
                goodsStyleID = city.code;
            }
            else
            {
                goodsStyleStr = province.name;
                goodsStyleID = province.code;
            }
            
            if (weakSelf.typeView2.typeLable1.contentLable.text.length > 0 && weakSelf.typeView2.typeLable2.contentLable.text.length > 0 && weakSelf.typeView2.typeLable3.contentLable.text.length > 0) {
                [weakSelf.view makeToast:@"最多只能选择三个" duration:0.5 position:CSToastPositionCenter];
                return;
            }
            
            
            if (weakSelf.typeView2.typeLable1.contentLable.text.length == 0) {
                
                if (![goodsStyleStr isEqualToString:weakSelf.typeView2.typeLable2.contentLable.text] || ![goodsStyleStr isEqualToString:weakSelf.typeView2.typeLable3.contentLable.text]) {
                    weakSelf.typeView2.lable1 = goodsStyleStr;
                    
                    weakSelf.typeView2.chooseID1 = goodsStyleID;
                }
                
                
            }
            else if (weakSelf.typeView2.typeLable2.contentLable.text.length == 0)
            {
                if (![goodsStyleStr isEqualToString:weakSelf.typeView2.typeLable1.contentLable.text] || ![goodsStyleStr isEqualToString:weakSelf.typeView2.typeLable3.contentLable.text]) {
                    
                    weakSelf.typeView2.lable2 = goodsStyleStr;
                    
                    weakSelf.typeView2.chooseID2 = goodsStyleID;
                }
                
                
            }
            else if (weakSelf.typeView2.typeLable3.contentLable.text.length == 0)
            {
                if (![goodsStyleStr isEqualToString:weakSelf.typeView2.typeLable1.contentLable.text] || ![goodsStyleStr isEqualToString:weakSelf.typeView2.typeLable2.contentLable.text]) {
                    
                    weakSelf.typeView2.lable3 = goodsStyleStr;
                    
                    weakSelf.typeView2.chooseID3 = goodsStyleID;
                }
            }
        
            
            
        } cancelBlock:^{
            
        }];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}





#pragma mark -- 货物类型
-(void)getCargoListRequest1
{
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\"",@""];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetCagoList URLMethod:GetCagoListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        
        NSArray * dataArray = result[@"result"][@"data"];
        
        NSMutableArray * pppArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i < dataArray.count; i++) {
            
            //            NSMutableDictionary * qqq = [NSMutableDictionary dictionary];
            //
            //            NSMutableDictionary * sss = [NSMutableDictionary dictionary];
            
            NSMutableDictionary * ppp = [NSMutableDictionary dictionary];
            
            NSMutableArray * sssArray = [NSMutableArray array];
            
            //            NSMutableArray * qqqArray = [NSMutableArray array];
            
            NSDictionary * dict = dataArray[i];
            
            if ([dict[@"f_level"] isEqual:[NSNull null]]) {
                
            }
            else
            {
                NSArray * f_levelArray = dict[@"f_level"];
                for (NSInteger a = 0; a < f_levelArray.count; a++) {
                    NSDictionary * adict = f_levelArray[a];
                    
                    NSMutableArray * qqqArray = [NSMutableArray array];
                    NSMutableDictionary * sss = [NSMutableDictionary dictionary];
                    
                    if ([adict[@"s_level"] isEqual:[NSNull null]]) {
                        
                    }
                    else
                    {
                        NSArray * s_levelArray = adict[@"s_level"];
                        for (NSInteger b = 0; b < s_levelArray.count; b++) {
                            
                            NSMutableDictionary * qqq = [NSMutableDictionary dictionary];
                            
                            NSDictionary * bDict = s_levelArray[b];
                            
                            [qqq setObject:bDict[@"id"] forKey:@"code"];
                            [qqq setObject:bDict[@"name"] forKey:@"name"];
                            [qqq setObject:[NSString stringWithFormat:@"%ld",b] forKey:@"index"];
                            
                            [qqqArray addObject:qqq];
                        }
                    }
                    
                    [sss setObject:adict[@"id"] forKey:@"code"];
                    [sss setObject:adict[@"name"] forKey:@"name"];
                    [sss setObject:[NSString stringWithFormat:@"%ld",a] forKey:@"index"];
                    [sss setObject:qqqArray forKey:@"arealist"];
                    
                    [sssArray addObject:sss];
                }
            }
            
            [ppp setObject:dict[@"id"] forKey:@"code"];
            [ppp setObject:dict[@"name"] forKey:@"name"];
            [ppp setObject:[NSString stringWithFormat:@"%ld",i] forKey:@"index"];
            [ppp setObject:sssArray forKey:@"citylist"];
            [pppArray addObject:ppp];
            
        }
        
        NSArray * dataSource = [NSArray arrayWithArray:pppArray];
        
        BRAddressPickerView *addressView = [[BRAddressPickerView alloc]init];
        addressView.fromTag = @"特列";
        
        __weak typeof(self) weakSelf = self;
        [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:nil isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            
            XXJLog(@"%@  %@  %@",province.name,city.name,area.name)
            
            if (area.name.length <= 0) {
                //                return ;
                
                NSDictionary * dict = dataSource[0][@"citylist"][0][@"arealist"];
                if (dict.count > 0) {
                    dict = dataSource[0][@"citylist"][0][@"arealist"][0];
                    if (dict.count > 0) {
                        area.name = dict[@"name"];
                        area.code = dict[@"code"];
                        area.index = [dict[@"index"] integerValue];
                    }
                }
            }
            
            
            NSString * goodsStyleStr = nil;
            NSString * goodsStyleID = nil;
            if (![area.name isEqualToString:@" "] && ![area.name isEqual:[NSNull null]] && area.name != nil) {
                goodsStyleStr = area.name;
                goodsStyleID = area.code;
            }
            else if (![city.name isEqualToString:@" "] && ![city.name isEqual:[NSNull null]] && city.name != nil)
            {
                goodsStyleStr = city.name;
                goodsStyleID = city.code;
            }
            else
            {
                goodsStyleStr = province.name;
                goodsStyleID = province.code;
            }
            
            if (weakSelf.typeView1.typeButton2.currentTitle.length > 0) {
                [weakSelf.view makeToast:@"最多只能选择三个" duration:0.5 position:CSToastPositionCenter];
                return;
            }
            

            if (weakSelf.typeView1.typeButton.currentTitle.length == 0) {
                [weakSelf.typeView1.typeButton setTitle:goodsStyleStr forState:UIControlStateNormal];
                [weakSelf.typeView1.typeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
                weakSelf.typeView1.typeButton.alpha = 1;
                weakSelf.typeView1.douhaoLable.alpha = 0;
                weakSelf.typeView1.chooseID = goodsStyleID;
            }
            else if (weakSelf.typeView1.typeButton1.currentTitle.length == 0)
            {
                if (![goodsStyleStr isEqualToString:weakSelf.typeView1.typeButton.currentTitle]) {
                    [weakSelf.typeView1.typeButton1 setTitle:goodsStyleStr forState:UIControlStateNormal];
                    [weakSelf.typeView1.typeButton1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
                    weakSelf.typeView1.typeButton1.alpha = 1;
                    weakSelf.typeView1.douhaoLable.alpha = 1;
                    weakSelf.typeView1.chooseID1 = goodsStyleID;
                }
                
                
            }
            else if (weakSelf.typeView1.typeButton2.currentTitle.length == 0)
            {
                if (![goodsStyleStr isEqualToString:weakSelf.typeView1.typeButton.currentTitle] && ![goodsStyleStr isEqualToString:weakSelf.typeView1.typeButton1.currentTitle]) {
                    [weakSelf.typeView1.typeButton2 setTitle:goodsStyleStr forState:UIControlStateNormal];
                    [weakSelf.typeView1.typeButton2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
                    weakSelf.typeView1.douhaoLable.alpha = 1;
                    weakSelf.typeView1.douhaoLable1.alpha = 1;
                    weakSelf.typeView1.typeButton2.alpha = 1;
                    weakSelf.typeView1.chooseID2 = goodsStyleID;
                }
            }
            
            CGFloat contentWidth = 0;
            if (weakSelf.typeView1.typeButton1.currentTitle.length > 0) {
                contentWidth = weakSelf.typeView1.typeButton.frame.origin.x + weakSelf.typeView1.typeButton.frame.size.width +  weakSelf.typeView1.typeButton1.frame.size.width + realW(40);
            }
            if (weakSelf.typeView1.typeButton2.currentTitle.length > 0)
            {
                contentWidth = weakSelf.typeView1.typeButton.frame.origin.x + weakSelf.typeView1.typeButton.frame.size.width +  weakSelf.typeView1.typeButton1.frame.size.width +  weakSelf.typeView1.typeButton2.frame.size.width + realW(80);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.typeView1.scrollView setContentSize:CGSizeMake(contentWidth, 0)];
            });
            
            
        } cancelBlock:^{
            
        }];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}




#pragma mark -- 货物类型
-(void)getCargoListRequest
{
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\"",@""];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetCagoList URLMethod:GetCagoListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        
        NSArray * dataArray = result[@"result"][@"data"];
        
        NSMutableArray * pppArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i < dataArray.count; i++) {
            
//            NSMutableDictionary * qqq = [NSMutableDictionary dictionary];
//
//            NSMutableDictionary * sss = [NSMutableDictionary dictionary];
            
            NSMutableDictionary * ppp = [NSMutableDictionary dictionary];
            
            NSMutableArray * sssArray = [NSMutableArray array];
            
//            NSMutableArray * qqqArray = [NSMutableArray array];
            
            NSDictionary * dict = dataArray[i];
            
            if ([dict[@"f_level"] isEqual:[NSNull null]]) {
                
            }
            else
            {
                NSArray * f_levelArray = dict[@"f_level"];
                for (NSInteger a = 0; a < f_levelArray.count; a++) {
                    NSDictionary * adict = f_levelArray[a];
                    
                    NSMutableArray * qqqArray = [NSMutableArray array];
                    NSMutableDictionary * sss = [NSMutableDictionary dictionary];
                    
                    if ([adict[@"s_level"] isEqual:[NSNull null]]) {
                        
                    }
                    else
                    {
                        NSArray * s_levelArray = adict[@"s_level"];
                        for (NSInteger b = 0; b < s_levelArray.count; b++) {
                            
                            NSMutableDictionary * qqq = [NSMutableDictionary dictionary];
                            
                            NSDictionary * bDict = s_levelArray[b];
                            
                            [qqq setObject:bDict[@"id"] forKey:@"code"];
                            [qqq setObject:bDict[@"name"] forKey:@"name"];
                            [qqq setObject:[NSString stringWithFormat:@"%ld",b] forKey:@"index"];
                            
                            [qqqArray addObject:qqq];
                        }
                    }
                    
                    [sss setObject:adict[@"id"] forKey:@"code"];
                    [sss setObject:adict[@"name"] forKey:@"name"];
                    [sss setObject:[NSString stringWithFormat:@"%ld",a] forKey:@"index"];
                    [sss setObject:qqqArray forKey:@"arealist"];
                    
                    [sssArray addObject:sss];
                }
            }
            
            [ppp setObject:dict[@"id"] forKey:@"code"];
            [ppp setObject:dict[@"name"] forKey:@"name"];
            [ppp setObject:[NSString stringWithFormat:@"%ld",i] forKey:@"index"];
            [ppp setObject:sssArray forKey:@"citylist"];
            [pppArray addObject:ppp];
            
        }
        
        NSArray * dataSource = [NSArray arrayWithArray:pppArray];
        
        BRAddressPickerView *addressView = [[BRAddressPickerView alloc]init];
        addressView.fromTag = @"特列";
        
        __weak typeof(self) weakSelf = self;
        [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:nil isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            
            XXJLog(@"%@  %@  %@",province.name,city.name,area.name)
            
            if (area.name.length <= 0) {
                //                return ;
                
                NSDictionary * dict = dataSource[0][@"citylist"][0][@"arealist"];
                if (dict.count > 0) {
                    dict = dataSource[0][@"citylist"][0][@"arealist"][0];
                    if (dict.count > 0) {
                        area.name = dict[@"name"];
                        area.code = dict[@"code"];
                        area.index = [dict[@"index"] integerValue];
                    }
                }
                
            }
            
            
            NSString * goodsStyleStr = nil;
            NSString * goodsStyleID = nil;
            if (![area.name isEqualToString:@" "] && ![area.name isEqual:[NSNull null]] && area.name != nil) {
                goodsStyleStr = area.name;
                goodsStyleID = area.code;
            }
            else if (![city.name isEqualToString:@" "] && ![city.name isEqual:[NSNull null]] && city.name != nil)
            {
                goodsStyleStr = city.name;
                goodsStyleID = city.code;
            }
            else
            {
                goodsStyleStr = province.name;
                goodsStyleID = province.code;
            }
            
            if ([weakSelf.typeView.chooseButton.currentTitle isEqualToString:@"请选择前载货物(最多三个)"]) {
                [weakSelf.typeView.chooseButton setTitle:goodsStyleStr forState:UIControlStateNormal];
                weakSelf.goodsStyleID = goodsStyleID;
            }
            else
            {
            
                
                NSArray *array = [weakSelf.typeView.chooseButton.currentTitle componentsSeparatedByString:@","];
                
                if ([array containsObject:goodsStyleStr]) {
                    return ;
                }
                
                
                if (array.count == 3) {
                    [weakSelf.view makeToast:@"最多只能选择三个类型" duration:0.5 position:CSToastPositionCenter];
                    return ;
                }
                
                
                NSString * str = [NSString stringWithFormat:@"%@,%@",weakSelf.typeView.chooseButton.currentTitle,goodsStyleStr];
                weakSelf.goodsStyleID = [NSString stringWithFormat:@"%@,%@",weakSelf.goodsStyleID,goodsStyleID];
                [weakSelf.typeView.chooseButton setTitle:str forState:UIControlStateNormal];
            }
            
            
            
            [weakSelf.typeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
            
            
            
        } cancelBlock:^{
            
        }];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}










#pragma mark -- 确认报空
-(void)publishClick:(UIButton *)button
{
    
   
    
    if (self.weightView.dunTextField.text.length == 0) {
        
        [self.view makeToast:@"请填写意向货量" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    else
    {
        NSString * deadweight = self.model == nil ? self.updateModel.deadweight : self.model.deadweight;
        
        if ([self.weightView.dunTextField.text floatValue] > [deadweight floatValue]) {
            
            [self.view makeToast:@"货量超重，请重填" duration:0.5 position:CSToastPositionCenter];
            
            return;
        }
        else
        {
            CGFloat weight = [self.weightView.dunTextField.text floatValue] /*+ [self.weightView.dunTextField.text floatValue] * ([self.weightView.percentTextField.text floatValue] * 0.01)*/;
            
            if (weight > [deadweight floatValue]) {
                [self.view makeToast:@"货量超重，请重填" duration:0.5 position:CSToastPositionCenter];
                
                return;
            }
        }
    }
    

    if (self.dateView.startDateTextField.text.length == 0) {
        [self.view makeToast:@"请填写空载期" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    if (self.dateView.endDateTextField.text.length == 0) {
        [self.view makeToast:@"请填写空载期" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    if (self.addressView1.chooseID == nil && self.addressView1.chooseID1 == nil  && self.addressView1.chooseID2 == nil ) {
        [self.view makeToast:@"请选择空载地" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    else
    {
//        if (self.addressView1.chooseID2) {
//            self.addressID = [NSString stringWithFormat:@"%@,%@,%@",self.addressView1.chooseID,self.addressView1.chooseID1,self.addressView1.chooseID2];
//        }
//        else if (self.addressView1.chooseID1)
//        {
//            self.addressID = [NSString stringWithFormat:@"%@,%@",self.addressView1.chooseID,self.addressView1.chooseID1];
//        }
//        else if (self.addressView1.chooseID)
//        {
//            self.addressID = self.addressView1.chooseID;
//        }
        
    
        
        if (self.addressView1.chooseID) {
            if (self.addressView1.chooseID1) {
                if (self.addressView1.chooseID2) {
                    self.addressID = [NSString stringWithFormat:@"%@,%@,%@",self.addressView1.chooseID,self.addressView1.chooseID1,self.addressView1.chooseID2];
                }
                else
                {
                    self.addressID = [NSString stringWithFormat:@"%@,%@",self.addressView1.chooseID,self.addressView1.chooseID1];
                }
            }
            else
            {
                if (self.addressView1.chooseID2) {
                    self.addressID = [NSString stringWithFormat:@"%@,%@",self.addressView1.chooseID,self.addressView1.chooseID2];
                }
                else
                {
                    self.addressID = self.addressView1.chooseID;
                }
            }
        }
        else
        {
            if (self.addressView1.chooseID1) {
                if (self.addressView1.chooseID2) {
                    self.addressID = [NSString stringWithFormat:@"%@,%@",self.addressView1.chooseID1,self.addressView1.chooseID2];
                }
                else
                {
                    self.addressID = self.typeView2.chooseID1;
                }
            }
            else
            {
                if (self.addressView1.chooseID2) {
                    self.addressID = self.addressView1.chooseID2;
                }
                else
                {
                    [self.view makeToast:@"请选择空载地" duration:0.5 position:CSToastPositionCenter];
                    return;
                }
            }
        }
        
        
    }
    
    if (self.typeView2.chooseID1 == nil && self.typeView2.chooseID2 == nil && self.typeView2.chooseID3 == nil) {
        [self.view makeToast:@"请选择前载货物" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    else
    {
//        if (self.typeView2.chooseID3) {
//            self.goodsStyleID = [NSString stringWithFormat:@"%@,%@,%@",self.typeView2.chooseID1,self.typeView2.chooseID2,self.typeView2.chooseID3];
//        }
//        else if (self.typeView2.chooseID2)
//        {
//            self.goodsStyleID = [NSString stringWithFormat:@"%@,%@",self.typeView1.chooseID,self.typeView1.chooseID1];
//        }
//        else if (self.typeView1.chooseID)
//        {
//            self.goodsStyleID = self.typeView1.chooseID;
//        }
        
        if (self.typeView2.chooseID1) {
            if (self.typeView2.chooseID2) {
                if (self.typeView2.chooseID3) {
                    self.goodsStyleID = [NSString stringWithFormat:@"%@,%@,%@",self.typeView2.chooseID1,self.typeView2.chooseID2,self.typeView2.chooseID3];
                }
                else
                {
                    self.goodsStyleID = [NSString stringWithFormat:@"%@,%@",self.typeView2.chooseID1,self.typeView2.chooseID2];
                }
            }
            else
            {
                if (self.typeView2.chooseID3) {
                    self.goodsStyleID = [NSString stringWithFormat:@"%@,%@",self.typeView2.chooseID1,self.typeView2.chooseID3];
                }
                else
                {
                    self.goodsStyleID = self.typeView2.chooseID1;
                }
            }
        }
        else
        {
            if (self.typeView2.chooseID2) {
                if (self.typeView2.chooseID3) {
                    self.goodsStyleID = [NSString stringWithFormat:@"%@,%@",self.typeView2.chooseID2,self.typeView2.chooseID3];
                }
                else
                {
                    self.goodsStyleID = self.typeView2.chooseID2;
                }
            }
            else
            {
                if (self.typeView2.chooseID3) {
                    self.goodsStyleID = self.typeView2.chooseID3;
                }
                else
                {
                    [self.view makeToast:@"请选择前载货物" duration:0.5 position:CSToastPositionCenter];
                    return;
                }
            }
        }
    }
    
    
//    if ([self.addressView.chooseButton.currentTitle isEqualToString:@"请选择空载地(最多三个)"]) {
//        [self.view makeToast:@"请选择空载地" duration:0.5 position:CSToastPositionCenter];
//        return;
//    }
//
//    if ([self.typeView.chooseButton.currentTitle isEqualToString:@"请选择前载货物(最多三个)"]) {
//        [self.view makeToast:@"请选择前载货物" duration:0.5 position:CSToastPositionCenter];
//        return;
//    }
    
    
    
    
    
    NSInteger date1 = [TYDateUtils compareDate:self.dateView.startDateTextField.text withDate:self.dateView.endDateTextField.text formate:@"yyyy-MM-dd"];
    if (date1 == 1) {
        //end 大
    }
    else
    {
        //end 小
        [self.view makeToast:@"请重新选择受载期" duration:1.0 position:CSToastPositionCenter];
        
        return;
    }
    
    NSString * shipping_id = nil;
    NSString * msg = nil;
    if ([button.currentTitle isEqualToString:@"确认修改"]) {
        shipping_id = self.updateModel.shipping_id;
        msg = @"修改成功";
    }
    else
    {
        shipping_id = @"";
        msg = @"报空成功";
    }
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"ship_id\":\"%@\",\"cargo_ton\":\"%@\",\"n_port\":\"%@\",\"f_port\":\"%@\",\"n_time\":\"%ld\",\"remark\":\"%@\",\"acess_token\":\"%@\",\"source\":\"%@\",\"e_n_time\":\"%ld\",\"before_cargo\":\"%@\",\"cargo_ton_num\":\"%@\",\"shipping_id\":\"%@\"",
                                 self.model.ship_id == nil ? self.updateModel.ship_id : self.model.ship_id,
                                 self.weightView.dunTextField.text,
                                 self.addressID,
                                 self.addressID,
                                 [TYDateUtils timeSwitchTimestamp:self.dateView.startDateTextField.text andFormatter:@"yyyy-MM-dd"],
                                 self.attentionView.textView.text,
                                 [UseInfo shareInfo].access_token,
                                 @"2",
                                 [TYDateUtils timeSwitchTimestamp:self.dateView.endDateTextField.text andFormatter:@"yyyy-MM-dd"],
                                 self.goodsStyleID,
                                 self.weightView.percentTextField.text.length == 0 ? @"0" : self.weightView.percentTextField.text,
                                 shipping_id
                                 ];
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:EmptyShip URLMethod:EmptyShipMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        if ([result[@"result"][@"status"] boolValue]) {
            
            [self.view makeToast:msg duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                if ([msg isEqualToString:@"修改成功"]) {
                    self.emptyUpdateBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            
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
