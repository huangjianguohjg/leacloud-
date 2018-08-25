//
//  InsuranceInputThreeController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceInputThreeController.h"
#import "GrayLine.h"
#import "HeadView.h"
#import "BoatNameInfoViewCell.h"
#import "ShipAgeViewCell.h"
#import "ShipAgeModel.h"
#import "DepartureDateModel.h"
#import "SearchBoatModel.h"
#import "InsuranceInputFourController.h"
#import "InsuranceConfirmController.h"
@interface InsuranceInputThreeController (){
    NSString *identifier;
    UIScrollView *scrollView;
    UITextField *applicanter;
    UITextField *applicantered;
    UITextField *fromLoc;
    UITextField *contactMobile;
    UIButton *NextBt;
    NSString *insuranceId ;
    int shipAgeType;
    NSString *shipAgeName;
    NSString *departureDateCode;
    NSString *departureDateName;
    UITextField *boatName;
    UITextField *toLoc;
    UITextField *wayBillNo;
    UILabel *feeLvValueLabel;
    UILabel *boatAge;
    UIView *backView;
    UIView *BoatAgeView;
    NSMutableArray *shipAgeList;
    NSMutableArray *DepartureDateList;
    
    UILabel *departureDate;
    
    UIView *DepartureDateView;
    AFFNumericHoriKeyboard *keyboard;
    UIView *youMingView;
    NSMutableArray *searchBoatModels;
    
    InsuranceModel *SelfInsuranceModel;
    UIView *head;
}

@end

@implementation InsuranceInputThreeController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"填写保单";
    
    [self setUpUI];
    
}




-(void)setUpUI
{
    
    keyboard = [[AFFNumericHoriKeyboard alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 216)];
    keyboard.delegate = self;
    
    [self KeyBoardHidden];
    [self getInsuranceInfo];

}

-(void)KeyBoardHidden{
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
}


-(void)initView{
    identifier = @"cell";
    
    int titleWidth = 70;
    // 1.创建UIScrollView
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREEN_WIDTH, ([CommonDimensStyle screenHeight]- kStatusBarHeight - kNavigationBarHeight) ); // frame中的size指UIScrollView的可视范围
    [self.view addSubview:scrollView];
    
    //导航条
    UIView *navView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) type:3];
    [scrollView addSubview:navView];
    
    if (self.isEdit) {
        navView.gjcf_height = 0;
    }
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, navView.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [scrollView addSubview:grayLine];
    
    //船名
    UIView *applicantview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    applicantview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:applicantview];
    
    UILabel *applicantNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicantview.gjcf_height)];
    applicantNameLabel.text= @"船名";
    applicantNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    applicantNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [applicantview addSubview:applicantNameLabel];
    
    boatName = [[UITextField alloc]initWithFrame:CGRectMake((applicantNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH-applicantNameLabel.gjcf_right -2*[CommonDimensStyle smallMargin]), applicantview.gjcf_height)];
    boatName.textAlignment = NSTextAlignmentRight;
    boatName.placeholder =@"填写船舶名称";
    boatName.textColor = [CommonFontColorStyle I3Color];
    boatName.font =[CommonFontColorStyle MenuSizeFont];
    boatName.delegate = self;
    boatName.tag = 1;
    [boatName addTarget:self action:@selector(boatNameChange:) forControlEvents:UIControlEventEditingChanged];
    [applicantview addSubview:boatName];
    
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0.0f;
    self.BoatNamecollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, applicantview.gjcf_bottom, SCREEN_WIDTH, 0) collectionViewLayout:flowLayout];
    self.BoatNamecollectionView.backgroundColor = [UIColor whiteColor];
    self.BoatNamecollectionView.tag = 3;
    [scrollView addSubview:self.BoatNamecollectionView];
    //注册单元格
    [self.BoatNamecollectionView registerClass:[BoatNameInfoViewCell class]forCellWithReuseIdentifier:identifier];
    self.BoatNamecollectionView.backgroundColor = [CommonFontColorStyle WhiteColor];
    
    //设置代理
    self.BoatNamecollectionView.delegate = self;
    self.BoatNamecollectionView.dataSource = self;
    
    youMingView = [[UIView alloc]initWithFrame:CGRectMake(0, self.BoatNamecollectionView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 300)];
    [scrollView addSubview:youMingView];
    
    
    //横线
    GrayLine* grayLine2 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 0, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [youMingView addSubview:grayLine2];
    
    
    
    //船龄
    UIView *applicanteredNameview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine2.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    applicanteredNameview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [youMingView addSubview:applicanteredNameview];
    
    UILabel *applicanteredNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    applicanteredNameLabel.text= @"船龄";
    applicanteredNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    applicanteredNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [applicanteredNameview addSubview:applicanteredNameLabel];
    
    boatAge = [[UILabel alloc]initWithFrame:CGRectMake((applicantNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 37-applicantNameLabel.gjcf_right -[CommonDimensStyle smallMargin]), applicantview.gjcf_height)];
    boatAge.textAlignment = NSTextAlignmentRight;
    [boatAge setText:@"选中船龄"];
    boatAge.textColor = [CommonFontColorStyle D0D4D7Color];
    boatAge.font =[CommonFontColorStyle MenuSizeFont];
    [applicanteredNameview addSubview:boatAge];
    
    UITapGestureRecognizer *goodsPackUnitGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(boatAgeclick:)];
    goodsPackUnitGesture1.numberOfTapsRequired=1;
    boatAge.userInteractionEnabled = YES;
    [boatAge addGestureRecognizer:goodsPackUnitGesture1];
    
    UIImageView *boatAgeimage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[CommonDimensStyle smallMargin] - 9-9), (applicantview.gjcf_height- 13)/2, 13, 13)];
    boatAgeimage.image = [UIImage imageNamed:@"form_icon_arrow"];
    [applicanteredNameview addSubview:boatAgeimage];
    
    UITapGestureRecognizer *goodsPackUnitimageGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(boatAgeclick:)];
    goodsPackUnitimageGesture.numberOfTapsRequired=1;
    boatAgeimage.userInteractionEnabled = YES;
    [boatAgeimage addGestureRecognizer:goodsPackUnitimageGesture];
    
    
    //横线
    GrayLine* grayLine3 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], applicanteredNameview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [youMingView addSubview:grayLine3];
    
    //数量
    UIView *contactview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine3.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    contactview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [youMingView addSubview:contactview];
    
    UILabel *contactNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    contactNameLabel.text= @"启运地";
    contactNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    contactNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [contactview addSubview:contactNameLabel];
    
    fromLoc = [[UITextField alloc]initWithFrame:CGRectMake((contactNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-contactNameLabel.gjcf_right ), contactview.gjcf_height)];
    fromLoc.textAlignment = NSTextAlignmentRight;
    fromLoc.placeholder = @"填写启运地";
    fromLoc.delegate = self;
    fromLoc.textColor = [CommonFontColorStyle I3Color];
    fromLoc.font =[CommonFontColorStyle MenuSizeFont];
    //    fromLoc.text = self.oldInsuranceModel.from_loc;
    [contactview addSubview:fromLoc];
    
    //横线
    GrayLine* grayLine4 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], contactview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [youMingView addSubview:grayLine4];
    
    //单位
    UIView *contactMobileview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine4.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    contactMobileview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [youMingView addSubview:contactMobileview];
    
    UILabel *contactMobileLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    contactMobileLabel.text= @"目的地";
    contactMobileLabel.textColor = [CommonFontColorStyle FontNormalColor];
    contactMobileLabel.font =[CommonFontColorStyle MenuSizeFont];
    [contactMobileview addSubview:contactMobileLabel];
    
    toLoc = [[UITextField alloc]initWithFrame:CGRectMake((applicantNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH -contactMobileLabel.gjcf_right -2*[CommonDimensStyle smallMargin]), applicantview.gjcf_height)];
    toLoc.textAlignment = NSTextAlignmentRight;
    toLoc.placeholder = @"填写目的地";
    toLoc.textColor = [CommonFontColorStyle I3Color];
    toLoc.font =[CommonFontColorStyle MenuSizeFont];
    //    toLoc.text = self.oldInsuranceModel.to_loc;
    [contactMobileview addSubview:toLoc];
    
    //横线
    GrayLine* grayLine5 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], contactMobileview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [youMingView addSubview:grayLine5];
    
    //单据号
    UIView *wayBillNoview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine5.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    wayBillNoview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [youMingView addSubview:wayBillNoview];
    
    UILabel *wayBillNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    wayBillNoLabel.text= @"联系电话";
    wayBillNoLabel.textColor = [CommonFontColorStyle FontNormalColor];
    wayBillNoLabel.font =[CommonFontColorStyle MenuSizeFont];
    [wayBillNoview addSubview:wayBillNoLabel];
    
    
    
    wayBillNo = [[UITextField alloc]initWithFrame:CGRectMake((wayBillNoLabel.gjcf_right +10), 0, (SCREEN_WIDTH -2* [CommonDimensStyle smallMargin]-wayBillNoLabel.gjcf_right ), wayBillNoview.gjcf_height)];
    wayBillNo.textAlignment = NSTextAlignmentRight;
    wayBillNo.placeholder = @"填写联系电话";
    wayBillNo.textColor = [CommonFontColorStyle I3Color];
    wayBillNo.font =[CommonFontColorStyle MenuSizeFont];
    wayBillNo.inputView = keyboard;
    //    wayBillNo.text = self.oldInsuranceModel.ship_contact_phone;
    [wayBillNoview addSubview:wayBillNo];
    
    //横线
    GrayLine* grayLine6 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], wayBillNoview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [youMingView addSubview:grayLine6];
    
    //起运时间
    UIView *departureDateview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine6.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    departureDateview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [youMingView addSubview:departureDateview];
    
    UILabel *departureDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, departureDateview.gjcf_height)];
    departureDateLabel.text= @"起运时间";
    departureDateLabel.textColor = [CommonFontColorStyle FontNormalColor];
    departureDateLabel.font =[CommonFontColorStyle MenuSizeFont];
    [departureDateview addSubview:departureDateLabel];
    
    departureDate = [[UILabel alloc]initWithFrame:CGRectMake((departureDateLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 37-departureDateLabel.gjcf_right -[CommonDimensStyle smallMargin]), departureDateview.gjcf_height)];
    departureDate.textAlignment = NSTextAlignmentRight;
    [departureDate setText:@"选择起运时间"];
    departureDate.textColor = [CommonFontColorStyle D0D4D7Color];
    departureDate.font =[CommonFontColorStyle MenuSizeFont];
    
    [departureDateview addSubview:departureDate];
    
    UITapGestureRecognizer *departureDateGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(departureDateclick:)];
    departureDateGesture1.numberOfTapsRequired=1;
    departureDate.userInteractionEnabled = YES;
    [departureDate addGestureRecognizer:departureDateGesture1];
    
    UIImageView *departureDateImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[CommonDimensStyle smallMargin] - 9-9), (applicantview.gjcf_height- 13)/2, 13, 13)];
    departureDateImage.image = [UIImage imageNamed:@"form_icon_arrow"];
    [departureDateview addSubview:departureDateImage];
    
    UITapGestureRecognizer *departureDateimageGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(departureDateclick:)];
    departureDateimageGesture.numberOfTapsRequired=1;
    departureDateImage.userInteractionEnabled = YES;
    [departureDateImage addGestureRecognizer:departureDateimageGesture];
    
    //横线
    GrayLine* grayLine7 = [[GrayLine alloc]initWithFrame:CGRectMake(0, departureDateview.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5)];
    [youMingView addSubview:grayLine7];
    
    //下一步
    NextBt= [[UIButton alloc] initWithFrame:CGRectMake( CommonDimensStyle.smallMargin , (grayLine7.gjcf_bottom +CommonDimensStyle.topMargin), (CommonDimensStyle.screenWidth - 2*CommonDimensStyle.smallMargin ), CommonDimensStyle.btHeight)];
    
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"2dabff") Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateNormal];
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"0f92ea") Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateHighlighted];
    
    [NextBt setBackgroundColor:XXJColor(27, 69, 138)];
    
    
    NextBt.layer.cornerRadius =CommonDimensStyle.smallCornerRadius;
    if (self.isEdit) {
        [NextBt setTitle:@"确认保存" forState:UIControlStateNormal];
    }else{
        [NextBt setTitle:@"下一步(保险信息)" forState:UIControlStateNormal];
    }
    NextBt.titleLabel.font =[CommonFontColorStyle ButtonTextFont];
    [NextBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    [NextBt addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [youMingView addSubview:NextBt];
    
    youMingView.gjcf_height =NextBt.gjcf_bottom+10;
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = [CommonFontColorStyle LoadingColor];
    [self.view addSubview:backView];
    backView.hidden = YES;
    
    UITapGestureRecognizer *backViewGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewclick:)];
    backViewGesture1.numberOfTapsRequired=1;
    backView.userInteractionEnabled = YES;
    [backView addGestureRecognizer:backViewGesture1];
    
    UISwipeGestureRecognizer *backViewrecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backViewclick:)];
    [backViewrecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [backView addGestureRecognizer:backViewrecognizer];
}

-(void)navigationInfo{
    
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
    return 0;
}

//每个分区上得元素个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1) {
        return shipAgeList.count;
    }else if (collectionView.tag == 2) {
        return DepartureDateList.count;
    }else{
        return searchBoatModels.count;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 3){
        return CGSizeMake(SCREEN_WIDTH, [CommonDimensStyle inputHeight]);
    }else{
        return CGSizeMake(SCREEN_WIDTH, 44);
    }
}
//设置元素内容
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShipAgeViewCell *boatNameViewCell = (ShipAgeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
    if (collectionView.tag == 1) {
        ShipAgeModel *shipAgeModel =((ShipAgeModel *)shipAgeList[indexPath.row]);
        [boatNameViewCell initwithContent:shipAgeModel.Name Id:shipAgeModel.id];
    }else if (collectionView.tag == 2) {
        DepartureDateModel *departureDateModel =((DepartureDateModel *)DepartureDateList[indexPath.row]);
        [boatNameViewCell initwithContent:departureDateModel.Name Id:departureDateModel.code];
    }else{
        BoatNameInfoViewCell *boatNameViewCell = (BoatNameInfoViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        
        NSString *name =((SearchBoatModel *)searchBoatModels[indexPath.row]).name;
        
        [boatNameViewCell setName:name];
        
        return boatNameViewCell;
    }
    
    
    return boatNameViewCell;
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self closeAllShow];
    ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:YES];
    if (collectionView.tag == 1) {
        shipAgeType =(int)[GJCFStringUitil stringToInt:cell.shipId] ;
        shipAgeName = cell.name;
    }else if (collectionView.tag == 2){
        departureDateCode = cell.shipId;
        departureDateName = cell.name;
    }else{
        BoatNameInfoViewCell * cell = (BoatNameInfoViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        boatName.text =cell.contentLabel.text;
        self.BoatNamecollectionView.gjcf_height = 0;
        youMingView.gjcf_top = self.BoatNamecollectionView.gjcf_bottom-0.5;
        //        [self scrollSize];
        if ([cell.contentLabel.text containsString:@"拖"]||[cell.contentLabel.text containsString:@"驳"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"拖驳运输的费率统一为千分之一" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            
            [alertController addAction:otherAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }
    
}

//UICollectionView没有选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [CommonFontColorStyle DBE6EFColor];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [CommonFontColorStyle WhiteColor];
}

-(void)nextClick{
    //运输信息保存  id    保单id ship_name    船名  ship_age_type    船龄  from_loc    启运地  to_loc    目的地
    //departure_date    启运时间（非时间戳形式）  ship_contact_phone    联系方式
    NSString *ship_name =boatName.text;
    NSString *from_loc =fromLoc.text;
    NSString *to_loc =toLoc.text;
    NSString *ship_contact_phone =wayBillNo.text;
    
    if([GJCFStringUitil stringIsNull:ship_name]){
        [self.view makeToast:@"船名不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if(shipAgeType== 0){
        [self.view makeToast:@"船龄不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if([GJCFStringUitil stringIsNull:from_loc]){
        [self.view makeToast:@"启运地不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if([GJCFStringUitil stringIsNull:to_loc]){
        [self.view makeToast:@"目的地不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if([GJCFStringUitil stringIsNull:ship_contact_phone]){
        [self.view makeToast:@"联系电话不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }else{
        
        NSString *regex = @"^(^0\\d{2}-?\\d{8}$)|(^0\\d{3}-?\\d{7,8}$)|(^\(0\\d{2}\)-?\\d{8}$)|(^\(0\\d{3}\)-?\d{7,8}$)|((\\+\\d+)?1\\d{10})$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = false;
        
        isMatch = [pred evaluateWithObject:ship_contact_phone];
        if (!isMatch) {
            [self.view makeToast:@"联系电话格式不正确" duration:0.5 position:CSToastPositionCenter];
            return;
        }
        
    }
    if([GJCFStringUitil stringIsNull:departureDateCode]){
        [self.view makeToast:@"起运时间不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    [NextBt setUserInteractionEnabled:YES];
    NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\",\"ship_name\":\"%@\",\"ship_age_type\":\"%i\",\"from_loc\":\"%@\",\"to_loc\":\"%@\",\"departure_date\":\"%@\",\"ship_contact_phone\":\"%@\"",self.InsuranceId,ship_name,shipAgeType,from_loc,to_loc,departureDateCode,ship_contact_phone];
    
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:SaveTransportInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                if (self.isEdit) {
                    InsuranceConfirmController *insuranceConfirmController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                    insuranceConfirmController.InsuranceId = self.InsuranceId;
                    [self.navigationController popToViewController:insuranceConfirmController animated:YES];

                }else{
                    InsuranceInputFourController *insuranceInputFourController = [[InsuranceInputFourController alloc]init];
                    insuranceInputFourController.InsuranceId = self.InsuranceId;
                    //                insuranceInputFourController.oldInsuranceModel = self.oldInsuranceModel;
                    [self.navigationController pushViewController: insuranceInputFourController animated:YES];
                }
            }else{
                [NextBt setUserInteractionEnabled:YES];
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}



- (void)setInfoViewFrame:(BOOL)isDown Index:(int)index{
    UIView *infoView;
    if (index ==1) {
        infoView =BoatAgeView;
    }else if(index ==2){
        infoView =DepartureDateView;
    }
    if(isDown == NO)
    {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:0
                         animations:^{
                             [infoView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, infoView.gjcf_height)];
                             backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
                         }
                         completion:^(BOOL finished) {
                             backView.hidden = YES;
                         }];
        
    }else
    {
        backView.hidden = NO;
        backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:0
                         animations:^{
                             [infoView setFrame:CGRectMake(0, SCREEN_HEIGHT-infoView.gjcf_height, SCREEN_WIDTH, infoView.gjcf_height)];
                             
                             backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}



-(void)InitBoatAge{
    if (BoatAgeView== NULL) {
        BoatAgeView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        BoatAgeView.backgroundColor = [UIColor whiteColor];
        BoatAgeView.backgroundColor = [UIColor redColor];
        [self.view addSubview:BoatAgeView ];
        
        UIView *boatAgeHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [boatAgeHeadView setBackgroundColor:[CommonFontColorStyle ebBackgroudColor]];
//        boatAgeHeadView.backgroundColor = [UIColor yellowColor];
        [BoatAgeView addSubview:boatAgeHeadView];
        
        UILabel *boatAgetitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, boatAgeHeadView.gjcf_width, 17)];
        
        boatAgetitle.text = @"船龄";
        boatAgetitle.textColor = [CommonFontColorStyle I3Color];
        boatAgetitle.font = [CommonFontColorStyle MenuSizeFont];
        boatAgetitle.textAlignment = NSTextAlignmentCenter;
        [boatAgeHeadView addSubview:boatAgetitle];
        
        UILabel *boatAgeXiantitle = [[UILabel alloc]initWithFrame:CGRectMake(0, boatAgetitle.gjcf_bottom + 1, boatAgeHeadView.gjcf_width, 17)];
//        boatAgetitle.backgroundColor = [UIColor orangeColor];
        boatAgeXiantitle.text = @"(船龄>=30年的不予投保)";
        boatAgeXiantitle.textColor = [CommonFontColorStyle RedColor];
        boatAgeXiantitle.font = [CommonFontColorStyle SuperSmallFont];
        boatAgeXiantitle.textAlignment = NSTextAlignmentCenter;
        [boatAgeHeadView addSubview:boatAgeXiantitle];
        
        UIButton *cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, boatAgeHeadView.gjcf_height)];
        [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBt setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
        cancelBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [boatAgeHeadView addSubview: cancelBt];
        [cancelBt addTarget:self action:@selector(boatAgeCancel) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *okBt = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 60), 0, 50, boatAgeHeadView.gjcf_height)];
        [okBt setTitle:@"确认" forState:UIControlStateNormal];
        [okBt setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
        okBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [boatAgeHeadView addSubview: okBt];
        [okBt addTarget:self action:@selector(boatAgeConfirm) forControlEvents:UIControlEventTouchDown];
        
        
        
        GrayLine *subGrayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, boatAgeHeadView.gjcf_bottom-0.5, boatAgeHeadView.gjcf_width, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
        [BoatAgeView addSubview:subGrayLine];
        
        
        
        UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0.0f;
        self.BoatAgeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, subGrayLine.gjcf_bottom, BoatAgeView.gjcf_width, 300) collectionViewLayout:flowLayout];
        self.BoatAgeCollectionView.backgroundColor = [UIColor whiteColor];
        self.BoatAgeCollectionView.tag = 1;
        
        [BoatAgeView addSubview:self.BoatAgeCollectionView];
        //注册单元格
        [self.BoatAgeCollectionView registerClass:[ShipAgeViewCell class]forCellWithReuseIdentifier:identifier];
        self.BoatAgeCollectionView.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        //设置代理
        self.BoatAgeCollectionView.delegate = self;
        self.BoatAgeCollectionView.dataSource = self;
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:GetUnitList URLMethod:GetShipAgeListMethod parameters:nil finished:^(id result) {
            [SVProgressHUD dismiss];
            shipAgeList = [[NSMutableArray alloc]init];
            if (result != nil) {
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    NSDictionary *boatresultdic =[boatresult objectForKey:@"list"];
                    for (NSString *item in boatresultdic.allKeys) {
                        ShipAgeModel *shipAgeModel = [[ShipAgeModel alloc]init];
                        shipAgeModel.id = item;
                        shipAgeModel.Name = [boatresultdic objectForKey:item];
                        [shipAgeList addObject:shipAgeModel];
                    }
                }
            }
            //重新设置高度
            long dateNewHeight = 0;
            if (shipAgeList.count <= 4 ) {
                dateNewHeight = 44*5;
            }else if(shipAgeList.count == 5){
                dateNewHeight = 44*6;
            }
            else{
                dateNewHeight = 44*6;
            }
            BoatAgeView.gjcf_height = dateNewHeight;
            self.BoatAgeCollectionView.gjcf_height = dateNewHeight - 44;
            BoatAgeView.gjcf_top = SCREEN_HEIGHT;
            [self.BoatAgeCollectionView reloadData];
            [self setBoatAgeDefault];
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
    }
}

//设置船龄默认
-(void)setBoatAgeDefault{
    //设置默认
    if(SelfInsuranceModel != nil){
        
        for (int i = 0; i <shipAgeList.count; i++) {
            
            if ([SelfInsuranceModel.ship_age_type isEqualToString:((ShipAgeModel *)shipAgeList[i]).id]) {
                NSIndexPath *path= [self.BoatAgeCollectionView indexPathForItemAtPoint:CGPointMake(20, i*44 +10)];
                [self.BoatAgeCollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
                shipAgeType =(int)[GJCFStringUitil stringToInt:((ShipAgeModel *)shipAgeList[i]).id] ;
                shipAgeName = ((ShipAgeModel *)shipAgeList[i]).Name;
            }
        }
    }
}



-(void)InitDepartureDateView{
    if (DepartureDateView== NULL) {
        DepartureDateView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        DepartureDateView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:DepartureDateView ];
        
        UIView *departureDateHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [departureDateHeadView setBackgroundColor:[CommonFontColorStyle ebBackgroudColor]];
        [DepartureDateView addSubview:departureDateHeadView];
        
        UILabel *departureDatetitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, departureDateHeadView.gjcf_width, 17)];
        departureDatetitle.text = @"起运时间";
        departureDatetitle.textColor = [CommonFontColorStyle I3Color];
        departureDatetitle.font = [CommonFontColorStyle MenuSizeFont];
        departureDatetitle.textAlignment = NSTextAlignmentCenter;
        [departureDateHeadView addSubview:departureDatetitle];
        
        UILabel *boatAgeXiantitle = [[UILabel alloc]initWithFrame:CGRectMake(0, departureDatetitle.gjcf_bottom + 1, departureDateHeadView.gjcf_width, 17)];
        boatAgeXiantitle.text = @"(请在起运前1小时投保)";
        boatAgeXiantitle.textColor = [CommonFontColorStyle RedColor];
        boatAgeXiantitle.font = [CommonFontColorStyle SuperSmallFont];
        boatAgeXiantitle.textAlignment = NSTextAlignmentCenter;
        [departureDateHeadView addSubview:boatAgeXiantitle];
        
        UIButton *cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, departureDateHeadView.gjcf_height)];
        [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBt setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
        cancelBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [departureDateHeadView addSubview: cancelBt];
        [cancelBt addTarget:self action:@selector(departureDateCancel) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *okBt = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 60), 0, 50, departureDateHeadView.gjcf_height)];
        [okBt setTitle:@"确认" forState:UIControlStateNormal];
        [okBt setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
        okBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [departureDateHeadView addSubview: okBt];
        [okBt addTarget:self action:@selector(departureDateConfirm) forControlEvents:UIControlEventTouchDown];
        
        
        
        GrayLine *subGrayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, departureDateHeadView.gjcf_bottom-0.5, departureDateHeadView.gjcf_width, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
        [DepartureDateView addSubview:subGrayLine];
        
        
        
        UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0.0f;
        self.DepartureDateCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, subGrayLine.gjcf_bottom, BoatAgeView.gjcf_width, 300) collectionViewLayout:flowLayout];
        self.DepartureDateCollectionView.backgroundColor = [UIColor whiteColor];
        self.DepartureDateCollectionView.tag = 2;
        
        [DepartureDateView addSubview:self.DepartureDateCollectionView];
        //注册单元格
        [self.DepartureDateCollectionView registerClass:[ShipAgeViewCell class]forCellWithReuseIdentifier:identifier];
        self.DepartureDateCollectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
        
        //设置代理
        self.DepartureDateCollectionView.delegate = self;
        self.DepartureDateCollectionView.dataSource = self;
        
        DepartureDateList = [[NSMutableArray alloc]init];
        
        int getDays = 7;
        //获取日期
        NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth  | NSCalendarUnitDay |NSCalendarUnitWeekday| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
        for (int i= 0; i<getDays; i++) {
            NSDate *date =  [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([[NSDate date] timeIntervalSinceReferenceDate] + i*24*3600)];
            
            comps = [calendar components:unitFlags fromDate:date];
            NSString *now = [NSString stringWithFormat:@"%ld-%ld-%ld %@",(long)[comps year],(long)[comps month],(long)[comps day],[arrWeek objectAtIndex:[comps weekday]-1]];
            
            DepartureDateModel *departureDatemodel = [[DepartureDateModel alloc]init];
            departureDatemodel.code = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)[comps year],(long)[comps month],(long)[comps day]];
            departureDatemodel.Name =now;
            [DepartureDateList addObject:departureDatemodel];
        }
        
        //重新设置高度
        long dateNewHeight = 44*6;
        DepartureDateView.gjcf_height = dateNewHeight;
        self.DepartureDateCollectionView.gjcf_height = dateNewHeight - 44;
        DepartureDateView.gjcf_top = SCREEN_HEIGHT;
        [self.DepartureDateCollectionView reloadData];
        [self setDepartureDateDefault];
    }
}


//设置单位默认
-(void)setDepartureDateDefault{
    //设置默认
    if(SelfInsuranceModel != nil){
        
        NSString *oldShipAgeType =SelfInsuranceModel.departure_date_show;
        NSArray *oldShipAgeTypes = [oldShipAgeType componentsSeparatedByString:@"-"];
        if (oldShipAgeTypes.count == 3) {
            NSString *twoWei =oldShipAgeTypes[1];
            if ([[twoWei substringToIndex:1] isEqualToString:@"0"]) {
                twoWei = [twoWei substringFromIndex:1];
            }
            
            NSString *threeWei =oldShipAgeTypes[2];
            if ([[threeWei substringToIndex:1] isEqualToString:@"0"]) {
                threeWei = [threeWei substringFromIndex:1];
            }
            NSString *newShipAgeType = [NSString stringWithFormat:@"%@-%@-%@",oldShipAgeTypes[0],twoWei,threeWei];
            for (int i = 0; i <DepartureDateList.count; i++) {
                
                if ([newShipAgeType isEqualToString:((DepartureDateModel *)DepartureDateList[i]).code]) {
                    NSIndexPath *path= [self.DepartureDateCollectionView indexPathForItemAtPoint:CGPointMake(20, i*44 +10)];
                    [self.DepartureDateCollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
                    
                    departureDateCode = ((DepartureDateModel *)DepartureDateList[i]).code;
                    departureDateName = ((DepartureDateModel *)DepartureDateList[i]).Name;
                }
            }
        }
    }
}



//船龄点击
- (void)boatAgeclick:(UITapGestureRecognizer *)sender{
    [self closeAllShow];
    [self setInfoViewFrame:YES Index:1];
}

//起运时间
- (void)departureDateclick:(UITapGestureRecognizer *)sender{
    [self closeAllShow];
    [self setInfoViewFrame:YES Index:2];
}

//关闭所有的弹出窗口
-(void)closeAllShow{
    [self.view endEditing:YES];
    self.BoatNamecollectionView.gjcf_height = 0;
    youMingView.gjcf_top = self.BoatNamecollectionView.gjcf_bottom-0.5;
}

-(void)boatAgeConfirm{
    if([GJCFStringUitil stringIsNull:shipAgeName]){

        [self.view makeToast:@"船龄不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    boatAge.text =shipAgeName;
    boatAge.textColor = [CommonFontColorStyle I3Color];
    [self setInfoViewFrame:NO Index:1];
}

-(void)boatAgeCancel{
    [self setInfoViewFrame:NO Index:1];
}


-(void)departureDateConfirm{
    if([GJCFStringUitil stringIsNull:departureDateName]){
        [self.view makeToast:@"起运时间不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    departureDate.text =departureDateName;
    departureDate.textColor = [CommonFontColorStyle I3Color];
    [self setInfoViewFrame:NO Index:2];
}

-(void)departureDateCancel{
    [self setInfoViewFrame:NO Index:2];
}

#pragma mark 联系方式自定义键盘
- (id)findFirstResponder{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.view.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
    }
    return nil;
}

- (void)numberKeyboardBackspace{
    
    if (wayBillNo.text.length != 0)
    {
        wayBillNo.text = [wayBillNo.text substringToIndex:wayBillNo.text.length -1];
    }
    
}

- (void)numberKeyBoardFinish{
    [wayBillNo resignFirstResponder];
}

-(void)numberKeyboardInput:(NSInteger)number{
    int num = (int)number;
    wayBillNo.text = [wayBillNo.text stringByAppendingString:[NSString stringWithFormat:@"%d",num]];
    
    NSMutableString *textString = [[NSMutableString alloc]initWithFormat:@"%@",wayBillNo.text];
    NSString *regex = @"^(\\d{0,4}-{0,1}[0-9]{0,8})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = false;
    
    isMatch = [pred evaluateWithObject:textString];
    if (!isMatch) {
        if (textString.length >0) {
            wayBillNo.text = [textString substringToIndex:(textString.length -1)];
        }
    }else{
        wayBillNo.text = textString;
    }
}

- (void)writeInRadixPoint{
    if (![wayBillNo.text containsString:@"-"]) {
        wayBillNo.text = [wayBillNo.text stringByAppendingString:[NSString stringWithFormat:@"%@",@"-"]];
    }
}


-(void)getInsuranceInfo{
    NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"access_token\":\"%@\"",self.InsuranceId,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetInsuranceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        [self initView];
        [self InitBoatAge];
        [self InitDepartureDateView];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                InsuranceModel *insuranceModel = [InsuranceModel mj_objectWithKeyValues:[boatresult objectForKey:@"data"]];
                SelfInsuranceModel  = insuranceModel;
                
                //赋初值
                boatName.text = insuranceModel.ship_name;
                if(![GJCFStringUitil stringIsNull:insuranceModel.ship_age]){
                    boatAge.text = insuranceModel.ship_age;
                    boatAge.textColor = [CommonFontColorStyle I3Color];
                }
                
                shipAgeType  = [GJCFStringUitil stringToInt:insuranceModel.ship_age_type];
                
                fromLoc.text = insuranceModel.from_loc;
                toLoc.text = insuranceModel.to_loc;
                wayBillNo.text = insuranceModel.ship_contact_phone;
                
                
                
                if(![GJCFStringUitil stringIsNull: insuranceModel.departure_date ]){
                    
                    //获取日期
                    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
                    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
                    NSDateComponents *comps = [[NSDateComponents alloc] init];
                    
                    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth  | NSCalendarUnitDay |NSCalendarUnitWeekday| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[GJCFStringUitil stringToInt:insuranceModel.departure_date]];
                    comps = [calendar components:unitFlags fromDate:date];
                    departureDate.text = [NSString stringWithFormat:@"%ld-%ld-%ld %@",(long)[comps year],(long)[comps month],(long)[comps day],[arrWeek objectAtIndex:[comps weekday]-1]];
                    
                    departureDate.textColor = [CommonFontColorStyle I3Color];
                    departureDateCode =SelfInsuranceModel.departure_date_show;
                }
                
            }else{
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
            
        }
        
        
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];

}


-(void)doSearch{
    NSString *search = [boatName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\",\"access_token\":\"%@\"",search,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetShipPosition URLMethod:QueryShipByName parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *resultDict =[result objectForKey:@"result"];
            
            if ([[resultDict objectForKey:@"status"] boolValue]) {
                //有数据
                //                if ([[result objectForKey:@"totalCount"]intValue]>0) {
                if( ![[resultDict objectForKey:@"data"] isEqual:[NSNull null]]&&  [resultDict objectForKey:@"data"] != nil){
                    NSArray *list = [resultDict objectForKey:@"data"];
                    if( ![list isEqual:[NSNull null]]&&  list != nil &&[list count] >0){
                        searchBoatModels = [[NSMutableArray alloc]init];
                        for(int i = 0; i < list.count;i ++){
                            SearchBoatModel *boatModel = [SearchBoatModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                            [searchBoatModels addObject:boatModel];
                        }
                        if (list.count<3) {
                            self.BoatNamecollectionView.gjcf_height = [CommonDimensStyle inputHeight]*list.count;
                        }else{
                            self.BoatNamecollectionView.gjcf_height = [CommonDimensStyle inputHeight]*3;
                        }
                    }else {
                        self.BoatNamecollectionView.gjcf_height = 0;
                    }
                }
                //                }
                else {
                    self.BoatNamecollectionView.gjcf_height = 0;
                }
            }else{
                self.BoatNamecollectionView.gjcf_height = 0;
            }
            
            youMingView.gjcf_top =self.BoatNamecollectionView.gjcf_bottom-0.5;
            [self.BoatNamecollectionView reloadData];
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
}

-(void)boatNameChange:(id) sender {
    [self doSearch];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        [self doSearch];
    }else{
        self.BoatNamecollectionView.gjcf_height = 0;
        youMingView.gjcf_top = self.BoatNamecollectionView.gjcf_bottom-0.5;
    }
    return YES;
}

- (void)backViewclick:(UITapGestureRecognizer *)sender{
    [self setInfoViewFrame:NO Index:2];
    [self setInfoViewFrame:NO Index:1];
}












@end
