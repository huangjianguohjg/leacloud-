//
//  SendGoodsViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "SendGoodsViewController.h"

#import "GoodsMessageViewController.h"

#import "MyTransportViewController.h"

#import "AddressViewController.h"

#import "RecommendViewController.h"

#import "UpdateViewController.h"

#import "PublishGoodsView.h"
#import "MyGoodsView.h"

#import "AddBoatView.h"

#import "AlreadyOfferModel.h"

#import "ApproveViewController.h"
#import "ChooseApproveViewController.h"

#import "InviteViewController.h"
@interface SendGoodsViewController ()

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, weak) PublishGoodsView * pubLishView;

@property (nonatomic, weak) MyGoodsView * myGoodsView;

@end

@implementation SendGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.page = 1;
    self.max = 20;
    
    [self setUpNav];
    
    [self setUpUI];
    
}


-(void)setUpNav
{
    
    
    //分段控制器
    NSArray *array = [NSArray arrayWithObjects:@"发布货盘",@"我的货盘", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    segment.tintColor = XXJColor(26, 160, 231);
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    segment.layer.cornerRadius = 5;
    segment.clipsToBounds = YES;
    segment.layer.borderWidth = 1;
    segment.layer.borderColor = XXJColor(41, 191, 240).CGColor;
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    
    
    
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



-(void)change:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        
//        [self getMyCargoRequest];
    }
}



-(void)setUpUI
{

    CGFloat margin = 0;
    if (isIPHONEX) {
        margin = 34;
    }
    
    __weak typeof(self) weakSelf = self;
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight)];
    scrollView.userInteractionEnabled = YES;
    scrollView.scrollEnabled = NO;
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    
    PublishGoodsView * pubLishView = [[PublishGoodsView alloc]init];
    pubLishView.chooseAddressBlock = ^(NSString *addressStr) {
        
        NSString * switchAddress = addressStr;
        
        AddressViewController * addressVc = [[AddressViewController alloc]init];
        addressVc.fromTag = @"屏蔽全部";
        addressVc.empty = @"报空";//就是为了不让右上角出现清空的按钮
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
    
    pubLishView.nameApproveBlock = ^{
        ChooseApproveViewController * approveVc = [[ChooseApproveViewController alloc]init];
        approveVc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:approveVc animated:YES];
    };
    
    pubLishView.publishSuccessBlock = ^(NSDictionary *dict) {
        RecommendViewController * recommendVc = [[RecommendViewController alloc]init];
        recommendVc.dataDict = dict;
        recommendVc.fromTag = @"发货";
        [weakSelf.navigationController pushViewController:recommendVc animated:YES];
    };
    
    pubLishView.inviteSuccessBlock = ^(NSString *cargo_id) {
        
        InviteViewController * inviteVc = [[InviteViewController alloc]init];
        inviteVc.cargo_id = cargo_id;
        inviteVc.fromTag = @"指定发货";
        [weakSelf.navigationController pushViewController:inviteVc animated:YES];
    };
    
    [scrollView addSubview:pubLishView];
    [pubLishView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight);
    }];
    self.pubLishView = pubLishView;
    
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
    
    [scrollView addSubview:myGoodsView];
    [myGoodsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView);
        make.left.equalTo(scrollView).offset(SCREEN_WIDTH);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight);
    }];
    self.myGoodsView = myGoodsView;
    

}





//#pragma mark -- 获取我的货盘列表
//-(void)getMyCargoRequest
//{
//    [SVProgressHUD show];
//
//    NSString *parameterstring = [NSString stringWithFormat:@"\"max\":\"%lu\",\"page\":\"%lu\",\"access_token\":\"%@\"",(unsigned long)self.max,(unsigned long)self.page,[UseInfo shareInfo].access_token];
//
//
//    [XXJNetManager requestPOSTURLString:MyCargo URLMethod:MyCargoMethod parameters:parameterstring finished:^(id result) {
//        [SVProgressHUD dismiss];
//
//        XXJLog(@"%@",result);
//
//         NSArray * array = [AlreadyOfferModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
//
////        [self.myGoodsView.dataArray addObjectsFromArray:array];
//
//
//    } errored:^(NSError *error) {
//
//        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
//
//        [SVProgressHUD dismiss];
//    }];
//
//}
//


@end
