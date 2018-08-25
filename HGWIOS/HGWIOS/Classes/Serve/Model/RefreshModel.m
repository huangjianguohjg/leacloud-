//
//  RefreshModel.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "RefreshModel.h"

@implementation RefreshModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _datas = [NSMutableArray arrayWithCapacity:8];
        self.pageIndex = 1;
        self.pageSize = 8;
    }
    return self;
}

@end
