//
//  ArrayRepository.m
//  haoyunhl
//
//  Created by lianghy on 16/8/4.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "ArrayRepository.h"
#import "stdlib.h"
@implementation ArrayRepository
+(NSString *)GetDealStatusName:(int)statusNumber{
    NSString *statusName = @"";
    switch (statusNumber) {
        case 0:
            statusName = @"预约中";
            break;
        case 1:
            statusName = @"待装货";
            break;
        case 2:
            statusName = @"已取消";
            break;
        case 3:
            statusName = @"待卸货";
            break;
        case 4:
            statusName = @"已完成";
            break;
        case 5:
            statusName = @"已完成";
            break;
        case 8:
            statusName = @"船东违约";
            break;
        case 9:
            statusName = @"货主违约";
            break;
        case 10:
            statusName = @"未交易";
            break;
        case 11:
            statusName = @"已过期";
            break;
        default:
            break;
    }
    return  statusName;
}


+(NSString *)GetRandomColor{
    
    NSString *randomString;
//    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    int randomNum = rand() % 7;
    switch (randomNum) {
        case 0:
            randomString = @"f9b68d";
            break;
        case 1:
            randomString = @"a2d0ce";
            break;
        case 2:
            randomString = @"aaa4be";
            break;
        case 3:
            randomString = @"d8d278";
            break;
        case 4:
            randomString = @"7da1ce";
            break;
        case 5:
            randomString = @"e9a3bb";
            break;
        case 6:
            randomString = @"92d575";
            break;
        default:
            randomString = @"92d575";
            break;
    }
    return  randomString;
}
@end
