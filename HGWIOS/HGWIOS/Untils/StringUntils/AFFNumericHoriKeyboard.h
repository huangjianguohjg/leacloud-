//
//  AFFNumericHoriKeyboard.h
//  haoyunhl
//
//  Created by lianghy on 16/5/26.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AFFNumericHoriKeyboardDelegate <NSObject>

- (void) numberKeyboardInput:(NSInteger) number;
- (void) numberKeyboardBackspace;
- (void) writeInRadixPoint;
//- (void) changeKeyboardType;
@end
@interface AFFNumericHoriKeyboard : UIView
{
    NSArray *arrLetter;
}
@property (nonatomic,assign) id<AFFNumericHoriKeyboardDelegate> delegate;
@end
