//
//  ServeView.h
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ServeButtonBlock)(NSString * title);

@interface ServeView : UIView

@property (nonatomic, strong) NSArray * titleArray;

@property (nonatomic, strong) NSArray * imageArray;

-(void)setTitleArray:(NSArray *)titleArray ImageArray:(NSArray *)imageArray Title:(NSString *)title;

@property (nonatomic, copy) ServeButtonBlock serveButtonBlock;

@end
