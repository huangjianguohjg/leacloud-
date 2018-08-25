

//
//  PhoneStyle.m
//  haoyunhl
//
//  Created by lianghy on 16/3/16.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "PhoneStyle.h"
#import "GJCFSystemMacrocDefine.h"
@implementation PhoneStyle
+(int) phoneScale{
    int result = 1;
    
    if (GJCFSystemiPhone4) {
        result = 1;
    }else if (GJCFSystemiPhone5){
            result = 2;
    }
    else if (GJCFSystemiPhone6){
            result = 2;
    }
    else if (GJCFSystemiPhone6Plus){
            result = 3;
    }
    else if (GJCFSystemiPhone6s){
            result = 2;
    }
    else if (GJCFSystemiPhone6PlusS){
        result = 3;
    }else{
        result = 3;
    }
    return result;
}
@end
