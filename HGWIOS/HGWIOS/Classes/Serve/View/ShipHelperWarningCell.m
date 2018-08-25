//
//  ShipHelperWarningCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperWarningCell.h"
#import "GrayLine.h"
@implementation ShipHelperWarningCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        [self setUpUI];
        
    }
    return self;
}

-(void)setUpUI
{
    self.detailTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, self.contentView.frame.size.width - 45, 15)];
    self.detailTime.font = [CommonFontColorStyle NormalSizeFont];
    self.detailTime.textColor = [CommonFontColorStyle I3Color];
    [self.contentView addSubview:self.detailTime];
    
    self.detailTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, self.detailTime.gjcf_bottom + 6, self.contentView.frame.size.width - 55, 15)];
    self.detailTitle.font = [CommonFontColorStyle F13SizeFont];
    self.detailTitle.textColor = [CommonFontColorStyle FontNormalColor];
    [self.contentView addSubview:self.detailTitle];
    
    self.detailImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-35, 0, 45, 40)];
    self.detailImage.image = [UIImage imageNamed:@"aide_icon_today"];
    [self.contentView addSubview:self.detailImage];
    self.detailImage.hidden = YES;
    
    //横线
    GrayLine * grayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake(0, 71.5, self.contentView.frame.size.width ,0.5) Color:[CommonFontColorStyle E1E6ECColor]];
    [self.contentView addSubview:grayLine1];
}



-(void)setContent:(NSString *)cellId  Title:(NSString *)title  Date:(NSString *)date{
    self.detailTitle.text = title;
    self.detailTime.text = date;
    self.cellId = cellId;
    
    //今天的做特殊处理
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *value =[formatter stringFromDate:[NSDate date]];
    if ([value isEqualToString:date]) {
        self.detailImage.hidden = NO;
        self.detailTime.textColor = [CommonFontColorStyle BlueColor];
    }else{
        self.detailImage.hidden = YES;
        self.detailTime.textColor = [CommonFontColorStyle I3Color];
    }
}




























@end
