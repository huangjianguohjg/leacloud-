//
//  InsuranceTiaoKuanViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceTiaoKuanViewController.h"

@interface InsuranceTiaoKuanViewController ()

@end

@implementation InsuranceTiaoKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    
    self.navigationItem.title = @"水路货物运输保险条款";
    
    [self setUpUI];
    
    
    
}




-(void)setUpUI
{
    
    [self initView];
    
}


-(void)initView{
    
    self.view.backgroundColor = [CommonFontColorStyle WhiteColor];
    
    
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(10, kStatusBarHeight + kNavigationBarHeight, [CommonDimensStyle screenWidth]-20, ([CommonDimensStyle screenHeight]-64))];
    self.webview.backgroundColor = [CommonFontColorStyle WhiteColor];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"tiaokuan" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webview loadRequest:request];
    self.webview.scalesPageToFit = YES;
    [self.view addSubview: self.webview];
}






























@end
