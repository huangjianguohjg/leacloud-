//
//  DiscussOtherViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "DiscussOtherViewController.h"
#import "TggStarEvaluationView.h"

@interface DiscussOtherViewController ()<UITextViewDelegate>

@property (nonatomic, strong) TggStarEvaluationView * tggStarEvaView;

@property (nonatomic, weak) UILabel * scoreLable;

@property (nonatomic, copy) NSString * scoreStr;

@property (nonatomic, weak) UIButton * tishiButton;

@property (nonatomic, weak) UITextView * contentTextView;

@property (nonatomic, weak) UILabel * placeHolderLable;

@end

@implementation DiscussOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(242, 242, 242);
    
    self.scoreStr = @"0";
    
    self.navigationItem.title = self.titleStr;
    
    [self setUpUI];
    
}



-(void)setUpUI
{
    
    
    UILabel * titleLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"点击星星就能打分了,赶紧试一下吧"];
    [titleLable sizeToFit];
    [self.view addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(realH(40) + kStatusBarHeight + kNavigationBarHeight);;
        make.centerX.equalTo(self.view);
    }];
    
    
    
    // 注意weakSelf
    __weak __typeof(self)weakSelf = self;
    // 初始化
    self.tggStarEvaView = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        NSString * tishiStr = nil;
        if (count == 0) {
            tishiStr = @"请点击星星评价对方";
        }
        else if (count == 1)
        {
            tishiStr = @"非常抱歉,合作不愉快";
        }
        else if (count == 2)
        {
            tishiStr = @"不满意,比较差";
        }
        else if (count == 3)
        {
            tishiStr = @"一般,需要改善";
        }
        else if (count == 4)
        {
            tishiStr = @"合作较满意,但认可改善";
        }
        else if (count == 5)
        {
            tishiStr = @"合作很满意,无可挑剔";
        }
        
        [weakSelf.tishiButton setTitle:tishiStr forState:UIControlStateNormal];
        
        // 做评星后点处理
        weakSelf.scoreStr = [NSString stringWithFormat:@"%lu",count];
        weakSelf.scoreLable.text = [NSString stringWithFormat:@"%lu分",(unsigned long)count];
    }];
    [self.view addSubview:self.tggStarEvaView];
    [self.tggStarEvaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.bottom).equalTo(realH(40));
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(realW(400), realH(90)));
    }];
    
    
    // 设置展示的星星数量
    // self.tggStarEvaView.starCount = 3;
    
    // 星星之间的间距，默认0.5
     self.tggStarEvaView.spacing = 0.2;
    
    // 星星的点击事件使能,默认YES
    // self.tggStarEvaView.tapEnabled = NO;
    
    UILabel * scoreLable = [UILabel lableWithTextColor:XXJColor(249, 170, 87) textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"0分"];
    [scoreLable sizeToFit];
    [self.view addSubview:scoreLable];
    [scoreLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tggStarEvaView.bottom).offset(realH(20));;
        make.centerX.equalTo(self.view);
    }];
    self.scoreLable = scoreLable;
    
    UIButton * tishiButton = [[UIButton alloc]init];
    [tishiButton setTitle:@"请点击星星评价对方" forState:UIControlStateNormal];
    [tishiButton setTitleColor:XXJColor(26, 78, 114) forState:UIControlStateNormal];
    tishiButton.layer.borderColor = XXJColor(192, 192, 192).CGColor;
    tishiButton.layer.borderWidth = realH(1);
    tishiButton.backgroundColor = XXJColor(211, 236, 253);
    tishiButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [self.view addSubview:tishiButton];
    [tishiButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scoreLable.bottom).offset(realH(20));
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(realW(400), realH(60)));
    }];
    self.tishiButton = tishiButton;
    
    
    UITextView * contentTextView = [[UITextView alloc]init];
    contentTextView.delegate = self;
    contentTextView.textColor = [UIColor grayColor];
    contentTextView.tintColor = [UIColor redColor];
    contentTextView.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(34)];
    [self.view addSubview:contentTextView];
    [contentTextView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tishiButton.bottom).offset(realH(40));
        make.size.equalTo(CGSizeMake(realW(500), realH(300)));
        make.centerX.equalTo(self.view);
    }];
    self.contentTextView = contentTextView;
    
    UILabel * placeHolderLable = [UILabel lableWithTextColor:[UIColor colorWithHexString:@"#999999"] textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"请填写您的建议(选填)"];
    placeHolderLable.numberOfLines = 0;
    [placeHolderLable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [placeHolderLable setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    placeHolderLable.preferredMaxLayoutWidth = SCREEN_WIDTH - realW(60) - realW(10);
    [contentTextView addSubview:placeHolderLable];
    [placeHolderLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentTextView).offset(realH(15));
        make.left.equalTo(contentTextView).offset(realW(5));
        make.right.bottom.equalTo(contentTextView).offset(realW(-5));
    }];
    self.placeHolderLable = placeHolderLable;
    
    
    
    
    
    UIButton * addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [addButton setTitleColor:XXJColor(72, 180, 252) forState:UIControlStateNormal];
    addButton.backgroundColor = XXJColor(237, 246, 255);
    addButton.layer.cornerRadius = realW(30);
    addButton.clipsToBounds = YES;
    addButton.layer.borderWidth = realW(1);
    addButton.layer.borderColor = XXJColor(142, 194, 239).CGColor;
    addButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [self.view addSubview:addButton];
    [addButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(contentTextView.bottom).offset(realH(40));
        make.size.equalTo(CGSizeMake(realW(250) , realH(60)));
    }];
    
    
    
    
    
    
    
}


-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        self.placeHolderLable.text = @"";
    }
    else
    {
        self.placeHolderLable.text = @"请填写您的建议(选填)";
    }
}



-(void)addClick
{
    if ([self.scoreStr isEqualToString:@"0"]) {
        [self.view makeToast:@"请选择星星评价" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
   
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"score\":\"%@\",\"deal_id\":\"%@\",\"type\":\"%@\",\"evaluate\":\"%@\"",
                                 [UseInfo shareInfo].access_token,
                                 self.scoreStr,
                                 self.cargo_id,
                                 [[UseInfo shareInfo].identity isEqual:@"船东"] ? @"1" : @"0",
                                 self.contentTextView.text.length > 0 ? self.contentTextView.text : @""
                                 ];
    
    [XXJNetManager requestPOSTURLString:TransportDeal URLMethod:EvaluateMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"] isEqual:[NSNull null]]) {
            [self.view makeToast:@"评价成功" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            return ;
        }
        
        if ([result[@"result"][@"status"] boolValue]) {
            [self.view makeToast:@"评价成功" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [self.view makeToast:@"提交失败" duration:1.0 position:CSToastPositionCenter];
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}





@end
