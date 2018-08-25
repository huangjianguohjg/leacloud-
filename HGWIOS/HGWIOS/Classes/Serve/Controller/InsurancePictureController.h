//
//  InsurancePictureController.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
#import "InsuranceModel.h"
@interface InsurancePictureController : BaseViewController<UIWebViewDelegate>
@property (strong ,nonatomic)UIWebView *webview ;
@property (strong ,nonatomic)InsuranceModel *insuranceModel ;
@end
