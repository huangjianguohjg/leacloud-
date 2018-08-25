//
//  BankTableViewCell.m
//  HGWIOS
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BankTableViewCell.h"
#import "BankModel.h"
#import "BankNameHelper.h"
#import "SupportBankModel.h"
@interface BankTableViewCell()

@property (nonatomic, weak) UIImageView * image_View;

@property (nonatomic, weak) UILabel * titleLable;

//@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation BankTableViewCell

//-(NSMutableArray *)dataArray
//{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//
//        NSMutableDictionary *banks = [BankNameHelper getAll];
//        for (NSString *key in [banks keyEnumerator])
//        {
//            SupportBankModel *supportBankModel1 = [[SupportBankModel alloc]init];
//            supportBankModel1.title =[banks valueForKey:key];
//            supportBankModel1.titleAb = key;
//            supportBankModel1.imageurl = key;
//            [_dataArray addObject:supportBankModel1];
//        }
//
//    }
//    return _dataArray;
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = XXJColor(234, 239, 245);
        
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = realW(10);
    backView.clipsToBounds = YES;
    [self.contentView addSubview:backView];
    [backView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(realW(20));
        make.top.equalTo(self.contentView).offset(realH(20));
        make.right.equalTo(self.contentView).offset(realW(-20));
//        make.height.equalTo(realH(100));
        make.bottom.equalTo(self.contentView).offset(realH(-20));
    }];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self.contentView addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(realW(10));
        make.centerY.equalTo(backView);
        make.size.equalTo(CGSizeMake(realW(70), realH(70)));
    }];
    self.image_View = imageView;
    
    UILabel * titleLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(28) fontFamily:PingFangSc_Regular text:@"添加银行卡"];
    [titleLable sizeToFit];
    [self.contentView addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.right).offset(realW(20));
        make.centerY.equalTo(self.contentView);
    }];
    self.titleLable = titleLable;
    
    
    
}


-(void)setModel:(BankModel *)model
{
    _model = model;
    
    self.titleLable.text = model.bank_name;
    
    
    
    [self.imageView setImage:[UIImage imageNamed:model.bank_name_ab]];
    
}












@end
