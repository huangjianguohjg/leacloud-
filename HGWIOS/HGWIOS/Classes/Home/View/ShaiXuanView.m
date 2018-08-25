//
//  ShaiXuanView.m
//  HGWIOS
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShaiXuanView.h"
#import "ShaiXuanChildView.h"

@interface ShaiXuanView()

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, weak) ShaiXuanChildView * weightView;
@property (nonatomic, weak) ShaiXuanChildView * cashView;
@property (nonatomic, weak) ShaiXuanChildView * typeView;
@property (nonatomic, weak) ShaiXuanChildView * typeView1;

@property (nonatomic, strong) NSArray * typeArray;

@property (nonatomic, copy) NSString * weightStr;
@property (nonatomic, copy) NSString * cashStr;
@property (nonatomic, copy) NSString * payStr;
@property (nonatomic, copy) NSString * typeStr;

@end

@implementation ShaiXuanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = XXJColor(242, 242, 242);
        
        
    }
    return self;
}

//-(void)setFromTag:(NSString *)fromTag
//{
//    _fromTag = fromTag;
//
//    [self setUpUI];
//}

-(void)setFromTag:(NSString *)fromTag Array:(NSArray *)array
{
    self.typeArray = array;
    self.fromTag = fromTag;
    [self setUpUI];
}


-(void)setUpUI
{
    __weak typeof(self) weakSelf = self;

    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = XXJColor(242, 242, 242);
    [self addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    self.scrollView = scrollView;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.5;
    [scrollView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(scrollView);
        make.top.equalTo(scrollView.top);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, realH(1)));
    }];
    
    
    
    UIView * weightBackView = [[UIView alloc]init];
    weightBackView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:weightBackView];
    [weightBackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom);
        make.left.equalTo(scrollView);
        make.height.equalTo(realH(52));
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    UILabel * weightlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"货物重量(吨)"];
    [weightlable sizeToFit];
    [weightBackView addSubview:weightlable];
    [weightlable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weightBackView).offset(realH(20));
        make.left.equalTo(weightBackView).offset(realH(20));
        make.height.equalTo(realH(32));
    }];
    
    ShaiXuanChildView * weightView = [[ShaiXuanChildView alloc]init];
    weightView.shaiBlock = ^(NSString *str) {
        weakSelf.weightStr = str;
    };
    weightView.titleArray = @[@"不限",@"0-1000",@"1000-3000",@"3000-5000",@"5000以上"];
    [scrollView addSubview:weightView];
    [weightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weightBackView.bottom).offset(realH(0));
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    self.weightView = weightView;
    
    if ([self.fromTag isEqualToString:@"找货"])
    {
        
        UIView * cashBackView = [[UIView alloc]init];
        cashBackView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:cashBackView];
        [cashBackView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weightView.bottom);
            make.left.equalTo(scrollView);
            make.height.equalTo(realH(52));
            make.width.equalTo(SCREEN_WIDTH);
        }];
        
        UILabel * cashlable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"履约保证金"];
        [cashlable sizeToFit];
        [cashBackView addSubview:cashlable];
        [cashlable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cashBackView).offset(realH(20));
            make.left.equalTo(cashBackView).offset(realH(20));
            make.height.equalTo(realH(32));
        }];

        ShaiXuanChildView * cashView = [[ShaiXuanChildView alloc]init];
        cashView.shaiBlock = ^(NSString *str) {
            weakSelf.cashStr = str;
        };
        cashView.titleArray = @[@"不限",@"无需支付",@"双方支付"];
        [scrollView addSubview:cashView];
        [cashView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cashBackView.bottom).offset(realH(0));
            make.left.equalTo(scrollView);
            make.width.equalTo(SCREEN_WIDTH);
        }];
        self.cashView = cashView;
        
        
        UIView * typeBackView = [[UIView alloc]init];
        typeBackView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:typeBackView];
        [typeBackView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cashView.bottom);
            make.left.equalTo(scrollView);
            make.height.equalTo(realH(52));
            make.width.equalTo(SCREEN_WIDTH);
        }];
        
        
        
        UILabel * typelable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"结算方式"];
        [typelable sizeToFit];
        [typeBackView addSubview:typelable];
        [typelable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(typeBackView).offset(realH(20));
            make.left.equalTo(typeBackView).offset(realH(20));
            make.height.equalTo(realH(32));
        }];
        
        
        ShaiXuanChildView * typeView = [[ShaiXuanChildView alloc]init];
        typeView.shaiBlock = ^(NSString *str) {
            weakSelf.payStr = str;
        };
        typeView.titleArray = @[@"不限",@"平台结算",@"线下结算"];
        [scrollView addSubview:typeView];
        [typeView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(typeBackView.bottom).offset(realH(0));
            make.left.equalTo(scrollView);
            make.width.equalTo(SCREEN_WIDTH);
        }];
        self.typeView = typeView;
        
        
        UIView * buttonView = [[UIView alloc]init];
        buttonView.backgroundColor = [UIColor whiteColor];
        [self addSubview:buttonView];
        [buttonView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(typeView.bottom);
            make.left.equalTo(self);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, realH(168)));
        }];
        
        
        UIButton * cancelbutton = [[UIButton alloc]init];
        [cancelbutton setBackgroundImage:[UIImage createImageWithColor:XXJColor(29, 169, 252)] forState:UIControlStateNormal];
        [cancelbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelbutton.layer.cornerRadius = realW(10);
        cancelbutton.clipsToBounds = YES;
        [cancelbutton setTitle:@"重 置" forState:UIControlStateNormal];
        cancelbutton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
        [cancelbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:cancelbutton];
        [cancelbutton makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(buttonView).offset(realW(40));
            make.top.equalTo(buttonView.top).offset(realH(40));
            make.size.equalTo(CGSizeMake(realW(200), realH(88)));
        }];
        
        
        UIButton * okbutton = [[UIButton alloc]init];
        [okbutton setBackgroundImage:[UIImage createImageWithColor:XXJColor(27, 69, 138)] forState:UIControlStateNormal];
        [okbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        okbutton.layer.cornerRadius = realW(10);
        okbutton.clipsToBounds = YES;
        [okbutton setTitle:@"确 定" forState:UIControlStateNormal];
        okbutton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
        [okbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:okbutton];
        [okbutton makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cancelbutton.right).offset(realW(40));
            make.top.equalTo(buttonView.top).offset(realH(40));
            make.right.equalTo(buttonView).offset(realW(-40));
            make.height.equalTo(realH(88));
        }];
  
    }
    else if ([self.fromTag isEqualToString:@"找船"])
    {
        
        UIView * typeBackView = [[UIView alloc]init];
        typeBackView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:typeBackView];
        [typeBackView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.weightView.bottom);
            make.left.equalTo(scrollView);
            make.height.equalTo(realH(52));
            make.width.equalTo(SCREEN_WIDTH);
        }];
        
        
        UILabel * typelable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"船舶类型"];
        [typelable sizeToFit];
        [typeBackView addSubview:typelable];
        [typelable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(typeBackView).offset(realH(20));
            make.left.equalTo(typeBackView).offset(realH(20));
            make.height.equalTo(realH(32));
        }];
        
        
        ShaiXuanChildView * typeView1 = [[ShaiXuanChildView alloc]init];
        typeView1.shaiBlock = ^(NSString *str) {
            weakSelf.typeStr = str;
        };
        typeView1.titleArray = self.typeArray;
        [scrollView addSubview:typeView1];
        [typeView1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(typeBackView.bottom).offset(realH(0));
            make.left.equalTo(self.scrollView);
            make.width.equalTo(SCREEN_WIDTH);
        }];
        self.typeView1 = typeView1;
        
        
        UIView * buttonView = [[UIView alloc]init];
        buttonView.backgroundColor = [UIColor whiteColor];
        [self addSubview:buttonView];
        [buttonView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(typeView1.bottom);
            make.left.equalTo(self);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, realH(168)));
        }];
        
        
        
        UIButton * cancelbutton = [[UIButton alloc]init];
        [cancelbutton setBackgroundImage:[UIImage createImageWithColor:XXJColor(29, 169, 252)] forState:UIControlStateNormal];
        [cancelbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelbutton.layer.cornerRadius = realW(10);
        cancelbutton.clipsToBounds = YES;
        [cancelbutton setTitle:@"重 置" forState:UIControlStateNormal];
        cancelbutton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
        [cancelbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:cancelbutton];
        [cancelbutton makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(buttonView).offset(realW(40));
            make.top.equalTo(buttonView.top).offset(realH(40));
            make.size.equalTo(CGSizeMake(realW(200), realH(88)));
        }];
        
        
        UIButton * okbutton = [[UIButton alloc]init];
        [okbutton setBackgroundImage:[UIImage createImageWithColor:XXJColor(27, 69, 138)] forState:UIControlStateNormal];
        [okbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        okbutton.layer.cornerRadius = realW(10);
        okbutton.clipsToBounds = YES;
        [okbutton setTitle:@"确 定" forState:UIControlStateNormal];
        okbutton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
        [okbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:okbutton];
        [okbutton makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cancelbutton.right).offset(realW(40));
            make.top.equalTo(buttonView.top).offset(realH(40));
            make.right.equalTo(buttonView).offset(realW(-40));
            make.height.equalTo(realH(88));
        }];
        
        
        
    }
    
    
    
}



-(void)buttonClick:(UIButton *)button
{


    if ([button.currentTitle isEqualToString:@"重 置"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"remart" object:nil];
        
        self.weightStr = @"";
        self.cashStr = @"";
        self.payStr = @"";
        self.typeStr = @"";
        return;
    }
    
    if (self.shaiChooseBlock) {
        self.shaiChooseBlock(button.currentTitle, self.weightStr, self.cashStr, self.payStr, self.typeStr);
    }
}





-(void)shipTypeRequest
{
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:ShipType URLMethod:ShipTypeMethod parameters:nil finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result)
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
//        NSArray * array = [resultDict[@"result"][@"list"] allKeys];
        
        NSArray * tempArray = [resultDict[@"result"][@"list"] allValues];
        
        NSMutableArray * array = [NSMutableArray array];
        [array addObjectsFromArray:tempArray];
        [array insertObject:@"不限" atIndex:0];
        
        NSArray * titleArray = [NSArray arrayWithArray:array];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            
            self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        });
        
        
        
    } errored:^(NSError *error) {
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}














@end
