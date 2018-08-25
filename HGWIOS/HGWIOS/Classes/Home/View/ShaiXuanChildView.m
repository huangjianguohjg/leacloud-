//
//  ShaiXuanChildView.m
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShaiXuanChildView.h"

@interface ShaiXuanChildView()

@property (nonatomic, weak) UIButton * preButton;

@end

@implementation ShaiXuanChildView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remartClick) name:@"remart" object:nil];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    CGFloat w = (SCREEN_WIDTH - realW(20) * 2 - realW(40) * 2) / 3;
    CGFloat h = realH(88);
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton * button = [[UIButton alloc]init];
//        [button setBackgroundImage:[UIImage createImageWithColor:XXJColor(44, 252, 46)] forState:UIControlStateSelected];
//        [button setBackgroundImage:[UIImage createImageWithColor:XXJColor(117, 159, 227)] forState:UIControlStateNormal];
        
        button.layer.borderColor = XXJColor(222, 222, 222).CGColor;
        button.layer.borderWidth = realW(3);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = realW(10);
        button.clipsToBounds = YES;
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSString * titleStr = titleArray[i];
        if (![titleStr containsString:@"0"]) {
            if (titleStr.length > 6) {
                titleStr = [NSString stringWithFormat:@"%@\n%@",[titleStr substringToIndex:6],[titleStr substringFromIndex:6]];
            }
            [button setTitle:titleStr forState:UIControlStateNormal];
        }
        else
        {
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
        }
        
        button.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(28)];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            self.preButton = button;
            self.preButton.layer.borderColor = XXJColor(47, 155, 213).CGColor;
        }
        [self addSubview:button];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(realW(20) + realW(40) * (i % 3) + w * (i % 3));
            make.top.equalTo(self).offset(realH(10) + (realH(88) + realH(20)) * (i / 3));
            make.size.equalTo(CGSizeMake(w, h));
            if (i == titleArray.count - 1) {
                make.bottom.equalTo(self).offset(realH(-realH(15)));
            }
        }];
    }
    
}




-(void)buttonClick:(UIButton *)button
{
    self.preButton.layer.borderColor = XXJColor(222, 222, 222).CGColor;
    self.preButton.selected = NO;
    button.selected = YES;
    self.preButton = button;
    
    if (button.selected) {
        
        button.layer.borderColor = XXJColor(47, 155, 213).CGColor;
        
        if (self.shaiBlock) {
            self.shaiBlock(button.currentTitle);
        }
    }
    
    
}



-(void)remartClick
{
    XXJLog(@"2222")
    self.preButton.selected = NO;
    self.preButton.layer.borderColor = XXJColor(222, 222, 222).CGColor;
    for (UIButton * button in self.subviews) {
        if ([button.currentTitle isEqualToString:@"不限"]) {
            button.selected = YES;
            button.layer.borderColor = XXJColor(47, 155, 213).CGColor;
            self.preButton = button;
        }
    }
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}







@end
