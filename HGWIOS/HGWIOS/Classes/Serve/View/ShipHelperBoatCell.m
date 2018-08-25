//
//  ShipHelperBoatCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperBoatCell.h"
#import "GrayLine.h"
@implementation ShipHelperBoatCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, self.contentView.frame.size.width - 55, 15)];
        self.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        self.titleLabel.textColor = [CommonFontColorStyle I3Color];
        [self.contentView addSubview:self.titleLabel];
        
        //横线
        GrayLine* grayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake(10, self.frame.size.height-0.5, self.contentView.frame.size.width-20 ,0.5) Color:[CommonFontColorStyle E1E6ECColor]];
        [self.contentView addSubview:grayLine1];
        
    }
    return self;
}

-(void)setContent:(NSString *)cellId  Title:(NSString *)title{
    self.titleLabel.text = title;
    self.cellId = cellId;
}
@end
