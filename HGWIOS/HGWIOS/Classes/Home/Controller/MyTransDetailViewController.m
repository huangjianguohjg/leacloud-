//
//  MyTransDetailViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyTransDetailViewController.h"
#import "DetailMainViewController.h"
@interface MyTransDetailViewController ()

@end

@implementation MyTransDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"我的运单详情";
    
    [self setUpUI];
}


-(void)setUpUI
{
    DetailMainViewController * mainVc = [[DetailMainViewController alloc]init];
    mainVc.cargo_id = self.cargo_id;
    mainVc.detail_id = self.detail_id;
    mainVc.weight_num = self.weight_num;
    mainVc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addChildViewController:mainVc];
    [self.view addSubview:mainVc.view];
}

























































@end
