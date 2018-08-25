//
//  MyGoodsViewController.m
//  HGWIOS
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyGoodsViewController.h"
#import "MyGoodsView.h"
#import "RecommendViewController.h"
#import "UpdateViewController.h"
#import "InviteViewController.h"
#import "GoodsMessageViewController.h"
#import "MyTransportViewController.h"
#import "AlreadyOfferModel.h"
@interface MyGoodsViewController ()

@end

@implementation MyGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"我的货盘";
    
    [self setUpUI];
    
}

-(void)setUpUI
{
    __weak typeof(self) weakSelf = self;
    MyGoodsView * myGoodsView = [[MyGoodsView alloc]init];
    myGoodsView.handleBlock = ^(NSString *str, AlreadyOfferModel * model) {
        if ([str isEqualToString:@"配船"]) {
            RecommendViewController * recommendVc = [[RecommendViewController alloc]init];
            recommendVc.model = model;
            [weakSelf.navigationController pushViewController:recommendVc animated:YES];
        }
        else if ([str isEqualToString:@"修改"])
        {
            UpdateViewController * updateVc = [[UpdateViewController alloc]init];
            updateVc.model = model;
            [weakSelf.navigationController pushViewController:updateVc animated:YES];
        }
        else if ([str isEqualToString:@"邀请"])
        {
            InviteViewController * inviteVc = [[InviteViewController alloc]init];
            inviteVc.cargo_id = model.id;
            [weakSelf.navigationController pushViewController:inviteVc animated:YES];
        }
        else if ([str isEqualToString:@"无法修改"])
        {
            //已有人报价的情况下，无法修改
            [weakSelf.view makeToast:@"已有人报价，暂无法修改" duration:0.5 position:CSToastPositionCenter];
        }
        else if ([str isEqualToString:@"cell点击"])
        {
            if ([model.status_name isEqualToString:@"报价中"]) {
                GoodsMessageViewController * goodsVc = [[GoodsMessageViewController alloc]init];
                goodsVc.cargo_id = model.qp_id;
                goodsVc.cargo_Type = model.cargo_type;
                goodsVc.parent_b = model.parent_b;
                goodsVc.parent_e = model.parent_e;
                goodsVc.freight_name = model.freight_name;
                
                goodsVc.cons_type = model.cons_type;
                goodsVc.open_time = model.open_time;
                goodsVc.count = model.count;
                
                goodsVc.deliver_count = model.deliver_count;
                goodsVc.negotia = model.negotia;
                
                goodsVc.open = model.open;
                
                [weakSelf.navigationController pushViewController:goodsVc animated:YES];
            }
            else if ([model.status_name isEqualToString:@"已开标"])
            {
                MyTransportViewController * myTransVc = [[MyTransportViewController alloc]init];
                [weakSelf.navigationController pushViewController:myTransVc animated:YES];
            }
        }
    };
    
    [self.view addSubview:myGoodsView];
    [myGoodsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.equalTo(self.view);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight));
    }];
    
}

@end
