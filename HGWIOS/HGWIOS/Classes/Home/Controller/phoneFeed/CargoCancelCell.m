//
//  CargoCancelCell.m
//  haoyunhl
//
//  Created by lianghy on 16/7/22.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "CargoCancelCell.h"
#import "CommonFontColorStyle.h"
#import "UIView+Extend.m"
#import "GrayLine.h"
#import "GJCFStringUitil.h"
#import "UIImageView+WebCache.h"

@implementation CargoCancelCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        self.showContent = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width - 60, self.frame.size.height)];
        self.showContent.font = [CommonFontColorStyle NormalSizeFont];
        self.showContent.textColor = [CommonFontColorStyle I3Color];
        [self addSubview:self.showContent];
        
        self.chooseImage  = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width -40,(self.frame.size.height-20)/2, 20, 20)];
        self.chooseImage.layer.cornerRadius = 10;
        self.chooseImage.backgroundColor = DDColor(@"f2f2f2");
        self.chooseImage.layer.masksToBounds = YES;
        [self addSubview:self.chooseImage];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5 , self.gjcf_width, 0.5)];
        lineView2.backgroundColor = DDColor(@"e2e2e2");
        [self addSubview:lineView2];

        
            }
    return self;
}

//设置信息
-(void)setContent:(NSString *)key Desc:(NSString *)desc{
    self.cellkey = key;
    self.showContent.text = desc;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.chooseImage.layer.cornerRadius = 10;
        self.chooseImage.layer.borderWidth = 4;
        self.chooseImage.layer.borderColor = DDColor(@"2dabff").CGColor;
        self.chooseImage.backgroundColor = DDColor(@"ffffff");
        self.chooseImage.layer.masksToBounds = YES;
    }else{
        self.chooseImage.layer.cornerRadius = 10;
        self.chooseImage.layer.borderWidth = 0;
        self.chooseImage.backgroundColor = DDColor(@"f2f2f2");
        self.chooseImage.layer.masksToBounds = YES;
    }
}
@end
