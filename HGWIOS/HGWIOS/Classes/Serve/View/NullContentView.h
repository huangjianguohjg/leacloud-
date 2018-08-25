//
//  NullContentView.h
//  haoyunhl
//
//  Created by lianghy on 16/8/30.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NullContentView : UIView
@property (strong, nonatomic) UIImageView *imageView;
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title;
- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)name Title:(NSString *)title;
- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)name Top:(int)top Width:(int)width Height:(int)height Title:(NSString *)title;
@end
