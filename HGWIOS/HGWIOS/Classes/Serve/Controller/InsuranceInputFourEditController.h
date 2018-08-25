//
//  InsuranceInputFourEditController.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaseViewController.h"
#import "AFFNumericKeyboard.h"
#import "InsuranceModel.h"
@interface InsuranceInputFourEditController : BaseViewController<AFFNumericKeyboardDelegate,UITextFieldDelegate>
@property (strong, nonatomic) NSString *InsuranceId;
@property (nonatomic) Boolean isEdit;
@property (strong, nonatomic) InsuranceModel *oldInsuranceModel;
@property (strong, nonatomic) NSString *expresscompany;
@property (strong, nonatomic) NSString *invoice_type;//发票类型
@property (strong, nonatomic) NSString *taitou_title;//抬头
@property (strong, nonatomic) NSString *title_type;//发票抬头类型

//邮寄地址
@property (strong, nonatomic) NSString *recipient;//收件人
@property (strong, nonatomic) NSString *mobile;//手机号
@property (strong, nonatomic) NSString *address;//大地址
@property (strong, nonatomic) NSString *detail_address;//详细地址
@property (strong, nonatomic) NSString *invoice_fee;//邮费
@property ( nonatomic) Boolean isNeedFaPiao;//发票传递过来的值
@end
