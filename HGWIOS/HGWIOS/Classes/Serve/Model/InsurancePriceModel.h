//
//  InsurancePriceModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsurancePriceModel : NSObject
@property (nonatomic,strong)NSString *deductible_statement;
@property (nonatomic,strong)NSString *insured_fee;
@property (nonatomic,strong)NSString *invoice_fee;
@property (nonatomic,strong)NSString *ratio;

@property (nonatomic,strong)NSString *ratio_show;
@property (nonatomic,strong)NSString *total_fee;
@property (nonatomic,strong)NSString *total_test_fee;
@end
