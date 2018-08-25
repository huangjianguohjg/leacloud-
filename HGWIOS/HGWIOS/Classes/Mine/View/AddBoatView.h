//
//  AddBoatView.h
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteBlcok)(void);

typedef void(^DateBlock)(void);

typedef void(^ChooseBlock)(void);

typedef void(^PublishDate)(NSString * s);

typedef void(^ImageBlock)(UIImage * image);

@interface AddBoatView : UIView

@property (nonatomic, weak) UILabel * leftLable;

@property (nonatomic, weak) UIButton * deleteButton;

@property (nonatomic, weak) UIView * coverLeftLableView;

@property (nonatomic, weak) UILabel * starLable;

@property (nonatomic, weak) UITextField * textField;

@property (nonatomic, weak) UIButton * chooseButton;

@property (nonatomic, weak) UIView * frameView;

@property (nonatomic, weak) UILabel * timeLable;

@property (nonatomic, weak) UIImageView * imageView;

@property (nonatomic, weak) UIButton * uploadButton;

@property (nonatomic, weak) UILabel * percentLable;

@property (nonatomic, weak) UITextField * percentTextField;

@property (nonatomic, weak) UILabel * errorLable;

@property (nonatomic, weak) UILabel * dunLable;

@property (nonatomic, weak) UITextField * dunTextField;

@property (nonatomic, weak) UITextField * endDateTextField;

@property (nonatomic, weak) UILabel * toLable;

@property (nonatomic, weak) UITextField * startDateTextField;

@property (nonatomic, weak) UILabel * unitLable;

@property (nonatomic, weak) UITextField * lossTextField;

@property (nonatomic, weak) UIView * borderView;

@property (nonatomic, weak) UILabel * timeBorderLable;

@property (nonatomic, weak) UILabel * attentionLable;

@property (nonatomic, weak) UITextView * textView;

@property (nonatomic, weak) UILabel * placeholderLable;

@property (nonatomic, weak) UITextField * emptyTextField;

@property (nonatomic, weak) UIButton * endChooseButton;

@property (nonatomic, weak) UILabel * endLable;

@property (nonatomic, weak) UILabel * changeToLable;

@property (nonatomic, weak) UIButton * startChooseButton;

@property (nonatomic, weak) UILabel * startLable;

@property (nonatomic, weak) UIButton * zhiqiButton;

@property (nonatomic, weak) UITextField * zhiqiTextField;

@property (nonatomic, weak) UIView * lineView;

@property (nonatomic, copy) DeleteBlcok deleteBlock;

@property (nonatomic, copy) DateBlock dateBlock;

@property (nonatomic, copy) ChooseBlock chooseBlock;

@property (nonatomic, copy) PublishDate publishDate;

@property (nonatomic, copy) ImageBlock imageBlock;

@end
