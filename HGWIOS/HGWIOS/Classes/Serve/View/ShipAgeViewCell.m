//
//  ShipAgeViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipAgeViewCell.h"

@implementation ShipAgeViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        int rowHeight = 44;
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, self.frame.size.width-80, rowHeight)];
        self.nameLabel.font = [CommonFontColorStyle NormalSizeFont];
        self.nameLabel.textColor = [CommonFontColorStyle FontNormalColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nameLabel];
        
        self.choosedView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-33), (rowHeight - 18)/2, 18, 18)];
        self.choosedView.image = [UIImage imageNamed:@"form_pic_choose"];
        [self addSubview:self.choosedView];
        self.choosedView.hidden = YES;
        
        UIView *borderView = [[UIView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], self.frame.size.height-0.5, (self.frame.size.width - 2*[CommonDimensStyle smallMargin]), 0.5)];
        borderView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
        [self addSubview:borderView];
    }
    return self;
}

-(void) initwithContent:(NSString *)name Id:(NSString *)id{
    self.nameLabel.text = name;
    self.name = name;
    self.shipId = id;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.choosedView.hidden = NO;
        self.nameLabel.textColor = [CommonFontColorStyle BlueColor];
        self.backgroundColor =[CommonFontColorStyle F1F4F9Color];
    }else{
        self.choosedView.hidden = YES;
        self.nameLabel.textColor = [CommonFontColorStyle FontNormalColor];
        self.backgroundColor =[CommonFontColorStyle WhiteColor];
    }
}

@end
