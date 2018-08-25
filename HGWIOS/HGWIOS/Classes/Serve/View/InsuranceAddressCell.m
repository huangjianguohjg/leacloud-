//
//  InsuranceAddressCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceAddressCell.h"
#import "GrayLine.h"
@implementation InsuranceAddressCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        int imageWidth = 20;
        
        GrayLine* GrayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5) Color:[CommonFontColorStyle E2E5ECColor]];
        [self addSubview:GrayLine1];
        
        //第一部分
        self.firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 18, self.frame.size.width-60, 16)];
        self.firstView.backgroundColor =[CommonFontColorStyle WhiteColor];
        [self addSubview: self.firstView];
        
        
        self.NameLabel =[[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 0, 100, self.firstView.gjcf_height)];
        self.NameLabel.font = [CommonFontColorStyle NormalSizeFont];
        self.NameLabel.textColor = [CommonFontColorStyle I3Color];
        [self.firstView addSubview: self.NameLabel];
        
        self.MobileLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.NameLabel.gjcf_right + 23, 0, 100, self.firstView.gjcf_height)];
        self.MobileLabel.font = [CommonFontColorStyle NormalSizeFont];
        self.MobileLabel.textColor = [CommonFontColorStyle I3Color];
        [self.firstView addSubview: self.MobileLabel];
        
        //邮费
        self.youfeiTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.firstView.gjcf_width - 100, 0, 50, 15)];
        self.youfeiTitleLabel.text = @"邮费:";
        self.youfeiTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.youfeiTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [self.firstView addSubview:self.youfeiTitleLabel];
        [self.youfeiTitleLabel sizeToFit];
        
        self.YouFeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.youfeiTitleLabel.gjcf_right, 0, 50, self.firstView.gjcf_height)];
        self.YouFeiLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.YouFeiLabel.textColor = [CommonFontColorStyle I3Color];
        
        [self.firstView addSubview:self.YouFeiLabel];
        
        self.youfeiUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.YouFeiLabel.gjcf_width, 0, 50, 15)];
        self.youfeiUnitLabel.text = @"元";
        self.youfeiUnitLabel.font = [CommonFontColorStyle SmallSizeFont];
        self.youfeiUnitLabel.textColor = [CommonFontColorStyle FontNormalColor];
        [self.firstView addSubview:self.youfeiUnitLabel];
        [self.youfeiUnitLabel sizeToFit];
        
        
        
        
        //第二部分
        UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], self.firstView.gjcf_bottom, self.frame.size.width-60-[CommonDimensStyle smallMargin], 28)];
        secondView.backgroundColor = [CommonFontColorStyle WhiteColor];
        [self addSubview: secondView];
        
        self.insuranceAddressView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, secondView.gjcf_width, 30)];
        [secondView addSubview:self.insuranceAddressView];
        self.insuranceAddressView.font = [CommonFontColorStyle SmallSizeFont];
        self.insuranceAddressView.textColor =[ CommonFontColorStyle BottomTextColor];
        self.insuranceAddressView.userInteractionEnabled = NO;
        
        
        self.editView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width - 3*imageWidth , 0, 3*imageWidth, self.frame.size.height)];
        [self addSubview:self.editView];
        
        self.editImgView = [[UIImageView alloc]initWithFrame:CGRectMake(imageWidth ,(self.frame.size.height- imageWidth)/2, imageWidth, imageWidth)];
        self.editImgView.image = [UIImage imageNamed:@"ins_icon_edit"];
        [self.editView addSubview:self.editImgView];
        
    }
    return self;
}

-(void)initContent:(NSString *)title Mobile:(NSString *)mobile YouFei:(NSString *)youfei
           Address:(NSString *)address Moren:(Boolean)moren InsuranceId:(NSString *)insuranceId Express_company:(NSString *)express_company{
    self.insuranceTitle = title;
    if (title.length > 5) {
        title = [NSString stringWithFormat:@"%@...",[title substringToIndex:5]];
    }
    self.NameLabel.text=title;
    [self.NameLabel sizeToFit];
    
    self.MobileLabel.text=mobile;
    self.MobileLabel.gjcf_left = self.NameLabel.gjcf_right + 23;
    
    if (moren) {
        NSString *addressContent = [NSString stringWithFormat:@"[默认地址]%@",address];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:addressContent];
        [str addAttribute:NSForegroundColorAttributeName value:[CommonFontColorStyle RedColor] range:NSMakeRange(0,6)];
        [str addAttribute:NSForegroundColorAttributeName value:[CommonFontColorStyle BottomTextColor] range:NSMakeRange(6,addressContent.length - 6)];
        self.insuranceAddressView.attributedText = str;
        self.insuranceAddressView.numberOfLines = 0;
    }else{
        self.insuranceAddressView.text=address;
    }
    self.YouFeiLabel.text = youfei;
    
    self.insuranceId = insuranceId;
    self.express_company = express_company;
    
    //重新设置宽度
    [self.YouFeiLabel sizeToFit];
    self.youfeiUnitLabel.gjcf_left =self.YouFeiLabel.gjcf_right;
    self.youfeiTitleLabel.gjcf_left =self.firstView.gjcf_width - 10-self.YouFeiLabel.gjcf_width - 35;
    self.YouFeiLabel.gjcf_left = self.youfeiTitleLabel.gjcf_right;
    self.youfeiUnitLabel.gjcf_left = self.YouFeiLabel.gjcf_right;
}
@end
