//
//  WebViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "WebViewController.h"
#import<WebKit/WebKit.h>
#import "WebBottomView.h"
@interface WebViewController ()
{
    WKWebView *webView;
    UIProgressView * progressView;
    WebBottomView * bottomView;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DDColor(@"ffffff");
    


    self.navigationItem.title = self.titleStr;
    
    [self setUpUI];
    
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = XXJColor(27, 69, 138);
    
    XXJLog(@"我又回来了%@",self.navigationController.navigationBar.barTintColor)
}






-(void)setUpUI
{
   
    
    
    CGFloat margin = 0;
    if (isIPHONEX) {
        margin = 34;
    }
    
    bottomView = [[WebBottomView alloc]init];
    bottomView.webBlock = ^(NSString *s) {
        if ([s isEqualToString:@"返回"]) {
            [webView goBack];
        }
        else if ([s isEqualToString:@"前进"])
        {
            [webView goForward];
        }
    };
    [self.view addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-margin);
        make.height.equalTo(realH(100));
    }];
    
    
    webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREENWIDTH,SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight - margin - realH(100))];
    //    webView.delegate = self;
    webView.backgroundColor = DDColor(@"ffffff");
    if (self.link) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
    }
    else if (self.filePath)
    {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.filePath]]];
    }
    
    [webView
     addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil
     ];
    [webView
     addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil
     ];
    
    [webView
     addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:webView];
    
    
    progressView = [[UIProgressView alloc]init];
//    progressView.backgroundColor = [UIColor redColor];
    progressView.progressTintColor = [UIColor redColor];
    progressView.progress = 0;
    progressView.progressViewStyle = UIProgressViewStyleDefault;
    [webView addSubview:progressView];
    [progressView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(webView).offset(realH(2));
        make.right.left.equalTo(webView);
        make.height.equalTo(2);
        
    }];
    
}




// 只要观察对象属性有新值就会调用

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void                                                      *)context
{
    
    bottomView.backButton.enabled = webView.canGoBack
    ;
    
    bottomView.goButton.enabled = webView.canGoForward
    ;
    
    progressView.progress = webView.estimatedProgress;
    
    progressView.hidden = webView.estimatedProgress >= 1;
}


-(void)dealloc
{
    [webView removeObserver:self forKeyPath:@"canGoBack"];
    [webView removeObserver:self forKeyPath:@"canGoForward"];
    
    
    [webView removeObserver:self forKeyPath:@"estimatedProgress"];
}




@end
