//
//  InsuranceReceiptController.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
#import "ZYRadioButton.h"
@interface InsuranceReceiptController : BaseViewController<RadioButtonDelegate>
@property (strong, nonatomic) NSString  *holderName;
@property (strong, nonatomic) NSString  *recognizeeName;
@property (strong, nonatomic) NSString  *selectTitle;
@property (strong, nonatomic) NSString  *needselectTitle;
@property (strong, nonatomic) NSString  *invoiceType;
@property (nonatomic) Boolean  isFour;
@end
