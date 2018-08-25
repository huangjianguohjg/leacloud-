//
//  InsuranceSampleController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceSampleController.h"

@interface InsuranceSampleController ()

@end

@implementation InsuranceSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"保单样例";
    
    [self setUpUI];
    
    
    
}



-(void)setUpUI
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight,SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight)];
    imageView.image = [UIImage imageNamed: @"ex.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    
    
    
    
    
    
    
    
    
    
}









































@end
