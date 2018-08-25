//
//  UpdateViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/29.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "UpdateViewController.h"

#import "AddressViewController.h"

#import "PublishGoodsView.h"
#import "AddBoatView.h"
#import "AlreadyOfferModel.h"
@interface UpdateViewController ()

@property (nonatomic, weak) PublishGoodsView * pubLishView;

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"修改货盘";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSuccess) name:@"update" object:nil];
    
    [self setUpUI];
    
    //信息回填
    [self valueWrite];
    
}



-(void)setUpUI
{
    __weak typeof(self) weakSelf = self;
    PublishGoodsView * pubLishView = [[PublishGoodsView alloc]init];
    
    
    pubLishView.fromTag = @"修改";
    
    pubLishView.chooseAddressBlock = ^(NSString *addressStr) {
        
        NSString * switchAddress = addressStr;
        
        AddressViewController * addressVc = [[AddressViewController alloc]init];
        addressVc.addressBackBlock = ^(NSString *addressID, NSString *addressStr, NSString *parentProID,NSString * address_Str) {
            if ([switchAddress isEqualToString:@"起运港"]) {
                [weakSelf.pubLishView.startView.chooseButton setTitle:address_Str forState:UIControlStateNormal];
                [weakSelf.pubLishView.startView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
                
                weakSelf.pubLishView.b_port_id = addressID;
                weakSelf.pubLishView.parent_b_port_id = parentProID;
                weakSelf.pubLishView.b_port_address = addressStr;
            }
            else
            {
                [weakSelf.pubLishView.endView.chooseButton setTitle:address_Str forState:UIControlStateNormal];
                [weakSelf.pubLishView.endView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
                
                weakSelf.pubLishView.e_port_id = addressID;
                weakSelf.pubLishView.parent_e_port_id = parentProID;
                weakSelf.pubLishView.e_port_address = addressStr;
                
            }
        };
        [weakSelf.navigationController pushViewController:addressVc animated:YES];
        
    };
    
    pubLishView.publishSuccessBlock = ^(NSDictionary *dict) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateSuccess" object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    };
    
    [self.view addSubview:pubLishView];
    [pubLishView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
    }];
    self.pubLishView = pubLishView;
    
    
}


//数据回填
-(void)valueWrite
{
    
    self.pubLishView.updateCargo_id = self.model.id;
    
    NSString * priceStr = [self.model.cons_type isEqualToString:@"1"] ? @"公开询价" : @"指定询价";
    
    self.pubLishView.priceStr = self.model.cons_type;
    
    //询价类型
    [self.pubLishView.priceTypeView.chooseButton setTitle:priceStr forState:UIControlStateNormal];
    [self.pubLishView.priceTypeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    
    //货物类型
    [self.pubLishView.goodsTypeView.chooseButton setTitle:self.model.cargo_type forState:UIControlStateNormal];
    [self.pubLishView.goodsTypeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    self.pubLishView.goodsStyleID = self.model.cargo_type_id;
    
    
    //货物重量
    self.pubLishView.weightView.dunTextField.text = self.model.weight;
    self.pubLishView.weightView.percentTextField.text = self.model.weight_num;
    
    //起运港
    [self.pubLishView.startView.chooseButton setTitle:[NSString stringWithFormat:@"%@-%@",self.model.parent_b,self.model.b_port] forState:UIControlStateNormal];
    [self.pubLishView.startView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    self.pubLishView.b_port_id = [NSString stringWithFormat:@"%@-%@",self.model.parent_b_port_id,self.model.b_port_id];
    self.pubLishView.parent_b_port_id = self.model.parent_b_port_id;
    self.pubLishView.b_port_address = [NSString stringWithFormat:@"%@%@",self.model.parent_b,self.model.b_port];
    
    
    //目的港
    [self.pubLishView.endView.chooseButton setTitle:[NSString stringWithFormat:@"%@-%@",self.model.parent_e,self.model.e_port] forState:UIControlStateNormal];
    [self.pubLishView.endView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    self.pubLishView.e_port_id = [NSString stringWithFormat:@"%@-%@",self.model.parent_e_port_id,self.model.e_port_id];
    self.pubLishView.parent_e_port_id = self.model.parent_e_port_id;
    self.pubLishView.e_port_address = [NSString stringWithFormat:@"%@%@",self.model.parent_e,self.model.e_port];
    
    //受载期
    self.pubLishView.dateView.startDateTextField.text = [TYDateUtils timestampSwitchTime:[self.model.b_time integerValue]];
    self.pubLishView.dateView.endDateTextField.text = [TYDateUtils timestampSwitchTime:[self.model.e_time integerValue]];
    
    
    //交接方式
    [self.pubLishView.changeView.startChooseButton setTitle:self.model.b_hand_type forState:UIControlStateNormal];
    [self.pubLishView.changeView.startChooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(0)];
    
    [self.pubLishView.changeView.endChooseButton setTitle:self.model.e_hand_type forState:UIControlStateNormal];
    [self.pubLishView.changeView.endChooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(0)];
    
    //滞期费用
    [self.pubLishView.retentionView.zhiqiButton setTitle:self.model.demurrage_unit forState:UIControlStateNormal];
    [self.pubLishView.retentionView.zhiqiButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(0)];
    
    self.pubLishView.retentionView.zhiqiTextField.text = self.model.demurrage;
    [self.pubLishView.retentionView.zhiqiButton setTitle:self.model.demurrage_unit forState:UIControlStateNormal];
    [self.pubLishView.referView.zhiqiButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(0)];
    
    
    
    //合理损耗
    self.pubLishView.lossView.lossTextField.text = self.model.loss;
    
    //装卸时间
    self.pubLishView.installView.lossTextField.text = self.model.dock_day;
    
    //滞期费用
    self.pubLishView.retentionView.lossTextField.text = self.model.demurrage;
    
    //履约保证金
    NSString * bondStr = [self.model.bond isEqualToString:@"1"] ? @"双方支付" : @"无需支付";
    [self.pubLishView.agreeView.chooseButton setTitle:bondStr forState:UIControlStateNormal];
    [self.pubLishView.agreeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    self.pubLishView.bondStr = self.model.bond;
    
    
    //结算方式
    NSString * payStr = [self.model.freight isEqualToString:@"1"] ? @"平台结算" : @"线下结算";
    [self.pubLishView.closeView.chooseButton setTitle:payStr forState:UIControlStateNormal];
    [self.pubLishView.closeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    self.pubLishView.payStyleStr = self.model.freight;
    
    
    //付款方式
    [self.pubLishView.payView.chooseButton setTitle:self.model.freight_name forState:UIControlStateNormal];
    [self.pubLishView.payView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    self.pubLishView.payStr = self.model.freight;
    
    
    //包含费用
    [self.pubLishView.includeView.chooseButton setTitle:self.model.contain_price forState:UIControlStateNormal];
    [self.pubLishView.includeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    self.pubLishView.containsStr = self.model.contain_price;
    
    //参考报价
    self.pubLishView.referView.lossTextField.text = self.model.a_cargo_price;
    
    
    //开标时间
    NSString * openTimeStr = [TYDateUtils timestampSwitchTime:[self.model.open_time integerValue]];
    if (![openTimeStr containsString:@":"]) {
        openTimeStr = [NSString stringWithFormat:@"%@ 00:00",openTimeStr];
    }
    self.pubLishView.bidOpenView.timeBorderLable.text = openTimeStr;
    
    //过期时间
    NSString * outTimeStr = [TYDateUtils timestampSwitchTime:[self.model.valid_time integerValue]];
    if (![outTimeStr containsString:@":"]) {
        outTimeStr = [NSString stringWithFormat:@"%@ 00:00",outTimeStr];
    }
    self.pubLishView.bidOutView.timeBorderLable.text = outTimeStr;
    
    //备注
    self.pubLishView.attentionView.textView.text = self.model.remark;
    self.pubLishView.attentionView.placeholderLable.text = nil;
    
    
    [self.pubLishView.publishButton setTitle:@"确认修改" forState:UIControlStateNormal];
    
}




-(void)updateSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}











@end
