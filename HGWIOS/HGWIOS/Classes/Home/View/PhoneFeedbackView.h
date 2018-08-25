//
//  PhoneFeedbackView.h
//  HGWIOS
//
//  Created by mac on 2018/7/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FeedBlock)(NSString * s);

@interface PhoneFeedbackView : UIView

@property (nonatomic, copy) FeedBlock feedBlock;

@end
