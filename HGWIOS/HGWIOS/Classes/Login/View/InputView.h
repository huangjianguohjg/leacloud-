//
//  InputView.h
//  化运网IOS
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 jiuze. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CodeBlock)(void);

@interface InputView : UIView

@property (nonatomic, weak) UIImageView * headImageView;

@property (nonatomic, weak) UITextField * nameTextField;

@property (nonatomic, weak) UIButton * codeButton;

@property (nonatomic, copy) CodeBlock codeBlock;

@end
