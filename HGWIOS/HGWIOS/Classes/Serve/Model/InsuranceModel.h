//
//  InsuranceModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "goodsTypeModel.h"
#import "InvoiceModel.h"
@interface InsuranceModel : NSObject

@property (nonatomic,strong)NSString *ali_trade_complete_time;
@property (nonatomic,strong)NSString *ali_trade_data;
@property (nonatomic,strong)NSString *ali_trade_no;
@property (nonatomic,strong)NSString *ali_trade_pay_time;
@property (nonatomic,strong)NSString *audit_msg;
@property (nonatomic,strong)NSString *b_time;
@property (nonatomic,strong)NSString *billing_person;
@property (nonatomic,strong)NSString *billing_time;
@property (nonatomic,strong)NSString *c_time;
@property (nonatomic,strong)NSString *can_download_insure_pdf;
@property (nonatomic,strong)NSString *can_download_policy_pdf;
@property (nonatomic,strong)NSString *can_drawback;

@property (nonatomic,strong)NSString *can_drawback_fee;
@property (nonatomic,strong)NSString *cancel_time;
@property (nonatomic,strong)NSString *cancel_uid;
@property (nonatomic,strong)NSString *contact_person;
@property (nonatomic,strong)NSString *contact_phone;
@property (nonatomic,strong)NSString *correct_uid;
@property (nonatomic,strong)NSString *correcting_status;
@property (nonatomic,strong)NSString *correcting_status_name;
@property (nonatomic,strong)NSString *currency_id;
@property (nonatomic,strong)NSString *deductible_statement;
@property (nonatomic,strong)NSString *departure_date;
@property (nonatomic,strong)NSString *departure_date_show;


@property (nonatomic,strong)NSString *end_currency_id;
@property (nonatomic,strong)NSString *from_loc;
@property (nonatomic,strong)NSString *goods_mtype_code;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic,strong)NSString *goods_pack_qty;
@property (nonatomic,strong)NSString *goods_pack_unit;
@property (nonatomic,strong)NSString *goods_pack_unit_show;
@property (nonatomic,strong)NSString *goods_stype_code;
@property (nonatomic,strong)NSString *holder_name;
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *insurance;
@property (nonatomic,strong)NSString *insured_amount_fee;

@property (nonatomic,strong)NSString *insured_fee;
@property (nonatomic,strong)NSString *insured_fee_saved;
@property (nonatomic,strong)InvoiceModel *invoice;//发票信息
@property (nonatomic,strong)NSString *invoice_fee;
@property (nonatomic,strong)NSString *invoice_number;
@property (nonatomic,strong)NSString *invoice_price;
@property (nonatomic,strong)NSString *invoice_project;
@property (nonatomic,strong)NSString *invoice_title;
@property (nonatomic,strong)NSString *is_delete;
@property (nonatomic,strong)NSString *is_invoice;//无用
@property (nonatomic,strong)NSString *is_paid;
@property (nonatomic,strong)NSString *is_paid_name;

@property (nonatomic,strong)NSString *is_rollback;
@property (nonatomic,strong)NSString *main_glauses_code;
@property (nonatomic,strong)NSString *need_check_status;
@property (nonatomic,strong)NSString *need_pay;
@property (nonatomic,strong)NSString *need_submit;
@property (nonatomic,strong)NSString *pay_type;
@property (nonatomic,strong)NSString *pay_type_name;
@property (nonatomic,strong)NSString *policy_no;
@property (nonatomic,strong)NSString *policy_no_long;
@property (nonatomic,strong)NSString *post_date_show;
@property (nonatomic,strong)NSString *post_time;
@property (nonatomic,strong)NSString *primary_no;

@property (nonatomic,strong)NSString *ratio;
@property (nonatomic,strong)NSString *ratio_show;
@property (nonatomic,strong)NSString *recognizee_name;
@property (nonatomic,strong)NSString *salesman;
@property (nonatomic,strong)NSString *ship_age;
@property (nonatomic,strong)NSString *ship_contact_phone;
@property (nonatomic,strong)NSString *ship_name;
@property (nonatomic,strong)NSString *show_time;
@property (nonatomic,strong)NSString *source;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *status_name;
@property (nonatomic,strong)NSString *to_loc;


@property (nonatomic,strong)NSString *total_fee;//支付总金额
@property (nonatomic,strong)NSString *total_fee_saved;
@property (nonatomic,strong)NSString *total_test_fee;
@property (nonatomic,strong)NSString *tracking_status_name;
@property (nonatomic,strong)NSString *transport;
@property (nonatomic,strong)NSString *transport_type;
@property (nonatomic,strong)NSString *uid;
@property (nonatomic,strong)NSString *way_bill_no;
@property (nonatomic,strong)NSString *ship_age_type;
@property (nonatomic,strong)goodsTypeModel *goods_type;
@property (nonatomic,strong)NSString *special_announce;


@end
