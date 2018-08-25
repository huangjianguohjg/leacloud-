//
//  MyInsurancesController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "MyInsurancesController.h"
#import "RefreshModel.h"

#import "GrayLine.h"
#import "InsuranceModel.h"
#import "UnPayViewCell.h"
#import "PayViewCell.h"
#import "InsuranceConfirmController.h"
#import "BaoxianViewController.h"
#import "InsurancePictureController.h"
#import "BaoxianViewController.h"
@interface MyInsurancesController (){
    NSString *identifier;
    UILabel *unPayLabel;
    UIView *unPayBlueView;
    
    UILabel *PayLabel;
    UIView *PayBlueView;
    
    RefreshModel *unPayList;
    RefreshModel *payList;
    
    //已支付
    UIView *payView;
    UIView *paynodata;
    
    //未支付
    UIView *unPayView;
    UIView *UnPayNodata;
}

@end

@implementation MyInsurancesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    
    [self setUpNav];
    
    [self setUpUI];
    
    
    
}


-(void)setUpNav
{
    self.navigationItem.title = @"我的保单";
    
    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"arrow-appbar-left"] forState:UIControlStateNormal];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    
    if (!self.isInputOneVc) {
        UIButton * rightButton = [[UIButton alloc]init];
        [rightButton addTarget:self action:@selector(rightItem) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:@"我要投保" forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
        [rightButton sizeToFit];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    }
    
    
}

-(void)leftItem
{
    if (self.isInputOneVc) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


-(void)rightItem
{
    BaoxianViewController * baoxianVc = [[BaoxianViewController alloc]init];
    baoxianVc.hidesBottomBarWhenPushed = YES;
    baoxianVc.isServeVC = NO;
    [self.navigationController pushViewController:baoxianVc animated:YES];
}


-(void)setUpUI
{
    
    unPayList = [[RefreshModel alloc]init];
    payList  = [[RefreshModel alloc]init];
    [self initView];
    
    unPayList.pageSize = 10;
    unPayList.pageIndex = 1;
    
    payList.pageSize = 10;
    payList.pageIndex = 1;
    
    //加载已支付
    [self showPayList];
    //加载未支付
    [self showUpPayList];
    
    [self setOnSelectedView:upPayStyle];
    
    
    
    
    
    
    
}



-(void)initView{
    identifier = @"cell";
    //标题
    self.view.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
//    UIView *head = [self setHeadTitle:@"我的保单"];
//    [self.view addSubview:head];
    
    int titleHeight = 45;
    UIView *flowCategoryView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREEN_WIDTH, titleHeight)];
    flowCategoryView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview:flowCategoryView];
    //未支付
    UIView *wifiFlow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, flowCategoryView.gjcf_width/2, flowCategoryView.gjcf_height)];
    [flowCategoryView addSubview:wifiFlow];
    
    UITapGestureRecognizer *wifiGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upPayViewClick:)];
    wifiGesture.numberOfTapsRequired=1;
    [wifiFlow addGestureRecognizer:wifiGesture];
    //文字
    unPayLabel = [[UILabel alloc]initWithFrame:CGRectMake(wifiFlow.gjcf_width/5, 0, wifiFlow.gjcf_width*3/5, wifiFlow.gjcf_height)];
    [wifiFlow addSubview:unPayLabel];
    unPayLabel.text = @"未提交";
    unPayLabel.font = [CommonFontColorStyle NormalSizeFont];
    unPayLabel.textColor = [CommonFontColorStyle BlueColor];
    unPayLabel.textAlignment = NSTextAlignmentCenter;
    //下面蓝色
    unPayBlueView = [[UIView alloc]initWithFrame:CGRectMake(0, (flowCategoryView.gjcf_height-1), wifiFlow.gjcf_width, 1)];
    unPayBlueView.backgroundColor = XXJColor(27, 69, 138);
    [wifiFlow addSubview:unPayBlueView];
    
    //支付
    UIView *shulineView = [[UIView alloc]initWithFrame:CGRectMake(wifiFlow.gjcf_right, 0, 1, wifiFlow.gjcf_height)];
    shulineView.backgroundColor = [CommonFontColorStyle E2E5ECColor];
    [flowCategoryView addSubview:shulineView];
    
    //支付
    UIView *monitorFlow = [[UIView alloc]initWithFrame:CGRectMake(shulineView.gjcf_right, 0, flowCategoryView.gjcf_width/2, flowCategoryView.gjcf_height)];
    [flowCategoryView addSubview:monitorFlow];
    
    UITapGestureRecognizer *monitorGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payViewClick:)];
    monitorGesture.numberOfTapsRequired=1;
    [monitorFlow addGestureRecognizer:monitorGesture];
    //文字
    PayLabel = [[UILabel alloc]initWithFrame:CGRectMake(monitorFlow.gjcf_width/5, 0, monitorFlow.gjcf_width*3/5, monitorFlow.gjcf_height)];
    [monitorFlow addSubview:PayLabel];
    PayLabel.text = @"审核状态";
    PayLabel.font = [CommonFontColorStyle NormalSizeFont];
    PayLabel.textColor = [CommonFontColorStyle BlueColor];
    PayLabel.textAlignment = NSTextAlignmentCenter;
    //下面蓝色
    PayBlueView = [[UIView alloc]initWithFrame:CGRectMake(0, (flowCategoryView.gjcf_height-1), monitorFlow.gjcf_width, 1)];
    PayBlueView.backgroundColor = XXJColor(32, 73, 133);
    [monitorFlow addSubview:PayBlueView];
    
    GrayLine* GrayLine20 = [[GrayLine alloc]initWithFrame:CGRectMake(0, flowCategoryView.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle E2E5ECColor]];
    [self.view addSubview:GrayLine20];
    
    //未支付
    unPayView = [[UIView alloc]initWithFrame:CGRectMake(0, (GrayLine20.gjcf_bottom + [CommonDimensStyle smallMargin]), SCREEN_WIDTH, (SCREEN_HEIGHT-flowCategoryView.gjcf_bottom) - 10)];
    [self.view addSubview:unPayView];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0.0f;
    self.UnPayCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, unPayView.gjcf_width, unPayView.gjcf_height) collectionViewLayout:flowLayout];
    self.UnPayCollectionView.tag =1;
    
    //注册单元格
    [self.UnPayCollectionView registerClass:[UnPayViewCell class]forCellWithReuseIdentifier:identifier];
    self.UnPayCollectionView.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    
    //设置代理
    self.UnPayCollectionView.delegate = self;
    
    self.UnPayCollectionView.dataSource = self;
    
    [unPayView addSubview:self.UnPayCollectionView];
    
    //没有搜索结果
    UnPayNodata = [[UIView alloc]initWithFrame:unPayView.frame];
    [unPayView addSubview: UnPayNodata];
    UnPayNodata.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    UIImageView *UnPaynodataImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 50, 80, 80)];
    UnPaynodataImage.image = [UIImage imageNamed:@"ser_pic_data"];
    [UnPayNodata addSubview:UnPaynodataImage];
    
    UILabel *unpaynodataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (UnPaynodataImage.gjcf_bottom+17), SCREEN_WIDTH, 20)];
    unpaynodataLabel.text = @"暂时没有保单记录";
    unpaynodataLabel.textColor = [CommonFontColorStyle FontSecondColor];
    unpaynodataLabel.font = [CommonFontColorStyle NormalSizeFont];
    unpaynodataLabel.textAlignment = NSTextAlignmentCenter;
    [UnPayNodata addSubview:unpaynodataLabel];
    UnPayNodata.hidden = YES;
    
    
    //已支付
    payView = [[UIView alloc]initWithFrame:CGRectMake(0, (GrayLine20.gjcf_bottom + [CommonDimensStyle smallMargin]), SCREEN_WIDTH, (SCREEN_HEIGHT -flowCategoryView.gjcf_bottom - 10))];
    [self.view addSubview:payView];
    
    //     EqualSpaceFlowLayout *payflowLayout = [[EqualSpaceFlowLayout alloc] init];
    //    payflowLayout.delegate = self;
    
    UICollectionViewFlowLayout * payflowLayout =[[UICollectionViewFlowLayout alloc] init];
    
    [payflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    payflowLayout.minimumLineSpacing = 0.0f;
    
    self.PayCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, payView.gjcf_width, payView.gjcf_height)collectionViewLayout:payflowLayout];
    self.PayCollectionView.tag =2;
    
    //注册单元格
    [self.PayCollectionView registerClass:[PayViewCell class]forCellWithReuseIdentifier:identifier];
    self.PayCollectionView.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    
    //设置代理
    self.PayCollectionView.delegate = self;
    
    self.PayCollectionView.dataSource = self;
    
    [payView addSubview:self.PayCollectionView];
    
    //没有搜索结果
    paynodata = [[UIView alloc]initWithFrame:payView.frame];
    [payView addSubview: paynodata];
    paynodata.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    UIImageView *nodataImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 50, 80, 80)];
    nodataImage.image = [UIImage imageNamed:@"ser_pic_data"];
    [paynodata addSubview:nodataImage];
    
    UILabel *nodataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (nodataImage.gjcf_bottom+17), SCREEN_WIDTH, 20)];
    nodataLabel.text = @"暂时没有保单记录";
    nodataLabel.textColor = [CommonFontColorStyle FontSecondColor];
    nodataLabel.font = [CommonFontColorStyle NormalSizeFont];
    nodataLabel.textAlignment = NSTextAlignmentCenter;
    [paynodata addSubview:nodataLabel];
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets top = {0,0,0,0};
    return top;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//每个分区上得元素个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1) {
        return unPayList.datas.count;
    }else{
        return payList.datas.count;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        return CGSizeMake(SCREEN_WIDTH, 228);
    }else  {
        
        InsuranceModel *insuranceModel =((InsuranceModel *)payList.datas[indexPath.row]);
        if([insuranceModel.status isEqualToString:@"2"]){
            return CGSizeMake(SCREEN_WIDTH, 225);
        }else{
            return CGSizeMake(SCREEN_WIDTH, 315 - 45 - 45);
        }
    }
    
}
//设置元素内容
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        UnPayViewCell *unPayViewCell = (UnPayViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        InsuranceModel *insuranceModel =((InsuranceModel *)unPayList.datas[indexPath.row]);
        NSString *trank = @"";
        NSString *fromLoc = [GJCFStringUitil stringIsNull:insuranceModel.from_loc]?@"":insuranceModel.from_loc;
        NSString *toLoc = [GJCFStringUitil stringIsNull:insuranceModel.to_loc]?@"":insuranceModel.to_loc;
        if (![GJCFStringUitil stringIsNull:fromLoc] || ![GJCFStringUitil stringIsNull:toLoc]) {
            trank = [NSString stringWithFormat:@"%@ 至 %@",fromLoc,toLoc];
        }
        if ([insuranceModel.status isEqualToString:@"0"]) {
            [unPayViewCell initContent:insuranceModel.insurance ShipName:insuranceModel.ship_name DepartureDate:insuranceModel.departure_date_show BoatTrank:trank Baofei:insuranceModel.insured_fee Kuaidi:insuranceModel.invoice_fee Id:insuranceModel.id];
        }
        
        
        UITapGestureRecognizer *editGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editClick:)];
        editGesture.numberOfTapsRequired=1;
        [unPayViewCell.editView addGestureRecognizer:editGesture];
        
        UITapGestureRecognizer *deleteGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteClick:)];
        deleteGesture.numberOfTapsRequired=1;
        [unPayViewCell.deleteView addGestureRecognizer:deleteGesture];
        
        return unPayViewCell;
        
    }else  {
        PayViewCell *payViewCell = (PayViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        
        InsuranceModel *insuranceModel =((InsuranceModel *)payList.datas[indexPath.row]);
        
 
            NSString *status = @"";
            if([insuranceModel.is_paid isEqualToString:@"1"]){
                if ([insuranceModel.status isEqualToString:@"2"]) {
                    status = @"已通过";
                }else{
                    status = @"未通过";
                }
            }
            
            NSString *trank = [NSString stringWithFormat:@"%@ 到 %@",insuranceModel.from_loc, insuranceModel.to_loc];
            
            [payViewCell.dianzibaodanLabel addTarget:self action:@selector(dianzibaodanClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [payViewCell initContent:insuranceModel.insurance ShipName:insuranceModel.ship_name DepartureDate:insuranceModel.departure_date_show BoatTrank:trank Baofei:insuranceModel.insured_fee Kuaidi:insuranceModel.invoice_fee Id:insuranceModel.id baodanId:insuranceModel.policy_no_long Status:insuranceModel.status_name];
        
        
        
        [payViewCell.submitBt addTarget:self action:@selector(reSubmit:) forControlEvents:UIControlEventTouchUpInside];
        return payViewCell;
    }
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        UnPayViewCell * cell = (UnPayViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        InsuranceConfirmController *insuranceConfirmController = [[InsuranceConfirmController alloc]init];
        insuranceConfirmController.InsuranceId = cell.insuranceId;
        insuranceConfirmController.IsShowBack = YES;
        [self.navigationController pushViewController:insuranceConfirmController animated:YES];
    }
    else{
        PayViewCell * cell = (PayViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        InsuranceConfirmController *insuranceConfirmController = [[InsuranceConfirmController alloc]init];
        insuranceConfirmController.InsuranceId = cell.insuranceId;
        insuranceConfirmController.IsShowDetail = YES;
        insuranceConfirmController.IsShowBack = YES;
        [self.navigationController pushViewController:insuranceConfirmController animated:YES];
        
    }
    
}


-(void)showUpPayList{
    //获取我的保单  access_token paid_status    支付状态  current_max    跟max一致  page    页数  max    最大值
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"status\":\"%@\",\"current_max\":\"%d\",\"page\":\"%d\",\"max\":\"%d\"",[UseInfo shareInfo].access_token,@"0",unPayList.pageSize, unPayList.pageIndex,unPayList.pageSize];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetInsuranceListByUserIdMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"data"];
                if(![list isEqual:[NSNull null]]  &&[list count] >0){
                    unPayList.pageIndex++;
                    for(int i = 0; i < list.count;i ++){
                        InsuranceModel *insuranceModel = [InsuranceModel mj_objectWithKeyValues:(NSDictionary *)(list[i])];
                        
                        [unPayList.datas addObject:insuranceModel];
                    }
                    self.UnPayCollectionView.hidden = NO;
                    UnPayNodata.hidden = YES;
                    //                    [self.view bringSubviewToFront:self.UnPayCollectionView];
                    //                    [self showContent:2];
                    
                }else {
                    if (unPayList.refreshType == RefreshTypeLoadMore) {
                        [self.view makeToast:@"已加载到最后一页" duration:0.5 position:CSToastPositionCenter];
                    }
                    self.UnPayCollectionView.hidden = NO;
                    UnPayNodata.hidden = YES;
                    //                     [self showContent:2];
                }
                
                
            }else{
                self.UnPayCollectionView.hidden = YES;
                UnPayNodata.hidden = NO;
                //                nodata.hidden = NO;
                //                 [self showContent:3];
            }
            
            
        }
        
        [self.UnPayCollectionView reloadData];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
}



-(void)showPayList{
    //获取我的保单  access_token paid_status    支付状态  current_max    跟max一致  page    页数  max    最大值
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"status\":\"%@\",\"current_max\":\"%d\",\"page\":\"%d\",\"max\":\"%d\"",[UseInfo shareInfo].access_token,@"9",payList.pageSize, payList.pageIndex,payList.pageSize];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetInsuranceListByUserIdMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"data"];
                if(![list isEqual:[NSNull null]]  &&[list count] >0){
                    payList.pageIndex++;
                    for(int i = 0; i < list.count;i ++){
                        InsuranceModel *insuranceModel = [InsuranceModel mj_objectWithKeyValues:(NSDictionary *)(list[i])];
                        
                        [payList.datas addObject:insuranceModel];
                        
                        
                    }
                    paynodata.hidden = YES;
                    self.PayCollectionView.hidden = NO;
                    //                     [self showContent:1];
                    
                }else {
                    if (payList.refreshType == RefreshTypeLoadMore) {
                        [self.view makeToast:@"已加载到最后一页" duration:0.5 position:CSToastPositionCenter];
                    }
                    paynodata.hidden = YES;
                    self.PayCollectionView.hidden = NO;
                }
                
                
            }else{
                paynodata.hidden = NO;
                self.PayCollectionView.hidden = YES;
                //                [self showErrorMessage:[boatresult objectForKey:@"msg"] ];
            }
        }
        [self.PayCollectionView reloadData];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
    
}



- (void)payViewClick:(UITapGestureRecognizer *)sender{
    [self setOnSelectedView:payStyle];
    //刷新页面
    //    [self getList:payStyle];
}

- (void)upPayViewClick:(UITapGestureRecognizer *)sender{
    [self setOnSelectedView:upPayStyle];
    //刷新页面
    //    [self getList:upPayStyle];
}

- (void)editClick:(UITapGestureRecognizer *)sender{
    UnPayViewCell * cell = (UnPayViewCell *)sender.view.superview;
    InsuranceConfirmController *insuranceConfirmController = [[InsuranceConfirmController alloc]init];
    insuranceConfirmController.InsuranceId = cell.insuranceId;
    [self.navigationController pushViewController:insuranceConfirmController animated:YES];
}

- (void)deleteClick:(UITapGestureRecognizer *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确认删除么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UnPayViewCell * cell = (UnPayViewCell *)sender.view.superview;
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //删除保单    insurance_id    保单id  Access_token
        NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"Access_token\":\"%@\"",cell.insuranceId ,[UseInfo shareInfo].access_token];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:DeleteInsuranceMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            if (result != nil) {
//                NSLog(@"%@",[boatdict objectForKey:@"result"] );
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    [self.view makeToast:@"删除成功" duration:0.5 position:CSToastPositionCenter];
                    unPayList.pageIndex = 1;
                    unPayList.datas = [[NSMutableArray alloc]init];
                    [self showUpPayList];
                }else{
                    [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
                }
            }
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
        
        
        
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}


-(void)getList:(int)style{
    if (style == payStyle) {
        [self showPayList];
    }else{
        [self showUpPayList];
    }
}
//1 已支付 2未支付
-(void)setOnSelectedView:(int)index{
    if (index ==payStyle) {
        PayLabel.textColor = XXJColor(27, 69, 138);
        PayBlueView.hidden = NO;
        unPayLabel.textColor = [CommonFontColorStyle I3Color];
        unPayBlueView.hidden = YES;
        
        payView.hidden = NO;
        unPayView.hidden = YES;
        
    }else{
        PayLabel.textColor = [CommonFontColorStyle I3Color];
        PayBlueView.hidden = YES;
        unPayLabel.textColor = XXJColor(27, 69, 138);
        unPayBlueView.hidden = NO;
        
        payView.hidden = YES;
        unPayView.hidden = NO;
    }
}


-(void)exitevent:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(UIView *)setHeadTitle:(NSString *)title{
    int headHeight = 44;
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [CommonDimensStyle screenWidth], headHeight)];
    [head setBackgroundColor:[CommonFontColorStyle BlueColor]];
    
    //标题
    UILabel *headtitle = [[UILabel alloc]init];
    [headtitle setText:title];
//    self.viewTitle = title;
    [headtitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [headtitle setTextColor:[CommonFontColorStyle WhiteColor]];
    headtitle.frame = CGRectMake(0, 0, [CommonDimensStyle screenWidth], head.gjcf_height) ;
    [headtitle setTextAlignment:NSTextAlignmentCenter];
    [head addSubview:headtitle];
    
    UIButton *sampleButton = [[UIButton alloc]initWithFrame:CGRectMake(head.gjcf_width-90, 0, 80, head.gjcf_height)];
    [sampleButton setTitle:@"我要投保" forState:UIControlStateNormal];
    [sampleButton setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    sampleButton.titleLabel.font = [CommonFontColorStyle detailBigTitleFont];
    [sampleButton addTarget:self action:@selector(sampleClick) forControlEvents:UIControlEventTouchUpInside];
    [head addSubview:sampleButton];
    
    //返回按钮
    UIView *backView =  [[UIView alloc]initWithFrame:CGRectMake(10, 0, 80, head.gjcf_height)];
    [head addSubview:backView];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 11, 14, 22)];
    backImage.image = [UIImage imageNamed:@"nav_arrow"];
    [backView addSubview:backImage];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake((backImage.gjcf_right), 0, 50, head.gjcf_height)];
    backLabel.text = @"返回";
    backLabel.textColor = [CommonFontColorStyle WhiteColor];
    [backLabel setFont:[CommonFontColorStyle detailBigTitleFont]];
    [backLabel setTextAlignment:NSTextAlignmentLeft];
    [backView addSubview:backLabel];
    
    UITapGestureRecognizer *backGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitevent:)];
    backGesture.numberOfTapsRequired=1;
    [backView addGestureRecognizer:backGesture];
    return head;
}

-(void)sampleClick{
    BaoxianViewController *insuranceInputOneController = [[BaoxianViewController alloc]init];
    [self.navigationController pushViewController:insuranceInputOneController animated:YES];
}


-(void)resubmitInsuranceMethod:(NSString *)insuranceId{
    //再次提交保单
    NSString *parameterstring = [NSString stringWithFormat:@"\"Access_token\":\"%@\",\"insurance_id\":\"%@\"",[UseInfo shareInfo].access_token,insuranceId];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:ResubmitInsuranceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                
                [self.view makeToast:@"提交成功" duration:0.5 position:CSToastPositionCenter];
                payList.pageIndex = 1;
                payList.datas = [[NSMutableArray alloc]init];
                [self showPayList];
            }else{
                
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
}


-(void)reSubmit:(id)sender
{
    PayViewCell *payViewCell  = (PayViewCell *)((UIButton *)sender).superview;
    NSString *payInsuranceId = payViewCell.insuranceId;
    [self resubmitInsuranceMethod:payInsuranceId];
    
}


-(void)dianzibaodanClick:(id)sender{
    UIButton *payBt =(UIButton *)sender;
    PayViewCell* payview =  (PayViewCell *)payBt.superview.superview;
    NSString *insuranceid =  payview.insuranceId;
    NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"access_token\":\"%@\"",insuranceid,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetInsuranceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                
                InsuranceModel* thisInsuranceModel = [InsuranceModel mj_objectWithKeyValues:[boatresult objectForKey:@"data"]];
                InsurancePictureController *insurancePictureController = [[InsurancePictureController alloc]init];
                insurancePictureController.insuranceModel = thisInsuranceModel;
                [self.navigationController pushViewController:insurancePictureController animated:YES];
                
            }
        }
        
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
    
    
    
}















@end
