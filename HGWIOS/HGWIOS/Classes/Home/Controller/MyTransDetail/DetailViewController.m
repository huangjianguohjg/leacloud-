//
//  DetailViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTopTableViewCell.h"
#import "DetailTableViewCell.h"
#import "DetailNumTableViewCell.h"
#import "TrainDetailModel.h"
#import "ApproveViewController.h"
#import "ChooseApproveViewController.h"
#import "PhoneFeedbackView.h"
#import "HLPhoneInfoController.h"
#import "TggStarEvaluationView.h"
#import <GKPhotoBrowser.h>
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource,GKPhotoBrowserDelegate>

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) TrainDetailModel * model;

/**
 记录拨打电话的运单ID
 */
@property (nonatomic, copy) NSString * log_id;

@property (nonatomic, weak) PhoneFeedbackView * feedView;

@property (nonatomic, weak) UIView * coverView;

@property (nonatomic, strong) TggStarEvaluationView * tggStarEvaView;

@property (nonatomic, strong) TggStarEvaluationView * tggStarEvaView1;

@property (nonatomic, weak) UIView * imageBackView;

@property (nonatomic, weak) UIView * imageBackView2;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(255, 255, 255);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneCall) name:@"PhoneCall" object:nil];
    
//    [self setUpUI];
    
    [self detailrequest];
    
}

-(void)setUpUI
{
    
    CGFloat margin = 0;
    if (isIPHONEX) {
        margin = 34;
    }
    
    
//    NSArray * array = @[@"我要装\n货",@"我已装\n货",@"我已卸\n货",@"评价货\n主",@"致电货\n主"];
//    for (NSInteger i = 0; i < 5; i++) {
//        UIButton * button = [[UIButton alloc]init];
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        button.titleLabel.numberOfLines = 0;
//        button.titleLabel.textAlignment = NSTextAlignmentCenter;
//        button.layer.cornerRadius = realW(10);
//        button.clipsToBounds = YES;
//        button.layer.borderWidth = realW(1);
//        button.layer.borderColor = XXJColor(76, 150, 214).CGColor;
//        [button setBackgroundImage:[UIImage createImageWithColor:XXJColor(237, 246, 254)] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage createImageWithColor:XXJColor(27, 66, 127)] forState:UIControlStateSelected];
//        [button setTitleColor:XXJColor(52, 163, 227) forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [button setTitle:array[i] forState:UIControlStateNormal];
//        if (i == 4) {
//            button.selected = YES;
//        }
//        [self.view addSubview:button];
//        [button makeConstraints:^(MASConstraintMaker *make) {
//            if (i != 4) {
//                make.left.equalTo(self.view).offset(realW(20) + realW(130) * i);
//            }
//            else
//            {
//                make.right.equalTo(self.view).offset(realW(-20));
//            }
//            
//            make.bottom.equalTo(self.view).offset(realH(-20) - margin);
//            make.size.equalTo(CGSizeMake(realW(130), realH(100)));
//        }];
//        
//    }
    
    
    UIButton * button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.layer.cornerRadius = realW(10);
    button.clipsToBounds = YES;
    button.layer.borderWidth = realW(1);
    button.layer.borderColor = XXJColor(76, 150, 214).CGColor;
    [button setBackgroundImage:[UIImage createImageWithColor:XXJColor(237, 246, 254)] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage createImageWithColor:XXJColor(27, 69, 138)] forState:UIControlStateSelected];
    [button setTitleColor:XXJColor(52, 163, 227) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    button.selected = YES;
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
        [button setTitle:@"致电货主" forState:UIControlStateNormal];
    }
    else
    {
        [button setTitle:@"致电船东" forState:UIControlStateNormal];
    }
    [self.view addSubview:button];
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(realW(20));
        make.right.equalTo(self.view).offset(realW(-20));
        make.bottom.equalTo(self.view).offset(realH(-30) - margin);
        make.height.equalTo(realH(88));
    }];
    
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = XXJColor(215, 217, 223);
    [self.view addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(realH(-140) - margin);
        make.height.equalTo(realH(1));
    }];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 60;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"DetailTableViewCell"];
    [tableView registerClass:[DetailNumTableViewCell class] forCellReuseIdentifier:@"DetailNumTableViewCell"];
    
    [tableView registerClass:[DetailTopTableViewCell class] forCellReuseIdentifier:@"DetailTopTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(lineView.top);
    }];
    
    tableView.sectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    CGRect frame = CGRectMake(0, 0, 0, CGFLOAT_MIN);
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:frame];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:frame];
    
    self.tableView = tableView;
    
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 500)];
    bottomView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = bottomView;
    
    
    CGFloat height = 0;
    
    
    UIView * pictureLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, realH(40))];
    pictureLineView.backgroundColor = XXJColor(242, 242, 242);
    [bottomView addSubview:pictureLineView];
    
    height += realH(40);
    
    UILabel * hetongLable = [UILabel lableWithTextColor:XXJColor(158, 158, 158) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"船东合同"];
    [hetongLable sizeToFit];
    [bottomView addSubview:hetongLable];
    [hetongLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(realW(40));
        make.top.equalTo(pictureLineView.bottom).offset(realH(10));
    }];
    
    height += realH(34) + realH(10);
    
    CGFloat width = (SCREEN_WIDTH - realW(12) * 2 - realW(40) * 2) / 3;
    
    UIView * imageBackView = [[UIView alloc]init];
    imageBackView.backgroundColor = [UIColor whiteColor];
    imageBackView.clipsToBounds = YES;
    [bottomView addSubview:imageBackView];
    [imageBackView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
//        make.top.equalTo(hetongLable.bottom).offset(realH(20));
        make.top.equalTo(pictureLineView.bottom).offset(realH(64 + 20));
        make.width.equalTo(SCREEN_WIDTH);
        
        if (![self.model.s_contract_file isEqual:[NSNull null]]) {
            
            CGFloat y = self.model.s_contract_file.count % 3;
            if (y == 0) {
                y = 0;
            }
            else
            {
                y = 1;
            }
            
            make.height.equalTo(width * ((self.model.s_contract_file.count / 3) + y) + realH(12) * ((self.model.s_contract_file.count / 3) + y - 1));
        }
        else
        {
            make.height.equalTo(1);
        }
        
    }];
    self.imageBackView = imageBackView;
    
    
    if (![self.model.s_contract_file isEqual:[NSNull null]]) {
        
        CGFloat y = self.model.s_contract_file.count % 3;
        if (y == 0) {
            y = 0;
        }
        else
        {
            y = 1;
        }
        
        
        height += width * ((self.model.s_contract_file.count / 3) + y) + realH(12) * ((self.model.s_contract_file.count / 3) + y - 1) + realH(12);
    }
    
    
    
    if (![self.model.s_contract_file isEqual:[NSNull null]]) {
        for (NSInteger i = 0; i < self.model.s_contract_file.count; i++) {
            UIImageView * contentImageView = [[UIImageView alloc]init];
            [contentImageView sd_setImageWithURL:[NSURL URLWithString:self.model.s_contract_file[i]]];
//            [contentImageView setImage:[UIImage imageNamed:@"222"]];
            contentImageView.alpha = 1;
            contentImageView.backgroundColor = XXJColor(247, 247, 247);
            contentImageView.userInteractionEnabled = YES;
            contentImageView.contentMode = UIViewContentModeScaleAspectFit;
            contentImageView.tag = 30000 + i;
            UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
            [contentImageView addGestureRecognizer:tapGes];
            [imageBackView addSubview:contentImageView];
            [contentImageView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageBackView).offset(H(6) * (i / 3) + width * (i / 3));
                make.left.equalTo(imageBackView).offset(W(6) * (i % 3) + width * (i % 3) + realW(40));
                make.size.equalTo(CGSizeMake(width, width));
            }];
        }
    }
    
    
    UILabel * huozhuHetongLable = [UILabel lableWithTextColor:XXJColor(158, 158, 158) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"货主合同"];
    [huozhuHetongLable sizeToFit];
    [bottomView addSubview:huozhuHetongLable];
    [huozhuHetongLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(realW(40));
        make.top.equalTo(imageBackView.bottom).offset(realH(10));
    }];
    
    height += realH(34) + realH(10);
    
    UIView * imageBackView2 = [[UIView alloc]init];
    imageBackView2.backgroundColor = [UIColor whiteColor];
    imageBackView2.clipsToBounds = YES;
    [bottomView addSubview:imageBackView2];
    [imageBackView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
        make.top.equalTo(huozhuHetongLable.bottom).offset(realH(20));
        make.width.equalTo(SCREEN_WIDTH);
//        make.height.equalTo(100);
        if (![self.model.c_contract_file isEqual:[NSNull null]]) {
            
            CGFloat y = self.model.c_contract_file.count % 3;
            if (y == 0) {
                y = 0;
            }
            else
            {
                y = 1;
            }
            
            make.height.equalTo(width * ((self.model.c_contract_file.count / 3) + y) + realH(12) * ((self.model.c_contract_file.count / 3) + y - 1));
        }
        else
        {
            make.height.equalTo(0);
        }
        
    }];
    self.imageBackView2 = imageBackView2;
    
    if (![self.model.c_contract_file isEqual:[NSNull null]]) {
        
        CGFloat y = self.model.c_contract_file.count % 3;
        if (y == 0) {
            y = 0;
        }
        else
        {
            y = 1;
        }
        
        
        
        height += width * ((self.model.c_contract_file.count / 3) + y) + realH(12) * ((self.model.c_contract_file.count / 3) + y - 1) + realH(20);
    }

    
    
    if (![self.model.c_contract_file isEqual:[NSNull null]])
    {
       
        
        if (![self.model.c_contract_file isEqual:[NSNull null]]) {
            for (NSInteger i = 0; i < self.model.c_contract_file.count; i++) {
                UIImageView * contentImageView = [[UIImageView alloc]init];
                [contentImageView sd_setImageWithURL:[NSURL URLWithString:self.model.c_contract_file[i]]];
//                contentImageView.alpha = 1;
                contentImageView.backgroundColor = XXJColor(247, 247, 247);
                contentImageView.userInteractionEnabled = YES;
                contentImageView.contentMode = UIViewContentModeScaleAspectFit;
                contentImageView.tag = 40000 + i;
                UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(huozhuimageClick:)];
                [contentImageView addGestureRecognizer:tapGes];
                [imageBackView2 addSubview:contentImageView];
                [contentImageView makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(imageBackView2).offset(H(6) * (i / 3) + width * (i / 3));
                    make.left.equalTo(imageBackView2).offset(W(6) * (i % 3) + width * (i % 3) + realW(40));
                    make.size.equalTo(CGSizeMake(width, width));
                }];
            }
        }
        
    }
    
    
    UILabel * fahuoLable = [UILabel lableWithTextColor:XXJColor(158, 158, 158) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"发货单"];
    [fahuoLable sizeToFit];
    [bottomView addSubview:fahuoLable];
    [fahuoLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(realW(40));
        make.top.equalTo(imageBackView2.bottom).offset(realH(10));
    }];
    
    height += realH(34) + realH(10);
    
    UIImageView * fahuoImageView = [[UIImageView alloc]init];
    [fahuoImageView sd_setImageWithURL:[NSURL URLWithString:self.model.loading_image_url]];
    //                contentImageView.alpha = 1;
    fahuoImageView.backgroundColor = XXJColor(247, 247, 247);
    fahuoImageView.userInteractionEnabled = YES;
    fahuoImageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fahuoImageClick:)];
    [fahuoImageView addGestureRecognizer:tapGes];
    [bottomView addSubview:fahuoImageView];
    [fahuoImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fahuoLable.bottom).offset(realH(20));
        make.left.equalTo(bottomView).offset(realW(40));
//        make.size.equalTo(CGSizeMake(width, width));
        if ([self.model.loading_image_url isEqualToString:@""]) {
            make.size.equalTo(CGSizeMake(width, 0));
        }
        else
        {
            make.size.equalTo(CGSizeMake(width, width));
        }
    }];
    
   
    
    
    UILabel * shouhuoLable = [UILabel lableWithTextColor:XXJColor(158, 158, 158) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"收货单"];
    [shouhuoLable sizeToFit];
    [bottomView addSubview:shouhuoLable];
    [shouhuoLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.centerX);
        make.top.equalTo(imageBackView2.bottom).offset(realH(10));
    }];
    
    height += realH(34) + realH(10);
    
    UIImageView * shouhuoImageView = [[UIImageView alloc]init];
    [shouhuoImageView sd_setImageWithURL:[NSURL URLWithString:self.model.unloading_image_url]];
    //                contentImageView.alpha = 1;
    shouhuoImageView.backgroundColor = XXJColor(247, 247, 247);
    shouhuoImageView.userInteractionEnabled = YES;
    shouhuoImageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer * tapGes1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shouhuoImageClick:)];
    [shouhuoImageView addGestureRecognizer:tapGes1];
    [bottomView addSubview:shouhuoImageView];
    [shouhuoImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shouhuoLable.bottom).offset(realH(20));
        make.left.equalTo(bottomView.centerX);
        if ([self.model.unloading_image_url isEqualToString:@""]) {
            make.size.equalTo(CGSizeMake(width, 0));
        }
        else
        {
            make.size.equalTo(CGSizeMake(width, width));
        }
    }];
    
    
    if (![self.model.loading_image_url isEqualToString:@""]) {
        
        height += width + realH(20);
    }
    else
    {
        if (![self.model.unloading_image_url isEqualToString:@""]) {
            
            height += width + realH(20);
        }
        
    }
    
    
    
    
    UILabel * huozhuPingjiaLable = [UILabel lableWithTextColor:XXJColor(158, 158, 158) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"货主收到评价"];
    [huozhuPingjiaLable sizeToFit];
    [bottomView addSubview:huozhuPingjiaLable];
    [huozhuPingjiaLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(realW(40));
        make.top.equalTo(fahuoImageView.bottom).offset(realH(10));
    }];
    
    height += realH(90) * 2;
    
    // 初始化
    self.tggStarEvaView = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        
    }];
    
    NSUInteger a = 0;
    if ([self.model.confirm_comment_score isEqual:[NSNull null]]) {
        a = 0;
    }
    else
    {
        NSString * s = [self.model.confirm_comment_score componentsSeparatedByString:@"."][0];
        a = [s integerValue];
    }
//    self.tggStarEvaView.starCount = [self.model.confirm_comment_score isEqual:[NSNull null]] ? 0 : [[self.model.confirm_comment_score componentsSeparatedByString:@"."][0] integerValue];
    
    self.tggStarEvaView.starCount = a;
    
    self.tggStarEvaView.userInteractionEnabled = NO;
    [bottomView addSubview:self.tggStarEvaView];
    [self.tggStarEvaView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(huozhuPingjiaLable.right).equalTo(realH(40));
        make.centerY.equalTo(huozhuPingjiaLable);
        make.size.equalTo(CGSizeMake(realW(400), realH(90)));
    }];
    
    
    UILabel * chaundongPingjiaLable = [UILabel lableWithTextColor:XXJColor(158, 158, 158) textFontSize:realFontSize(34) fontFamily:PingFangSc_Regular text:@"船东收到评价"];
    [chaundongPingjiaLable sizeToFit];
    [bottomView addSubview:chaundongPingjiaLable];
    [chaundongPingjiaLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(realW(40));
        make.top.equalTo(huozhuPingjiaLable.bottom).offset(realH(60));
    }];
    
    
    // 初始化
    self.tggStarEvaView1 = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        
    }];
    
    NSUInteger b = 0;
    if ([self.model.req_comment_score isEqual:[NSNull null]]) {
        b = 0;
    }
    else
    {
        NSString * s = [self.model.req_comment_score componentsSeparatedByString:@"."][0];
        b = [s integerValue];
    }

    self.tggStarEvaView1.starCount = b;
//    self.tggStarEvaView1.starCount = [self.model.req_comment_score isEqual:[NSNull null]] ? 0 : [[self.model.confirm_comment_score componentsSeparatedByString:@"."][0] integerValue];
    self.tggStarEvaView1.userInteractionEnabled = NO;
    [bottomView addSubview:self.tggStarEvaView1];
    [self.tggStarEvaView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chaundongPingjiaLable.right).equalTo(realH(40));
        make.centerY.equalTo(chaundongPingjiaLable);
        make.size.equalTo(CGSizeMake(realW(400), realH(90)));
    }];
    
    bottomView.xxj_height = height + realH(40);
    
}

#pragma mark -- 合同图片点击
-(void)imageClick:(UITapGestureRecognizer *)tap
{
    UIImageView * imageView = (UIImageView *)tap.view;
    

    [self HeTongzoomImageView:imageView image:imageView.image Array:self.model.s_contract_file Source:@"船东"];
    
}

#pragma mark -- 货主合同点击
-(void)huozhuimageClick:(UITapGestureRecognizer *)tap
{
    UIImageView * imageView = (UIImageView *)tap.view;


    [self HeTongzoomImageView:imageView image:imageView.image Array:self.model.c_contract_file Source:@"货主"];
}

#pragma mark -- 发货图片点击
-(void)fahuoImageClick:(UITapGestureRecognizer *)tap
{
    UIImageView * imageView = (UIImageView *)tap.view;

    [self zoomImageView:imageView image:imageView.image];
}

#pragma mark -- 收货图片点击
-(void)shouhuoImageClick:(UITapGestureRecognizer *)tap
{
    UIImageView * imageView = (UIImageView *)tap.view;

    [self zoomImageView:imageView image:imageView.image];
}

#pragma mark -- 合同图片放大
-(void)HeTongzoomImageView:(UIImageView *)imageView image:(UIImage *)image Array:(NSArray *)imageArray Source:(NSString *)source
{
    NSMutableArray *photos = [NSMutableArray new];
    
    NSInteger i = 0;
    if ([source isEqualToString:@"船东"]) {
        i = imageView.tag - 30000;
        for (UIImageView * imageNewView in self.imageBackView.subviews) {
            GKPhoto *photo = [GKPhoto new];
            photo.image = imageNewView.image;
            photo.sourceImageView = imageNewView;
//            if (imageNewView.tag == imageView.tag) {
//                photo.image = image;
//                photo.sourceImageView = imageView;
//            }
            
            
            
            [photos addObject:photo];
        }
    }
    else
    {
        i = imageView.tag - 40000;
        for (UIImageView * imageNewView in self.imageBackView2.subviews) {
            GKPhoto *photo = [GKPhoto new];
            photo.image = imageNewView.image;
            photo.sourceImageView = imageNewView;
            
            [photos addObject:photo];
        }
    }
    
    
    
    
    
//    GKPhoto *photo = [GKPhoto new];
//    photo.image = image;
//    photo.sourceImageView = imageView;
//
//    [photos addObject:photo];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:i];
    browser.showStyle           = GKPhotoBrowserShowStyleZoom;
    browser.hideStyle           = GKPhotoBrowserHideStyleZoomScale;
    browser.loadStyle           = GKPhotoBrowserLoadStyleIndeterminateMask;
    
    browser.delegate = self;
    
    [browser showFromVC:self];
}




#pragma mark -- 图片放大
-(void)zoomImageView:(UIImageView *)imageView image:(UIImage *)image
{
    
    
    NSMutableArray *photos = [NSMutableArray new];
    GKPhoto *photo = [GKPhoto new];
    photo.image = image;
    photo.sourceImageView = imageView;
    
    [photos addObject:photo];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:0];
    browser.showStyle           = GKPhotoBrowserShowStyleZoom;
    browser.hideStyle           = GKPhotoBrowserHideStyleZoomScale;
    browser.loadStyle           = GKPhotoBrowserLoadStyleIndeterminateMask;
    
    browser.delegate = self;
    
    [browser showFromVC:self];
}



-(void)buttonClick:(UIButton *)button
{
//    if ([button.currentTitle isEqualToString:@"我要装\n货"]) {
//
//    }
//    else if ([button.currentTitle isEqualToString:@"我已装\n货"])
//    {
//
//    }
//    else if ([button.currentTitle isEqualToString:@"我已卸\n货"])
//    {
//
//    }
//    else if ([button.currentTitle isEqualToString:@"评价货\n主"])
//    {
//
//    }
//    else if ([button.currentTitle isEqualToString:@"致电货\n主"])
//    {
    
    if ([button.currentTitle isEqualToString:@"致电货主"]) {
        [self phoneCall:self.model.c_mobile];
    }
    else
    {
        [self phoneCall:self.model.s_mobile];
    }
    
//    }
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    else if (section == 1)
    {
        return 13;
    }
    else
    {
        return 5;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * titleArray1 = @[@"运单编号:",@"承运价格:"];
    
    NSArray * titleArray2 = @[@"货物类型:",@"货物重量:",@"起运港:",@"目的港:",@"受载期:",@"交接方式",@"合理损耗:",@"装卸作业时间:",@"滞期费用:",@"履约保证金:",@"结算方式:",@"付款方式:",@"包含费用:"];
    
    NSArray * titleArray3 = @[@"船舶名称",@"船舶类型",@"参考载重",@"船舶舱容",@"船舶属性",@"建造年份"];
    
    NSArray * detailArray1 = nil;
    NSArray * detailArray2 = nil;
    NSArray * detailArray3 = nil;
    if (self.model) {
        detailArray1 = @[
                         self.model.deal_no,
                         [NSString stringWithFormat:@"%@元/吨",self.model.first_money]
                         ];
        detailArray2 = @[
                         self.model.cargo_type_name == nil ? @"未设置" : self.model.cargo_type_name,
                         [NSString stringWithFormat:@"%@吨 ±%@%@",self.model.weight,self.model.weight_num,@"%"],
                         self.model.b_port,
                         self.model.e_port,
                         [NSString stringWithFormat:@"%@至%@",[TYDateUtils timestampSwitchTime:[self.model.b_time integerValue]],[TYDateUtils timestampSwitchTime:[self.model.e_time integerValue]]],
                         [NSString stringWithFormat:@"起运港 %@    目的港 %@",self.model.b_hand_type,self.model.e_hand_type],
                         [NSString stringWithFormat:@"%@‰",self.model.loss],
                         [NSString stringWithFormat:@"%@天",self.model.dock_day],
                         [NSString stringWithFormat:@"%@%@",self.model.demurrage,self.model.demurrage_unit],
                         [self.model.bond isEqualToString:@"0"] ? @"无需支付" : @"双方支付",
                         [self.model.pay_type isEqualToString:@"0"] ? @"线下结算" : @"平台结算",
                         self.model.freight_show,
                         self.model.contain_price
                         ];
        
        detailArray3 = @[
                         self.model.name,
                         self.model.ship_type_name,
                         [NSString stringWithFormat:@"%@ 吨",self.model.deadweight],
                         [NSString stringWithFormat:@"%@立方米",self.model.storage],
                         [NSString stringWithFormat:@"船长:%@米 船宽:%@米 满载吃水:%@米",self.model.length,self.model.width,self.model.draught],
                         [TYDateUtils timestampSwitchTime:[self.model.complete_time integerValue]]
                         ];
    }
    
    
    
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            DetailTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTopTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
            DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titlelable.text = titleArray1[indexPath.row - 1];
            
            cell.detailLable.text = detailArray1[indexPath.row - 1];
            
            if (indexPath.row == 1) {
                cell.typeLable.alpha = 1;
                cell.typeLable.text = self.model.status_name;
            }
            else
            {
                cell.typeLable.alpha = 0;
            }
            
            return cell;
        }
        
    }
    else
    {
        DetailNumTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailNumTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeLable.alpha = 0;
        if (indexPath.section == 1) {
            cell.titlelable.text = titleArray2[indexPath.row];
            cell.detailLable.text = detailArray2[indexPath.row];
        }
        else
        {
            cell.titlelable.text = titleArray3[indexPath.row];
            cell.detailLable.text = detailArray3[indexPath.row];
        }
        
        return cell;
    }
    
    
}

#pragma mark -- 运单详情
-(void)detailrequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"cargo_id\":\"%@\",\"access_token\":\"%@\"",self.cargo_id,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:TransportDetail URLMethod:TransportDetailMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        self.model = [TrainDetailModel mj_objectWithKeyValues:result[@"result"][@"info"]];
        
        [self setUpUI];
        
//        [self.tableView reloadData];
        
        XXJLog(@"%@",result)
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}





#pragma mark -- 打电话
-(void)phoneCall:(NSString *)phone
{

    
    __weak typeof(self) weakSelf = self;
    
    
    if ([[UseInfo shareInfo].nameApprove isEqualToString:@"认证通过"])
    {
        if ([[UseInfo shareInfo].companyApprove isEqualToString:@"认证通过"]) {
            //打电话
//            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
//            UIWebView * callWebview = [[UIWebView alloc] init];
//            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//            [self.view addSubview:callWebview];
            
            [self checkPhone:phone];
            
            return;
        }
        else
        {
            //判断加入的公司
            if ([[UseInfo shareInfo].joinCompanyApprove isEqualToString:@"认证通过"])
            {
                //打电话
//                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
//                UIWebView * callWebview = [[UIWebView alloc] init];
//                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//                [self.view addSubview:callWebview];
                
                [self checkPhone:phone];
                
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
        
        ChooseApproveViewController * approveVc = [[ChooseApproveViewController alloc]init];
        approveVc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:approveVc animated:YES];
        
    }];
    [alertController addAction:rubbishAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}


#pragma mark - ************************************************ (监听电话相关)
-(void)phoneCall
{
    
    int event = 0;
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
        event = 5;
    }
    else
    {
        event = 4;
    }
    
    HLPhoneInfoController * vc = [[HLPhoneInfoController alloc]init];
    vc.logId = [self.log_id integerValue];
    vc.appLogEvent = event;
    
    vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
    
//    UIView * coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    coverView.backgroundColor = [UIColor blackColor];
//    coverView.alpha = 0.4;
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:coverView];
//    self.coverView = coverView;
//    
//    __weak typeof(self) weakSelf = self;
//    PhoneFeedbackView * feedView = [[PhoneFeedbackView alloc]init];
//    feedView.feedBlock = ^(NSString *s) {
//        if ([s isEqualToString:@"取消"]) {
//            
//            
//            [weakSelf.coverView removeFromSuperview];
//            
//            [weakSelf.feedView removeFromSuperview];
//            weakSelf.coverView = nil;
//            weakSelf.feedView = nil;
//            
//            
//        }
//        else
//        {
//            [self feedbackRequest:s];
//        }
//        
//    };
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:feedView];
//    [feedView makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - realW(150), SCREEN_WIDTH  - realW(140)));
//        make.centerX.centerY.equalTo([[[UIApplication sharedApplication] delegate] window]);
//    }];
//    self.feedView = feedView;
    
    
    
    
    
    
    
    
    
    
    
}



#pragma mark -- 电话反馈
-(void)checkPhone:(NSString *)phone
{
    NSInteger event = 0;
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
        event = 5;
    }
    else
    {
        event = 4;
    }
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"device\":\"%@\",\"access_token\":\"%@\",\"channel\":\"%i\",\"event\":\"%li\",\"error\":\"%i\",\"obj\":\"%@\"",[[[UIDevice currentDevice] identifierForVendor] UUIDString],[UseInfo shareInfo].access_token,0,(long)event,0,self.model.cargo_id];
    
    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:AddAppLogMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result);
        
        NSDictionary * boatresult = result;
        
        if ([boatresult[@"result"][@"status"] boolValue]) {
            self.log_id = boatresult[@"result"][@"id"];
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
            
        }
        else
        {
            [self.view makeToast:boatresult[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter];
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}


//#pragma mark -- 获取反馈列表
//-(void)getFeedRemarkList
//{
//    NSInteger event = 0;
//    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
//        event = 5;
//    }
//    else
//    {
//        event = 4;
//    }
//    
//    NSString *parameterstring = [NSString stringWithFormat:@"\"event\":\"%ld\"",(long)event];
//    
//    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:GetAppLogRemarkMethod parameters:parameterstring finished:^(id result) {
//        [SVProgressHUD dismiss];
//        XXJLog(@"%@",result);
//        
//        NSDictionary * boatresult = result;
//        
//        if ([boatresult[@"result"][@"status"] boolValue]) {
//            //            NSArray * lsitArray = boatresult[@"result"][@"data"];
//        }
//        
//    } errored:^(NSError *error) {
//        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
//        
//        [SVProgressHUD dismiss];
//    }];
//}
//
//
//
//
//#pragma mark -- 反馈
//-(void)feedbackRequest:(NSString *)s
//{
//    
//    [SVProgressHUD show];
//    //deal_id  运单id  access_token  score 评价分数
//    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"log_id\":\"%ld\",\"remark\":\"%@\"",[UseInfo shareInfo].access_token,(long)self.log_id,s];
//    
//    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:FeedBackMethod parameters:parameterstring finished:^(id result) {
//        [SVProgressHUD dismiss];
//        XXJLog(@"%@",result);
//        
//        NSDictionary * boatresult = result;
//        
//        if ([boatresult[@"result"][@"status"] boolValue]) {
//            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"提交成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
////                [GKCover hide];
//                
//                [self.coverView removeFromSuperview];
//                [self.feedView removeFromSuperview];
//                self.coverView = nil;
//                self.feedView = nil;
//                
//            }];
//        }
//        else
//        {
//            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"提交失败，请重试" duration:0.5 position:CSToastPositionCenter];
//        }
//        
//    } errored:^(NSError *error) {
//        [[[[UIApplication sharedApplication] delegate] window] makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
//        
//        [SVProgressHUD dismiss];
//    }];
//    
//}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}































@end
