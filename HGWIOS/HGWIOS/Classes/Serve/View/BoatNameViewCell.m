//
//  BoatNameViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BoatNameViewCell.h"
#import "GrayLine.h"
@implementation BoatNameViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        int leftmargin = 90;
        GrayLine* GrayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake(leftmargin, self.contentLabel.gjcf_bottom, (CommonDimensStyle.screenWidth-leftmargin), 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
        [self addSubview:GrayLine1];
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.5, self.frame.size.width-10, self.frame.size.height-0.5)];
        [self addSubview:self.contentLabel];
        self.contentLabel.font = [CommonFontColorStyle BigNormalSizeFont];
        self.contentLabel.textColor = [CommonFontColorStyle I3Color];
        self.contentLabel.textAlignment = NSTextAlignmentRight;
        
        
    }
    return self;
}

-(void)setName:(NSString *)name{
    self.contentLabel.text  = name;
}
-(void)setBoatName:(NSString *)name{
    self.contentLabel.text  = name;
}
-(void)setBoatName:(NSString *)name Id:(NSString *)boatId{
    self.contentLabel.text  = name;
    self.boatId = boatId;
}
@end
