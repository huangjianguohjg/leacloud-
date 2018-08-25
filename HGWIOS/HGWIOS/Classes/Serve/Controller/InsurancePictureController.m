//
//  InsurancePictureController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsurancePictureController.h"
#import "NumberToCapital.h"
#import "DateHelper.h"
@interface InsurancePictureController ()

@end

@implementation InsurancePictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"电子保单";
    
    [self setUpUI];
    
    
    
}




-(void)setUpUI
{
    self.view.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(10, kStatusBarHeight+ kNavigationBarHeight, [CommonDimensStyle screenWidth]-20, ([CommonDimensStyle screenHeight]-kStatusBarHeight - kNavigationBarHeight))];
    self.webview.backgroundColor = [CommonFontColorStyle WhiteColor];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"baodan" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webview loadRequest:request];
    //    self.webview.scalesPageToFit = YES;
    self.webview.delegate = self;
    [self.view addSubview: self.webview];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NumberToCapital *numberToCapital = [[NumberToCapital alloc]init];
    NSString *total_fee_capital = [numberToCapital getUperDigit:self.insuranceModel.total_fee];
    NSString *insured_amount_fee_capital = [numberToCapital getUperDigit:self.insuranceModel.insured_amount_fee];
    NSString *showTime = [DateHelper StringDateStampZHToString:self.insuranceModel.c_time];
    //    NSString *qiyunshijian = [NSString stringWithFormat:@"%@时",self.insuranceModel.departure_date_show];
    NSString* js =[NSString stringWithFormat:@"WriteContent(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\");",self.insuranceModel.policy_no_long,self.insuranceModel.holder_name,self.insuranceModel.recognizee_name ,self.insuranceModel.goods_name,self.insuranceModel.goods_pack_qty,self.insuranceModel.goods_pack_unit_show,self.insuranceModel.ship_name,self.insuranceModel.from_loc,self.insuranceModel.to_loc,self.insuranceModel.departure_date_show,self.insuranceModel.deductible_statement,insured_amount_fee_capital,self.insuranceModel.insured_amount_fee,total_fee_capital,self.insuranceModel.total_fee,self.insuranceModel.way_bill_no,showTime,self.insuranceModel.special_announce];
    
    [self.webview stringByEvaluatingJavaScriptFromString:js];
    //    self.webview.scalesPageToFit = YES;
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=0.5, minimum-scale=0.1, maximum-scale=1.0, user-scalable=yes\"", webView.frame.size.width];
    [webView stringByEvaluatingJavaScriptFromString:meta];
}






@end
