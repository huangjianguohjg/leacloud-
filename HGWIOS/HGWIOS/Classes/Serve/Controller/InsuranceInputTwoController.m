//
//  InsuranceInputTwoController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceInputTwoController.h"
#import "GrayLine.h"
#import "HeadView.h"
#import "typeViewCell.h"
#import "GoodsMtypeModel.h"
#import "GoodsStypeModel.h"
#import "InsuranceInputThreeController.h"
#import "InsuranceConfirmController.h"
@interface InsuranceInputTwoController (){
    NSString *identifier;
    UIScrollView *scrollView;
    UITextField *applicanter;
    UITextField *applicantered;
    UITextField *contact;
    UIButton *NextBt;
    NSString *insuranceId ;
    
    UILabel *goodTypeCode;
    UILabel *goodsPackUnit;
    UITextField *wayBillNo;
    UILabel *feeLvValueLabel;
    
    UIView *GoodsTypeView;
    
    NSMutableArray *goodsMtypeList;
    NSMutableArray *goodsStypeList;
    UIView *backView;
    UILabel *mTypeLableNav;
    UIView *mTypeLableViewNav;
    
    UILabel *sTypeLableNav;
    UIView *sTypeLableViewNav;
    
    NSString *goods_mtype_code;
    NSString *goods_stype_code;
    
    NSString *goods_mtype_name;
    NSString *goods_stype_name;
    
    NSString *temp_goods_mtype_code;//临时大分类
    NSString *temp_goods_stype_code;//临时小分类
    
    NSString *temp_goods_stype_name;//临时小分类
    
    NSString *mtype_rate;
    NSString *deductible_statement;
    NSMutableArray *unitList;
    UIView *UinitView;
    NSString *unitSelected;
    AFFNumericKeyboard *keyboard;
    
    
    NSString *selectTypeName;//货物种类
    NSString *slectedRatio;//选中利率
    
    UIButton *zhongleiokBt;
    
    InsuranceModel *SelfInsuranceModel;
    
    NSIndexPath *goodsMtypeIndexPath;//大类选中
    UIView *head;
    Boolean isSelectedTwo;
}

@end

@implementation InsuranceInputTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"填写保单";
    
    [self setUpUI];
    
}



-(void)setUpUI
{
    keyboard = [[AFFNumericKeyboard alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 216)];
    keyboard.delegate = self;
    
    
    [self WriteContent];
    
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
    UIView *navView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) type:2];
    [scrollView addSubview:navView];
    
    if (self.isEdit) {
        navView.gjcf_height = 0;
    }
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, navView.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [scrollView addSubview:grayLine];
    
    //种类
    UIView *goodsTypeView = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    goodsTypeView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:goodsTypeView];
    
    UILabel *goodsTypeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, goodsTypeView.gjcf_height)];
    goodsTypeNameLabel.text= @"种类";
    goodsTypeNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    goodsTypeNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [goodsTypeView addSubview:goodsTypeNameLabel];
    
    goodTypeCode = [[UILabel alloc]initWithFrame:CGRectMake((goodsTypeNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 30-goodsTypeNameLabel.gjcf_right -[CommonDimensStyle smallMargin]), goodsTypeView.gjcf_height)];
    goodTypeCode.textAlignment = NSTextAlignmentRight;
    [goodTypeCode setText:@"请选择"];
    goodTypeCode.textColor = [CommonFontColorStyle D0D4D7Color];
    goodTypeCode.font =[CommonFontColorStyle MenuSizeFont];
    [goodsTypeView addSubview:goodTypeCode];
    
    UITapGestureRecognizer *oilDateGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goodTypeCodelick:)];
    oilDateGesture1.numberOfTapsRequired=1;
    goodTypeCode.userInteractionEnabled = YES;
    [goodTypeCode addGestureRecognizer:oilDateGesture1];
    
    UIImageView *goodTypeimage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[CommonDimensStyle smallMargin] - 13), (goodsTypeView.gjcf_height- 13)/2, 13, 13)];
    goodTypeimage.image = [UIImage imageNamed:@"form_icon_arrow"];
    [goodsTypeView addSubview:goodTypeimage];
    
    UITapGestureRecognizer *oilDateGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goodTypeCodelick:)];
    oilDateGesture.numberOfTapsRequired=1;
    goodTypeimage.userInteractionEnabled = YES;
    [goodTypeimage addGestureRecognizer:oilDateGesture];
    
    //横线
    GrayLine* grayLine2 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], goodsTypeView.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine2];
    
    //名称
    UIView *applicanteredNameview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine2.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    applicanteredNameview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:applicanteredNameview];
    
    UILabel *applicanteredNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    applicanteredNameLabel.text= @"名称";
    applicanteredNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    applicanteredNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [applicanteredNameview addSubview:applicanteredNameLabel];
    
    applicantered = [[UITextField alloc]initWithFrame:CGRectMake((applicanteredNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-applicanteredNameLabel.gjcf_right ), applicanteredNameview.gjcf_height)];
    applicantered.textAlignment = NSTextAlignmentRight;
    applicantered.textColor = [CommonFontColorStyle I3Color];
    applicantered.font =[CommonFontColorStyle MenuSizeFont];
    applicantered.placeholder =@"如:黄沙";
    //    applicantered.text =self.oldInsuranceModel.goods_name;
    [applicanteredNameview addSubview:applicantered];
    
    //横线
    GrayLine* grayLine3 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], applicanteredNameview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine3];
    
    //数量
    UIView *contactview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine3.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    contactview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:contactview];
    
    UILabel *contactNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    contactNameLabel.text= @"数量";
    contactNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    contactNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [contactview addSubview:contactNameLabel];
    
    contact = [[UITextField alloc]initWithFrame:CGRectMake((contactNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-contactNameLabel.gjcf_right ), contactview.gjcf_height)];
    contact.textAlignment = NSTextAlignmentRight;
    contact.inputView = keyboard;
    contact.textColor = [CommonFontColorStyle I3Color];
    contact.font =[CommonFontColorStyle MenuSizeFont];
    contact.placeholder = @"填写数量";
    //    contact.text =self.oldInsuranceModel.goods_pack_qty;
    [contactview addSubview:contact];
    
    //横线
    GrayLine* grayLine4 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], contactview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine4];
    
    //单位
    UIView *contactMobileview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine4.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    contactMobileview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:contactMobileview];
    
    UILabel *contactMobileLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    contactMobileLabel.text= @"单位";
    contactMobileLabel.textColor = [CommonFontColorStyle FontNormalColor];
    contactMobileLabel.font =[CommonFontColorStyle MenuSizeFont];
    [contactMobileview addSubview:contactMobileLabel];
    
    goodsPackUnit = [[UILabel alloc]initWithFrame:CGRectMake((contactMobileLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 30-contactMobileLabel.gjcf_right -[CommonDimensStyle smallMargin]), contactMobileview.gjcf_height)];
    goodsPackUnit.textAlignment = NSTextAlignmentRight;
    [goodsPackUnit setText:@"吨"];
    goodsPackUnit.textColor = [CommonFontColorStyle I3Color];
    goodsPackUnit.font =[CommonFontColorStyle MenuSizeFont];
    [contactMobileview addSubview:goodsPackUnit];
    
    UITapGestureRecognizer *goodsPackUnitGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Unitclick:)];
    goodsPackUnitGesture1.numberOfTapsRequired=1;
    goodsPackUnit.userInteractionEnabled = YES;
    [goodsPackUnit addGestureRecognizer:goodsPackUnitGesture1];
    
    UIImageView *goodsPackUnitimage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[CommonDimensStyle smallMargin] - 13), (contactMobileview.gjcf_height- 13)/2, 13, 13)];
    goodsPackUnitimage.image = [UIImage imageNamed:@"form_icon_arrow"];
    [contactMobileview addSubview:goodsPackUnitimage];
    
    UITapGestureRecognizer *goodsPackUnitimageGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Unitclick:)];
    goodsPackUnitimageGesture.numberOfTapsRequired=1;
    goodsPackUnitimage.userInteractionEnabled = YES;
    [goodsPackUnitimage addGestureRecognizer:goodsPackUnitimageGesture];
    
    //横线
    GrayLine* grayLine5 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], contactMobileview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine5];
    
    //单据号
    UIView *wayBillNoview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine5.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    wayBillNoview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:wayBillNoview];
    
    UILabel *wayBillNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 53, applicanteredNameview.gjcf_height)];
    wayBillNoLabel.text= @"单据号";
    wayBillNoLabel.textColor = [CommonFontColorStyle FontNormalColor];
    wayBillNoLabel.font =[CommonFontColorStyle MenuSizeFont];
    [wayBillNoview addSubview:wayBillNoLabel];
    
    UILabel *xuantianLabel = [[UILabel alloc]initWithFrame:CGRectMake(wayBillNoLabel.gjcf_right, 0, 50, applicanteredNameview.gjcf_height)];
    xuantianLabel.text= @"(选填)";
    xuantianLabel.textColor = [CommonFontColorStyle FontSecondColor];
    xuantianLabel.font =[CommonFontColorStyle SmallSizeFont];
    [wayBillNoview addSubview:xuantianLabel];
    
    
    wayBillNo = [[UITextField alloc]initWithFrame:CGRectMake((xuantianLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-xuantianLabel.gjcf_right ), wayBillNoview.gjcf_height)];
    wayBillNo.textAlignment = NSTextAlignmentRight;
    wayBillNo.placeholder= @"填写发票号或运单号";
    
    wayBillNo.textColor = [CommonFontColorStyle I3Color];
    wayBillNo.font =[CommonFontColorStyle MenuSizeFont];
    
    [wayBillNoview addSubview:wayBillNo];
    
    //横线
    GrayLine* grayLine6 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], wayBillNoview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine6];
    
    //费率
    UIView *feeLvview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine6.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    feeLvview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:feeLvview];
    
    UILabel *feeLvLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    feeLvLabel.text= @"费率";
    feeLvLabel.textColor = [CommonFontColorStyle FontNormalColor];
    feeLvLabel.font =[CommonFontColorStyle MenuSizeFont];
    [feeLvview addSubview:feeLvLabel];
    
    feeLvValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - [CommonDimensStyle smallMargin]), feeLvLabel.gjcf_height)];
    feeLvValueLabel.textColor = [CommonFontColorStyle RedColor];
    feeLvValueLabel.font =[CommonFontColorStyle SmallSizeFont];
    feeLvValueLabel.textAlignment = NSTextAlignmentRight;
    [feeLvview addSubview:feeLvValueLabel];
    //    if (self.oldInsuranceModel != nil) {
    //        feeLvValueLabel.text = [self turnToPercent:self.oldInsuranceModel.ratio];
    //    }
    
    //横线
    GrayLine* grayLine7 = [[GrayLine alloc]initWithFrame:CGRectMake(0, feeLvview.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5)];
    [scrollView addSubview:grayLine7];
    
    //下一步
    NextBt= [[UIButton alloc] initWithFrame:CGRectMake( CommonDimensStyle.smallMargin , (grayLine7.gjcf_bottom +CommonDimensStyle.topMargin), (CommonDimensStyle.screenWidth - 2*CommonDimensStyle.smallMargin ), CommonDimensStyle.btHeight)];
    
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"2dabff")  Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateNormal];
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"0f92ea") Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateHighlighted];
    
    [NextBt setBackgroundColor:XXJColor(27, 69, 138)];
    
    NextBt.layer.cornerRadius =CommonDimensStyle.smallCornerRadius;
    if (self.isEdit) {
        [NextBt setTitle:@"确认保存" forState:UIControlStateNormal];
    }else{
        [NextBt setTitle:@"下一步(运输信息)" forState:UIControlStateNormal];
    }
    NextBt.titleLabel.font =[CommonFontColorStyle ButtonTextFont];
    [NextBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    [NextBt addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:NextBt];
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = [CommonFontColorStyle LoadingColor];
    [self.view addSubview:backView];
    
    UITapGestureRecognizer *backViewGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewclick:)];
    backViewGesture1.numberOfTapsRequired=1;
    backView.userInteractionEnabled = YES;
    [backView addGestureRecognizer:backViewGesture1];
    
    UISwipeGestureRecognizer *backViewrecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backViewclick:)];
    [backViewrecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [backView addGestureRecognizer:backViewrecognizer];
    backView.hidden = YES;
}

-(void)navigationInfo{
    
}


#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag ==1) {
        return 1;
    }else{
        return 1;
    }
    
    
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
        return goodsMtypeList.count;
    }else if(collectionView.tag == 2){
        return goodsStypeList.count;
    }
    else{
        return unitList.count;
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
    typeViewCell *typeViewCellI = (typeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
    
    if (collectionView.tag == 1) {
        GoodsMtypeModel *goodsMtypeModel =(GoodsMtypeModel *)goodsMtypeList[indexPath.row];
        
        [typeViewCellI initwithContent:goodsMtypeModel.name Id:goodsMtypeModel.id Code:goodsMtypeModel.code];
        
        if([goods_mtype_code isEqualToString:goodsMtypeModel.code]){
            goodsMtypeIndexPath =indexPath;
        }
    }else if (collectionView.tag == 2) {
        GoodsStypeModel *goodsStypeModel =(GoodsStypeModel *)goodsStypeList[indexPath.row];
        
        [typeViewCellI initwithContent:goodsStypeModel.name Id:goodsStypeModel.id Code:goodsStypeModel.code Rate:goodsStypeModel.rate Deductible_statement:goodsStypeModel.deductible_statement];
    }else{
        NSString *unitName =(NSString *)unitList[indexPath.row];
        
        [typeViewCellI init:unitName];
    }
    
    
    return typeViewCellI;
    
}



//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self closeAllShow];
    
    typeViewCell * cell = (typeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:YES];
    if (collectionView.tag == 1) {
        isSelectedTwo = NO;
        [self setSelectedBt:1];
        zhongleiokBt.hidden = NO;
        temp_goods_mtype_code = cell.code;
        NSString *parameterstring = [NSString stringWithFormat:@"\"main_code_id\":\"%@\"",cell.id];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetSubCodeListMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            goodsStypeList = [[NSMutableArray alloc]init];
            if (result != nil) {
                NSDictionary *boatresult =[result objectForKey:@"result"];
                
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    NSArray *list = [boatresult objectForKey:@"data"];
                    if( ![list isEqual:[NSNull null]]&&  list != nil &&[list count] >0){
                        for(int i = 0; i < list.count;i ++){
                            GoodsStypeModel *goodsstypeModel = [GoodsStypeModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                            [goodsStypeList addObject:goodsstypeModel];
                        }
                    }
                    
                }
            }
            
            self.GoodsStypecollectionView.gjcf_height  =GoodsTypeView.gjcf_height - 44*2;
            
            [self.GoodsStypecollectionView reloadData];
            [self setMainTypeContent:2];
            
            if (![GJCFStringUitil stringIsNull:goods_stype_code]) {
                for (int i = 0; i <goodsStypeList.count; i++) {
                    if ([goods_stype_code isEqualToString:((GoodsStypeModel *)goodsStypeList[i]).code]) {
                        NSIndexPath *path= [self.GoodsStypecollectionView indexPathForItemAtPoint:CGPointMake(20, i*44 +10)];
                        [self.GoodsStypecollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
                    }
                }
            }
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
        
    }else if (collectionView.tag == 2){
        isSelectedTwo = YES;
        temp_goods_stype_code = cell.code;
        mtype_rate = cell.rate;
        deductible_statement = cell.deductible_statement;
        temp_goods_stype_name = cell.name;//货物种类
        slectedRatio =cell.rate;//选中利率
        
    }else{
        unitSelected = cell.name;
    }
        
        
    
}

-(void)startInsurance{
    NSString *parameterstring = [NSString stringWithFormat:@"\"uid\":\"%@\",\"source\":\"2\"",[UseInfo shareInfo].uID];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:StartInsuranceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                insuranceId = [boatresult objectForKey:@"id"];

            }else{
                
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
            
            
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}




-(void)nextClick{

    if([GJCFStringUitil stringIsNull:goods_mtype_code]){
        [self.view makeToast:@"种类不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if([GJCFStringUitil stringIsNull:goods_stype_code]){
        [self.view makeToast:@"种类不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    NSString *goods_name =applicantered.text;
    if([GJCFStringUitil stringIsNull:goods_name]){
        [self.view makeToast:@"名称不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    NSString *goods_pack_qty =contact.text;
    if([GJCFStringUitil stringIsNull:goods_pack_qty]){
        [self.view makeToast:@"数量不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    NSString *goods_pack_unit =goodsPackUnit.text;
    if([GJCFStringUitil stringIsNull:goods_pack_unit]){
        [self.view makeToast:@"单位不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    int goods_pack_unit_num = -1;
    for(int i =0 ;i<unitList.count; i++){
        if ([unitList[i] isEqualToString:goods_pack_unit]) {
            goods_pack_unit_num = i;
            break;
        }
    }
    
    
    NSString *way_bill_no =wayBillNo.text;
    if([GJCFStringUitil stringIsNull:deductible_statement]){
        [self.view makeToast:@"请重新选择种类" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    
    [NextBt setUserInteractionEnabled:NO];
    NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\",\"goods_mtype_code\":\"%@\",\"goods_stype_code\":\"%@\",\"goods_name\":\"%@\",\"goods_pack_qty\":\"%@\",\"goods_pack_unit\":\"%d\",\"way_bill_no\":\"%@\",\"deductible_statement\":\"%@\"",self.InsuranceId,goods_mtype_code,goods_stype_code,goods_name,goods_pack_qty,goods_pack_unit_num,way_bill_no,deductible_statement];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:SaveGoodsInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                if (self.isEdit) {
                    InsuranceConfirmController *insuranceConfirmController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                    insuranceConfirmController.InsuranceId = self.InsuranceId;
                    [self.navigationController popToViewController:insuranceConfirmController animated:YES];
                    
                }else{
                    
                    InsuranceInputThreeController *insuranceInputThreeController = [[InsuranceInputThreeController alloc]init];
                    insuranceInputThreeController.InsuranceId = self.InsuranceId;
                    //                insuranceInputThreeController.oldInsuranceModel = self.oldInsuranceModel;
                    [self.navigationController pushViewController:insuranceInputThreeController animated:YES];
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



-(void)InitgoodsTypeView{
    if (GoodsTypeView== NULL) {
        GoodsTypeView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        GoodsTypeView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:GoodsTypeView ];
        
        UIView *GoodsTypeHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [GoodsTypeHeadView setBackgroundColor:[CommonFontColorStyle ebBackgroudColor]];
        [GoodsTypeView addSubview:GoodsTypeHeadView];
        
        UILabel *GoodsTypetitle = [[UILabel alloc]initWithFrame:GoodsTypeHeadView.frame];
        GoodsTypetitle.text = @"货物种类";
        GoodsTypetitle.textColor = [CommonFontColorStyle I3Color];
        GoodsTypetitle.font = [CommonFontColorStyle MenuSizeFont];
        GoodsTypetitle.textAlignment = NSTextAlignmentCenter;
        [GoodsTypeHeadView addSubview:GoodsTypetitle];
        
        UIButton *cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, GoodsTypeHeadView.gjcf_height)];
        [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBt setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
        cancelBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [GoodsTypeHeadView addSubview: cancelBt];
        [cancelBt addTarget:self action:@selector(GoodsTypeCancel) forControlEvents:UIControlEventTouchUpInside];
        
        zhongleiokBt = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 60), 0, 50, GoodsTypeHeadView.gjcf_height)];
        [zhongleiokBt setTitle:@"确认" forState:UIControlStateNormal];
        [zhongleiokBt setTitleColor:[CommonFontColorStyle BlueColor] forState:UIControlStateNormal];
        zhongleiokBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [GoodsTypeHeadView addSubview: zhongleiokBt];
        [zhongleiokBt addTarget:self action:@selector(GoodsTypeSelect) forControlEvents:UIControlEventTouchDown];
        zhongleiokBt.hidden = YES;
        
        UIView *GoodsTypeNavigationView = [[UIView alloc]initWithFrame:CGRectMake(0, GoodsTypeHeadView.gjcf_bottom, SCREEN_WIDTH, 44)];
        [GoodsTypeNavigationView setBackgroundColor:[CommonFontColorStyle WhiteColor]];
        [GoodsTypeView addSubview:GoodsTypeNavigationView];
        
        //wifi充值
        UIView *mTypeNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GoodsTypeView.gjcf_width/2, GoodsTypeNavigationView.gjcf_height)];
        [GoodsTypeNavigationView addSubview:mTypeNav];
        
        UITapGestureRecognizer *wifiGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mTypeNavClick:)];
        wifiGesture.numberOfTapsRequired=1;
        [mTypeNav addGestureRecognizer:wifiGesture];
        //文字
        mTypeLableNav = [[UILabel alloc]initWithFrame:CGRectMake(mTypeNav.gjcf_width/5, 0, mTypeNav.gjcf_width*3/5, mTypeNav.gjcf_height)];
        [mTypeNav addSubview:mTypeLableNav];
        mTypeLableNav.text = @"大分类";
        mTypeLableNav.font = [CommonFontColorStyle NormalSizeFont];
        mTypeLableNav.textColor = [CommonFontColorStyle BlueColor];
        mTypeLableNav.textAlignment = NSTextAlignmentCenter;
        //下面蓝色
        mTypeLableViewNav = [[UIView alloc]initWithFrame:CGRectMake(mTypeNav.gjcf_width/5, (mTypeNav.gjcf_height-2), mTypeNav.gjcf_width*3/5, 2)];
        mTypeLableViewNav.backgroundColor = [CommonFontColorStyle BlueColor];
        [mTypeNav addSubview:mTypeLableViewNav];
        
        //监控流量充值
        UIView *sTypeNav = [[UIView alloc]initWithFrame:CGRectMake(GoodsTypeNavigationView.gjcf_width/2, 0, GoodsTypeNavigationView.gjcf_width/2, GoodsTypeNavigationView.gjcf_height)];
        [GoodsTypeNavigationView addSubview:sTypeNav];
        
        UITapGestureRecognizer *monitorGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sTypeNavClick:)];
        monitorGesture.numberOfTapsRequired=1;
        [sTypeNav addGestureRecognizer:monitorGesture];
        //文字
        sTypeLableNav = [[UILabel alloc]initWithFrame:CGRectMake(sTypeNav.gjcf_width/5, 0, sTypeNav.gjcf_width*3/5, sTypeNav.gjcf_height)];
        [sTypeNav addSubview:sTypeLableNav];
        sTypeLableNav.text = @"子分类";
        sTypeLableNav.font = [CommonFontColorStyle NormalSizeFont];
        sTypeLableNav.textColor = [CommonFontColorStyle BlueColor];
        sTypeLableNav.textAlignment = NSTextAlignmentCenter;
        //下面蓝色
        sTypeLableViewNav = [[UIView alloc]initWithFrame:CGRectMake(sTypeNav.gjcf_width/5, (sTypeNav.gjcf_height-2), sTypeNav.gjcf_width*3/5, 2)];
        sTypeLableViewNav.backgroundColor = [CommonFontColorStyle BlueColor];
        [sTypeNav addSubview:sTypeLableViewNav];
        sTypeLableViewNav.hidden = YES;
        
        GrayLine *subGrayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, GoodsTypeNavigationView.gjcf_bottom-0.5, GoodsTypeHeadView.gjcf_width, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
        [GoodsTypeView addSubview:subGrayLine];
        
        
        
        UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0.0f;
        self.GoodsMtypecollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, GoodsTypeNavigationView.gjcf_bottom, GoodsTypeHeadView.gjcf_width, 300) collectionViewLayout:flowLayout];
        self.GoodsMtypecollectionView.backgroundColor = [UIColor whiteColor];
        self.GoodsMtypecollectionView.tag = 1;
        
        [GoodsTypeView addSubview:self.GoodsMtypecollectionView];
        //注册单元格
        [self.GoodsMtypecollectionView registerClass:[typeViewCell class]forCellWithReuseIdentifier:identifier];
        self.GoodsMtypecollectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
        
        //设置代理
        self.GoodsMtypecollectionView.delegate = self;
        self.GoodsMtypecollectionView.dataSource = self;
        
        
        UICollectionViewFlowLayout * sTypeFlowLayout =[[UICollectionViewFlowLayout alloc] init];
        [sTypeFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        sTypeFlowLayout.minimumLineSpacing = 0.0f;
        self.GoodsStypecollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.GoodsMtypecollectionView.gjcf_right, GoodsTypeNavigationView.gjcf_bottom, GoodsTypeHeadView.gjcf_width, 300) collectionViewLayout:sTypeFlowLayout];
        self.GoodsStypecollectionView.backgroundColor = [UIColor whiteColor];
        
        [GoodsTypeView addSubview:self.GoodsStypecollectionView];
        //注册单元格
        [self.GoodsStypecollectionView registerClass:[typeViewCell class]forCellWithReuseIdentifier:identifier];
        self.GoodsStypecollectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
        self.GoodsStypecollectionView.tag = 2;
        //设置代理
        self.GoodsStypecollectionView.delegate = self;
        self.GoodsStypecollectionView.dataSource = self;
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetMainCodeListMethod parameters:nil finished:^(id result) {
            [SVProgressHUD dismiss];
            
            goodsMtypeList = [[NSMutableArray alloc]init];
            
            if (result != nil) {
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    NSArray *list = [boatresult objectForKey:@"data"];
                    if( ![list isEqual:[NSNull null]]&&  list != nil &&[list count] >0){
                        for(int i = 0; i < list.count;i ++){
                            GoodsMtypeModel *goodsMtypeModel = [GoodsMtypeModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                            if ([SelfInsuranceModel.goods_mtype_code isEqualToString:goodsMtypeModel.code]) {
                                goods_mtype_name =goodsMtypeModel.name;
                                goods_mtype_code =  SelfInsuranceModel.goods_mtype_code;
                            }
                            [goodsMtypeList addObject:goodsMtypeModel];
                        }
                    }
                    
                }
 
            }
            
            //重新设置高度
            long dateNewHeight = 0;
            if (goodsMtypeList.count <= 5 ) {
                dateNewHeight = 44*(goodsMtypeList.count +2);
            }else{
                dateNewHeight = 44*7;
            }
            GoodsTypeView.gjcf_height = dateNewHeight;
            self.GoodsMtypecollectionView.gjcf_height = dateNewHeight - 44*2;
            GoodsTypeView.gjcf_top = SCREEN_HEIGHT;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.GoodsMtypecollectionView reloadData];
                [self setGoodsTypeDefault];
            });
    
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
    }
}


//设置单位默认
-(void)setGoodsTypeDefault{
    //设置默认
    if(SelfInsuranceModel != nil){
        
        for (int i = 0; i <goodsMtypeList.count; i++) {
            if ([SelfInsuranceModel.goods_mtype_code isEqualToString:((GoodsMtypeModel *)goodsMtypeList[i]).code]) {
                NSIndexPath *path= [self.GoodsMtypecollectionView indexPathForItemAtPoint:CGPointMake(20, i*44 +10)];
                [self.GoodsMtypecollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
                goods_mtype_code = ((GoodsMtypeModel *)goodsMtypeList[i]).code;
                
            }
        }
    }
}

-(void)InitUnitView{
    if (UinitView== NULL) {
        UinitView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        UinitView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:UinitView ];
        
        UIView *UinitHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [UinitHeadView setBackgroundColor:[CommonFontColorStyle ebBackgroudColor]];
        [UinitView addSubview:UinitHeadView];
        
        UILabel *Uinittitle = [[UILabel alloc]initWithFrame:UinitHeadView.frame];
        Uinittitle.text = @"单位";
        Uinittitle.textColor = [CommonFontColorStyle I3Color];
        Uinittitle.font = [CommonFontColorStyle MenuSizeFont];
        Uinittitle.textAlignment = NSTextAlignmentCenter;
        [UinitHeadView addSubview:Uinittitle];
        
        UIButton *cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, UinitHeadView.gjcf_height)];
        [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBt setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
        cancelBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [UinitHeadView addSubview: cancelBt];
        [cancelBt addTarget:self action:@selector(unitCancel) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *okBt = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 60), 0, 50, UinitHeadView.gjcf_height)];
        [okBt setTitle:@"确认" forState:UIControlStateNormal];
        [okBt setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
        okBt.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
        [UinitHeadView addSubview: okBt];
        [okBt addTarget:self action:@selector(unitSelect) forControlEvents:UIControlEventTouchDown];
        
        
        
        GrayLine *subGrayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, UinitHeadView.gjcf_bottom-0.5, UinitHeadView.gjcf_width, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
        [UinitView addSubview:subGrayLine];
        
        
        
        UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0.0f;
        self.UnitcollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, subGrayLine.gjcf_bottom, UinitView.gjcf_width, 300) collectionViewLayout:flowLayout];
        self.UnitcollectionView.backgroundColor = [UIColor whiteColor];
        self.UnitcollectionView.tag = 3;
        
        [UinitView addSubview:self.UnitcollectionView];
        //注册单元格
        [self.UnitcollectionView registerClass:[typeViewCell class]forCellWithReuseIdentifier:identifier];
        self.UnitcollectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
        
        //设置代理
        self.UnitcollectionView.delegate = self;
        self.UnitcollectionView.dataSource = self;
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:GetUnitList URLMethod:GetUnitListMethod parameters:nil finished:^(id result) {
            [SVProgressHUD dismiss];
            
            if (result != nil) {
                
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    unitList = [boatresult objectForKey:@"list"];
                    if(SelfInsuranceModel != nil){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            long code =  [GJCFStringUitil stringToInt:SelfInsuranceModel.goods_pack_unit ] ;
                            goodsPackUnit.text = unitList[code];
                        });
                    }
                }
            }
            
            //重新设置高度
            long dateNewHeight = 0;
            if (unitList.count <= 5 ) {
                dateNewHeight = 44*(unitList.count +1);
            }else{
                dateNewHeight = 44*6;
            }
            UinitView.gjcf_height = dateNewHeight;
            self.UnitcollectionView.gjcf_height = dateNewHeight - 44;
            UinitView.gjcf_top = SCREEN_HEIGHT;
            [self.UnitcollectionView reloadData];
            
            [self setUnitDefault];

        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
 
    }
}




//设置单位默认
-(void)setUnitDefault{
    //设置默认
    if(SelfInsuranceModel != nil){
        long code =  [GJCFStringUitil stringToInt:SelfInsuranceModel.goods_pack_unit ] ;
        
        NSIndexPath *path= [self.UnitcollectionView indexPathForItemAtPoint:CGPointMake(20, code*44 +10)];
        [self.UnitcollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
        unitSelected = unitList[code];
    }
}


//种类点击
- (void)goodTypeCodelick:(UITapGestureRecognizer *)sender{
    [self closeAllShow];
    //    [self hideKeyBoard];
    [self setInfoViewFrame:YES Index:0];
}

//种类点击
- (void)Unitclick:(UITapGestureRecognizer *)sender{
    [self closeAllShow];
    [self setInfoViewFrame:YES Index:1];
}

//关闭所有的弹出窗口
-(void)closeAllShow{
    [self.view endEditing:YES];
}


- (void)setInfoViewFrame:(BOOL)isDown Index:(int)index{
    UIView *infoView;
    if (index ==0) {
        infoView =GoodsTypeView;
    }else if(index ==1){
        infoView =UinitView;
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

-(void)setMainTypeContent:(int)type{
    if (type ==1) {
        self.GoodsMtypecollectionView.gjcf_left = 0;
        self.GoodsStypecollectionView.gjcf_left  = self.GoodsMtypecollectionView.gjcf_width;
    }else{
        self.GoodsMtypecollectionView.gjcf_left = self.GoodsMtypecollectionView.gjcf_width *-1;
        self.GoodsStypecollectionView.gjcf_left  = 0;
        
    }
}

-(void)unitCancel{
    [self setInfoViewFrame:NO Index:1];
}
-(void)unitSelect{
    goodsPackUnit.text =unitSelected;
    [self setInfoViewFrame:NO Index:1];
}


#pragma mark 数量自定义键盘
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
    
    if (contact.text.length != 0)
    {
        contact.text = [contact.text substringToIndex:contact.text.length -1];
    }
    
}

- (void)numberKeyBoardFinish{
    [contact resignFirstResponder];
}

-(void)numberKeyboardInput:(NSInteger)number{
    int num = (int)number;
    contact.text = [contact.text stringByAppendingString:[NSString stringWithFormat:@"%d",num]];
    
    NSMutableString *textString = [[NSMutableString alloc]initWithFormat:@"%@",contact.text];
    NSString *regex = @"^(\\d{0,10}.{0,1}[0-9]{0,4})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = false;
    
    isMatch = [pred evaluateWithObject:textString];
    if (!isMatch) {
        if (textString.length >0) {
            contact.text = [textString substringToIndex:(textString.length -1)];
        }
    }else{
        contact.text = textString;
    }
}


- (void)writeInRadixPoint{
    if (![contact.text containsString:@"."]) {
        contact.text = [contact.text stringByAppendingString:[NSString stringWithFormat:@"%@",@"."]];
    }
}


-(void)WriteContent{
    NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"access_token\":\"%@\"",self.InsuranceId,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetInsuranceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result)
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if ([boatresult isEqual:[NSNull null]]) {
                return ;
            }
            
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                InsuranceModel *insuranceModel = [InsuranceModel mj_objectWithKeyValues:[boatresult objectForKey:@"data"] ];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self initValue:insuranceModel];
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

-(void)initValue:(InsuranceModel *)insuranceValue{
    
    
    [self initView];
    [self InitgoodsTypeView];
    [self KeyBoardHidden];
    [self InitUnitView];
    
    //赋初值
    applicantered.text = insuranceValue.goods_name;
    if(![GJCFStringUitil stringIsNull:insuranceValue.goods_pack_qty] && ![insuranceValue.goods_pack_qty isEqualToString:@"0"]){
        contact.text = insuranceValue.goods_pack_qty;
    }
    if(insuranceValue.way_bill_no != nil){
        wayBillNo.text = insuranceValue.way_bill_no;
    }
    feeLvValueLabel.text =  [NSString stringWithFormat:@"%@%%",[self turnToPercent:insuranceValue.ratio]];
    goods_mtype_code = insuranceValue.goods_mtype_code;
    goods_stype_code = insuranceValue.goods_stype_code;
    
    temp_goods_mtype_code =insuranceValue.goods_mtype_code;
    temp_goods_stype_code = insuranceValue.goods_stype_code;
    [self getZhongLeiName:insuranceValue.goods_mtype_code Stype_code:insuranceValue.goods_stype_code];
    SelfInsuranceModel = insuranceValue;
    
    deductible_statement = insuranceValue.deductible_statement;
}


-(void)getZhongLeiName:(NSString *)main_code_id Stype_code:(NSString *)stype_code{
    NSString *parameterstring = [NSString stringWithFormat:@"\"main_code_id\":\"%@\"",main_code_id];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetSubCodeListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"data"];
                if( ![list isEqual:[NSNull null]]&&  list != nil &&[list count] >0){
                    for(int i = 0; i < list.count;i ++){
                        GoodsStypeModel *goodsstypeModel = [GoodsStypeModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                        if ([stype_code isEqualToString:goodsstypeModel.code]) {
                            goods_stype_name =goodsstypeModel.name;
                            break;
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        goodTypeCode.text = goods_stype_name;
                        goodTypeCode.textColor = [CommonFontColorStyle I3Color];
                        goods_stype_code =  stype_code;
                    });
                }
                
            }
            
            
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}

-(void)setSelectedBt:(int)type{
    if (type == 0) {
        mTypeLableNav.textColor = [CommonFontColorStyle BlueColor];
        mTypeLableViewNav.hidden = NO;
        sTypeLableNav.textColor = [CommonFontColorStyle FontSecondColor];
        sTypeLableViewNav.hidden = YES;
    }else{
        mTypeLableNav.textColor = [CommonFontColorStyle FontSecondColor];
        mTypeLableViewNav.hidden = YES;
        sTypeLableNav.textColor = [CommonFontColorStyle BlueColor];
        sTypeLableViewNav.hidden = NO;
    }
}
-(void)GoodsTypeCancel{
    [self setInfoViewFrame:NO Index:0];
}



-(void)GoodsTypeSelect{
    if(!isSelectedTwo){
        [self.view makeToast:@"子分类不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if ([GJCFStringUitil stringIsNull:temp_goods_mtype_code]||[GJCFStringUitil stringIsNull:temp_goods_stype_code]) {
        [self.view makeToast:@"种类不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    [self setInfoViewFrame:NO Index:0];
    goods_mtype_code = temp_goods_mtype_code;
    goods_stype_code = temp_goods_stype_code;
    if ([GJCFStringUitil stringIsNull:temp_goods_stype_name]) {
        temp_goods_stype_name =goodTypeCode.text;
    }
    selectTypeName =temp_goods_stype_name;
    
    goodTypeCode.text = selectTypeName;
    goodTypeCode.textColor = [CommonFontColorStyle I3Color];
    
    feeLvValueLabel.text = [NSString stringWithFormat:@"%@%%",[self turnToPercent:slectedRatio]];
    
    if ([temp_goods_stype_name isEqualToString:@"粮谷类（非集装箱运输）"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"受潮、霉变除外！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

//转化为百分数
-(NSString *)turnToPercent:(NSString *)value{
    NSString *ratioNstring = [NSString stringWithFormat:@"%f",[GJCFStringUitil stringToFloat:value]*100];
    while ([[ratioNstring substringFromIndex:ratioNstring.length - 1] isEqualToString:@"0"]) {
        ratioNstring =[ratioNstring substringToIndex:(ratioNstring.length - 1)];
    }
    return ratioNstring;
}

- (void)mTypeNavClick:(UITapGestureRecognizer *)sender{
    
    [self setSelectedBt:0];
    [self setMainTypeContent:1];
    
}



- (void)sTypeNavClick:(UITapGestureRecognizer *)sender{
    if([GJCFStringUitil stringIsNull:temp_goods_mtype_code ]){
        [self.view makeToast:@"请选择大分类" duration:0.5 position:CSToastPositionCenter];
    }else{
        [self setSelectedBt:1];
        [self setMainTypeContent:2];
        zhongleiokBt.hidden = NO;
        //如果有数据则显示，没有数据就加载
        if(goodsStypeList == nil){
            NSString *parameterstring = [NSString stringWithFormat:@"\"main_code_id\":\"%@\"",temp_goods_mtype_code];
            
            [SVProgressHUD show];
            
            [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetSubCodeListMethod parameters:parameterstring finished:^(id result) {
                [SVProgressHUD dismiss];
                
                goodsStypeList = [[NSMutableArray alloc]init];
                if (result != nil) {
                    NSDictionary *boatresult =[result objectForKey:@"result"];
                    if ([[boatresult objectForKey:@"status"] boolValue]) {
                        NSArray *list = [boatresult objectForKey:@"data"];
                        if( ![list isEqual:[NSNull null]]&&  list != nil &&[list count] >0){
                            for(int i = 0; i < list.count;i ++){
                                GoodsStypeModel *goodsstypeModel = [GoodsStypeModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                                [goodsStypeList addObject:goodsstypeModel];
                            }
                        }
                    }
                }
                
                //重新设置高度
                
                self.GoodsStypecollectionView.gjcf_height = GoodsTypeView.gjcf_height - 44*2;
                
                [self.GoodsStypecollectionView reloadData];
                [self setMainTypeContent:2];
                
                if (![GJCFStringUitil stringIsNull:goods_stype_code]) {
                    for (int i = 0; i <goodsStypeList.count; i++) {
                        if ([goods_stype_code isEqualToString:((GoodsStypeModel *)goodsStypeList[i]).code]) {
                            NSIndexPath *path= [self.GoodsStypecollectionView indexPathForItemAtPoint:CGPointMake(20, i*44 +10)];
                            [self.GoodsStypecollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
                        }
                    }
                }
                
                
                
                
                
            } errored:^(NSError *error) {
                [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
                
                [SVProgressHUD dismiss];
            }];
            
            
        }
    }
}

- (void)backViewclick:(UITapGestureRecognizer *)sender{
    [self setInfoViewFrame:NO Index:0];
    [self setInfoViewFrame:NO Index:1];
}

























@end
