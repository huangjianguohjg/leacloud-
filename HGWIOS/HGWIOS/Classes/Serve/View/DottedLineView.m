//
//  DottedLineView.m
//  haoyunhl
//
//  Created by lianghy on 16/8/30.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "DottedLineView.h"
#import "CommonDimensStyle.h"
//#import <quartzcore.quartzcore.h">
#define kInterval 10                                // 全局间距
@implementation DottedLineView
- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self) {
        _lineColor = [UIColor redColor];
        _startPoint = CGPointMake(0, 1);
        _endPoint = CGPointMake(0 , self.frame.size.height);
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    CGContextSetLineWidth(context,1);//线宽度
    
    CGContextSetStrokeColorWithColor(context,self.lineColor.CGColor);
    
    CGFloat lengths[] = {2,2};//先画4个点再画2个点
    
    CGContextSetLineDash(context,0, lengths,2);//注意2(count)的值等于lengths数组的长度
    
    CGContextMoveToPoint(context,self.startPoint.x,self.startPoint.y);
    
    CGContextAddLineToPoint(context,self.endPoint.x,self.endPoint.y);
    
    CGContextStrokePath(context);
    
    CGContextClosePath(context);
    
}
@end
