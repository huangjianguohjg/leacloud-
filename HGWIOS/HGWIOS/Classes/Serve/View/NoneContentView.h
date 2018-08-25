//
//  NoneContentView.h
//  haoyunhl
//
//  Created by lianghy on 16/7/28.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoneContentView : UIView
@property (strong, nonatomic) UIImageView *imageView;
- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)name;
- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)name Top:(int)top;
@end
