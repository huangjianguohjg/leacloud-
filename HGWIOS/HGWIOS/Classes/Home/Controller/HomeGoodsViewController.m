//
//  HomeGoodsViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "HomeGoodsViewController.h"

#import "GoodsDetailViewController.h"

#import "MyBoatViewController.h"

#import "AddressViewController.h"

#import "MyTransportViewController.h"

#import "HomeGoodsTableViewCell.h"

#import "TopView.h"

#import "HomeGoodsModel.h"

#import "ShaiXuanView.h"

#import "ApproveViewController.h"
#import "ChooseApproveViewController.h"
#import "PhoneFeedbackView.h"
#import "HLPhoneInfoController.h"
@interface HomeGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) ShaiXuanView * shaiView;

//筛选的参数
@property (nonatomic, copy) NSString * weightStr;
@property (nonatomic, copy) NSString * cashStr;
@property (nonatomic, copy) NSString * payStr;

//起运港参数
@property (nonatomic, copy) NSString * b_portID;

@property (nonatomic, weak) TopView * topView;

/** 呼叫中心*/
@property (nonatomic, strong) CTCallCenter *callCenter;

/**
 记录拨打电话的运单ID
 */
@property (nonatomic, copy) NSString * phoneCargo_id;
@property (nonatomic, copy) NSString * log_id;

@property (nonatomic, weak) PhoneFeedbackView * feedView;

@property (nonatomic, weak) UIView * coverView;

@property (nonatomic, weak) UIBezierPath *path;
@property (nonatomic, weak) UIImageView * imageView;

@property (nonatomic, assign) BOOL isTel;

@end

@implementation HomeGoodsViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXJColor(242, 242, 242);
    
    self.isTel = NO;
    self.b_portID = nil;
    self.weightStr = nil;
    self.cashStr = nil;
    self.payStr = nil;
    
    self.page = 1;
    self.max = 20;
    
    [self setUpNav];
    
    [self setUpUI];
    
    [self shuaiXuanView];
    
//    [self getAllUserStatusRequest];
    
    [self monitorTelephoneCall];
    
    if ([[UseInfo shareInfo].firstLogin isEqualToString:@"是"]) {
        [self newGuide];
    }

}

-(void)newGuide
{
    
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    //    // 这里添加第二个路径 （这个是圆）
    ////    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width - 30, 42) radius:30 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    //    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(frame.size.width - 55, 22, 47, 40) cornerRadius:5] bezierPathByReversingPath]];
    
    CGFloat margin = 0;
    if (SCREEN_WIDTH == 414) {
        margin = 10;
    }
    
    [self creatGuideViewPathFrame:CGRectMake(SCREEN_WIDTH - realW(110), kStatusBarHeight + realH(4), realW(94), realH(80)) TitleFrame:CGRectMake(SCREEN_WIDTH - realW(240) + margin, kStatusBarHeight + kNavigationBarHeight + realH(40) - margin, realW(300), realH(120)) TapAction:@selector(sureTapClick:) Title:@"货主发布货物\n信息" ImageViewFrame:CGRectMake(realW(100) + margin, kStatusBarHeight + kNavigationBarHeight - realH(60), realW(600), realH(380)) ImageName:@"报空"];
    
}

-(void)sureTapClick:(UITapGestureRecognizer *)tap
{
    UIView * view = tap.view;
    [view removeFromSuperview];
    
    [view removeGestureRecognizer:tap];
    
    CGFloat margin = 0;
    if (SCREEN_WIDTH == 414) {
        margin = 10;
    }
    
    [self creatGuideViewPathFrame:CGRectMake(realW(20), kStatusBarHeight + realH(4), realW(94), realW(80)) TitleFrame:CGRectMake(realW(60) + margin, kStatusBarHeight + kNavigationBarHeight + realW(50) - margin, realW(300), realW(80)) TapAction:@selector(sureTapClick1:) Title:@"查看运单列表" ImageViewFrame:CGRectMake(realW(30), kStatusBarHeight + kNavigationBarHeight - realH(60), realW(600), realH(380)) ImageName:@"运单"];
    
}

-(void)sureTapClick1:(UITapGestureRecognizer *)tap
{
    UIView * view = tap.view;
    [view removeFromSuperview];
    
    [view removeGestureRecognizer:tap];
    
    CGFloat margin = 0;
    if (SCREEN_WIDTH == 414) {
        margin = 10;
    }
    
    CGFloat bottomMargin = 0;
    if (isIPHONEX) {
        bottomMargin = 34;
    }
    
    //    [self creatGuideViewPathFrame:CGRectMake(SCREEN_WIDTH/2 + realW(40), kStatusBarHeight + kNavigationBarHeight, realW(300), realW(100)) TitleFrame:CGRectMake(SCREEN_WIDTH/2 + realW(100) + margin, kStatusBarHeight + kNavigationBarHeight + realW(100), realW(300), realW(80)) TapAction:@selector(sureTapClick2:) Title:@"条件筛选" ImageViewFrame:CGRectZero ImageName:nil];
    //}
    //
    //-(void)sureTapClick2:(UITapGestureRecognizer *)tap
    //{
    //    UIView * view = tap.view;
    //    [view removeFromSuperview];
    //
    //    [view removeGestureRecognizer:tap];
    
    [self creatGuideViewPathFrame:CGRectMake(realW(550) + margin, SCREEN_HEIGHT - 49 - bottomMargin, 100 - margin , 49) TitleFrame:CGRectMake(realW(430) + margin, SCREEN_HEIGHT - 49 - realH(80 + 80) - bottomMargin, realW(300), realH(120)) TapAction:@selector(sureTapClick3:) Title:@"个人中心信息查看\n实名认证" ImageViewFrame:CGRectMake(realW(80) - margin, SCREEN_HEIGHT - 49 - realH(400) - bottomMargin, realW(600), realH(380)) ImageName:@"个人"];
    
}

-(void)sureTapClick3:(UITapGestureRecognizer *)tap
{
    UIView * view = tap.view;
    [view removeFromSuperview];
    
    [view removeGestureRecognizer:tap];
}

-(void)creatGuideViewPathFrame:(CGRect)pathRect TitleFrame:(CGRect)titleRect TapAction:(SEL)action Title:(NSString *)title ImageViewFrame:(CGRect)imageRect ImageName:(NSString *)imageName
{
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView * bgView = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [bgView addGestureRecognizer:tap1];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:[UIScreen mainScreen].bounds];
    // 这里添加第二个路径 （这个是圆）//CGRectMake(10, 22, 47, 40)
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:5] bezierPathByReversingPath]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    //shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    [bgView.layer setMask:shapeLayer];
    //CGRectMake(10, 72, 100, 40)
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:imageRect];
    imageView.image = [UIImage imageNamed:imageName];
    [bgView addSubview:imageView];
    
    UILabel * titlelable = [UILabel lableWithTextColor:[UIColor whiteColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Medium text:title];
    titlelable.alpha = 0;
    titlelable.numberOfLines = 0;
    [titlelable sizeToFit];
    titlelable.frame = titleRect;
    [bgView addSubview:titlelable];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void)setUpNav
{
    self.navigationItem.title = @"化运网";
    
    self.navigationController.navigationBar.barTintColor = XXJColor(27, 69, 138);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    
    
    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"运单" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    UIButton * rightButton = [[UIButton alloc]init];
    [rightButton addTarget:self action:@selector(rightItem) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"报空" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
}


#pragma mark -- 运单/发货
-(void)leftItem
{
    MyTransportViewController * mytrainsportVc = [[MyTransportViewController alloc]init];
    mytrainsportVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mytrainsportVc animated:YES];
}

-(void)rightItem
{
//    [self newGuide];
    
    MyBoatViewController * boatVc = [[MyBoatViewController alloc]init];
    boatVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:boatVc animated:YES];
}


-(void)shuaiXuanView
{
    __weak typeof(self) weakSelf = self;
    ShaiXuanView * shaiView = [[ShaiXuanView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight + realH(100) + SCREEN_HEIGHT, SCREENWIDTH, SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight - realH(100) - 49)];
    
    shaiView.shaiChooseBlock = ^(NSString *str, NSString *weightStr, NSString *cashStr, NSString *payStr, NSString *typeStr) {
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.shaiView.xxj_y = kStatusBarHeight + kNavigationBarHeight + realH(100 ) + SCREEN_HEIGHT;
        }];
        
        
        if ([str isEqualToString:@"确 定"])
        {
            weakSelf.weightStr = [weightStr isEqualToString:@"不限"] || weightStr == nil ? @"" : weightStr;
            weakSelf.cashStr = [cashStr isEqualToString:@"不限"] || cashStr == nil ? @"" : cashStr;
            weakSelf.payStr = [payStr isEqualToString:@"不限"] || payStr == nil ? @"" : payStr;
            
            [weakSelf.tableView.mj_header beginRefreshing];
        }
    };
    [shaiView setFromTag:@"找货" Array:nil];
    [self.view addSubview:shaiView];
    self.shaiView = shaiView;
}

#pragma mark -- 界面初始化
-(void)setUpUI
{
    __weak typeof(self) weakSelf = self;
    TopView * topView = [[TopView alloc]init];
    topView.title = @"起运港";
    topView.topblock = ^(NSString *s) {
        if ([s isEqualToString:weakSelf.topView.leftButton.currentTitle]) {
            XXJLog(@"起运港")
            AddressViewController * addressVc = [[AddressViewController alloc]init];
            addressVc.addressBackBlock = ^(NSString *addressID, NSString *addressStr, NSString *parentProID,NSString * address_Str) {
                
                if ([addressStr isEqualToString:@"空载港"]) {
                    
                    weakSelf.b_portID = @"";
                }
                else
                {
                    weakSelf.b_portID = [addressID componentsSeparatedByString:@"-"][1];
                }
                
                [weakSelf.topView changeTitle:addressStr];
                
                [weakSelf.tableView.mj_header beginRefreshing];
            };
            addressVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:addressVc animated:YES];
        }
        else if ([s isEqualToString:@"筛选"])
        {
            XXJLog(@"筛选")
            if (weakSelf.shaiView.xxj_y > 300) {
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.shaiView.xxj_y = kStatusBarHeight + kNavigationBarHeight + realH(100);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.shaiView.xxj_y = kStatusBarHeight + kNavigationBarHeight + realH(100) + SCREEN_HEIGHT;
                }];
            }
            
            
            
        }
    };
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    self.topView = topView;
    
    
    UITableView * tableView = [[UITableView alloc]init];
    tableView.backgroundColor = XXJColor(242, 242, 242);
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 200;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[HomeGoodsTableViewCell class] forCellReuseIdentifier:@"HomeGoodsTableViewCell"];
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.bottom);
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        self.max = 20;
        [self.dataArray removeAllObjects];
        [self findGoodsRequest];
        
        [self getUserInfo];
        [self selfCompanyStatus];
        [self joinCompanyStatus];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page += 1;
        [self findGoodsRequest];
    }];
    
    [tableView.mj_header beginRefreshing];
    
    self.tableView = tableView;
}




#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    HomeGoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeGoodsTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HomeGoodsModel * model = self.dataArray[indexPath.row];
    
    cell.model = self.dataArray[indexPath.row];
    
    cell.phoneBlock = ^(NSString *phoneNum) {
        
        weakSelf.phoneCargo_id = model.cargo_id;
        
        //打电话
        [weakSelf phoneCall:phoneNum];
   
    };
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController * goodsDetailVc = [[GoodsDetailViewController alloc] init];
    goodsDetailVc.fromTag = @"找货";
    goodsDetailVc.hidesBottomBarWhenPushed = YES;
    HomeGoodsModel * model = self.dataArray[indexPath.row];
    goodsDetailVc.idStr = model.cargo_id;
    goodsDetailVc.offerVCModel = model;
    goodsDetailVc.cargo_Type = model.cargo_type_name;
    goodsDetailVc.freight_name = model.freight_name;
    
    goodsDetailVc.deliver_count = model.deliver_count;
    goodsDetailVc.negotia = model.negotia;
    
    [self.navigationController pushViewController:goodsDetailVc animated:YES];
    
}



#pragma mark -- 找货请求
-(void)findGoodsRequest
{
    NSString *parameterstring = nil;

    if (self.weightStr.length <= 0) {
        self.weightStr = @"";
    }
    
    if (self.cashStr.length <= 0) {
        self.cashStr = @"";
    }
    
    if (self.payStr.length <= 0) {
        self.payStr = @"";
    }
    
    if (self.b_portID.length <= 0) {
        self.b_portID = @"";
    }
    
    parameterstring = [NSString stringWithFormat:@"\"b_port\":\"%@\",\"e_port\":\"\",\"weight\":\"%@\",\"valid_day\":\"\",\"pay_type\":\"%@\",\"bond\":\"%@\",\"max\":\"%lu\",\"page\":\"%lu\",\"access_token\":\"%@\"",self.b_portID,self.weightStr,self.payStr,self.cashStr,(unsigned long)self.max,(unsigned long)self.page,[UseInfo shareInfo].access_token];
    
    
//    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:FindGoods URLMethod:FindGoodsMethod parameters:parameterstring finished:^(id result) {
//        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result isEqual:[NSNull null]] || result == nil || [result[@"result"] isEqual:[NSNull null]]) {
            if (self.dataArray.count > 0) {
                [self.view makeToast:@"暂无更多数据" duration:1.0 position:CSToastPositionCenter];
            }
            else
            {
                [self.view makeToast:@"暂无数据" duration:1.0 position:CSToastPositionCenter];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
        NSArray * listArray = resultDict[@"result"][@"list"];
        
        if ([listArray isEqual:[NSNull null]]) {
            if (self.dataArray.count > 0) {
                [self.view makeToast:@"暂无更多数据" duration:1.0 position:CSToastPositionCenter];
            }
            else
            {
                [self.view makeToast:@"暂无数据" duration:1.0 position:CSToastPositionCenter];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
       
        for (NSDictionary * modelDict in listArray) {
            
            HomeGoodsModel * model = [HomeGoodsModel mj_objectWithKeyValues:modelDict];
            if ([model.show isEqualToString:@"1"]) {
                [self.dataArray addObject:model];
            }
            
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
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
/**
 监听电话介入
 */
- (void)monitorTelephoneCall {
    __weak typeof(self) weakSelf = self;

    // MsgAppStarting
    // MsgAppReactivate
    _callCenter = [[CTCallCenter alloc] init];
    _callCenter.callEventHandler = ^(CTCall * call) {
        if ([call.callState isEqualToString:CTCallStateDisconnected]) {// Call has been disconnected
            NSLog(@"电话 --- 断开连接");

            dispatch_async(dispatch_get_main_queue(), ^{
                UIViewController * viewControllerNow = [weakSelf currentViewController];
                if (![viewControllerNow  isKindOfClass:[HomeGoodsViewController class]]) {   //如果不是页面XXX，则执行下面语句
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneCall" object:nil];
                }
                else
                {
                    
                    HLPhoneInfoController * vc = [[HLPhoneInfoController alloc]init];
                    vc.logId = [weakSelf.log_id integerValue];
                    vc.appLogEvent = 5;
                    
                    vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
                    
                    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    
                    [weakSelf presentViewController:vc animated:YES completion:nil];
                    
                    
//                    UIView * coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//                    coverView.backgroundColor = [UIColor blackColor];
//                    coverView.alpha = 0.4;
//                    [weakSelf.view addSubview:coverView];
//                    weakSelf.coverView = coverView;
//
//                    //                    __weak typeof(self) weakSelf = self;
//                    PhoneFeedbackView * feedView = [[PhoneFeedbackView alloc]init];
//                    feedView.feedBlock = ^(NSString *s) {
//                        if ([s isEqualToString:@"取消"]) {
//
//
//                            [weakSelf.coverView removeFromSuperview];
//
//                            [weakSelf.feedView removeFromSuperview];
//                            weakSelf.coverView = nil;
//                            weakSelf.feedView = nil;
//
//
//                        }
//                        else
//                        {
//                            [weakSelf feedbackRequest:s];
//                        }
//
//                    };
//                    [weakSelf.view addSubview:feedView];
//                    [feedView makeConstraints:^(MASConstraintMaker *make) {
//                        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - realW(150), SCREEN_WIDTH  - realW(140)));
//                        make.centerX.centerY.equalTo(weakSelf.view);
//                    }];
//                    weakSelf.feedView = feedView;
                }


            });

        }
        else if ([call.callState isEqualToString:CTCallStateConnected]) {// Call has just been connected
            NSLog(@"电话 --- 接通");
            // 通知 H5 当前截屏操作
            dispatch_async(dispatch_get_main_queue(), ^{
                // do somethings


            });

        }
        else if ([call.callState isEqualToString:CTCallStateIncoming]) {// Call is incoming
            NSLog(@"电话 --- 待接通");
        }
        else if ([call.callState isEqualToString:CTCallStateDialing]) {// Call is Dialing
            NSLog(@"电话 --- 拨号中");
            // 通知 H5 当前截屏操作
            dispatch_async(dispatch_get_main_queue(), ^{

                //                [weakSelf getFeedRemarkList];

            });

        }
        else {// Nothing is done"
            NSLog(@"电话 --- 无操作");
        }
    };
}



-(UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
    
}

-(UIViewController*) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
    
}


#pragma mark -- 电话反馈
-(void)checkPhone:(NSString *)phone
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"device\":\"%@\",\"access_token\":\"%@\",\"channel\":\"%i\",\"event\":\"%i\",\"error\":\"%i\",\"obj\":\"%@\"",[[[UIDevice currentDevice] identifierForVendor] UUIDString],[UseInfo shareInfo].access_token,0,5,0,self.phoneCargo_id];
    
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
//            _isTel = [[UIApplication sharedApplication] openURL:[NSURL URLWithString: str]];
//            XXJLog(@"%d",_isTel)
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
//    NSString *parameterstring = [NSString stringWithFormat:@"\"event\":\"%d\"",5];
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
//            [self.view makeToast:@"提交成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
////                [GKCover hide];
//                
//                [self.coverView removeFromSuperview];
//                
//                [self.feedView removeFromSuperview];
//                self.coverView = nil;
//                self.feedView = nil;
//                
//            }];
//        }
//        else
//        {
//            [self.view makeToast:@"提交失败，请重试" duration:0.5 position:CSToastPositionCenter];
//        }
//        
//    } errored:^(NSError *error) {
//        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
//        
//        [SVProgressHUD dismiss];
//    }];
//    
//}








#pragma mark -- 获取用户所有认证状态
-(void)getAllUserStatusRequest
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetUserAllStatus URLMethod:GetUserAllStatusMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"] isEqual:[NSNull null]]) {
            return ;
        }
        
        if ([result[@"result"][@"status"] boolValue]) {
            NSDictionary * authDict = result[@"result"][@"auth"];
            
            //0=>未认证，1=>待审核， 2=>认证通过，3=>认证失败
            NSString * str = nil;
            if ([authDict[@"u_review"] isEqualToString:@"0"]) {
                //实名认证
                str = @"未认证";
            }
            else if ([authDict[@"u_review"] isEqualToString:@"1"])
            {
                str = @"待审核";
            }
            else if ([authDict[@"u_review"] isEqualToString:@"2"])
            {
                str = @"认证通过";
            }
            else
            {
                str = @"认证失败";
            }
            
            [UseInfo shareInfo].nameApprove = str;
            
            
            if ([authDict[@"s_review"] isEqualToString:@"0"]) {
                //船舶认证
            }
            else if ([authDict[@"s_review"] isEqualToString:@"1"])
            {
                
            }
            else if ([authDict[@"s_review"] isEqualToString:@"2"])
            {
                
            }
            else
            {
                
            }
            
            if ([authDict[@"e_review"] isEqualToString:@"0"]) {
                //企业认证
                str = @"未认证";
            }
            else if ([authDict[@"e_review"] isEqualToString:@"1"])
            {
                str = @"待审核";
            }
            else if ([authDict[@"e_review"] isEqualToString:@"2"])
            {
                str = @"认证通过";
            }
            else
            {
                str = @"认证失败";
            }
            [UseInfo shareInfo].companyApprove = str;;
            
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}




#pragma mark -- 获取用户实名认证
-(void)getUserInfo
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    
    [XXJNetManager requestPOSTURLString:GetUserInfo URLMethod:GetUserInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        if ([result[@"result"][@"status"] boolValue]) {
            NSDictionary * infoDict = result[@"result"][@"users_authentication"];
            
            if (![infoDict isEqual:[NSNull null]]) {
                
                
                
                if ([infoDict[@"review"] isEqual:@1]) {
                    //待审核
                    [UseInfo shareInfo].nameApprove = @"待审核";
                }
                else if ([infoDict[@"review"] isEqual:@2])
                {
                    //已认证 通过
                    
                    [UseInfo shareInfo].nameApprove = @"认证通过";
                }
                else
                {
                    //未认证
                    [UseInfo shareInfo].nameApprove = @"未认证";
                }
            }
            
            
        }
        else
        {
            [self.view makeToast:@"获取实名认证信息失败" duration:0.5 position:CSToastPositionCenter];
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}




#pragma mark -- 获取用户企业认证信息（自己的企业认证）
-(void)selfCompanyStatus
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetCompanyInfo URLMethod:GetCompanyInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            
            if ([result[@"result"][@"status"] boolValue]) {
                NSDictionary * infoDict = result[@"result"][@"enterprise"];
                
                if (infoDict != nil) {
                    
                    
                    
                    if ([infoDict[@"review"] isEqualToString:@"1"]) {
                        //待审核
                        [UseInfo shareInfo].companyApprove = @"待审核";
                        
                    }
                    else if ([infoDict[@"review"] isEqualToString:@"2"])
                    {
                        //成功
                        [UseInfo shareInfo].companyApprove = @"认证通过";
                        
                    }
                    else if ([infoDict[@"review"] isEqualToString:@"3"])
                    {
                        //失败
                        [UseInfo shareInfo].companyApprove = @"未认证";
                    }
                }
            }
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}

//加入的企业的认证信息
-(void)joinCompanyStatus
{
    
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetCompanyStatus URLMethod:GetCompanyStatusMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result);
        
        if ([result[@"result"][@"status"] boolValue]) {
            
//            NSDictionary * dataDict = result[@"result"][@"data"];
            
            [UseInfo shareInfo].joinCompanyApprove = @"认证通过";
        }
        else
        {
            [UseInfo shareInfo].joinCompanyApprove = @"认证未通过";
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}

















@end
