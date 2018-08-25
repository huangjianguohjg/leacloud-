//
//  RefreshModel.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, RefreshType) {
    RefreshTypeReload,
    RefreshTypeLoadMore
};
@interface RefreshModel : NSObject

@property (strong, nonatomic) NSMutableArray *datas;
@property (assign, nonatomic) int pageIndex;
@property (assign, nonatomic) int pageSize;
@property (assign, nonatomic) RefreshType refreshType;

@end
