//
//  IdeaTableViewCell.m
//  lineroad
//
//  Created by gagakj on 2017/8/8.
//  Copyright © 2017年 田宇. All rights reserved.
//

#import "IdeaTableViewCell.h"



@implementation IdeaTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpUI];
        
    }
    return self;
}

-(void)setUpUI
{
    
    UILabel * titleLable = [UILabel lableWithTextColor:[UIColor blackColor] textFont:14 text:@"111"];
    [self.contentView addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    self.titleLable = titleLable;
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.alpha = 0.25;
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(H(1));
    }];
    
    
}


-(void)dealloc
{
    XXJLog(@"IdeaTableViewCell--释放")
}






@end
