//
//  PublishGoodsView.m
//  HGWIOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "PublishGoodsView.h"

#import <BRStringPickerView.h>
#import <BRDatePickerView.h>
#import <BRAddressPickerView.h>
#import "AddBoatView.h"
#import "TypeView.h"
#import "JJPopoverTool.h"
#import "IdeaTableViewCell.h"

#import "JJPopoverTool.h"
@interface PublishGoodsView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, weak) UIScrollView * scrollView;

///**
// 记录询价类型
// */
//@property (nonatomic, copy) NSString * priceStr;
///**
// 记录履约保证金
// */
//@property (nonatomic, copy) NSString * bondStr;
///**
// 记录支付方式
// */
//@property (nonatomic, copy) NSString * payStyleStr;
///**
// 记录货物类型
// */
//@property (nonatomic, copy) NSString * goodsStyleID;
//
///**
// 记录付款方式
// */
//@property (nonatomic, copy) NSString * payStr;
//
///**
// 记录包含费用
// */
//@property (nonatomic, copy) NSString * containsStr;


/**
 遮盖层
 */
@property (nonatomic, weak) UIView * coverView;
@property (nonatomic, weak) TypeView * popView;
//记录现在是否已经请求了包含费用
@property (nonatomic, strong) NSArray * containsArray;
//记录现在是否已经请求了货物类型
@property (nonatomic, strong) NSArray * typeArray;


//保存交接方式
@property (nonatomic, strong) NSArray * changeArray;
//记录是哪个按钮点击交换方式的
@property (nonatomic, copy) NSString * witchChange;
@end

@implementation PublishGoodsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = XXJColor(242, 242, 242);
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jjTouchClick) name:@"JJTouch" object:nil];
        
        [self setUpUI];
        
        [self creatPopView];
        
        //获取交接方式
        [self changeTypeRequest];
        
    }
    return self;
}

#pragma mark -- 检查类型的弹窗
-(void)creatPopView
{
    UIView * coverView = [[UIView alloc]init];
    [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0;
    [self addSubview:coverView];
    [coverView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    self.coverView = coverView;
    
    __weak typeof(self) weakSelf = self;
    TypeView * popView = [[TypeView alloc]init];
    popView.okBlock = ^(NSString *ss) {
        if ([ss isEqualToString:@"取消"]) {
            
        }
        else
        {
            if ([ss containsString:@"其他"]) {
                weakSelf.includeView.chooseButton.alpha = 0;
                weakSelf.includeView.textField.alpha = 1;
                weakSelf.includeView.textField.placeholder = @"请填写包含费用";
                if (weakSelf.containsStr) {
                    NSString * str = [ss substringToIndex:ss.length - 3];
                    NSArray * selectArray = [str componentsSeparatedByString:@","];
                    for (NSString * s in selectArray) {
                        if (![weakSelf.containsStr containsString:s]) {
                            weakSelf.containsStr = [weakSelf.containsStr stringByAppendingString:[NSString stringWithFormat:@",%@",s]];
                        }
                    }
                    
                    weakSelf.includeView.textField.text = weakSelf.containsStr;
                }
                else
                {
                    weakSelf.includeView.textField.text = [ss substringToIndex:ss.length - 2];
                    weakSelf.containsStr = [ss substringToIndex:ss.length - 3];
                }
                
                
                weakSelf.includeView.textField.delegate = self;
                [weakSelf.includeView.textField becomeFirstResponder];
            }
            else
            {
                weakSelf.includeView.chooseButton.alpha = 1;
                weakSelf.includeView.textField.alpha = 0;
                [weakSelf.includeView.textField resignFirstResponder];
                if (weakSelf.containsStr) {
                    NSArray * selectArray = [ss componentsSeparatedByString:@","];
                    for (NSString * s in selectArray) {
                        if (![weakSelf.containsStr containsString:s]) {
                            weakSelf.containsStr = [weakSelf.containsStr stringByAppendingString:[NSString stringWithFormat:@",%@",s]];
                        }
                    }
                    [weakSelf.includeView.chooseButton setTitle:weakSelf.containsStr forState:UIControlStateNormal];
                }
                else
                {
                    [weakSelf.includeView.chooseButton setTitle:ss forState:UIControlStateNormal];
                    weakSelf.containsStr = ss;
                }
                
                [weakSelf.includeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];

            }
            
            
        }
        [weakSelf tapClick];
    };
    popView.backgroundColor = [UIColor whiteColor];
    popView.alpha = 0;
    popView.layer.cornerRadius = 10;
    popView.clipsToBounds = YES;
    [self addSubview:popView];
    [popView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(realW(400), realH(500)));
    }];
    self.popView = popView;
}

#pragma mark -- 点击背景消失
-(void)tapClick
{
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 0;
        self.popView.alpha = 0;
    }];
}


-(void)setUpUI
{
    CGFloat margin = 0;
    if (isIPHONEX) {
        margin = 34;
    }
    
    __weak typeof(self) weakSelf = self;
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight)];
    scrollView.userInteractionEnabled = YES;
    scrollView.backgroundColor = XXJColor(242, 242, 242);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    //询价类型
    AddBoatView * priceTypeView = [[AddBoatView alloc]init];
    priceTypeView.chooseBlock = ^{
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        //类型选择
        [BRStringPickerView showStringPickerWithTitle:@"询价类型" dataSource:@[@"公开询价",@"指定询价"] defaultSelValue:@"" isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
            
            [weakSelf.priceTypeView.chooseButton setTitle:selectValue forState:UIControlStateNormal];
            [weakSelf.priceTypeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            if ([selectValue isEqualToString:@"公开询价"]) {
                weakSelf.priceStr = @"1";
                
                weakSelf.bidOpenView.alpha = 0;
                weakSelf.bidOutView.alpha = 1;
                weakSelf.bidOutView.timeBorderLable.text = [NSString stringWithFormat:@"%@ %@",[TYDateUtils getDateAfterDays:7 withFormat:@"yyyy-MM-dd"],@"00:00"];
                [weakSelf.bidOutView updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakSelf.referView.bottom).offset(realH(10));
                }];
                
            }
            else
            {
                weakSelf.priceStr = @"0";
                
                weakSelf.bidOpenView.alpha = 1;
                weakSelf.bidOutView.alpha = 0;
                weakSelf.bidOutView.timeBorderLable.text = [NSString stringWithFormat:@"%@ %@",[TYDateUtils getDateAfterDays:300 withFormat:@"yyyy-MM-dd"],@"00:00"];
                weakSelf.bidOpenView.timeBorderLable.text = [NSString stringWithFormat:@"%@ %@",[TYDateUtils getDateAfterDays:2 withFormat:@"yyyy-MM-dd"],@"00:00"];
                [weakSelf.attentionView updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakSelf.bidOpenView.bottom).offset(realH(10));
                }];
                
            }
            
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
    };
    priceTypeView.starLable.alpha = 1;
    priceTypeView.chooseButton.alpha = 1;
    priceTypeView.lineView.alpha = 0;
    priceTypeView.leftLable.text = @"询价类型";
    [priceTypeView.chooseButton setTitle:@"公开询价" forState:UIControlStateNormal];
    [priceTypeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    self.priceStr = @"1";
    [scrollView addSubview:priceTypeView];
    [priceTypeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).offset(realH(20));
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.priceTypeView = priceTypeView;

    
    //货物类型
    AddBoatView * goodsTypeView = [[AddBoatView alloc]init];
    goodsTypeView.chooseBlock = ^{
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        //类型选择
        [weakSelf getCargoListRequest];
        
    };
    goodsTypeView.starLable.alpha = 1;
    goodsTypeView.chooseButton.alpha = 1;
    goodsTypeView.leftLable.text = @"货物类型";
    [goodsTypeView.chooseButton setTitle:@"请选择货物类型" forState:UIControlStateNormal];
    [goodsTypeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [scrollView addSubview:goodsTypeView];
    [goodsTypeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceTypeView.bottom).offset(realH(10));
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.goodsTypeView = goodsTypeView;
    
    
    //货物重量
    AddBoatView * weightView = [[AddBoatView alloc]init];
    weightView.starLable.alpha = 1;
    weightView.lineView.alpha = 0;
    weightView.percentLable.alpha = 1;
    weightView.percentTextField.alpha = 1;
    weightView.percentTextField.keyboardType = UIKeyboardTypeDecimalPad;
    weightView.percentTextField.placeholder = @"重量偏差";
    weightView.errorLable.alpha = 1;
    weightView.dunLable.alpha = 1;
    weightView.dunTextField.alpha = 1;
    weightView.dunTextField.keyboardType = UIKeyboardTypeDecimalPad;
    weightView.dunTextField.placeholder = @"填写货物重量";
    weightView.leftLable.text = @"货物重量";
    [scrollView addSubview:weightView];
    [weightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsTypeView.bottom);
        make.left.equalTo(scrollView);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, realH(120)));
    }];
    self.weightView = weightView;
    
    
    //起运港
    AddBoatView * startView = [[AddBoatView alloc]init];
    startView.chooseBlock = ^{
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        //类型选择
        if (weakSelf.chooseAddressBlock) {
            weakSelf.chooseAddressBlock(@"起运港");
        }
    };
    startView.starLable.alpha = 1;
    startView.chooseButton.alpha = 1;
    startView.leftLable.text = @"起运港";
    [startView.chooseButton setTitle:@"请选择起运港" forState:UIControlStateNormal];
    [startView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [scrollView addSubview:startView];
    [startView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weightView.bottom).offset(realH(10));
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.startView = startView;
    
    
    //目的港
    AddBoatView * endView = [[AddBoatView alloc]init];
    endView.chooseBlock = ^{
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        //类型选择
        if (weakSelf.chooseAddressBlock) {
            weakSelf.chooseAddressBlock(@"目的港");
        }
    };
    endView.starLable.alpha = 1;
    endView.chooseButton.alpha = 1;
    endView.leftLable.text = @"目的港";
    [endView.chooseButton setTitle:@"请选择目的港" forState:UIControlStateNormal];
    [endView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [scrollView addSubview:endView];
    [endView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.endView = endView;
    
    
    //受载期
    AddBoatView * dateView = [[AddBoatView alloc]init];
    dateView.publishDate = ^(NSString *s) {
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        if ([s isEqualToString:@"end"]) {
            //结束时间
            XXJLog(@"end")
            
            NSString * startStr = [TYDateUtils getCurentDate];
            
            NSDate * startDate = [TYDateUtils getFormatDate:startStr withFormat:@"yyyy-MM-dd"];
            
            NSString * endStr = [TYDateUtils getDateAfterDays:25 withFormat:@"yyyy-MM-dd"];
            
            NSDate * endDate = [TYDateUtils getFormatDate:endStr withFormat:@"yyyy-MM-dd"];
            
            NSMutableArray * aa = [TYDateUtils getAllDate:startDate endDate:endDate];
            
            [BRStringPickerView showStringPickerWithTitle:@"时间选择" dataSource:aa defaultSelValue:startDate resultBlock:^(id selectValue) {
                
                weakSelf.dateView.endDateTextField.text = selectValue;
                
            }];
            
            
        }
        else
        {
            //开始时间
            XXJLog(@"start")
            NSString * startStr = [TYDateUtils getCurentDate];
            
            NSDate * startDate = [TYDateUtils getFormatDate:startStr withFormat:@"yyyy-MM-dd"];
            
            NSString * endStr = [TYDateUtils getDateAfterDays:15 withFormat:@"yyyy-MM-dd"];
            
            NSDate * endDate = [TYDateUtils getFormatDate:endStr withFormat:@"yyyy-MM-dd"];
            
            NSMutableArray * aa = [TYDateUtils getAllDate:startDate endDate:endDate];
            
            [BRStringPickerView showStringPickerWithTitle:@"时间选择" dataSource:aa defaultSelValue:startDate resultBlock:^(id selectValue) {
                
                weakSelf.dateView.startDateTextField.text = selectValue;
                
            }];
        }
    };
    dateView.starLable.alpha = 1;
    dateView.lineView.alpha = 0;
    dateView.startDateTextField.alpha = 1;
    dateView.startDateTextField.text = [TYDateUtils getCurentDate];
    dateView.toLable.alpha = 1;
    dateView.endDateTextField.alpha = 1;
    dateView.endDateTextField.text = [TYDateUtils getDateAfterDays:7 withFormat:@"yyyy-MM-dd"];
    dateView.leftLable.text = @"受载期";
    [scrollView addSubview:dateView];
    [dateView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(endView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.dateView = dateView;
    
    
    //交接方式
    AddBoatView * changeView = [[AddBoatView alloc]init];
    changeView.publishDate = ^(NSString *s) {
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        
        if ([s isEqualToString:@"目的港"]) {
            [weakSelf pullView:weakSelf.changeArray UIView:weakSelf.changeView.endChooseButton];
            weakSelf.witchChange = @"目的港";
        }
        else
        {
            [weakSelf pullView:weakSelf.changeArray UIView:weakSelf.changeView.startChooseButton];
            weakSelf.witchChange = @"起运港";
        }
    };
    changeView.starLable.alpha = 1;
    changeView.leftLable.text = @"交接方式";
    changeView.endChooseButton.alpha = 1;
    changeView.endLable.alpha = 1;
    changeView.changeToLable.alpha = 1;
    changeView.startChooseButton.alpha = 1;
    changeView.startLable.alpha = 1;
    [scrollView addSubview:changeView];
    [changeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateView.bottom).offset(realH(10));
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.changeView = changeView;
    
    //合理损耗
    AddBoatView * lossView = [[AddBoatView alloc]init];
    lossView.starLable.alpha = 1;
    lossView.unitLable.alpha = 1;
    lossView.lossTextField.alpha = 1;
    lossView.lossTextField.keyboardType = UIKeyboardTypeDecimalPad;
    lossView.leftLable.text = @"合理损耗";
    lossView.lossTextField.placeholder = @"请填写合理损耗";
    [scrollView addSubview:lossView];
    [lossView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changeView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.lossView = lossView;
    
    
    //装卸时间
    AddBoatView * installView = [[AddBoatView alloc]init];
    installView.starLable.alpha = 1;
    installView.unitLable.alpha = 1;
    installView.lossTextField.alpha = 1;
    installView.lossTextField.keyboardType = UIKeyboardTypeDecimalPad;
    installView.unitLable.text = @"小时";
    installView.leftLable.text = @"装卸总作业时间";
    installView.lossTextField.placeholder = @"请填写装卸总作业时间";
    [scrollView addSubview:installView];
    [installView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lossView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.installView = installView;
    
    
    //滞期费用
    AddBoatView * retentionView = [[AddBoatView alloc]init];
    retentionView.starLable.alpha = 1;
    retentionView.zhiqiButton.alpha = 1;
    retentionView.zhiqiTextField.alpha = 1;
    retentionView.zhiqiTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [retentionView.zhiqiButton setTitle:@"元/天" forState:UIControlStateNormal];
    [retentionView.zhiqiButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(5)];
    retentionView.publishDate = ^(NSString *s) {
        weakSelf.witchChange = @"滞期费用";
        [weakSelf untilChoose];
        
    };
    retentionView.leftLable.text = @"滞期费用";
    retentionView.zhiqiTextField.placeholder = @"请填写滞期费用";
    [scrollView addSubview:retentionView];
    [retentionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(installView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.retentionView = retentionView;
    
    
    //履约保证金
    AddBoatView * agreeView = [[AddBoatView alloc]init];
    agreeView.chooseBlock = ^{
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        
        //选择履约保证金
        //类型选择
        [BRStringPickerView showStringPickerWithTitle:@"履约保证金" dataSource:@[@"无需支付",@"双方支付"] defaultSelValue:@"" isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
            
            [weakSelf.agreeView.chooseButton setTitle:selectValue forState:UIControlStateNormal];
            [weakSelf.agreeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
            if ([selectValue isEqualToString:@"无需支付"]) {
                weakSelf.bondStr = @"0";
            }
            else
            {
                weakSelf.bondStr = @"1";
            }
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
        
    };
    agreeView.starLable.alpha = 1;
    agreeView.chooseButton.alpha = 1;
    agreeView.leftLable.text = @"履约保证金";
    [agreeView.chooseButton setTitle:@"请选择履约保证金" forState:UIControlStateNormal];
    [agreeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [scrollView addSubview:agreeView];
    [agreeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(retentionView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.agreeView = agreeView;
    
    
    //结算
    AddBoatView * closeView = [[AddBoatView alloc]init];
    closeView.chooseBlock = ^{
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        
        //选择履约保证金
        //类型选择
        [BRStringPickerView showStringPickerWithTitle:@"结算方式" dataSource:@[@"线下结算",@"平台结算"] defaultSelValue:@"" isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
            
            [weakSelf.closeView.chooseButton setTitle:selectValue forState:UIControlStateNormal];
            [weakSelf.closeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
            if ([selectValue isEqualToString:@"线下结算"]) {
                weakSelf.payStyleStr = @"0";
            }
            else
            {
                weakSelf.payStyleStr = @"1";
            }
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
    };
    closeView.starLable.alpha = 1;
    closeView.chooseButton.alpha = 1;
    closeView.leftLable.text = @"结算方式";
    [closeView.chooseButton setTitle:@"请选择结算方式" forState:UIControlStateNormal];
    [closeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [scrollView addSubview:closeView];
    [closeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(agreeView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.closeView = closeView;
    
    //付款
    AddBoatView * payView = [[AddBoatView alloc]init];
    payView.chooseBlock = ^{
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        //选择付款方式
        [weakSelf getFreightRequest];
    };
    payView.starLable.alpha = 1;
    payView.chooseButton.alpha = 1;
    payView.leftLable.text = @"付款方式";
    [payView.chooseButton setTitle:@"请选择付款方式" forState:UIControlStateNormal];
    [payView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [scrollView addSubview:payView];
    [payView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(closeView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.payView = payView;
    
    
    //包含费用
    AddBoatView * includeView = [[AddBoatView alloc]init];
    includeView.chooseBlock = ^{
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        //选择包含费用
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.popView.alpha = 1;
            
            weakSelf.coverView.alpha = 0.3;
            
            if ([weakSelf.includeView.chooseButton.currentTitle isEqualToString:@"请选择报价包含费用"]) {
                weakSelf.popView.clear = @"清空";
            }
        }];
        [weakSelf containPriceRequest];
        
    };
    includeView.starLable.alpha = 1;
    includeView.chooseButton.alpha = 1;
    includeView.leftLable.text = @"包含费用";
    [includeView.chooseButton setTitle:@"请选择报价包含费用" forState:UIControlStateNormal];
    [includeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    includeView.textField.delegate = self;
    [scrollView addSubview:includeView];
    [includeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.includeView = includeView;
    
    
    //参考
    AddBoatView * referView = [[AddBoatView alloc]init];
    referView.lineView.alpha = 0;
    referView.unitLable.alpha = 1;
    referView.lossTextField.alpha = 1;
    referView.lossTextField.keyboardType = UIKeyboardTypeDecimalPad;
    referView.unitLable.text = @"元/吨";
    referView.leftLable.text = @"参考报价";
    referView.lossTextField.placeholder = @"请填写参考报价";
    [scrollView addSubview:referView];
    [referView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(includeView.bottom);
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.referView = referView;
    
    
    
    AddBoatView * bidOpenView = [[AddBoatView alloc]init];
    bidOpenView.starLable.alpha = 1;
    bidOpenView.lineView.alpha = 0;
    bidOpenView.alpha = 0;
    bidOpenView.dateBlock = ^{
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        NSString * startStr = [TYDateUtils getCurentDate];
        
        NSDate * startDate = [TYDateUtils getFormatDate:startStr withFormat:@"yyyy-MM-dd"];
        
//        NSString * tommorwStr = [TYDateUtils getDateAfterDays:2 startDate:startDate withFormat:@"yyyy-MM-dd"];
//
//        NSDate * tommorwDate = [TYDateUtils getFormatDate:tommorwStr withFormat:@"yyyy-MM-dd"];
        
        NSString * endStr = [TYDateUtils getDateAfterDays:15 withFormat:@"yyyy-MM-dd"];
        
        NSDate * endDate = [TYDateUtils getFormatDate:endStr withFormat:@"yyyy-MM-dd"];
        
        NSMutableArray * aa = [TYDateUtils getAllDate:startDate endDate:endDate];
        
        NSArray * dateArray = [[NSArray alloc]initWithArray:aa];
        
        //开标时间
        NSArray * hourArray = @[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"01:00",@"20:00",@"21:00",@"22:00",@"23:00"];
//        NSMutableArray * hourArray = [NSMutableArray array];
//        [hourArray addObjectsFromArray:hourArray1];
//        NSString * nowHour = [TYDateUtils getCurentDateWithFormat:@"HH:mm"];
//        NSString * formatHour = [[nowHour substringToIndex:2] stringByAppendingString:@":00"];
//        XXJLog(@"%@",formatHour);
        
        
        
        NSArray * dataSource = @[dateArray,hourArray];
        
        [BRStringPickerView showStringPickerWithTitle:@"开标时间" dataSource:dataSource defaultSelValue:nil isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
            
            NSArray * selectArray = (NSArray *)selectValue;
            
            NSString * currentDate = [TYDateUtils getCurentDateWithFormat:@"YYYY-MM-dd HH:mm"];
            
            NSInteger compareDate = [TYDateUtils compareDate:[NSString stringWithFormat:@"%@ %@",selectArray[0],selectArray[1]] withDate:currentDate formate:@"YYYY-MM-dd HH:mm"];
            
            if (compareDate > 0) {
                [self makeToast:@"开标时间不得选择当前时间之前" duration:1.0 position:CSToastPositionCenter];
                return;
            }
            
            
            
            weakSelf.bidOpenView.timeBorderLable.text = [NSString stringWithFormat:@"%@ %@",selectArray[0],selectArray[1]];
            
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
        
//        NSMutableArray * dataSourceArray = [NSMutableArray array];
//        NSInteger i = 0;
//        for (NSString * dateStr in dateArray) {
//            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//            if (i == 0) {
//                [dict setObject:@[@"0",@"1"] forKey:dateStr];
//            }
//            
//        }
        
        
        
        
        
        
    };
    bidOpenView.borderView.alpha = 1;
    bidOpenView.timeBorderLable.alpha = 1;
    bidOpenView.leftLable.text = @"开标时间";
    bidOpenView.timeBorderLable.text = [NSString stringWithFormat:@"%@ %@",[TYDateUtils getCurentDate],@"00:00"];
    [scrollView addSubview:bidOpenView];
    [bidOpenView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(referView.bottom).offset(realH(10));
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.bidOpenView = bidOpenView;
    
    
    //过期时间
    AddBoatView * bidOutView = [[AddBoatView alloc]init];
    bidOutView.starLable.alpha = 1;
    bidOutView.lineView.alpha = 0;
    bidOutView.dateBlock = ^{
        
        [weakSelf.weightView.dunTextField resignFirstResponder];
        [weakSelf.weightView.percentTextField resignFirstResponder];
        [weakSelf.lossView.lossTextField resignFirstResponder];
        [weakSelf.installView.lossTextField resignFirstResponder];
        [weakSelf.retentionView.zhiqiTextField resignFirstResponder];
        [weakSelf.referView.lossTextField resignFirstResponder];
        [weakSelf.attentionView.textView resignFirstResponder];
        
        NSString * startStr = [TYDateUtils getCurentDate];
        
        NSDate * startDate = [TYDateUtils getFormatDate:startStr withFormat:@"yyyy-MM-dd"];
        
//        NSString * tommorwStr = [TYDateUtils getDateAfterDays:2 startDate:startDate withFormat:@"yyyy-MM-dd"];
//
//        NSDate * tommorwDate = [TYDateUtils getFormatDate:tommorwStr withFormat:@"yyyy-MM-dd"];
        
        NSString * endStr = [TYDateUtils getDateAfterDays:25 withFormat:@"yyyy-MM-dd"];
        
        NSDate * endDate = [TYDateUtils getFormatDate:endStr withFormat:@"yyyy-MM-dd"];
        
        NSMutableArray * aa = [TYDateUtils getAllDate:startDate endDate:endDate];
        
        NSArray * dateArray = [[NSArray alloc]initWithArray:aa];
        
        //开标时间
        NSArray * hourArray = @[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"01:00",@"20:00",@"21:00",@"22:00",@"23:00"];
        
        
        NSArray * dataSource = @[dateArray,hourArray];
        
        [BRStringPickerView showStringPickerWithTitle:@"过期时间" dataSource:dataSource defaultSelValue:nil isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
            
            NSArray * selectArray = (NSArray *)selectValue;
            
            NSString * currentDate = [TYDateUtils getCurentDateWithFormat:@"YYYY-MM-dd HH:mm"];
            
            NSInteger compareDate = [TYDateUtils compareDate:[NSString stringWithFormat:@"%@ %@",selectArray[0],selectArray[1]] withDate:currentDate formate:@"YYYY-MM-dd HH:mm"];
            
            if (compareDate > 0) {
                [self makeToast:@"该时间已过期" duration:0.5 position:CSToastPositionCenter];
                return ;
            }
            
            weakSelf.bidOutView.timeBorderLable.text = [NSString stringWithFormat:@"%@ %@",selectArray[0],selectArray[1]];
            
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
        
        
    };
    bidOutView.borderView.alpha = 1;
    bidOutView.timeBorderLable.alpha = 1;
    bidOutView.leftLable.text = @"过期时间";
    bidOutView.timeBorderLable.text = [NSString stringWithFormat:@"%@ %@",[TYDateUtils getDateAfterDays:7 withFormat:@"yyyy-MM-dd"],@"00:00"];
    [scrollView addSubview:bidOutView];
    [bidOutView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(referView.bottom).offset(realH(10));
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.bidOutView = bidOutView;
    
    
    //备注
    AddBoatView * attentionView = [[AddBoatView alloc]init];
    attentionView.lineView.alpha = 0;
    attentionView.textView.alpha = 1;
    attentionView.placeholderLable.alpha = 1;
    attentionView.leftLable.alpha = 0;
    attentionView.attentionLable.alpha = 1;
    attentionView.attentionLable.text = @"备注";
    [scrollView addSubview:attentionView];
    [attentionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bidOutView.bottom).offset(realH(10));
        make.left.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(200));
    }];
    self.attentionView = attentionView;
    
    
    //确认发布
    UIButton * publishButton = [[UIButton alloc]init];
    [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    [publishButton setTitle:@"确认发布" forState:UIControlStateNormal];
    [publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishButton.backgroundColor = XXJColor(27, 69, 138);
    publishButton.layer.cornerRadius = 5;
    publishButton.clipsToBounds = YES;
    publishButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [scrollView addSubview:publishButton];
    [publishButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(scrollView);
        make.top.equalTo(attentionView.bottom).offset(realH(20));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
        make.bottom.equalTo(scrollView.bottom).offset(realH(-10));
    }];
    self.publishButton = publishButton;
    
    
}



#pragma mark -- 滞期费用单位选择
-(void)untilChoose
{
    
    [self pullView:@[@"1",@"2"] UIView:self.retentionView.zhiqiButton];
    
}


-(void)pullView:(NSArray *)array UIView:(UIView *)view
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, W(100), H(35) * array.count)];
    tableView.dataSource =self;
    tableView.delegate = self;
    tableView.rowHeight = H(35);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [JJPopoverTool presentContentView:tableView
                          pointToItem:view
                     passThroughViews:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.witchChange isEqualToString:@"滞期费用"]) {
        return 2;
    }
    return self.changeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    IdeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IdeaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if ([self.witchChange isEqualToString:@"滞期费用"]) {
        
        NSArray * array = @[@"元/天",@"元/吨/天"];
        cell.titleLable.text = array[indexPath.row];
    }
    else
    {
        cell.titleLable.text = self.changeArray[indexPath.row];
    }
    
    cell.titleLable.font = [UIFont systemFontOfSize:14];
    return  cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([JJPopoverTool isShowPopover]) {
        [JJPopoverTool dismiss];
    }
    
    IdeaTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.witchChange isEqualToString:@"滞期费用"]) {
        [self.retentionView.zhiqiButton setTitle:cell.titleLable.text forState:UIControlStateNormal];
        [self.retentionView.zhiqiButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];
    }
    else
    {
        if ([self.witchChange isEqualToString:@"目的港"]) {
            [self.changeView.endChooseButton setTitle:cell.titleLable.text forState:UIControlStateNormal];
            [self.changeView.endChooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];
        }
        else
        {
            [self.changeView.startChooseButton setTitle:cell.titleLable.text forState:UIControlStateNormal];
            [self.changeView.startChooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];
        }
        
    }
    
    
}
#pragma mark -- 点击背景退出下拉菜单
-(void)jjTouchClick
{
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -- 货物类型
-(void)getCargoListRequest
{
    if (self.typeArray) {
        
        BRAddressPickerView *addressView = [[BRAddressPickerView alloc]init];
        addressView.fromTag = @"特列";
        
        __weak typeof(self) weakSelf = self;
        
//        NSArray * array = @[self.typeArray[1]];
        
        [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:self.typeArray defaultSelected:nil isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            
            XXJLog(@"%@  %@  %@",province.name,city.name,area.name)
            if (area.name.length <= 0) {

                NSDictionary * dict = self.typeArray[0][@"citylist"][0][@"arealist"];
                
                if (dict.count > 0) {
                    dict = self.typeArray[0][@"citylist"][0][@"arealist"][0];
                    if (dict.count > 0) {
                        area.name = dict[@"name"];
                        area.code = dict[@"code"];
                        area.index = [dict[@"index"] integerValue];
                    }
                }
                
                XXJLog(@"%@",dict)
            }
            NSString * goodsStyleStr = nil;
            NSString * goodsStyleID = nil;
            if (![area.name isEqualToString:@" "] && ![area.name isEqual:[NSNull null]] && area.name != nil && area.name.length > 0) {
                goodsStyleStr = area.name;
                goodsStyleID = area.code;
            }
            else if (![city.name isEqualToString:@" "] && ![city.name isEqual:[NSNull null]] && city.name != nil && city.name.length > 0)
            {
                goodsStyleStr = city.name;
                goodsStyleID = city.code;
            }
            else
            {
                goodsStyleStr = province.name;
                goodsStyleID = province.code;
            }
            
            [weakSelf.goodsTypeView.chooseButton setTitle:goodsStyleStr forState:UIControlStateNormal];
            [weakSelf.goodsTypeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
            weakSelf.goodsStyleID = goodsStyleID;
            
            
        } cancelBlock:^{
            
        }];
        
        
        return;
    }
    
    
    
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\"",@""];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetCagoList URLMethod:GetCagoListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        
        NSArray * dataArray = result[@"result"][@"data"];
        
        NSMutableArray * pppArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i < dataArray.count; i++) {
            
//            NSMutableDictionary * qqq = [NSMutableDictionary dictionary];
            
//            NSMutableDictionary * sss = [NSMutableDictionary dictionary];
            
            NSMutableDictionary * ppp = [NSMutableDictionary dictionary];
            
            NSMutableArray * sssArray = [NSMutableArray array];
            
//            NSMutableArray * qqqArray = [NSMutableArray array];

            NSDictionary * dict = dataArray[i];
            
            if ([dict[@"f_level"] isEqual:[NSNull null]]) {
                
            }
            else
            {
                NSArray * f_levelArray = dict[@"f_level"];
                for (NSInteger a = 0; a < f_levelArray.count; a++) {
                    NSDictionary * adict = f_levelArray[a];

                    NSMutableArray * qqqArray = [NSMutableArray array];
                    NSMutableDictionary * sss = [NSMutableDictionary dictionary];
                    if ([adict[@"s_level"] isEqual:[NSNull null]]) {
                        
                    }
                    else
                    {
                        NSArray * s_levelArray = adict[@"s_level"];

                        for (NSInteger b = 0; b < s_levelArray.count; b++) {

                            NSMutableDictionary * qqq = [NSMutableDictionary dictionary];
                            
                            NSDictionary * bDict = s_levelArray[b];
                            
                            [qqq setObject:bDict[@"id"] forKey:@"code"];
                            [qqq setObject:bDict[@"name"] forKey:@"name"];
                            [qqq setObject:[NSString stringWithFormat:@"%ld",(long)b] forKey:@"index"];
                            
                            [qqqArray addObject:qqq];
                        }
                    }

                    [sss setObject:adict[@"id"] forKey:@"code"];
                    [sss setObject:adict[@"name"] forKey:@"name"];
                    [sss setObject:[NSString stringWithFormat:@"%ld",(long)a] forKey:@"index"];
                    [sss setObject:qqqArray forKey:@"arealist"];
                    
                    [sssArray addObject:sss];
                }
            }
            
            [ppp setObject:dict[@"id"] forKey:@"code"];
            [ppp setObject:dict[@"name"] forKey:@"name"];
            [ppp setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:@"index"];
            [ppp setObject:sssArray forKey:@"citylist"];
            [pppArray addObject:ppp];
            
        }

        NSArray * dataSource = [NSArray arrayWithArray:pppArray];
        self.typeArray = dataSource;
    
        
        BRAddressPickerView *addressView = [[BRAddressPickerView alloc]init];
        addressView.fromTag = @"特列";
        
        __weak typeof(self) weakSelf = self;
        [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:nil isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            
            XXJLog(@"%@  %@  %@",province.name,city.name,area.name)
            if (area.name.length <= 0) {
                //                return ;
                
                NSDictionary * dict = dataSource[0][@"citylist"][0][@"arealist"];
                if (dict.count > 0) {
                    dict = dataSource[0][@"citylist"][0][@"arealist"][0];
                    if (dict.count > 0) {
                        area.name = dict[@"name"];
                        area.code = dict[@"code"];
                        area.index = [dict[@"index"] integerValue];
                    }
                }
                
            }
            NSString * goodsStyleStr = nil;
            NSString * goodsStyleID = nil;
            if (![area.name isEqualToString:@" "] && ![area.name isEqual:[NSNull null]] && area.name != nil) {
                goodsStyleStr = area.name;
                goodsStyleID = area.code;
            }
            else if (![city.name isEqualToString:@" "] && ![city.name isEqual:[NSNull null]] && city.name != nil)
            {
                goodsStyleStr = city.name;
                goodsStyleID = city.code;
            }
            else
            {
                goodsStyleStr = province.name;
                goodsStyleID = province.code;
            }
            
            [weakSelf.goodsTypeView.chooseButton setTitle:goodsStyleStr forState:UIControlStateNormal];
            [weakSelf.goodsTypeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
            weakSelf.goodsStyleID = goodsStyleID;
            
            
        } cancelBlock:^{
            
        }];
        
        
    } errored:^(NSError *error) {
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}


#pragma mark -- 付款方式
-(void)getFreightRequest
{
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetFreight URLMethod:GetFreightMethod parameters:nil finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        NSDictionary * listDict = result[@"result"][@"list"];
        
//        [self.payDictionary setDictionary:listDict];
        
        NSArray * keyArray = [listDict allKeys];
        NSArray * valueArray = [listDict allValues];
        
        //类型选择
        __weak typeof(self) weakSelf = self;
        [BRStringPickerView showStringPickerWithTitle:@"付款方式" dataSource:valueArray defaultSelValue:@"" isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
            
            [weakSelf.payView.chooseButton setTitle:selectValue forState:UIControlStateNormal];
            [weakSelf.payView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
            for (NSInteger i = 0; i < valueArray.count; i++) {
                if ([selectValue isEqualToString:valueArray[i]]) {
                    weakSelf.payStr = keyArray[i];
                    break;
                }
            }
            
            
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
        
        
        
    } errored:^(NSError *error) {
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}


#pragma mark -- 包含费用
-(void)containPriceRequest
{
    if (self.containsArray.count > 0) {
        return;
    }
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:ContainCargo URLMethod:ContainCargoMethod parameters:nil finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        //类型选择
        
        self.popView.dataArray = result[@"result"];
        self.containsArray = result[@"result"];

        
    } errored:^(NSError *error) {
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        self.includeView.chooseButton.alpha = 1;
        [self.includeView.chooseButton setTitle:@"请选择报价包含费用" forState:UIControlStateNormal];
        self.containsStr = nil;
        [self.includeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        self.includeView.textField.alpha = 0;
        [self.includeView.textField resignFirstResponder];
    }
    else
    {
        NSString * douhao = [self.includeView.textField.text substringFromIndex:self.includeView.textField.text.length - 1];
        XXJLog(@"%@",douhao)
        
        //如果最后有逗号，去除逗号
        if ([douhao isEqualToString:@","]) {
            self.includeView.textField.text = [self.includeView.textField.text substringToIndex:self.includeView.textField.text.length - 1];
        }
        
        //输完内容后需要拼接到原来的值后面，以逗号隔开
        if (textField.text.length > self.containsStr.length) {
            NSString * inputStr = [textField.text substringFromIndex:self.containsStr.length];

            XXJLog(@"%@",inputStr)
            textField.text = [self.containsStr stringByAppendingString:[NSString stringWithFormat:@",%@",inputStr]];
            
            
        }
        
        
        self.containsStr = textField.text;
    }
}




#pragma mark -- 获取交接方式
-(void)changeTypeRequest
{
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:HandType URLMethod:HandTypeMethod parameters:nil finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        self.changeArray = result[@"result"];
        
    } errored:^(NSError *error) {
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}







#pragma mark -- 发布
-(void)publishClick
{
    
    __weak typeof(self) weakSelf = self;
    
    
    if ([[UseInfo shareInfo].nameApprove isEqualToString:@"认证通过"])
    {
        if ([[UseInfo shareInfo].companyApprove isEqualToString:@"认证通过"]) {
            [self surePublish];
            
            return;
        }
        else
        {
            //判断加入的公司
            if ([[UseInfo shareInfo].joinCompanyApprove isEqualToString:@"认证通过"])
            {
                [self surePublish];
                
                return;
            }
            
        }
    }
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"化运网是实名制平台，请认证后再操作" message:@"" preferredStyle:UIAlertControllerStyleAlert ];
    //取消style:UIAlertActionStyleDefault
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alertController addAction:cancelAction];
    
    //简直废话:style:UIAlertActionStyleDestructive
    UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"认证" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if (weakSelf.nameApproveBlock) {
            weakSelf.nameApproveBlock();
        }
        
    }];
    [alertController addAction:rubbishAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
 
}

-(void)surePublish
{
    
    
    
    
    
    
    if ([self.goodsTypeView.chooseButton.currentTitle isEqualToString:@"请选择货物类型"]) {
        [self makeToast:@"请选择货物类型" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.weightView.dunTextField.text.length == 0) {
        [self makeToast:@"请填写货物重量" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    
    if ([self.startView.chooseButton.currentTitle isEqualToString:@"请选择起运港"]) {
        [self makeToast:@"请选择起运港" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if ([self.endView.chooseButton.currentTitle isEqualToString:@"请选择目的港"]) {
        [self makeToast:@"请选择目的港" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.lossView.lossTextField.text.length == 0) {
        [self makeToast:@"请填写合理损耗" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.installView.lossTextField.text.length == 0) {
        [self makeToast:@"请填写装卸总作业时间" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.retentionView.zhiqiTextField.text.length == 0) {
        [self makeToast:@"请填写滞期费用" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if ([self.agreeView.chooseButton.currentTitle isEqualToString:@"请选择履约保证金"]) {
        [self makeToast:@"请选择履约保证金" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if ([self.closeView.chooseButton.currentTitle isEqualToString:@"请选择结算方式"]) {
        [self makeToast:@"请选择结算方式" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if ([self.payView.chooseButton.currentTitle isEqualToString:@"请选择付款方式"]) {
        [self makeToast:@"请选择付款方式" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.includeView.chooseButton.alpha == 1) {
        if ([self.includeView.chooseButton.currentTitle isEqualToString:@"请选择报价包含费用"] || self.containsStr == nil) {
            [self makeToast:@"请选择报价包含费用" duration:1.0 position:CSToastPositionCenter];
            return;
        }
    }
    else
    {
        if (self.includeView.textField.text.length == 0) {
            [self makeToast:@"请填写包含费用" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        else
        {
            self.containsStr = self.includeView.textField.text;
        }
    }
    
    if ([self.changeView.startChooseButton.currentTitle isEqualToString:@"选择"]) {
        [self makeToast:@"请选择起运港交接方式" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if ([self.changeView.endChooseButton.currentTitle isEqualToString:@"选择"]) {
        [self makeToast:@"请选择目的港交接方式" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    
    
    
    
    
    
    
    NSInteger date1 = [TYDateUtils compareDate:self.dateView.startDateTextField.text withDate:self.dateView.endDateTextField.text formate:@"yyyy-MM-dd"];
    if (date1 == 1) {
        //end 大
    }
    else
    {
        //end 小
        [self makeToast:@"请重新选择受载期" duration:1.0 position:CSToastPositionCenter];
        
        return;
    }
    
    
    NSInteger date2 = [TYDateUtils compareDate:self.bidOpenView.timeBorderLable.text withDate:self.bidOutView.timeBorderLable.text formate:@"yyyy-MM-dd HH:mm"];
    if (date2 == -1) {
        //end 小
        [self makeToast:@"请重新选择开标/过期时间" duration:1.0 position:CSToastPositionCenter];
        
        return;
    }
    else
    {
        //end 大
        
    }
    
    NSString *parameterstring = nil;
    if ([self.fromTag isEqualToString:@"修改"]) {
        parameterstring = [NSString stringWithFormat:@"\"cargo_type\":\"%@\",\"weight\":\"%@\",\"b_port_id\":\"%@""\",\"e_port_id\":\"%@""\",\"pay_type\":\"%@\",\"freight\":\"%@\",\"valid_time\":\"%@\",\"dock_day\":\"%@\",\"demurrage\":\"%@\",\"ship_type\":\"%@\",\"ship_cover\":\"%@\",\"cover_port\":\"%@\",\"ship_len\":\"%@\",\"ship_wid\":\"%@\",\"ship_draught\":\"%@\",\"access_token\":\"%@\",\"source\":\"2\",\"weight_num\":\"%@\",\"open_time\":\"%@\",\"parent_b_port_id\":\"%@\",\"parent_e_port_id\":\"%@\",\"cons_type\":\"%@\",\"b_port_address\":\"%@\",\"e_port_address\":\"%@\",\"loss\":\"%@\",\"bond\":\"%@\",\"is_insure\":\"%@\",\"viewable\":\"%@\",\"remark\":\"%@\",\"e_time\":\"%@\",\"b_time\":\"%@\",\"contain_price\":\"%@\",\"a_cargo_price\":\"%@\",\"b_hand_type\":\"%@\",\"e_hand_type\":\"%@\",\"demurrage_unit\":\"%@\",\"cargo_id\":\"%@\"",
                                     self.goodsStyleID,
                                     self.weightView.dunTextField.text,
                                     self.b_port_id,
                                     self.e_port_id,
                                     self.payStyleStr,
                                     self.payStr,
                                     [NSString stringWithFormat:@"%ld",(long)[TYDateUtils timeSwitchTimestamp:self.bidOutView.timeBorderLable.text andFormatter:@"yyyy-MM-dd HH:mm"]],
                                     self.installView.lossTextField.text.length == 0 ? @"0" : self.installView.lossTextField.text,
                                     self.retentionView.zhiqiTextField.text,
                                     @"",
                                     @"",
                                     @"",
                                     @"",
                                     @"",
                                     @"",
                                     [UseInfo shareInfo].access_token,
                                     self.weightView.percentTextField.text.length == 0 ? @"0" : self.weightView.percentTextField.text,
                                     [NSString stringWithFormat:@"%ld",(long)[TYDateUtils timeSwitchTimestamp:self.bidOpenView.timeBorderLable.text andFormatter:@"yyyy-MM-dd HH:mm"]],
                                     self.parent_b_port_id,
                                     self.parent_e_port_id,
                                     self.priceStr,
                                     self.b_port_address,
                                     self.e_port_address,
                                     self.lossView.lossTextField.text,
                                     self.bondStr,
                                     @"",
                                     @"",
                                     self.attentionView.textView.text.length == 0 ?@"" : self.attentionView.textView.text,
                                     [NSString stringWithFormat:@"%ld",(long)[TYDateUtils timeSwitchTimestamp:self.dateView.endDateTextField.text andFormatter:@"yyyy-MM-dd"]],
                                     [NSString stringWithFormat:@"%ld",(long)[TYDateUtils timeSwitchTimestamp:self.dateView.startDateTextField.text andFormatter:@"yyyy-MM-dd"]],
                                     self.containsStr,
                                     self.referView.lossTextField.text,
                                     self.changeView.startChooseButton.currentTitle,
                                     self.changeView.endChooseButton.currentTitle,
                                     self.retentionView.zhiqiButton.currentTitle,
                                     self.updateCargo_id
                                     ];
    }
    else
    {
        parameterstring = [NSString stringWithFormat:@"\"cargo_type\":\"%@\",\"weight\":\"%@\",\"b_port_id\":\"%@""\",\"e_port_id\":\"%@""\",\"pay_type\":\"%@\",\"freight\":\"%@\",\"valid_time\":\"%@\",\"dock_day\":\"%@\",\"demurrage\":\"%@\",\"ship_type\":\"%@\",\"ship_cover\":\"%@\",\"cover_port\":\"%@\",\"ship_len\":\"%@\",\"ship_wid\":\"%@\",\"ship_draught\":\"%@\",\"access_token\":\"%@\",\"source\":\"2\",\"weight_num\":\"%@\",\"open_time\":\"%@\",\"parent_b_port_id\":\"%@\",\"parent_e_port_id\":\"%@\",\"cons_type\":\"%@\",\"b_port_address\":\"%@\",\"e_port_address\":\"%@\",\"loss\":\"%@\",\"bond\":\"%@\",\"is_insure\":\"%@\",\"viewable\":\"%@\",\"remark\":\"%@\",\"e_time\":\"%@\",\"b_time\":\"%@\",\"contain_price\":\"%@\",\"a_cargo_price\":\"%@\",\"b_hand_type\":\"%@\",\"e_hand_type\":\"%@\",\"demurrage_unit\":\"%@\"",
                                     self.goodsStyleID,
                                     self.weightView.dunTextField.text,
                                     self.b_port_id,
                                     self.e_port_id,
                                     self.payStyleStr,
                                     self.payStr,
                                     [NSString stringWithFormat:@"%ld",(long)[TYDateUtils timeSwitchTimestamp:self.bidOutView.timeBorderLable.text andFormatter:@"yyyy-MM-dd HH:mm"]],
                                     self.installView.lossTextField.text.length == 0 ? @"0" : self.installView.lossTextField.text,
                                     self.retentionView.zhiqiTextField.text,
                                     @"",
                                     @"",
                                     @"",
                                     @"",
                                     @"",
                                     @"",
                                     [UseInfo shareInfo].access_token,
                                     self.weightView.percentTextField.text.length == 0 ? @"0" : self.weightView.percentTextField.text,
                                     [NSString stringWithFormat:@"%ld",(long)[TYDateUtils timeSwitchTimestamp:self.bidOpenView.timeBorderLable.text andFormatter:@"yyyy-MM-dd HH:mm"]],
                                     self.parent_b_port_id,
                                     self.parent_e_port_id,
                                     self.priceStr,
                                     self.b_port_address,
                                     self.e_port_address,
                                     self.lossView.lossTextField.text,
                                     self.bondStr,
                                     @"",
                                     @"",
                                     self.attentionView.textView.text.length == 0 ?@"" : self.attentionView.textView.text,
                                     [NSString stringWithFormat:@"%ld",(long)[TYDateUtils timeSwitchTimestamp:self.dateView.endDateTextField.text andFormatter:@"yyyy-MM-dd"]],
                                     [NSString stringWithFormat:@"%ld",(long)[TYDateUtils timeSwitchTimestamp:self.dateView.startDateTextField.text andFormatter:@"yyyy-MM-dd"]],
                                     self.containsStr,
                                     self.referView.lossTextField.text,
                                     self.changeView.startChooseButton.currentTitle,
                                     self.changeView.endChooseButton.currentTitle,
                                     self.retentionView.zhiqiButton.currentTitle
                                     ];
    }
    
    
    
    NSString * url = nil;
    if ([self.fromTag isEqualToString:@"修改"]) {
        url = EditCargo;
    }
    else
    {
        url = PublishCargoMethod;
    }
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:PublishCargo URLMethod:url parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (![result[@"result"][@"status"] boolValue]) {
            [self makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter];
        }
        else
        {
            if ([self.fromTag isEqualToString:@"修改"]) {
                
                
                
                [self makeToast:@"修改成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
//                    [self.vc.navigationController popViewControllerAnimated:YES];
                }];
                
                
            }
            else
            {
                [self makeToast:@"发布成功" duration:1.0 position:CSToastPositionCenter];
            }
            
            
            
            
            
            NSDictionary * dict = @{
                                    @"b_port" : [self.startView.chooseButton.currentTitle componentsSeparatedByString:@"-"][1],
                                    @"e_port" : [self.endView.chooseButton.currentTitle componentsSeparatedByString:@"-"][1],
                                    @"weight" : [NSString stringWithFormat:@"%@ %@吨 ±%@%@",self.goodsTypeView.chooseButton.currentTitle,self.weightView.dunTextField.text,self.weightView.percentTextField.text,@"%"],
                                    @"time" : [NSString stringWithFormat:@"%@ 至 %@",self.dateView.startDateTextField.text,self.dateView.endDateTextField.text]
                                    };
            
            if ([self.priceStr isEqualToString:@"0"]) {
                if (self.inviteSuccessBlock) {
                    self.inviteSuccessBlock(result[@"result"][@"id"]);
                }
            }
            else
            {
                if (self.publishSuccessBlock) {
                    self.publishSuccessBlock(dict);
                }
            }
            
            
            
            
            [self.priceTypeView.chooseButton setTitle:@"公开询价" forState:UIControlStateNormal];
            [self.goodsTypeView.chooseButton setTitle:@"请选择货物类型" forState:UIControlStateNormal];
            self.weightView.dunTextField.text = nil;
            self.weightView.percentTextField.text = nil;
            [self.startView.chooseButton setTitle:@"请选择起运港" forState:UIControlStateNormal];
            [self.endView.chooseButton setTitle:@"请选择目的港" forState:UIControlStateNormal];
            self.dateView.startDateTextField.text = nil;
            self.dateView.endDateTextField.text = nil;
            self.lossView.lossTextField.text = nil;
            self.installView.lossTextField.text = nil;
            self.retentionView.zhiqiTextField.text = nil;
            [self.agreeView.chooseButton setTitle:@"请选择履约保证金" forState:UIControlStateNormal];
            [self.closeView.chooseButton setTitle:@"请选择结算方式" forState:UIControlStateNormal];
            [self.payView.chooseButton setTitle:@"请选择付款方式" forState:UIControlStateNormal];
            [self.includeView.chooseButton setTitle:@"请选择报价包含费用" forState:UIControlStateNormal];
            self.referView.lossTextField.text = nil;
            self.bidOpenView.timeBorderLable.text = nil;
            self.bidOutView.timeBorderLable.text = nil;
            self.attentionView.textView.text = nil;
            
            [self.priceTypeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            [self.goodsTypeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            [self.startView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            [self.endView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            [self.agreeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            [self.closeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            [self.payView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            [self.includeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
            
            self.dateView.startDateTextField.text = [TYDateUtils getCurentDate];
            self.dateView.endDateTextField.text = [TYDateUtils getDateAfterDays:7 withFormat:@"yyyy-MM-dd"];
            
//            self.bidOpenView.alpha = 0;
//            self.bidOutView.alpha = 1;
//            self.bidOutView.timeBorderLable.text = [NSString stringWithFormat:@"%@ %@",[TYDateUtils getDateAfterDays:7 withFormat:@"yyyy-MM-dd"],@"00:00"];
        }
        
    } errored:^(NSError *error) {
        [self makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}







@end
