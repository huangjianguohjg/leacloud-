//
//  DynamicHistoryViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "DynamicHistoryViewCell.h"

@implementation DynamicHistoryViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:0 green:66.0/255 blue:125.0/255 alpha:0.15];
        self.backgroundColor = [UIColor whiteColor];
        self.BoatNameTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 0,self.frame.size.width - 140, self.frame.size.height)];
        self.BoatNameTitle.font = [CommonFontColorStyle NormalSizeFont];
//        self.BoatNameTitle.textColor = [CommonFontColorStyle WhiteColor];
        self.BoatNameTitle.textColor = [UIColor blackColor];
        [self addSubview:self.BoatNameTitle];
        
        self.BoatTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.BoatNameTitle.gjcf_right, 0,100, self.frame.size.height)];
        self.BoatTimeLabel.font = [CommonFontColorStyle NormalSizeFont];
//        self.BoatTimeLabel.textColor = [CommonFontColorStyle WhiteColor];
        self.BoatTimeLabel.textColor = [UIColor blackColor];
        self.BoatTimeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.BoatTimeLabel];
    }
    return self;
}

-(void)initContent:(NSString *)id BoatName:(NSString *)boatName Time:(NSString *)time Mmsi:(NSString *)mmsi{
    self.BoatNameTitle.text=boatName;
    self.BoatTimeLabel.text = time;
    self.boatId = id;
    self.mmsi = mmsi;
}

@end
