//
//  AddBoatView.m
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AddBoatView.h"

@interface AddBoatView()<UITextViewDelegate,UITextFieldDelegate>

@end

@implementation AddBoatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    
    UILabel * leftLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"船舶名称"];
    [leftLable sizeToFit];
    [self addSubview:leftLable];
    [leftLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(20));
        make.centerY.equalTo(self);
    }];
    self.leftLable = leftLable;
    
    UIButton * deleteButton = [[UIButton alloc]init];
    deleteButton.alpha = 0;
    [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteButton.layer.cornerRadius = realW(5);
    deleteButton.clipsToBounds = YES;
    deleteButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    deleteButton.backgroundColor = XXJColor(27, 69, 138);
    [self addSubview:deleteButton];
    [deleteButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(20));
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(realW(100), realH(60)));
        //        make.bottom.equalTo(self).offset(realH(-10));
    }];
    self.deleteButton = deleteButton;
    
    
    UILabel * starLable = [UILabel lableWithTextColor:[UIColor redColor] textFontSize:realFontSize(26) fontFamily:PingFangSc_Regular text:@"*"];
    starLable.alpha = 0;
    [starLable sizeToFit];
    [self addSubview:starLable];
    [starLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLable.right).offset(realW(5));
        make.centerY.equalTo(self);
    }];
    self.starLable = starLable;
    
    UIView * coverView = [[UIView alloc]init];
    coverView.backgroundColor = [UIColor whiteColor];
    coverView.clipsToBounds = YES;
    [self addSubview:coverView];
    [coverView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLable.right).offset(realW(30));
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(realH(120));
    }];
    
    
    UITextField * textField = [[UITextField alloc]init];
    textField.alpha = 0;
    textField.textAlignment = NSTextAlignmentRight;
    textField.tintColor = XXJColor(27, 69, 138);
    textField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    textField.textColor = XXJColor(116, 116, 116);
    [self addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-40));
        make.left.equalTo(self).offset(realW(200));
        make.centerY.equalTo(self);
    }];
    self.textField = textField;


    UIView * coverLeftLableView = [[UIView alloc]init];
    coverLeftLableView.alpha = 0;
    coverLeftLableView.backgroundColor = [UIColor whiteColor];
    coverLeftLableView.clipsToBounds = YES;
    [self addSubview:coverLeftLableView];
    [coverLeftLableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.right.equalTo(leftLable.right).offset(realW(20));
        make.height.equalTo(realH(120));
    }];
    self.coverLeftLableView = coverLeftLableView;
    
    
    UIButton * chooseButton = [[UIButton alloc]init];
    [chooseButton addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    chooseButton.alpha = 0;
    chooseButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [chooseButton setTitleColor:XXJColor(116, 116, 116) forState:UIControlStateNormal];
    [chooseButton setImage:[UIImage imageNamed:@"cargo_ship_xq_03"] forState:UIControlStateNormal];
    [chooseButton sizeToFit];
    [chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(20)];

    [coverView addSubview:chooseButton];
    [chooseButton makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(realW(-20));
//        make.centerY.equalTo(self);
        make.right.equalTo(coverView).offset(realW(-20));
        make.centerY.equalTo(coverView);
    }];
    self.chooseButton = chooseButton;

    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = XXJColor(249, 249, 249);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)]];
    [self addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-20));
        make.centerY.equalTo(self);
        make.height.equalTo(realH(110));
        make.width.equalTo(realW(0));
    }];
    self.imageView = imageView;

    
    
    UIButton * uploadButton = [[UIButton alloc]init];
    uploadButton.alpha = 0;
    [uploadButton setTitle:@"点击上传" forState:UIControlStateNormal];
    [uploadButton addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
    uploadButton.alpha = 0;
    uploadButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [uploadButton setTitleColor:XXJColor(3, 85, 251) forState:UIControlStateNormal];
    [uploadButton sizeToFit];
    [self addSubview:uploadButton];
    [uploadButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageView.left).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.uploadButton = uploadButton;
    


    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha= 0.5;
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(SCREEN_WIDTH - realW(40));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(realH(-1));
        make.height.equalTo(realH(1));
    }];
    self.lineView = lineView;
    
//我的船舶，添加船舶
    UIView * frameView = [[UIView alloc]init];
    [frameView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateClick)]];
    frameView.alpha = 0;
    frameView.layer.borderWidth = realW(1);
    frameView.layer.borderColor = XXJColor(220, 220, 220).CGColor;
    [self addSubview:frameView];
    [frameView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(1));
//        make.left.equalTo(leftLable.right).offset(realW(100));//⭐️⭐️⭐️
//        make.top.equalTo(self).offset(realH(10));
//        make.bottom.equalTo(lineView.top).offset(realH(-10));
        make.height.equalTo(realH(100));
        make.width.equalTo(realW(500));
        make.centerY.equalTo(self);
    }];
    self.frameView = frameView;

    UILabel * timeLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@""];
    [timeLable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateClick)]];
    timeLable.alpha = 0;
    [timeLable sizeToFit];
    [self addSubview:timeLable];
    [timeLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.timeLable = timeLable;

//货物重量相关布局********************************************************
    //%
    UILabel * percentLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"%"];
    percentLable.alpha = 0;
    [percentLable sizeToFit];
    [self addSubview:percentLable];
    [percentLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.percentLable = percentLable;

    UITextField * percentTextField = [[UITextField alloc]init];
    percentTextField.alpha = 0;
    percentTextField.layer.borderWidth = realW(1);
    percentTextField.layer.borderColor = XXJColor(224, 224, 224).CGColor;
    percentTextField.textAlignment = NSTextAlignmentCenter;
    percentTextField.tintColor = XXJColor(27, 69, 138);
    percentTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    percentTextField.textColor = XXJColor(116, 116, 116);
    [self addSubview:percentTextField];
    [percentTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(percentLable.left).offset(realW(-10));
        make.centerY.equalTo(self);
        make.width.equalTo(realW(150));
        make.height.equalTo(realH(80));
    }];
    self.percentTextField = percentTextField;

    UILabel * errorLable = [UILabel lableWithTextColor:XXJColor(119, 119, 119) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"±"];
    errorLable.alpha = 0;
    [errorLable sizeToFit];
    [self addSubview:errorLable];
    [errorLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(percentTextField.left).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.errorLable = errorLable;


    UILabel * dunLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"吨"];
    dunLable.alpha = 0;
    [dunLable sizeToFit];
    [self addSubview:dunLable];
    [dunLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(errorLable.left).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.dunLable = dunLable;

    UITextField * dunTextField = [[UITextField alloc]init];
    dunTextField.alpha = 0;
    dunTextField.layer.borderWidth = realW(1);
    dunTextField.layer.borderColor = XXJColor(224, 224, 224).CGColor;
    dunTextField.textAlignment = NSTextAlignmentCenter;
    dunTextField.tintColor = XXJColor(27, 69, 138);
    dunTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    dunTextField.textColor = XXJColor(116, 116, 116);
    [self addSubview:dunTextField];
    [dunTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dunLable.left).offset(realW(-10));
        make.centerY.equalTo(self);
        make.width.equalTo(realW(220));
        make.height.equalTo(realH(80));
    }];
    self.dunTextField = dunTextField;


//受载期相关布局********************************************************

    UITextField * endDateTextField = [[UITextField alloc]init];
    [endDateTextField addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endClick)]];
    endDateTextField.alpha = 0;
    endDateTextField.delegate = self;
    endDateTextField.layer.borderWidth = realW(1);
    endDateTextField.layer.borderColor = XXJColor(224, 224, 224).CGColor;
    endDateTextField.textAlignment = NSTextAlignmentCenter;
    endDateTextField.tintColor = XXJColor(27, 69, 138);
    endDateTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    endDateTextField.textColor = XXJColor(116, 116, 116);
    [self addSubview:endDateTextField];
    [endDateTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(realW(-20));
        make.centerY.equalTo(self);
        make.width.equalTo(realW(220));
        make.height.equalTo(realH(80));
    }];
    self.endDateTextField = endDateTextField;


    UILabel * toLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"-"];
    toLable.alpha = 0;
    [toLable sizeToFit];
    [self addSubview:toLable];
    [toLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(endDateTextField.left).offset(realW(-40));
        make.centerY.equalTo(self);
    }];
    self.toLable = toLable;


    UITextField * startDateTextField = [[UITextField alloc]init];
    [startDateTextField addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startClick)]];
    startDateTextField.delegate = self;
    startDateTextField.alpha = 0;
    startDateTextField.layer.borderWidth = realW(1);
    startDateTextField.layer.borderColor = XXJColor(224, 224, 224).CGColor;
    startDateTextField.textAlignment = NSTextAlignmentCenter;
    startDateTextField.tintColor = XXJColor(27, 69, 138);
    startDateTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    startDateTextField.textColor = XXJColor(116, 116, 116);
    [self addSubview:startDateTextField];
    [startDateTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(toLable.left).offset(realW(-40));
        make.centerY.equalTo(self);
        make.width.equalTo(realW(220));
        make.height.equalTo(realH(80));
    }];
    self.startDateTextField = startDateTextField;




    UILabel * unitLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"‰"];
    unitLable.alpha = 0;
    [unitLable sizeToFit];
    [self addSubview:unitLable];
    [unitLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.unitLable = unitLable;

    

    UITextField * lossTextField = [[UITextField alloc]init];
    lossTextField.alpha = 0;
    lossTextField.textAlignment = NSTextAlignmentRight;
    lossTextField.tintColor = XXJColor(27, 69, 138);
    lossTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    lossTextField.textColor = XXJColor(116, 116, 116);
    [lossTextField sizeToFit];
    [self addSubview:lossTextField];
    [lossTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(unitLable.left).offset(realW(-10));
        make.centerY.equalTo(self);
//        make.width.equalTo(realW(200));
//        make.height.equalTo(realH(80));
    }];
    self.lossTextField = lossTextField;


//开标时间/过期时间 相关布局********************************************************
    UIView * borderView = [[UIView alloc]init];
    [borderView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bidTimeClick)]];
    borderView.alpha = 0;
    borderView.layer.borderWidth = realW(1);
    borderView.layer.borderColor = XXJColor(224, 224, 224).CGColor;
    borderView.layer.cornerRadius = 5;
    borderView.clipsToBounds = YES;
    [self addSubview:borderView];
    [borderView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(1));
        make.centerY.equalTo(self);
//        make.left.equalTo(leftLable.right).offset(realW(10));
        make.width.equalTo(realW(500));//⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️
        make.height.equalTo(realH(80));
    }];
    self.borderView = borderView;


    UILabel * timeBorderLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@""];
    [timeBorderLable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bidTimeClick)]];
    timeBorderLable.alpha = 0;
    [timeBorderLable sizeToFit];
    [self.borderView addSubview:timeBorderLable];
    [timeBorderLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.borderView).offset(realW(-20));
        make.centerY.equalTo(self.borderView);
    }];
    self.timeBorderLable = timeBorderLable;


    UILabel * attentionLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"备注"];
    attentionLable.alpha = 0;
    [attentionLable sizeToFit];
    [self addSubview:attentionLable];
    [attentionLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(realW(20));
        make.top.equalTo(self).offset(realH(40));
    }];
    self.attentionLable = attentionLable;


    UITextView * textView = [[UITextView alloc]init];
    textView.delegate = self;
    textView.alpha = 0;
    textView.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    textView.layer.cornerRadius = 5;
    textView.clipsToBounds = YES;
    textView.layer.borderWidth = realW(1);
    textView.layer.borderColor = XXJColor(224, 224, 224).CGColor;
    [self addSubview:textView];
    [textView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(attentionLable.right).offset(realW(10));
        make.width.equalTo(SCREEN_WIDTH - realW(150));//⭐️⭐️⭐️⭐️⭐️⭐️⭐️
        make.top.equalTo(self.top).offset(realH(20));
        make.right.equalTo(self).offset(realW(-20));
        make.height.equalTo(realH(160));
    }];
    self.textView = textView;

//备注信息********************************************************

    UILabel * placeholderLable = [UILabel lableWithTextColor:XXJColor(174, 174, 174) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"备注信息"];
    placeholderLable.alpha = 0;
    [placeholderLable sizeToFit];
    [textView addSubview:placeholderLable];
    [placeholderLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textView).offset(realW(10));
        make.top.equalTo(textView).offset(realH(15));
    }];
    self.placeholderLable = placeholderLable;

    
    
    
    
    
    UITextField * emptyTextField = [[UITextField alloc]init];
    emptyTextField.alpha = 0;
    emptyTextField.textAlignment = NSTextAlignmentRight;
    emptyTextField.tintColor = XXJColor(27, 69, 138);
    emptyTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    emptyTextField.textColor = XXJColor(116, 116, 116);
    [self addSubview:emptyTextField];
    [emptyTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLable.right).offset(realW(40));
        make.centerY.equalTo(self);
    }];
    self.emptyTextField = emptyTextField;
    
    
    
    
    //交接方式布局
    UIButton * endChooseButton = [[UIButton alloc]init];
    [endChooseButton addTarget:self action:@selector(endClick:) forControlEvents:UIControlEventTouchUpInside];
    endChooseButton.alpha = 0;
    [endChooseButton setTitle:@"选择" forState:UIControlStateNormal];
    endChooseButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [endChooseButton setImage:[UIImage imageNamed:@"changeDown"] forState:UIControlStateNormal];
    [endChooseButton setImage:[UIImage imageNamed:@"changUp"] forState:UIControlStateSelected];
    [endChooseButton setTitleColor:XXJColor(116, 116, 116) forState:UIControlStateNormal];
    [endChooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(0)];
    [endChooseButton sizeToFit];
    [self addSubview:endChooseButton];
    [endChooseButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.endChooseButton = endChooseButton;

    
    UILabel * endLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"目的港"];
    endLable.alpha = 0;
    [endLable sizeToFit];
    [self addSubview:endLable];
    [endLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(endChooseButton.left).offset(realW(-10));
        make.centerY.equalTo(self);
    }];
    self.endLable = endLable;
    
    UILabel * changeToLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"-"];
    changeToLable.alpha = 0;
    [changeToLable sizeToFit];
    [self addSubview:changeToLable];
    [changeToLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(endLable.left).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.changeToLable = changeToLable;
    
    
    //交接方式布局
    UIButton * startChooseButton = [[UIButton alloc]init];
    [startChooseButton addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    startChooseButton.alpha = 0;
    [startChooseButton setTitle:@"选择" forState:UIControlStateNormal];
    startChooseButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [startChooseButton setImage:[UIImage imageNamed:@"changeDown"] forState:UIControlStateNormal];
    [startChooseButton setImage:[UIImage imageNamed:@"changeUp"] forState:UIControlStateSelected];
    [startChooseButton setTitleColor:XXJColor(116, 116, 116) forState:UIControlStateNormal];
    [startChooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];
    [startChooseButton sizeToFit];
    [self addSubview:startChooseButton];
    [startChooseButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(changeToLable.left).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.startChooseButton = startChooseButton;
    
    
    UILabel * startLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"起运港"];
    startLable.alpha = 0;
    [startLable sizeToFit];
    [self addSubview:startLable];
    [startLable makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(startChooseButton.left).offset(realW(-10));
        make.centerY.equalTo(self);
    }];
    self.startLable = startLable;
    
    
    //滞期费用布局
    //交接方式布局
    UIButton * zhiqiButton = [[UIButton alloc]init];
    [zhiqiButton addTarget:self action:@selector(endClick:) forControlEvents:UIControlEventTouchUpInside];
    zhiqiButton.alpha = 0;
    [zhiqiButton setTitle:@"选择" forState:UIControlStateNormal];
    zhiqiButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [zhiqiButton setImage:[UIImage imageNamed:@"changeDown"] forState:UIControlStateNormal];
    [zhiqiButton setImage:[UIImage imageNamed:@"changUp"] forState:UIControlStateSelected];
    [zhiqiButton setTitleColor:XXJColor(116, 116, 116) forState:UIControlStateNormal];
    [zhiqiButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(0)];
    [zhiqiButton sizeToFit];
    [self addSubview:zhiqiButton];
    [zhiqiButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(realW(-20));
        make.centerY.equalTo(self);
    }];
    self.zhiqiButton = zhiqiButton;
    
    
    UITextField * zhiqiTextField = [[UITextField alloc]init];
    zhiqiTextField.alpha = 0;
    zhiqiTextField.textAlignment = NSTextAlignmentRight;
    zhiqiTextField.tintColor = XXJColor(27, 69, 138);
    zhiqiTextField.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    zhiqiTextField.textColor = XXJColor(116, 116, 116);
    [zhiqiTextField sizeToFit];
    [self addSubview:zhiqiTextField];
    [zhiqiTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(zhiqiButton.left).offset(realW(-10));
        make.centerY.equalTo(self);
        //        make.width.equalTo(realW(200));
        //        make.height.equalTo(realH(80));
    }];
    self.zhiqiTextField = zhiqiTextField;
    
    
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}


-(void)endClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (self.publishDate) {
        self.publishDate(@"目的港");
    }
}

-(void)startClick:(UIButton *)button
{
//    button.selected = !button.selected;
    
    if (self.publishDate) {
        self.publishDate(@"起始港");
    }
}

#pragma mark -- 删除
-(void)deleteClick
{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}


#pragma mark -- 选择
-(void)chooseClick
{
    
    
    if (self.chooseBlock) {
        self.chooseBlock();
    }
}

#pragma mark -- 日期选择
-(void)dateClick
{
    if (self.dateBlock) {
        self.dateBlock();
    }
}

#pragma mark -- 点击上传
-(void)uploadClick
{
    if (self.chooseBlock) {
        self.chooseBlock();
    }
}

#pragma mark -- 图片点击
-(void)imageTap
{
    if (self.imageBlock) {
        self.imageBlock(self.imageView.image);
    }
}

#pragma mark -- 发布货盘 开始/结束日期的点击
-(void)endClick
{
    if (self.publishDate) {
        self.publishDate(@"end");
    }
}
-(void)startClick
{
    if (self.publishDate) {
        self.publishDate(@"start");
    }
}


#pragma mark -- 发布货盘 开标时间 过期时间 点击
-(void)bidTimeClick
{
    if (self.dateBlock) {
        self.dateBlock();
    }
}






-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        self.placeholderLable.alpha = 0;
    }
    else
    {
        self.placeholderLable.alpha = 1;
    }
}














@end
