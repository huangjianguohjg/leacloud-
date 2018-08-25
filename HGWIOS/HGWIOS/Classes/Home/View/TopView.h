//
//  TopView.h
//  HGWIOS
//
//  Created by 许小军 on 2018/5/14.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TopBlock)(NSString * s);

@interface TopView : UIView

@property (nonatomic, copy) NSString * title;

@property(copy,nonatomic) TopBlock topblock;

@property (nonatomic, weak) UIButton * leftButton;

-(void)changeTitle:(NSString *)title;

@end
