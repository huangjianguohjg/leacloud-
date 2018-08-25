//
//  InsuranceReceiptDetailController.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
#import "ZYRadioButton.h"
@interface InsuranceReceiptDetailController : BaseViewController<RadioButtonDelegate>

@property (strong, nonatomic) NSString *InsuranceId;
@property (strong, nonatomic) NSString *invoice_type;//发票类型
@property (strong, nonatomic) NSString *taitou_title;//抬头
@property (strong, nonatomic) NSString *title_type;//发票抬头类型

//邮寄地址
@property (strong, nonatomic) NSString *addressId;//收件人
@property (strong, nonatomic) NSString *recipient;//收件人
@property (strong, nonatomic) NSString *mobile;//手机号
@property (strong, nonatomic) NSString *address;//大地址
@property (strong, nonatomic) NSString *detail_address;//详细地址
@property (strong, nonatomic) NSString *invoice_fee;//邮费
@property (strong, nonatomic) NSString *express_company;//公司id


@property ( nonatomic) Boolean isNeedFaPiao;//发票传递过来的值
@property ( nonatomic) Boolean isNeedAddress;//地址传递过来的值

@end
