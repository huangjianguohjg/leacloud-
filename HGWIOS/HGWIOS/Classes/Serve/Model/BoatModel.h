//
//  BoatModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoatModel : NSObject

@property (nonatomic,nonatomic)NSString * boatID;
@property (nonatomic,strong)NSString *image_path;
@property (nonatomic,strong)NSString *uid;
@property (nonatomic,strong)NSString *mmsi;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *type_id;
@property (nonatomic,strong)NSString *is_delete;
@property (nonatomic,strong)NSString *deadweight;
@property (nonatomic,strong)NSString *length;
@property (nonatomic,strong)NSString *width;
@property (nonatomic,strong)NSString *draught;
@property (nonatomic,strong)NSString *review;
@property (nonatomic,strong)NSString *has_cover;
@property (nonatomic,strong)NSString *c_time;
@property (nonatomic,strong)NSString *c_time_name;
@property (nonatomic,strong)NSString *source;
@property (nonatomic,strong)NSString *image_id;
@property (nonatomic,strong)NSString *has_crane;
@property (nonatomic,strong)NSString *contact_person;
@property (nonatomic,strong)NSString *contact_phone;
@property (nonatomic,strong)NSString *has_monitor;
@property (nonatomic,strong)NSString *type_name;
@property (nonatomic,strong)NSString *s_review;
@property (nonatomic,strong)NSString *review_status_name;
@property (nonatomic,strong)NSString *is_review_can_submit;
//@property (nonatomic,strong)NSString <Optional>*has_deal;
@property (nonatomic,strong)NSString *registry;//船籍港
@property (nonatomic,strong)NSString *is_review_pass;
@property (nonatomic,strong)NSString *can_op;
@property (nonatomic,strong)NSString *image_url;
@property (nonatomic,strong)NSString *registry_port_id;

@end
