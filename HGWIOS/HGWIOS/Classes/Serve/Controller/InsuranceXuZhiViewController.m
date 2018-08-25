//
//  InsuranceXuZhiViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceXuZhiViewController.h"

@interface InsuranceXuZhiViewController ()

@end

@implementation InsuranceXuZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"用户投保须知";
    
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
    NSString* path = [[NSBundle mainBundle] pathForResource:@"xuzhih" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webview loadRequest:request];
    self.webview.scalesPageToFit = YES;
    [self.view addSubview: self.webview];
}



@end
