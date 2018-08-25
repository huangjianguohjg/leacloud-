//
//  GoodsMessageViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "GoodsMessageViewController.h"

#import "GoodsDetailViewController.h"

#import "OfferListViewController.h"

#import "MyGoodsView.h"
#import "HomeGoodsModel.h"

@interface GoodsMessageViewController ()

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, strong) HomeGoodsModel * model;

@property (nonatomic, weak) UISegmentedControl *segment;

@end

@implementation GoodsMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    
    [self setUpUI];
    
    
    
}


-(void)setUpNav
{
    
    
    //分段控制器
    NSArray *array = [NSArray arrayWithObjects:@"货盘信息",@"报价信息", nil];
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
    self.segment = segment;
    
    
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
        if ([self.cons_type isEqualToString:@"0"]) {
            //指定询价
            NSString * currentDate = [TYDateUtils getCurentDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString * openTime = [TYDateUtils timestampSwitchTime:[self.open_time integerValue] Format:@"yyyy-MM-dd HH:mm:ss"];
            
            NSInteger date2 = [TYDateUtils compareDate:currentDate withDate:openTime formate:@"yyyy-MM-dd HH:mm:ss"];
            if (date2 == 1) {
                //end 大

                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"未到开标时间，不能查看"
                                                                                         message:[NSString stringWithFormat:@"已有%@人报价",self.count]
                                                                                  preferredStyle:UIAlertControllerStyleAlert ];
                //取消style:UIAlertActionStyleDefault
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:cancelAction];
                
                //简直废话:style:UIAlertActionStyleDestructive
                UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
                [alertController addAction:rubbishAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                
                
                
                
                self.segment.selectedSegmentIndex = 0;
            }
            else
            {
                //end 小
                XXJLog(@"可以看")
                
                self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
            }
            
            return;
        }
        
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        
    }
}



-(void)setUpUI
{
    
    
    
    
    CGFloat margin = 0;
    if (isIPHONEX) {
        margin = 34;
    }
    
    //    __weak typeof(self) weakSelf = self;
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight)];
    scrollView.userInteractionEnabled = YES;
    scrollView.scrollEnabled = NO;
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    
    GoodsDetailViewController * goodsVc = [[GoodsDetailViewController alloc]init];
    goodsVc.fromTag = @"货主查看货盘信息";
    goodsVc.idStr = self.cargo_id;//"发布货盘/我的货盘" --> 我的货盘 点击 --> 货盘信息
    goodsVc.cargo_Type = self.cargo_Type;
    goodsVc.parent_b = self.parent_b;
    goodsVc.parent_e = self.parent_e;
    goodsVc.freight_name = self.freight_name;
    goodsVc.deliver_count = self.deliver_count;
    goodsVc.negotia = self.negotia;
    goodsVc.open = self.open;
    [goodsVc.tableView reloadData];
    [self addChildViewController:goodsVc];
    [scrollView addSubview:goodsVc.view];
    [goodsVc.view makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight);
    }];
    
    
    OfferListViewController * offerListVc = [[OfferListViewController alloc]init];
    offerListVc.cargo_id = self.cargo_id;
    [self addChildViewController:offerListVc];
    [scrollView addSubview:offerListVc.view];
    [offerListVc.view makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView);
        make.left.equalTo(scrollView).offset(SCREEN_WIDTH);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight);
    }];
    
    
}
































@end
