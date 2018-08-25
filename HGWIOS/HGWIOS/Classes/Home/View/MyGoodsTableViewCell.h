//
//  MyGoodsTableViewCell.h
//  HGWIOS
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OfferBlock)(NSString * str);

@class AlreadyOfferModel;

@interface MyGoodsTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel * typeLable;

@property (nonatomic, weak) UILabel * bidLable;

@property (nonatomic, weak) UILabel * alreadyLable;

//@property (nonatomic, weak) UILabel * countLable;

@property (nonatomic, weak) UIButton * deleteButton;

@property (nonatomic, weak) UIButton * updateButton;

@property (nonatomic, weak) UIButton * refreshButton;

@property (nonatomic, weak) UIButton * allotButton;

@property (nonatomic, weak) UIButton * inviteButton;

@property (nonatomic, weak) UIButton * cancelButton;


@property (nonatomic, weak) UIButton * ingButton;

@property (nonatomic, strong) AlreadyOfferModel * model;

@property (nonatomic, copy) NSString * fromTag;

@property (nonatomic, copy) OfferBlock offerBlock;

@end
