//
//  InsuranceAddAddressController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceAddAddressController.h"
#import "InsuranceAddressModel.h"
#import "GrayLine.h"
#import "ShipAgeViewCell.h"
#import "ExpressCompanyModel.h"
#import "ProvinceModel.h"
#import "InsuranceInputFourController.h"
#import "InsuranceReceiptDetailController.h"
#import "InsuranceAddressListController.h"
@interface InsuranceAddAddressController (){
    
    //     title    抬头  addressee    收件人 mobile    电话 address    所在区域 detail_address    详细地址 expresscompany    快递公司id invoice_fee    邮费 is_current    默认（Y,N） access_token
    NSString *identifier;
    UIScrollView *scrollView;
    
    
    UITextField *titleTxt;
    UITextField *addresseeTxt;
    UITextField *mobileTxt;
    UITextField *contactMobileTxt;
    UILabel *iaddressLabel;
    UITextField *detail_addressLabel;
    UITextField *detail_addressTxt;
    UILabel *expresscompanyLabel;
    UILabel *invoice_feeLabel;
    
    
    UIButton *SaveBt;
    UIView *ExpressCompany;
    
    NSMutableArray *ExpressCompanyList;
    
    NSString *expresscompany_id;
    NSString *expresscompany_name;
    
    
    
    
    NSMutableArray *goodsMtypeList;
    NSMutableArray *goodsStypeList;
    UIView *backView;
    
    UILabel *sTypeLableNav;
    UIView *sTypeLableViewNav;
    
    
    NSString *mtype_rate;
    NSString *deductible_statement;
    NSMutableArray *unitList;
    UIView *UinitView;
    NSString *unitSelected;
    
    NSString *provinceId;
    NSString *cityId;
    NSString *areaId;
    NSString *provinceName;
    NSString *cityName;
    NSString *areaName;
    
    NSString *tempprovinceId;
    NSString *tempcityId;
    NSString *tempareaId;
    NSString *tempprovinceName;
    NSString *tempcityName;
    NSString *tempareaName;
    
    UIView *AreaView;
    UIButton *okBt;
    
    UILabel *provinceLableNav;
    UIView *provinceLableViewNav;
    
    UILabel *cityLableNav;
    UIView *cityLableViewNav;
    
    UILabel *countyLableNav;
    UIView *countyLableViewNav;
    
    NSMutableArray *provinceList;
    NSMutableArray *cityList;
    NSMutableArray *countyList;
    
    //    ZYRadioButton *rb1;
    
    Boolean selectedIndexboolen;
    UIButton *selectedIndexBt;
    InsuranceAddressModel *insuranceAddressModel;
    AFFNumericHoriKeyboard *keyboard;
    Boolean iscurrent;
    
    
}

@end

@implementation InsuranceAddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"邮寄地址";
    
    [self setUpUI];
    
    
    
}




-(void)setUpUI
{
    selectedIndexboolen = NO;
    keyboard = [[AFFNumericHoriKeyboard alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 216)];
    keyboard.delegate = self;
    
    [self initView];
    [self KeyBoardHidden];
    [self InitExpressCompanyView];
    [self InitAreaView];
    [self getAddressDetail];
    
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
    
//    self.view.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
//    UIView *head = [self setHeadTitle:@"邮寄地址"];
//    [self.view addSubview:head];
    
    identifier = @"cell";
    
    int titleWidth = 70;
    // 1.创建UIScrollView
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREEN_WIDTH, ([CommonDimensStyle screenHeight]- kStatusBarHeight - kNavigationBarHeight) ); // frame中的size指UIScrollView的可视范围
    [self.view addSubview:scrollView];
    
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, [CommonDimensStyle smallMargin], CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [scrollView addSubview:grayLine];
    
    
    
    //收件人
    UIView *applicanteredNameview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    applicanteredNameview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:applicanteredNameview];
    
    UILabel *applicanteredNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    applicanteredNameLabel.text= @"收件人";
    applicanteredNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    applicanteredNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [applicanteredNameview addSubview:applicanteredNameLabel];
    
    addresseeTxt = [[UITextField alloc]initWithFrame:CGRectMake((applicanteredNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-applicanteredNameLabel.gjcf_right ), applicanteredNameview.gjcf_height)];
    addresseeTxt.textAlignment = NSTextAlignmentRight;
    addresseeTxt.textColor = [CommonFontColorStyle I3Color];
    addresseeTxt.placeholder = @"填写收件人";
    addresseeTxt.font =[CommonFontColorStyle MenuSizeFont];
    [applicanteredNameview addSubview:addresseeTxt];
    
    //横线
    GrayLine* grayLine3 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], applicanteredNameview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine3];
    
    //电话
    UIView *contactview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine3.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    contactview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:contactview];
    
    UILabel *contactNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    contactNameLabel.text= @"联系电话";
    contactNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    contactNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [contactview addSubview:contactNameLabel];
    
    contactMobileTxt = [[UITextField alloc]initWithFrame:CGRectMake((contactNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-contactNameLabel.gjcf_right ), contactview.gjcf_height)];
    contactMobileTxt.textAlignment = NSTextAlignmentRight;
    contactMobileTxt.textColor = [CommonFontColorStyle I3Color];
    contactMobileTxt.font =[CommonFontColorStyle MenuSizeFont];
    contactMobileTxt.placeholder = @"填写收件电话";
    contactMobileTxt.inputView = keyboard;
    [contactview addSubview:contactMobileTxt];
    
    //横线
    GrayLine* grayLine4 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], contactview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine4];
    
    //所在区域
    UIView *contactMobileview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine4.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    contactMobileview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:contactMobileview];
    
    UILabel *contactMobileLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    contactMobileLabel.text= @"所在区域";
    contactMobileLabel.textColor = [CommonFontColorStyle FontNormalColor];
    contactMobileLabel.font =[CommonFontColorStyle MenuSizeFont];
    [contactMobileview addSubview:contactMobileLabel];
    
    iaddressLabel = [[UILabel alloc]initWithFrame:CGRectMake((contactMobileLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 37-contactMobileLabel.gjcf_right -[CommonDimensStyle smallMargin]), contactMobileview.gjcf_height)];
    iaddressLabel.textAlignment = NSTextAlignmentRight;
    iaddressLabel.textColor = [CommonFontColorStyle FontSecondColor];
    iaddressLabel.font =[CommonFontColorStyle MenuSizeFont];
    [contactMobileview addSubview:iaddressLabel];
    iaddressLabel.text =@"请选择所在区域";
    
    UITapGestureRecognizer *goodsPackUnitGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Areaclick:)];
    goodsPackUnitGesture1.numberOfTapsRequired=1;
    iaddressLabel.userInteractionEnabled = YES;
    [iaddressLabel addGestureRecognizer:goodsPackUnitGesture1];
    
    UIImageView *goodsPackUnitimage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[CommonDimensStyle smallMargin] - 9-9), (contactMobileview.gjcf_height- 13)/2, 13, 13)];
    goodsPackUnitimage.image = [UIImage imageNamed:@"form_icon_arrow"];
    [contactMobileview addSubview:goodsPackUnitimage];
    
    UITapGestureRecognizer *goodsPackUnitimageGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Areaclick:)];
    goodsPackUnitimageGesture.numberOfTapsRequired=1;
    goodsPackUnitimage.userInteractionEnabled = YES;
    [goodsPackUnitimage addGestureRecognizer:goodsPackUnitimageGesture];
    
    //横线
    GrayLine* grayLine5 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], contactMobileview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine5];
    
    //详细地址
    UIView *wayBillNoview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine5.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    wayBillNoview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:wayBillNoview];
    
    UILabel *wayBillNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    wayBillNoLabel.text= @"详细地址";
    wayBillNoLabel.textColor = [CommonFontColorStyle FontNormalColor];
    wayBillNoLabel.font =[CommonFontColorStyle MenuSizeFont];
    [wayBillNoview addSubview:wayBillNoLabel];
    
    detail_addressLabel = [[UITextField alloc]initWithFrame:CGRectMake((wayBillNoLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-wayBillNoLabel.gjcf_right ), wayBillNoview.gjcf_height)];
    detail_addressLabel.textAlignment = NSTextAlignmentRight;
    detail_addressLabel.textColor = [CommonFontColorStyle I3Color];
    detail_addressLabel.font =[CommonFontColorStyle MenuSizeFont];
    detail_addressLabel.placeholder = @"填写详细地址";
    [wayBillNoview addSubview:detail_addressLabel];
    
    //横线
    GrayLine* grayLine6 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], wayBillNoview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine6];
    
    //快递公司
    UIView *expresscompanyview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine6.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    expresscompanyview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:expresscompanyview];
    
    UILabel *expresscompanyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    expresscompanyTitleLabel.text= @"快递公司";
    expresscompanyTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
    expresscompanyTitleLabel.font =[CommonFontColorStyle MenuSizeFont];
    [expresscompanyview addSubview:expresscompanyTitleLabel];
    
    expresscompanyLabel = [[UILabel alloc]initWithFrame:CGRectMake((expresscompanyTitleLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 37-expresscompanyTitleLabel.gjcf_right -[CommonDimensStyle smallMargin]), contactMobileview.gjcf_height)];
    expresscompanyLabel.textAlignment = NSTextAlignmentRight;
    expresscompanyLabel.textColor = [CommonFontColorStyle FontSecondColor];
    expresscompanyLabel.font =[CommonFontColorStyle MenuSizeFont];
    expresscompanyLabel.text =@"请选择快递公司";
    [expresscompanyview addSubview:expresscompanyLabel];
    
    UITapGestureRecognizer *expresscompanyGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(expresscompanyclick:)];
    expresscompanyGesture1.numberOfTapsRequired=1;
    expresscompanyLabel.userInteractionEnabled = YES;
    [expresscompanyLabel addGestureRecognizer:expresscompanyGesture1];
    
    UIImageView *expresscompanyimage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[CommonDimensStyle smallMargin] - 9-9), (contactMobileview.gjcf_height- 13)/2, 13, 13)];
    expresscompanyimage.image = [UIImage imageNamed:@"form_icon_arrow"];
    [expresscompanyview addSubview:expresscompanyimage];
    
    UITapGestureRecognizer *expresscompanyGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(expresscompanyclick:)];
    expresscompanyGesture.numberOfTapsRequired=1;
    expresscompanyimage.userInteractionEnabled = YES;
    [expresscompanyimage addGestureRecognizer:expresscompanyGesture];
    
    //横线
    GrayLine* grayLine7 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], expresscompanyview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine7];
    
    //邮费
    UIView *feeLvview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine7.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    feeLvview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:feeLvview];
    
    UILabel *feeLvLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    feeLvLabel.text= @"邮费";
    feeLvLabel.textColor = [CommonFontColorStyle FontNormalColor];
    feeLvLabel.font =[CommonFontColorStyle MenuSizeFont];
    [feeLvview addSubview:feeLvLabel];
    
    invoice_feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - [CommonDimensStyle smallMargin]-25), feeLvLabel.gjcf_height)];
    invoice_feeLabel.text= @"0.00";
    invoice_feeLabel.textColor = [CommonFontColorStyle RedColor];
    invoice_feeLabel.font =[CommonFontColorStyle MenuSizeFont];
    invoice_feeLabel.textAlignment = NSTextAlignmentRight;
    [feeLvview addSubview:invoice_feeLabel];
    
    UILabel *feeLvUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(invoice_feeLabel.gjcf_right+2, 0, 18, applicanteredNameview.gjcf_height)];
    feeLvUnitLabel.text= @"元";
    feeLvUnitLabel.textColor = [CommonFontColorStyle FontNormalColor];
    feeLvUnitLabel.font =[CommonFontColorStyle MenuSizeFont];
    [feeLvview addSubview:feeLvUnitLabel];
    
    //横线
    GrayLine* grayLine8 = [[GrayLine alloc]initWithFrame:CGRectMake(0, feeLvview.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5)];
    [scrollView addSubview:grayLine8];
    
    //邮费
    UIView *morenAddressview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine8.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    morenAddressview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:morenAddressview];
    
    UITapGestureRecognizer *morenAddressviewGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(morenAddressviewclick:)];
    morenAddressviewGesture.numberOfTapsRequired=1;
    morenAddressview.userInteractionEnabled = YES;
    [morenAddressview addGestureRecognizer:morenAddressviewGesture];
    
    selectedIndexBt = [[UIButton alloc]initWithFrame:CGRectMake(10, (morenAddressview.gjcf_height - 17)/2, 17, 17)];
    [selectedIndexBt setBackgroundImage:[UIImage imageNamed:@"form_choose_no"] forState:UIControlStateNormal];
    [selectedIndexBt addTarget:self action:@selector(selectedIndexClick) forControlEvents:UIControlEventTouchUpInside];
    [morenAddressview addSubview:selectedIndexBt];
    
    UILabel *morenAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(selectedIndexBt.gjcf_right + 5, 0, 150, morenAddressview.gjcf_height)];
    morenAddressLabel.text= @"设为默认地址";
    morenAddressLabel.textColor = [CommonFontColorStyle FontNormalColor];
    morenAddressLabel.font =[CommonFontColorStyle MenuSizeFont];
    [morenAddressview addSubview:morenAddressLabel];
    
    //横线
    GrayLine* grayLine9 = [[GrayLine alloc]initWithFrame:CGRectMake(0, morenAddressview.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5)];
    [scrollView addSubview:grayLine9];
    
    //    //下一步
    SaveBt= [[UIButton alloc] initWithFrame:CGRectMake( CommonDimensStyle.smallMargin , (grayLine9.gjcf_bottom +[CommonDimensStyle smallMargin]), (CommonDimensStyle.screenWidth - 2*CommonDimensStyle.smallMargin ), CommonDimensStyle.btHeight)];
    
//    [SaveBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle EB9EFColor] Width:SaveBt.gjcf_width Height:SaveBt.gjcf_height] forState:UIControlStateNormal];
//    [SaveBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle BlueColor] Width:SaveBt.gjcf_width Height:SaveBt.gjcf_height] forState:UIControlStateHighlighted];
    
    [SaveBt setBackgroundColor:XXJColor(27, 69, 138)];
    
    SaveBt.layer.cornerRadius =CommonDimensStyle.smallCornerRadius;
    [SaveBt setTitle:@"确认保存" forState:UIControlStateNormal];
    SaveBt.titleLabel.font =[CommonFontColorStyle ButtonTextFont];
    [SaveBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    [SaveBt addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:SaveBt];
    
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
    backView.hidden = YES;
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
        return ExpressCompanyList.count;
    }else if (collectionView.tag == 6) {
        return provinceList.count;
    }else if (collectionView.tag == 7) {
        return cityList.count;
    }else if (collectionView.tag == 8) {
        return countyList.count;
    }else{
        return  0;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, 44);
}
//设置元素内容
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        ShipAgeViewCell *shipAgeViewCell = (ShipAgeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        ExpressCompanyModel *expressCompanyModel =(ExpressCompanyModel *)ExpressCompanyList[indexPath.row];
        [shipAgeViewCell initwithContent:expressCompanyModel.name Id:expressCompanyModel.id];
        return shipAgeViewCell;
    }else if(collectionView.tag == 6){
        ShipAgeViewCell *shipAgeViewCell = (ShipAgeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        ProvinceModel *dialgItemModel =(ProvinceModel *)provinceList[indexPath.row];
        [shipAgeViewCell initwithContent:dialgItemModel.area_name Id:dialgItemModel.id];
        return shipAgeViewCell;
    }else if(collectionView.tag == 7){
        ShipAgeViewCell *shipAgeViewCell = (ShipAgeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        ProvinceModel *dialgItemModel =(ProvinceModel *)cityList[indexPath.row];
        [shipAgeViewCell initwithContent:dialgItemModel.area_name Id:dialgItemModel.id];
        return shipAgeViewCell;
    }else if(collectionView.tag == 8){
        ShipAgeViewCell *shipAgeViewCell = (ShipAgeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        ProvinceModel *dialgItemModel =(ProvinceModel *)countyList[indexPath.row];
        [shipAgeViewCell initwithContent:dialgItemModel.area_name Id:dialgItemModel.id];
        return shipAgeViewCell;
    }
    else{
        UICollectionViewCell *shipAgeViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        return shipAgeViewCell;
    }
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self closeAllShow];
    
    if (collectionView.tag == 1) {
        ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setSelected:YES];
        expresscompany_id = cell.shipId;
        expresscompany_name =cell.name;
        
    }else if(collectionView.tag == 6){
        ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        tempprovinceName = cell.name;
        provinceLableNav.text = tempprovinceName;
        cityLableNav.text = @"选择市";
        countyLableNav.text = @"选择区";
        tempprovinceId = cell.shipId;
        [self clearTempData:2];
        [cell setSelected:YES];
        NSString *parameterstring = [NSString stringWithFormat:@"\"province_id\":\"%@\"",cell.shipId];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:GetUnitList URLMethod:GetCityListByProvinceIdMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            if (result != nil) {
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    cityList = [[NSMutableArray alloc]init];
                    NSArray *boatresultdic =[boatresult objectForKey:@"list"];
                    for(int i = 0; i < boatresultdic.count;i ++){
                        ProvinceModel *expressCompanyModel = [ProvinceModel mj_objectWithKeyValues:(NSDictionary *)(boatresultdic[i])];
                        [cityList addObject:expressCompanyModel];
                    }
                }
            }
            
            [self.CityCollectionView reloadData];
            [self setMainTypeContent:2];
            
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
    }else if(collectionView.tag == 7){
        ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        tempcityId = cell.shipId;
        tempcityName = cell.name;
        cityLableNav.text = tempcityName;
        countyLableNav.text = @"选择区";
        [cell setSelected:YES];
        [self clearTempData:3];
        NSString *parameterstring = [NSString stringWithFormat:@"\"city_id\":\"%@\"",cell.shipId];
        
        
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:GetUnitList URLMethod:GetAreaListByCityIdMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            if (result != nil) {
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    countyList = [[NSMutableArray alloc]init];
                    NSArray *boatresultdic =[boatresult objectForKey:@"list"];
                    for(int i = 0; i < boatresultdic.count;i ++){
                        ProvinceModel *expressCompanyModel = [ProvinceModel mj_objectWithKeyValues:(NSDictionary *)(boatresultdic[i])];
                        [countyList addObject:expressCompanyModel];
                    }
                    
                    
                }
            }
            
            [self.CountyCollectionView reloadData];
            [self setMainTypeContent:3];
            
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];

        
        
    }else if(collectionView.tag == 8){
        ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setSelected:YES];
        tempareaId = cell.shipId;
        tempareaName = cell.name;
        countyLableNav.text = tempareaName;
    }
    
}


//UICollectionView没有选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    if (collectionView.tag == 3) {
    //
    //    }else{
    ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:NO];
    //    }
}

-(void)InitExpressCompanyView{
    if (ExpressCompany== NULL) {
        ExpressCompany = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        ExpressCompany.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:ExpressCompany ];
        
        UIView *ExpressCompanyHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [ExpressCompanyHeadView setBackgroundColor:[CommonFontColorStyle ebBackgroudColor]];
        [ExpressCompany addSubview:ExpressCompanyHeadView];
        
        UILabel *ExpressCompanytitle = [[UILabel alloc]initWithFrame:ExpressCompanyHeadView.frame];
        ExpressCompanytitle.text = @"选择快递公司";
        ExpressCompanytitle.textColor = [CommonFontColorStyle I3Color];
        ExpressCompanytitle.font = [CommonFontColorStyle MenuSizeFont];
        ExpressCompanytitle.textAlignment = NSTextAlignmentCenter;
        [ExpressCompanyHeadView addSubview:ExpressCompanytitle];
        
        UIButton *cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, ExpressCompanyHeadView.gjcf_height)];
        [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBt setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
        cancelBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [ExpressCompanyHeadView addSubview: cancelBt];
        [cancelBt addTarget:self action:@selector(ExpressCompanyCancel) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *kuaidiokBt = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 60), 0, 50, ExpressCompanyHeadView.gjcf_height)];
        [kuaidiokBt setTitle:@"确认" forState:UIControlStateNormal];
        [kuaidiokBt setTitleColor:[CommonFontColorStyle BlueColor] forState:UIControlStateNormal];
        kuaidiokBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [ExpressCompanyHeadView addSubview: kuaidiokBt];
        [kuaidiokBt addTarget:self action:@selector(ExpressCompanySelect) forControlEvents:UIControlEventTouchDown];
        
        
        
        GrayLine *subGrayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, ExpressCompanyHeadView.gjcf_bottom-0.5, ExpressCompanyHeadView.gjcf_width, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
        [ExpressCompany addSubview:subGrayLine];
        
        
        
        UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0.0f;
        self.expresscompanyCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, subGrayLine.gjcf_bottom, ExpressCompany.gjcf_width, 300) collectionViewLayout:flowLayout];
        self.expresscompanyCollectionView.backgroundColor = [UIColor whiteColor];
        self.expresscompanyCollectionView.tag = 1;
        
        [ExpressCompany addSubview:self.expresscompanyCollectionView];
        
        //注册单元格
        [self.expresscompanyCollectionView registerClass:[ShipAgeViewCell class]forCellWithReuseIdentifier:identifier];
        self.expresscompanyCollectionView.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        //设置代理
        self.expresscompanyCollectionView.delegate = self;
        self.expresscompanyCollectionView.dataSource = self;
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetExpressTypeListMethod parameters:nil finished:^(id result) {
            [SVProgressHUD dismiss];
            if (result != nil) {
                
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    ExpressCompanyList = [[NSMutableArray alloc]init];
                    NSDictionary *boatresultdic =[boatresult objectForKey:@"list"];
                    for (NSString *item in boatresultdic.allKeys) {
                        ExpressCompanyModel *expressCompanyModel = [ExpressCompanyModel mj_objectWithKeyValues:[boatresultdic objectForKey:item]];
                        
                        [ExpressCompanyList addObject:expressCompanyModel];
                    }
                    
                    
                }
            }
            
            //重新设置高度
            long dateNewHeight = 0;
            if (ExpressCompanyList.count <= 4 ) {
                dateNewHeight = 44*5;
            }else if (ExpressCompanyList.count <= 5 ) {
                dateNewHeight = 44*(ExpressCompanyList.count +1);
            }else{
                dateNewHeight = 44*6;
            }
            ExpressCompany.gjcf_height = dateNewHeight;
            self.expresscompanyCollectionView.gjcf_height = dateNewHeight - 44;
            ExpressCompany.gjcf_top = SCREEN_HEIGHT;
            [self.expresscompanyCollectionView reloadData];
            
            if (insuranceAddressModel!= nil && ExpressCompanyList!= nil) {
                for (int i = 0; i<ExpressCompanyList.count ; i++) {
                    ExpressCompanyModel *expressCompanyModel  =  (ExpressCompanyModel *)(ExpressCompanyList[i]);
                    if ([expressCompanyModel.id isEqualToString:insuranceAddressModel.express_company]) {
                        expresscompanyLabel.text =expressCompanyModel.name;
                    }
                }
            }
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
    }
}



-(void)InitAreaView{
    if (AreaView== NULL) {
        AreaView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        [self.view addSubview:AreaView ];
        
        UIView *AreaHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [AreaHeadView setBackgroundColor:[CommonFontColorStyle ebBackgroudColor]];
        [AreaView addSubview:AreaHeadView];
        
        UILabel *Areatitle = [[UILabel alloc]initWithFrame:AreaHeadView.frame];
        Areatitle.text = @"选择省市区地址";
        Areatitle.textColor = [CommonFontColorStyle I3Color];
        Areatitle.font = [CommonFontColorStyle MenuSizeFont];
        Areatitle.textAlignment = NSTextAlignmentCenter;
        [AreaHeadView addSubview:Areatitle];
        
        UIButton *cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, AreaHeadView.gjcf_height)];
        [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBt setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
        cancelBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [AreaHeadView addSubview: cancelBt];
        [cancelBt addTarget:self action:@selector(AreaCancel) forControlEvents:UIControlEventTouchUpInside];
        
        okBt = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 60), 0, 50, AreaHeadView.gjcf_height)];
        [okBt setTitle:@"确认" forState:UIControlStateNormal];
        [okBt setTitleColor:[CommonFontColorStyle BlueColor] forState:UIControlStateNormal];
        okBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [AreaHeadView addSubview: okBt];
        [okBt addTarget:self action:@selector(AreaOK) forControlEvents:UIControlEventTouchDown];
        
        
        
        GrayLine *subGrayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, AreaHeadView.gjcf_bottom-0.5, AreaHeadView.gjcf_width, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
        [AreaView addSubview:subGrayLine];
        
        
        UIView *AreaNavigationView = [[UIView alloc]initWithFrame:CGRectMake(0, subGrayLine.gjcf_bottom, SCREEN_WIDTH, 44)];
        [AreaNavigationView setBackgroundColor:[CommonFontColorStyle WhiteColor]];
        [AreaView addSubview:AreaNavigationView];
        
        //省
        UIView *provinceNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AreaNavigationView.gjcf_width/3, AreaNavigationView.gjcf_height)];
        [AreaNavigationView addSubview:provinceNav];
        
        UITapGestureRecognizer *provinceNavGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(provinceNavClick:)];
        provinceNavGesture.numberOfTapsRequired=1;
        [provinceNav addGestureRecognizer:provinceNavGesture];
        //文字
        provinceLableNav = [[UILabel alloc]initWithFrame:CGRectMake(provinceNav.gjcf_width/5, 0, provinceNav.gjcf_width*3/5, provinceNav.gjcf_height)];
        [provinceNav addSubview:provinceLableNav];
        provinceLableNav.text = @"选择省";
        provinceLableNav.font = [CommonFontColorStyle NormalSizeFont];
        provinceLableNav.textColor = [CommonFontColorStyle BlueColor];
        provinceLableNav.textAlignment = NSTextAlignmentCenter;
        //下面蓝色
        provinceLableViewNav = [[UIView alloc]initWithFrame:CGRectMake(provinceNav.gjcf_width/5, (provinceNav.gjcf_height-2), provinceNav.gjcf_width*3/5, 2)];
        provinceLableViewNav.backgroundColor = [CommonFontColorStyle BlueColor];
        [provinceNav addSubview:provinceLableViewNav];
        
        //市
        UIView *cityNav = [[UIView alloc]initWithFrame:CGRectMake(AreaNavigationView.gjcf_width/3, 0, AreaNavigationView.gjcf_width/3, AreaNavigationView.gjcf_height)];
        [AreaNavigationView addSubview:cityNav];
        
        UITapGestureRecognizer *cityNavGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityNavClick:)];
        cityNavGesture.numberOfTapsRequired=1;
        [cityNav addGestureRecognizer:cityNavGesture];
        //文字
        cityLableNav = [[UILabel alloc]initWithFrame:CGRectMake(cityNav.gjcf_width/5, 0, cityNav.gjcf_width*3/5, cityNav.gjcf_height)];
        [cityNav addSubview:cityLableNav];
        cityLableNav.text = @"选择市";
        cityLableNav.font = [CommonFontColorStyle NormalSizeFont];
        cityLableNav.textColor = [CommonFontColorStyle BlueColor];
        cityLableNav.textAlignment = NSTextAlignmentCenter;
        //下面蓝色
        cityLableViewNav = [[UIView alloc]initWithFrame:CGRectMake(cityNav.gjcf_width/5, (cityNav.gjcf_height-2), cityNav.gjcf_width*3/5, 2)];
        cityLableViewNav.backgroundColor = [CommonFontColorStyle BlueColor];
        [cityNav addSubview:cityLableViewNav];
        cityLableViewNav.hidden = YES;
        
        //区
        UIView *countyNav = [[UIView alloc]initWithFrame:CGRectMake(AreaNavigationView.gjcf_width*2/3, 0, AreaNavigationView.gjcf_width/3, AreaNavigationView.gjcf_height)];
        [AreaNavigationView addSubview:countyNav];
        
        UITapGestureRecognizer *countyNavGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(countyNavClick:)];
        countyNavGesture.numberOfTapsRequired=1;
        [countyNav addGestureRecognizer:countyNavGesture];
        //文字
        countyLableNav = [[UILabel alloc]initWithFrame:CGRectMake(countyNav.gjcf_width/5, 0, countyNav.gjcf_width*3/5, countyNav.gjcf_height)];
        [countyNav addSubview:countyLableNav];
        countyLableNav.text = @"选择区";
        countyLableNav.font = [CommonFontColorStyle NormalSizeFont];
        countyLableNav.textColor = [CommonFontColorStyle BlueColor];
        countyLableNav.textAlignment = NSTextAlignmentCenter;
        //下面蓝色
        countyLableViewNav = [[UIView alloc]initWithFrame:CGRectMake(countyNav.gjcf_width/5, (countyNav.gjcf_height-2), countyNav.gjcf_width*3/5, 2)];
        countyLableViewNav.backgroundColor = [CommonFontColorStyle BlueColor];
        [countyNav addSubview:countyLableViewNav];
        countyLableViewNav.hidden = YES;
        
        GrayLine *subGrayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake(0, AreaNavigationView.gjcf_bottom-0.5, AreaHeadView.gjcf_width, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
        [AreaView addSubview:subGrayLine1];
        
        UICollectionViewFlowLayout * proviceflowLayout =[[UICollectionViewFlowLayout alloc] init];
        [proviceflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        proviceflowLayout.minimumLineSpacing = 0.0f;
        self.ProviceCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, subGrayLine1.gjcf_bottom, AreaNavigationView.gjcf_width, 300) collectionViewLayout:proviceflowLayout];
        self.ProviceCollectionView.backgroundColor = [UIColor whiteColor];
        self.ProviceCollectionView.tag = 6;
        
        [AreaView addSubview:self.ProviceCollectionView];
        //注册单元格
        [self.ProviceCollectionView registerClass:[ShipAgeViewCell class]forCellWithReuseIdentifier:identifier];
        self.ProviceCollectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
        
        //设置代理
        self.ProviceCollectionView.delegate = self;
        self.ProviceCollectionView.dataSource = self;
        
        //市
        UICollectionViewFlowLayout * cityFlowLayout =[[UICollectionViewFlowLayout alloc] init];
        [cityFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        cityFlowLayout.minimumLineSpacing = 0.0f;
        self.CityCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.ProviceCollectionView.gjcf_right, AreaNavigationView.gjcf_bottom, AreaNavigationView.gjcf_width, 300) collectionViewLayout:cityFlowLayout];
        self.CityCollectionView.backgroundColor = [UIColor whiteColor];
        self.CityCollectionView.tag = 7;
        
        [AreaView addSubview:self.CityCollectionView];
        //注册单元格
        [self.CityCollectionView registerClass:[ShipAgeViewCell class]forCellWithReuseIdentifier:identifier];
        self.CityCollectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
        //设置代理
        self.CityCollectionView.delegate = self;
        self.CityCollectionView.dataSource = self;
        
        //区
        UICollectionViewFlowLayout * countyFlowLayout =[[UICollectionViewFlowLayout alloc] init];
        [countyFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        countyFlowLayout.minimumLineSpacing = 0.0f;
        self.CountyCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.CityCollectionView.gjcf_right, AreaNavigationView.gjcf_bottom, AreaNavigationView.gjcf_width, 300) collectionViewLayout:countyFlowLayout];
        self.CountyCollectionView.backgroundColor = [UIColor whiteColor];
        self.CountyCollectionView.tag = 8;
        
        [AreaView addSubview:self.CountyCollectionView];
        //注册单元格
        [self.CountyCollectionView registerClass:[ShipAgeViewCell class]forCellWithReuseIdentifier:identifier];
        self.CountyCollectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
        //设置代理
        self.CountyCollectionView.delegate = self;
        self.CountyCollectionView.dataSource = self;
        
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:GetUnitList URLMethod:GetProvinceListMethod parameters:nil finished:^(id result) {
            [SVProgressHUD dismiss];
            if (result != nil) {
                
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    provinceList = [[NSMutableArray alloc]init];
                    NSArray *boatresultdic =[boatresult objectForKey:@"list"];
                    for(int i = 0; i < boatresultdic.count;i ++){
                        ProvinceModel *expressCompanyModel = [ProvinceModel mj_objectWithKeyValues:(NSDictionary *)(boatresultdic[i])];
                        [provinceList addObject:expressCompanyModel];
                    }
                    
                    
                }
            }
            
            //重新设置高度
            long dateNewHeight = 0;
            if (provinceList.count <= 5 ) {
                dateNewHeight = 44*(provinceList.count +1);
            }else{
                dateNewHeight = 44*6;
            }
            AreaView.gjcf_height = dateNewHeight;
            self.ProviceCollectionView.gjcf_height = dateNewHeight - 44;
            AreaView.gjcf_top = SCREEN_HEIGHT;
            [self.ProviceCollectionView reloadData];
            [self setProviceDefault];
            
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
        
        
    }
}



//关闭所有的弹出窗口
-(void)closeAllShow{
    [self.view endEditing:YES];
}

- (void)setInfoViewFrame:(BOOL)isDown Index:(int)index{
    UIView *infoView;
    if (index ==1) {
        infoView =ExpressCompany;
    }else if(index ==2){
        infoView =AreaView;
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

//快递公司点击
- (void)ExpressCompanySelect{
    if([GJCFStringUitil stringIsNull:expresscompany_name]){
        [self.view makeToast:@"快递公司不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    [self closeAllShow];
    [self setInfoViewFrame:NO Index:1];
    expresscompanyLabel.text =  expresscompany_name;
    expresscompanyLabel.textColor = [CommonFontColorStyle I3Color];
    //获得邮费
    [self youFeiValue];
}

- (void)ExpressCompanyCancel{
    [self closeAllShow];
    [self setInfoViewFrame:NO Index:1];
}


- (void)expresscompanyclick:(UITapGestureRecognizer *)sender{
    [self closeAllShow];
    [self setInfoViewFrame:YES Index:1];
}

-(void)saveClick{
    
    NSString  *addressee=addresseeTxt.text;//    收件人
    if([GJCFStringUitil stringIsNull:addressee]){
        [self.view makeToast:@"收件人不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    NSString  *mobile=contactMobileTxt.text;    //电话
    if([GJCFStringUitil stringIsNull:mobile]){
        [self.view makeToast:@"联系电话不能为空" duration:0.5 position:CSToastPositionCenter];

        return;
    }else{
        
        NSString *regex = @"^(^0\\d{2}-?\\d{8}$)|(^0\\d{3}-?\\d{7,8}$)|(^\(0\\d{2}\)-?\\d{8}$)|(^\(0\\d{3}\)-?\d{7,8}$)|((\\+\\d+)?1\\d{10})$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = false;
        
        isMatch = [pred evaluateWithObject:mobile];
        if (!isMatch) {
            [self.view makeToast:@"联系电话格式不正确" duration:0.5 position:CSToastPositionCenter];
            return;
        }
        
    }
    NSString  *address=iaddressLabel.text;//    所在区域
    if([GJCFStringUitil stringIsNull:address]){
        
        [self.view makeToast:@"所在区域不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if([GJCFStringUitil stringIsNull:provinceId]||[GJCFStringUitil stringIsNull:cityId]||[GJCFStringUitil stringIsNull:areaId]){
        [self.view makeToast:@"所在区域不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    NSString  *detail_address=detail_addressLabel.text;    //详细地址
    if([GJCFStringUitil stringIsNull:detail_address]){
        [self.view makeToast:@"详细地址不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    //快递公司
    if([GJCFStringUitil stringIsNull:expresscompany_id]){
        [self.view makeToast:@"快递公司不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    NSString  *invoice_fee=invoice_feeLabel.text;//    邮费
    NSString  *is_current=selectedIndexboolen?@"Y":@"N";//    默认（Y,N） access_token
    
    
    if ([GJCFStringUitil stringIsNull:self.addressId]) {
        
        NSString *parameterstring = [NSString stringWithFormat:@"\"addressee\":\"%@\",\"mobile\":\"%@\",\"address\":\"%@\",\"detail_address\":\"%@\",\"expresscompany\":\"%@\",\"invoice_fee\":\"%@\",\"is_current\":\"%@\",\"province_id\":\"%@\",\"city_id\":\"%@\",\"area_id\":\"%@\",\"access_token\":\"%@\"",addressee,mobile,address,detail_address,expresscompany_id,invoice_fee,is_current,provinceId,cityId,areaId,[UseInfo shareInfo].access_token];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:AddMailAddressMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD show];
            
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                
                switch (self.fromPage) {
                    case 1:{
                        InsuranceInputFourController *insuranceInputFourController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                        insuranceInputFourController.addressId = [boatresult objectForKey:@"res_id"];
                        insuranceInputFourController.recipient =addressee;
                        insuranceInputFourController.mobile =mobile;
                        insuranceInputFourController.address =address;
                        
                        insuranceInputFourController.detail_address =detail_address;
                        insuranceInputFourController.invoice_fee =invoice_fee;
                        insuranceInputFourController.expresscompany =expresscompany_id;
                        insuranceInputFourController.isNeedAddress = YES;
                        [self.navigationController popToViewController:insuranceInputFourController animated:YES];
                    }
                        break;
                        
                    case 2:{
                        [self getEcsList];
                    }
                        break;
                    case 3:{
                        InsuranceReceiptDetailController *insuranceInputFourController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                        insuranceInputFourController.addressId = [boatresult objectForKey:@"res_id"];
                        insuranceInputFourController.recipient =addressee;
                        insuranceInputFourController.mobile =mobile;
                        insuranceInputFourController.address =address;
                        
                        insuranceInputFourController.detail_address =detail_address;
                        insuranceInputFourController.invoice_fee =invoice_fee;
                        insuranceInputFourController.express_company =expresscompany_id;
                        insuranceInputFourController.isNeedAddress = YES;
                        [self.navigationController popToViewController:insuranceInputFourController animated:YES];
                    }
                        break;
                    default:
                        break;
                }
                
                
            }else{
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
        
        
        
        
        
    }else{
        NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\",\"addressee\":\"%@\",\"mobile\":\"%@\",\"address\":\"%@\",\"detail_address\":\"%@\",\"expresscompany\":\"%@\",\"invoice_fee\":\"%@\",\"is_current\":\"%@\",\"province_id\":\"%@\",\"city_id\":\"%@\",\"area_id\":\"%@\",\"access_token\":\"%@\"",self.addressId,addressee,mobile,address,detail_address,expresscompany_id,invoice_fee,is_current,provinceId,cityId,areaId,[UseInfo shareInfo].access_token];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:UpdateMailAddressMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                [self getEcsList];
                
            }else{
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
        
        
        
    }
    
}


//获取个人的发票地址列表
-(void)getEcsList{
    NSString *parameterstring = [NSString stringWithFormat:@"\"uid\":\"%@\"",[UseInfo shareInfo].uID];
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetEcListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        NSMutableArray *addressList = [[NSMutableArray alloc]init];
        if (result != nil) {
            
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]]  &&[list count] >0){
                    
                    for(int i = 0; i < list.count;i ++){
                        InsuranceAddressModel *insuranceModel = [InsuranceAddressModel mj_objectWithKeyValues:(NSDictionary *)(list[i])];
                        [addressList addObject:insuranceModel];
                    }
                }
            }
        }
        
        InsuranceAddressListController *insuranceAddressListController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        
        insuranceAddressListController.addressList =addressList;
        insuranceAddressListController.InsuranceId = self.insuranceId;
        //        insuranceAddressListController.isFour = NO;
        [self.navigationController popToViewController:insuranceAddressListController animated:YES];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    

}


-(void)getAddressDetail{
    if (![GJCFStringUitil stringIsNull:self.addressId]) {
        NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\"",self.addressId];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetMailAddressInfoMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            if (result != nil) {
                
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        insuranceAddressModel =[InsuranceAddressModel mj_objectWithKeyValues:[boatresult objectForKey:@"info"]];
                        titleTxt.text = insuranceAddressModel.title;
                        addresseeTxt.text = insuranceAddressModel.addressee;
                        contactMobileTxt.text = insuranceAddressModel.mobile;
                        iaddressLabel.text = insuranceAddressModel.address;
                        iaddressLabel.textColor = [CommonFontColorStyle I3Color];
                        detail_addressLabel.text = insuranceAddressModel.detail_address;
                        invoice_feeLabel.text = insuranceAddressModel.invoice_fee;
                        expresscompany_id= insuranceAddressModel.express_company;
                        expresscompanyLabel.textColor =[CommonFontColorStyle I3Color];
                        tempcityId = cityId = insuranceAddressModel.city_id;
                        tempprovinceId =  provinceId = insuranceAddressModel.province_id;
                        tempareaId= areaId= insuranceAddressModel.area_id;
                        NSArray *addressList =[insuranceAddressModel.address componentsSeparatedByString:@" "];
                        if (addressList.count == 3) {
                            tempprovinceName= provinceName = addressList[0];
                            provinceLableNav.text = [NSString stringWithFormat:@"%@省",provinceName];
                            tempcityName= cityName = addressList[1];
                            cityLableNav.text = cityName;
                            tempareaName= areaName = addressList[2];
                            countyLableNav.text = areaName;
                        }
                        
                        if([insuranceAddressModel.is_current isEqualToString:@"Y"]){
                            [selectedIndexBt setBackgroundImage:[UIImage imageNamed:@"form_choose_yes"] forState:UIControlStateNormal];
                            selectedIndexboolen = YES;
                        }else{
                            [selectedIndexBt setBackgroundImage:[UIImage imageNamed:@"form_choose_no"] forState:UIControlStateNormal];
                            selectedIndexboolen = NO;
                        }
                        if (insuranceAddressModel!= nil && ExpressCompanyList!= nil) {
                            for (int i = 0; i<ExpressCompanyList.count ; i++) {
                                ExpressCompanyModel *expressCompanyModel  =  (ExpressCompanyModel *)(ExpressCompanyList[i]);
                                if ([expressCompanyModel.id isEqualToString:insuranceAddressModel.express_company]) {
                                    expresscompanyLabel.text =expressCompanyModel.name;
                                }
                            }
                        }
                        
                        [self setProviceDefault];
                        [self setCityDefault];
                        [self setAreaDefault];
                    });
                    
                    
                }else{
                    
                    [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
                }
            }
            
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
        
        
    }
    
}

- (void)Areaclick:(UITapGestureRecognizer *)sender{
    [self closeAllShow];
    [self setInfoViewFrame:YES Index:2];
    
}

-(void)setMainTypeContent:(int)type{
    if (type ==1) {
        self.ProviceCollectionView.gjcf_left = 0;
        self.ProviceCollectionView.hidden = NO;
        self.CityCollectionView.gjcf_left  = self.ProviceCollectionView.gjcf_right;
        self.CityCollectionView.hidden = YES;
        self.CountyCollectionView.gjcf_left  = self.CityCollectionView.gjcf_right;
        self.CountyCollectionView.hidden = YES;
        
        provinceLableViewNav.hidden = NO;
        cityLableViewNav.hidden = YES;
        countyLableViewNav.hidden = YES;
        
    }else if (type ==2){
        self.ProviceCollectionView.gjcf_left = self.ProviceCollectionView.gjcf_width *-1;
        self.ProviceCollectionView.hidden = YES;
        self.CityCollectionView.gjcf_left  = 0;
        self.CityCollectionView.gjcf_width = SCREEN_WIDTH;
        self.CityCollectionView.hidden = NO;
        self.CountyCollectionView.gjcf_left  = self.CityCollectionView.gjcf_right;
        self.CountyCollectionView.hidden = YES;
        provinceLableViewNav.hidden = YES;
        cityLableViewNav.hidden = NO;
        countyLableViewNav.hidden = YES;
        
    }else{
        self.ProviceCollectionView.gjcf_left = self.ProviceCollectionView.gjcf_width *-2;
        self.ProviceCollectionView.hidden = YES;
        self.CityCollectionView.gjcf_left  = self.CityCollectionView.gjcf_width*-1;
        self.CityCollectionView.hidden = YES;
        self.CountyCollectionView.gjcf_left  = 0;
        self.CountyCollectionView.hidden = NO;
        provinceLableViewNav.hidden = YES;
        cityLableViewNav.hidden = YES;
        countyLableViewNav.hidden = NO;
        
    }
}

-(void)selectedIndexClick{
    
    if (selectedIndexboolen) {
        [selectedIndexBt setBackgroundImage:[UIImage imageNamed:@"form_choose_no"] forState:UIControlStateNormal];
        
    }else{
        [selectedIndexBt setBackgroundImage:[UIImage imageNamed:@"form_choose_yes"] forState:UIControlStateNormal];
    }
    selectedIndexboolen = !selectedIndexboolen;
}

-(void)AreaCancel{
    [self setInfoViewFrame:NO Index:2];
}

-(void)AreaOK{
    if ([GJCFStringUitil stringIsNull:tempprovinceId]) {
        
        [self.view makeToast:@"省不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if ([GJCFStringUitil stringIsNull:tempcityId]) {
        [self.view makeToast:@"市不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if ([GJCFStringUitil stringIsNull:tempareaId]) {
        [self.view makeToast:@"区不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    [self setTrueData];
    
    [self setInfoViewFrame:NO Index:2];
    iaddressLabel.text = [NSString stringWithFormat: @"%@ %@ %@",provinceName,cityName,areaName];
    iaddressLabel.textColor = [CommonFontColorStyle I3Color];
    //获得邮费
    [self youFeiValue];
}




//计算邮费
-(void)youFeiValue{
    if ([GJCFStringUitil stringIsNull:expresscompany_id]) {
        return;
    }
    if ([GJCFStringUitil stringIsNull:provinceName]) {
        return;
    }
    //根据省级和邮寄公司获得邮费   address    省级名称   ec_id    邮寄公司id
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"address\":\"%@\",\"ec_id\":\"%@\"",provinceName,expresscompany_id];
    
    [SVProgressHUD show];
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetFeeWithAddressEcMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    invoice_feeLabel.text=[boatresult objectForKey:@"fee"];
                });
            }
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}



#pragma mark 电话自定义键盘
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
    
    if (contactMobileTxt.text.length != 0)
    {
        contactMobileTxt.text = [contactMobileTxt.text substringToIndex:contactMobileTxt.text.length -1];
    }
    
}

- (void)numberKeyBoardFinish{
    [contactMobileTxt resignFirstResponder];
}

-(void)numberKeyboardInput:(NSInteger)number{
    int num = (int)number;
    contactMobileTxt.text = [contactMobileTxt.text stringByAppendingString:[NSString stringWithFormat:@"%d",num]];
    
    NSMutableString *textString = [[NSMutableString alloc]initWithFormat:@"%@",contactMobileTxt.text];
    NSString *regex = @"^(\\d{0,4}-{0,1}[0-9]{0,8})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = false;
    
    isMatch = [pred evaluateWithObject:textString];
    if (!isMatch) {
        if (textString.length >0) {
            contactMobileTxt.text = [textString substringToIndex:(textString.length -1)];
        }
    }else{
        contactMobileTxt.text = textString;
    }
}


- (void)writeInRadixPoint{
    if (![contactMobileTxt.text containsString:@"-"]) {
        contactMobileTxt.text = [contactMobileTxt.text stringByAppendingString:[NSString stringWithFormat:@"%@",@"-"]];
    }
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
    
    if (![GJCFStringUitil stringIsNull:self.addressId ]) {
        UIButton *sampleButton = [[UIButton alloc]initWithFrame:CGRectMake(head.gjcf_width-50, 0, 40, head.gjcf_height)];
        [sampleButton setTitle:@"删除" forState:UIControlStateNormal];
        [sampleButton setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
        sampleButton.titleLabel.font = [CommonFontColorStyle detailBigTitleFont];
        [sampleButton addTarget:self action:@selector(deleteclick) forControlEvents:UIControlEventTouchUpInside];
        [head addSubview:sampleButton];
    }
    
    //返回按钮
    UIView *backViewT =  [[UIView alloc]initWithFrame:CGRectMake(10, 0, 80, head.gjcf_height)];
    [head addSubview:backViewT];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 11, 14, 22)];
    backImage.image = [UIImage imageNamed:@"nav_arrow"];
    [backViewT addSubview:backImage];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake((backImage.gjcf_right), 0, 80, head.gjcf_height)];
    backLabel.text = @"返回";
    backLabel.textColor = [CommonFontColorStyle WhiteColor];
    [backLabel setFont:[CommonFontColorStyle detailBigTitleFont]];
    [backLabel setTextAlignment:NSTextAlignmentLeft];
    [backViewT addSubview:backLabel];
    
    UITapGestureRecognizer *backGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitevent:)];
    backGesture.numberOfTapsRequired=1;
    [backViewT addGestureRecognizer:backGesture];
    return head;
}

-(void)deleteclick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确认删除么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\",\"Access_token\":\"%@\"",self.addressId,[UseInfo shareInfo].access_token];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:DeleteMailAddressMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            if (result != nil) {
                
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    [self getEcsList];
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

- (void)countyNavClick:(UITapGestureRecognizer *)sender{
    if ([GJCFStringUitil stringIsNull: tempcityId ]) {
        [self.view makeToast:@"请先选择市" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    [self setMainTypeContent:3];
    
    if(![GJCFStringUitil stringIsNull: tempcityId ] && countyList == nil){
        NSString *parameterstring = [NSString stringWithFormat:@"\"city_id\":\"%@\"",cityId];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:GetUnitList URLMethod:GetAreaListByCityIdMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            if (result != nil) {
                
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    countyList = [[NSMutableArray alloc]init];
                    NSArray *boatresultdic =[boatresult objectForKey:@"list"];
                    for(int i = 0; i < boatresultdic.count;i ++){
                        ProvinceModel *expressCompanyModel = [ProvinceModel mj_objectWithKeyValues:(NSDictionary *)(boatresultdic[i])];
                        [countyList addObject:expressCompanyModel];
                    }
                    
                    
                }
            }
            
            [self.CountyCollectionView reloadData];
            [self setAreaDefault];
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
    }
    
    [self setAreaDefault];
}

- (void)cityNavClick:(UITapGestureRecognizer *)sender{
    if ([GJCFStringUitil stringIsNull: provinceId ]) {
        
        [self.view makeToast:@"请先选择省" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    [self setMainTypeContent:2];
    
    if(![GJCFStringUitil stringIsNull: provinceId ] && cityList == nil){
        NSString *parameterstring = [NSString stringWithFormat:@"\"province_id\":\"%@\"",provinceId];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:GetUnitList URLMethod:GetCityListByProvinceIdMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            if (result != nil) {
                
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    cityList = [[NSMutableArray alloc]init];
                    NSArray *boatresultdic =[boatresult objectForKey:@"list"];
                    for(int i = 0; i < boatresultdic.count;i ++){
                        ProvinceModel *expressCompanyModel = [ProvinceModel mj_objectWithKeyValues:(NSDictionary *)(boatresultdic[i])];
                        [cityList addObject:expressCompanyModel];
                    }
                    
                    
                }
            }
            
            [self.CityCollectionView reloadData];
            [self setCityDefault];
            
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
        
        
        
    }
    [self setCityDefault];
}

- (void)provinceNavClick:(UITapGestureRecognizer *)sender{
    [self setMainTypeContent:1];
    [self setProviceDefault];
}

-(void)setProviceDefault{
    //设置默认
    if(tempprovinceId != nil){
        
        for (int i = 0; i <provinceList.count; i++) {
            if ([((ProvinceModel *)provinceList[i]).id isEqualToString:tempprovinceId]) {
                NSIndexPath *path= [self.ProviceCollectionView indexPathForItemAtPoint:CGPointMake(20, i*44 +10)];
                [self.ProviceCollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
                
            }
        }
    }
}
-(void)setCityDefault{
    //设置默认
    if(tempcityId != nil){
        
        for (int i = 0; i <cityList.count; i++) {
            if ([((ProvinceModel *)cityList[i]).id isEqualToString:tempcityId]) {
                NSIndexPath *path= [self.CityCollectionView indexPathForItemAtPoint:CGPointMake(20, i*44 +10)];
                [self.CityCollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
                
            }
        }
    }
}
-(void)setAreaDefault{
    //设置默认
    if(tempareaId != nil){
        
        for (int i = 0; i <countyList.count; i++) {
            if ([((ProvinceModel *)countyList[i]).id isEqualToString:tempareaId]) {
                NSIndexPath *path= [self.CountyCollectionView indexPathForItemAtPoint:CGPointMake(20, i*44 +10)];
                [self.CountyCollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
                
            }
        }
    }
}

- (void)morenAddressviewclick:(UITapGestureRecognizer *)sender{
    if (selectedIndexboolen) {
        [selectedIndexBt setBackgroundImage:[UIImage imageNamed:@"form_choose_no"] forState:UIControlStateNormal];
        
    }else{
        [selectedIndexBt setBackgroundImage:[UIImage imageNamed:@"form_choose_yes"] forState:UIControlStateNormal];
    }
    selectedIndexboolen = !selectedIndexboolen;
}

-(void)setTrueData{
    provinceId =tempprovinceId;
    cityId=tempcityId;
    areaId=tempareaId;
    provinceName=tempprovinceName;
    cityName=tempcityName;
    areaName=tempareaName;
}

-(void)clearTempData:(int)index{
    if (index == 1) {
        tempprovinceId = @"";
        tempcityId= @"";
        tempareaId= @"";
        tempprovinceName= @"";
        tempcityName= @"";
        tempareaName= @"";
    }else if(index == 2) {
        tempcityId= @"";
        tempareaId= @"";
        tempcityName= @"";
        tempareaName= @"";
    }else if(index == 3) {
        tempareaId= @"";
        tempareaName= @"";
    }
}

- (void)backViewclick:(UITapGestureRecognizer *)sender{
    [self setInfoViewFrame:NO Index:1];
    [self setInfoViewFrame:NO Index:2];
}



































@end
