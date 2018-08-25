//
//  InvoiceModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvoiceModel : NSObject
@property (nonatomic,strong)NSString *ec_id;//邮寄公司ID
@property (nonatomic,strong)NSString *ec_name;//快递公司的全称
@property (nonatomic,strong)NSString *fee;//运费
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *insurance_id;//保险no
@property (nonatomic,strong)NSString *invoice_type;//增值税 普通发票判断
@property (nonatomic,strong)NSString *is_delete;
@property (nonatomic,strong)NSString *post_time;
@property (nonatomic,strong)NSString *recipient;//收件人
@property (nonatomic,strong)NSString *recipient_address;//所在区域
@property (nonatomic,strong)NSString *address_detail;//详情地址
@property (nonatomic,strong)NSString *total_address;// 省市区 和详细地址
@property (nonatomic,strong)NSString *recipient_mobile;//收件人号码
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *title;//抬头
@property (nonatomic,strong)NSString *title_type;//传递 的抬头 type
@property (nonatomic,strong)NSString *tracking_nu;//快递单号
@property (nonatomic,strong)NSString *tracking_status;//快递是否寄出的状态
@end
