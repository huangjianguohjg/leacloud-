//
//  ShipHelperWeatherCell.h
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AsyncImageView.h"
@interface ShipHelperWeatherCell : UICollectionViewCell

@property(nonatomic,strong )UILabel *placeLabel;
@property(nonatomic,strong )UIView *middleView;
//@property(nonatomic,strong )AsyncImageView *oneImageView;
@property (nonatomic, strong) UIImageView * oneImageView;
@property(nonatomic,strong )UIImageView *twoImageView;
//@property(nonatomic,strong )AsyncImageView *threeImageView;
@property (nonatomic, strong) UIImageView * threeImageView;
@property(nonatomic,strong )UILabel *weatherLabel;
@property(nonatomic,strong )UIView *rightView;
@property(nonatomic,strong )UILabel *temperatureLabel;
@property(nonatomic,strong )UILabel *remarksLabel;
-(void)setContent:(NSString *)cellId  Place:(NSString *)place  Remarks:(NSString *)remarks Weather:(NSString *)weather Temperature:(NSString *)temperature ImageOne:(NSString *)imageOne ImageTwo:(NSString *)imageTwo;

@end
