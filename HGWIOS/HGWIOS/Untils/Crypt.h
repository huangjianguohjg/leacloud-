//
//  Crypt.h
//  haoyunhl
//
//  Created by lianghy on 16/1/30.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Crypt : NSObject
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
@end
