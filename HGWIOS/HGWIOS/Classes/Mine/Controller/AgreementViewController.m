//
//  AgreementViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()
@property (strong ,nonatomic)UIWebView *webview ;
@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(234, 239, 245);
    

    self.navigationItem.title = @"服务协议";
    
    [self setUpUI];
    
}





-(void)setUpUI
{
    self.webview = [[UIWebView alloc]init];
    self.webview.backgroundColor = [UIColor whiteColor];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"xuzhih" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webview loadRequest:request];
    self.webview.scalesPageToFit = YES;
    [self.view addSubview: self.webview];
    [self.webview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.right.left.bottom.equalTo(self.view);
    }];
    
    
}


@end
