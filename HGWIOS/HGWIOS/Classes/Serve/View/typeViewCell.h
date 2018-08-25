//
//  typeViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface typeViewCell : UICollectionViewCell
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImageView *id;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *choosedView;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *rate;
@property (strong, nonatomic) NSString *deductible_statement;


-(void) initwithContent:(NSString *)name Id:(NSString *)id Code:(NSString *)code Rate:(NSString *)rate Deductible_statement:(NSString *)deductible_statement;
-(void) initwithContent:(NSString *)name Id:(NSString *)id Code:(NSString *)code;
-(void)init:(NSString *)name;

@end
