//
//  MessageModel.h
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

/**
 标题
 */
@property (nonatomic, copy) NSString * class_name;

/**
 内容
 */
@property (nonatomic, copy) NSString * ct_title;

/**
 时间
 */
@property (nonatomic, copy) NSString * ct_time;

/**
 id
 */
@property (nonatomic, copy) NSString * class_id;

/**
 图片
 */
@property (nonatomic, copy) NSString * real_image_url;

/**
 是否读取了
 */
@property (nonatomic, copy) NSString * has_unread;

/**
 类型
 */
@property (nonatomic, copy) NSString * identify;





@end
