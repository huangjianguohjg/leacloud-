//
//  InsuranceAddressCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsuranceAddressCell : UICollectionViewCell
@property(strong,nonatomic)UILabel *NameLabel;
@property(strong,nonatomic)UILabel *MobileLabel;
@property(strong,nonatomic)UILabel *YouFeiLabel;
@property(strong,nonatomic)UILabel *insuranceAddressView;
@property(strong,nonatomic)NSString *insuranceId;
@property(strong,nonatomic)UIView *editView;
@property(strong,nonatomic)UIImageView *editImgView;
@property(strong,nonatomic)UILabel *youfeiUnitLabel;
@property(strong,nonatomic)NSString *express_company;
@property(strong,nonatomic)NSString *insuranceTitle;
@property(strong,nonatomic)UILabel *youfeiTitleLabel;
@property(strong,nonatomic)UIView *firstView;


-(void)initContent:(NSString *)title Mobile:(NSString *)mobile YouFei:(NSString *)youfei
           Address:(NSString *)address Moren:(Boolean)moren InsuranceId:(NSString *)insuranceId Express_company:(NSString *)express_company;
@end
