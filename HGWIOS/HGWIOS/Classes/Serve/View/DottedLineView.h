//
//  DottedLineView.h
//  haoyunhl
//
//  Created by lianghy on 16/8/30.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DottedLineView : UIView
@property(nonatomic)CGPoint startPoint;//虚线起点

@property(nonatomic)CGPoint endPoint;//虚线终点

@property(nonatomic,strong)UIColor* lineColor;//虚线颜色
@end
