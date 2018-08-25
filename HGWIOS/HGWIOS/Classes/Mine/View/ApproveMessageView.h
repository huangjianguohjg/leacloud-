//
//  ApproveMessageView.h
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UploadBlock)(void);

typedef void(^ImageTapBlock)(UIImage * image);

@interface ApproveMessageView : UIView

@property (nonatomic, weak) UILabel * leftLable;

@property (nonatomic, weak) UITextField * textField;

@property (nonatomic, weak) UIImageView * imageview;

@property (nonatomic, weak) UIButton * uploadButton;

@property (nonatomic, copy) UploadBlock uploadBlock;

@property (nonatomic, copy) ImageTapBlock imageTapBlock;

@end
