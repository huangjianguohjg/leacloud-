//
//  ShipHelperWeatherCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperWeatherCell.h"
#import "GrayLine.h"
@implementation ShipHelperWeatherCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor =[UIColor colorWithRed:3/255.0 green:59/255.0 blue:110/255.0 alpha:0.3];
        
        self.placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.contentView.frame.size.width/3, self.contentView.frame.size.height)];
        self.placeLabel.font = [CommonFontColorStyle F17BoldSizeFont];
        self.placeLabel.textColor = [CommonFontColorStyle WhiteColor];
        self.placeLabel.textAlignment = NSTextAlignmentCenter;
        self.placeLabel.numberOfLines = 0;
        [self.contentView addSubview:self.placeLabel];
        
        //中间
        self.middleView = [[UIView alloc]initWithFrame:CGRectMake(self.placeLabel.gjcf_right, 0, self.contentView.frame.size.width/3, self.contentView.frame.size.height)];
        [self.contentView addSubview:self.middleView];
        
//        self.oneImageView  = [[AsyncImageView alloc]initWithFrame:CGRectMake(20, 10, 25, 25)];
        self.oneImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 25, 25)];
        self.oneImageView .layer.masksToBounds = true;
        self.oneImageView.layer.cornerRadius = 0;
        self.oneImageView.layer.borderWidth = 0;
        [self.middleView addSubview:self.oneImageView];
        
        
        
        self.twoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.oneImageView.gjcf_right+10, 10, 12, 25)];
        self.twoImageView.image = [UIImage imageNamed:@"weather_line"];
        [self.middleView addSubview:self.twoImageView];
        
        
//        self.threeImageView  = [[AsyncImageView alloc]initWithFrame:CGRectMake(self.twoImageView.gjcf_right+10, 10, 25, 25)];
        self.threeImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(self.twoImageView.gjcf_right+10, 10, 25, 25)];
        self.threeImageView .layer.masksToBounds = true;
        self.threeImageView.layer.cornerRadius = 0;
        self.threeImageView.layer.borderWidth = 0;
        [self.middleView addSubview:self.threeImageView];
        
        
        
        self.weatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.oneImageView.gjcf_bottom + 3, self.middleView.gjcf_width, 15)];
        self.weatherLabel.font = [CommonFontColorStyle SuperSmallFont];
        self.weatherLabel.textColor = [CommonFontColorStyle WhiteColor];
        self.weatherLabel.textAlignment = NSTextAlignmentCenter;
        [self.middleView addSubview:self.weatherLabel];
        
        //右边
        self.rightView = [[UIView alloc]initWithFrame:CGRectMake(self.middleView.gjcf_right, 0, self.contentView.frame.size.width-self.middleView.gjcf_right, self.contentView.frame.size.height)];
        [self.contentView addSubview:self.rightView];
        
        self.temperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.rightView.gjcf_width, 15)];
        self.temperatureLabel.font = [CommonFontColorStyle NormalSizeFont];
        self.temperatureLabel.textColor = [CommonFontColorStyle WhiteColor];
        self.temperatureLabel.textAlignment = NSTextAlignmentCenter;
        self.temperatureLabel.numberOfLines = 0;
        [self.rightView addSubview:self.temperatureLabel];
        
        self.remarksLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.temperatureLabel.gjcf_bottom + 8, self.rightView.gjcf_width-15, 12)];
        self.remarksLabel.font = [CommonFontColorStyle SuperSmallFont];
        self.remarksLabel.textColor = [CommonFontColorStyle WhiteColor];
        self.remarksLabel.textAlignment = NSTextAlignmentCenter;
        self.remarksLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.remarksLabel.numberOfLines = 0;
        [self.rightView addSubview:self.remarksLabel];
        //横线
        GrayLine* grayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-0.5, self.contentView.frame.size.width ,0.5) Color:[CommonFontColorStyle D82C1Color]];
        [self.contentView addSubview:grayLine1];
        
    }
    return self;
}

-(void)setContent:(NSString *)cellId  Place:(NSString *)place  Remarks:(NSString *)remarks Weather:(NSString *)weather Temperature:(NSString *)temperature ImageOne:(NSString *)imageOne ImageTwo:(NSString *)imageTwo{
    self.placeLabel.text = [self getValidValue:place];
    
    self.weatherLabel.text = [self getValidValue:weather];
    NSString *temperatureContent =[[self getValidValue:temperature] stringByReplacingOccurrencesOfString:@"—" withString:@"~"] ;
    self.temperatureLabel.text =[temperatureContent stringByAppendingString:@"°C"];
    self.remarksLabel.text = [self getValidValue:remarks];
    
    
    CGSize size = [self.remarksLabel sizeThatFits:CGSizeMake(self.remarksLabel.frame.size.width, MAXFLOAT)];
    CGRect frame  =self.remarksLabel.frame;
    frame.size.height = size.height;
    self.remarksLabel.frame =frame;
    if ([GJCFStringUitil stringIsNull:imageTwo]) {
//        [BaseHelper SetAsyncImage:self.oneImageView Path:imageOne PlaceImage:@""];
        [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:imageOne] placeholderImage:[UIImage imageNamed:@""]];
        self.oneImageView.gjcf_left =(self.middleView.gjcf_width -25)/2;
        self.twoImageView.hidden = YES;
        self.threeImageView.hidden = YES;
    }else{
        self.twoImageView.hidden = NO;
        self.threeImageView.hidden = NO;
        self.oneImageView.gjcf_left =(self.middleView.gjcf_width -72)/2;
        self.twoImageView.gjcf_left =self.oneImageView.gjcf_right;
        self.threeImageView.gjcf_left =self.twoImageView.gjcf_right;
        
//        [BaseHelper SetAsyncImage:self.oneImageView Path:imageOne PlaceImage:@""];
//        [BaseHelper SetAsyncImage:self.threeImageView Path:imageTwo PlaceImage:@""];
        
        [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:imageOne] placeholderImage:[UIImage imageNamed:@""]];
        [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:imageTwo] placeholderImage:[UIImage imageNamed:@""]];
    }
}

-(NSString *)getValidValue:(NSString *)value{
    return   [[[value stringByReplacingOccurrencesOfString:@"\r" withString:@""]stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"\t" withString:@""];
}
@end
