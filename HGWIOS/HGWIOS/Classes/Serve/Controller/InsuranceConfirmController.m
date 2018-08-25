//
//  InsuranceConfirmController.m
//  HGWIOS
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceConfirmController.h"
#import "GrayLine.h"
#import "InsuranceModel.h"
#import "BaoxianViewController.h"
#import "InsuranceInputTwoController.h"
#import "InsuranceInputThreeController.h"
#import "InsuranceInputFourEditController.h"
#import "InsuranceReceiptDetailController.h"
#import "InsuranceSampleController.h"
#import "MyInsurancesController.h"
#import "InsurancePictureController.h"
#import "MyInsurancesController.h"
@interface InsuranceConfirmController ()
{
    UIScrollView *scrollView;
    InsuranceModel *insuranceModel;
    
    UIView *holderNameView;
    UIView *recognizeeNameView;
    UIView *contactPersonView;
    UIView *contactPhoneView;
    UIView *goodsTypeCodeView;
    UIView *goodsNameView;
    UIView *goodsPackQtyView;
    UIView *goodsPackUnitView;
    UIView *wayBillNoView;
    UIView *feelvView;
    UIView *shipNameView;
    UIView *shipAgeView;
    UIView *shipContactPhoneView;
    UIView *fromLocView;
    UIView *toLocView;
    UIView *departureDateView;
    UIView *insuredAmountFeeView;
    UIView *baofeiView;
    UIView *noReceiptView;
    UIView *receiptView;
    UIView *emailAddressView;
    UILabel*  AddressName;
    UILabel* AddressPhone;
    UILabel *AddressfeeContentLabel;
    UILabel *AddressAddress;
    UIView *fiveMainView;
    UIView *fourMainView;
    GrayLine* grayLine31;
    UILabel *AddressfeeLabel;
    UILabel *AddressfeeUnitLabel;
    UILabel *totalPriceLabel;
    UILabel *showZhiPiaoLabel;
    UIView *fiveView;
    UILabel *haspayLabel;
}
@end

@implementation InsuranceConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    
    [self setUpNav];
    
    self.IsShowDetail = (self.IsShowDetail == nil ? NO : self.IsShowDetail);
    
    [self setUpUI];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self getInsurance];
}

-(void)setUpNav
{
    self.navigationItem.title = @"确认保单";
    
    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    if (self.IsShowBack) {
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    }
    else
    {
        [leftButton setTitle:@"我的保单" forState:UIControlStateNormal];
    }
    
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    UIButton * rightButton = [[UIButton alloc]init];
    [rightButton addTarget:self action:@selector(rightItem) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"保单样例" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [rightButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [rightButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
    
    
}

-(void)leftItem
{
//
//    self.navigationController popToRootViewControllerAnimated:<#(BOOL)#>
    if (self.IsShowBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        MyInsurancesController * myInsuranceVc = [[MyInsurancesController alloc]init];
        myInsuranceVc.isInputOneVc = NO;
        [self.navigationController pushViewController:myInsuranceVc animated:YES];
    }
    
    
}


-(void)rightItem
{
    InsurancePictureController * pictureVc = [[InsurancePictureController alloc]init];
    [self.navigationController pushViewController:pictureVc animated:YES];
}


-(void)setUpUI
{
    // 1.创建UIScrollView
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, kStatusBarHeight+ kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarHeight - kNavigationBarHeight - 50 ); // frame中的size指UIScrollView的可视范围
    [self.view addSubview:scrollView];
    
    //第一个
    UIView *firstMainView = [[UIView alloc]init];
    [scrollView addSubview:firstMainView];
    
    UIView *firstView =[self TitleBaseView:@"投保信息" Y:0];
    [firstMainView addSubview:firstView];
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, firstView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [firstMainView addSubview:grayLine];
    
    //投保人
    holderNameView = [self BaseView:@"投保人" Content:@"" Y:grayLine.gjcf_bottom];
    [firstMainView addSubview:holderNameView];
    
    
    //被保险人
    recognizeeNameView = [self BaseView:@"被保险人" Content:@"" Y:holderNameView.gjcf_bottom];
    [firstMainView addSubview:recognizeeNameView];
    
    
    //联系人
    contactPersonView = [self BaseView:@"联系人" Content:@"" Y:recognizeeNameView.gjcf_bottom];
    [firstMainView addSubview:contactPersonView];
    
    
    //联系电话
    contactPhoneView = [self BaseViewNoLine:@"联系电话" Content:@"" Y:contactPersonView.gjcf_bottom];
    [firstMainView addSubview:contactPhoneView];
    
    //横线
    GrayLine* grayLine4 = [[GrayLine alloc]initWithFrame:CGRectMake(0, contactPhoneView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [firstMainView addSubview:grayLine4];
    
    firstMainView.frame = CGRectMake(0, 0, scrollView.gjcf_width, grayLine4.gjcf_bottom) ;
    
    if (!self.IsShowDetail) {
        UITapGestureRecognizer *firstGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstMainViewclick:)];
        firstGesture.numberOfTapsRequired=1;
        firstMainView.userInteractionEnabled = YES;
        [firstMainView addGestureRecognizer:firstGesture];
    }
    
    
    //第二个
    
    UIView *secondMainView =[[UIView alloc]init ];
    [scrollView addSubview:secondMainView];
    
    UIView *secondView =[self TitleBaseView:@"货物信息" Y:0];
    [secondMainView addSubview:secondView];
    
    //横线
    GrayLine* grayLine5 = [[GrayLine alloc]initWithFrame:CGRectMake(0, secondView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [secondMainView addSubview:grayLine5];
    
    //种类
    goodsTypeCodeView = [self BaseView:@"种类" Content:@"" Y:grayLine5.gjcf_bottom];
    [secondMainView addSubview:goodsTypeCodeView];
    
    //名称
    goodsNameView = [self BaseView:@"名称" Content:@"" Y:goodsTypeCodeView.gjcf_bottom];
    [secondMainView addSubview:goodsNameView];
    
    //数量
    goodsPackQtyView = [self BaseView:@"数量" Content:@"" Y:goodsNameView.gjcf_bottom];
    [secondMainView addSubview:goodsPackQtyView];
    
    //数量
    goodsPackUnitView = [self BaseView:@"单位" Content:@"" Y:goodsPackQtyView.gjcf_bottom];
    [secondMainView addSubview:goodsPackUnitView];
    
    //单据号
    wayBillNoView = [self BaseView:@"单据号" Content:@"" Y:goodsPackUnitView.gjcf_bottom];
    [secondMainView addSubview:wayBillNoView];
    
    
    //费率
    feelvView = [self BaseViewNoLine:@"费率" Content:@"" Y:wayBillNoView.gjcf_bottom];
    [secondMainView addSubview:feelvView];
    
    //横线
    GrayLine* grayLine10 = [[GrayLine alloc]initWithFrame:CGRectMake(0, feelvView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [secondMainView addSubview:grayLine10];
    
    secondMainView.frame = CGRectMake(0, firstMainView.gjcf_bottom, scrollView.gjcf_width, grayLine10.gjcf_bottom);
    
    if (!self.IsShowDetail) {
        UITapGestureRecognizer *secondGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secondMainViewclick:)];
        secondGesture.numberOfTapsRequired=1;
        secondMainView.userInteractionEnabled = YES;
        [secondMainView addGestureRecognizer:secondGesture];
    }
    
    
    //第三个
    UIView *threeMainView =[[UIView alloc]init ];
    [scrollView addSubview:threeMainView];
    
    UIView *threeView =[self TitleBaseView:@"运输信息" Y:0];
    [threeMainView addSubview:threeView];
    
    //横线
    GrayLine* grayLine11 = [[GrayLine alloc]initWithFrame:CGRectMake(0, threeView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [threeMainView addSubview:grayLine11];
    
    //船名
    shipNameView = [self BaseView:@"船名" Content:@"" Y:grayLine11.gjcf_bottom];
    [threeMainView addSubview:shipNameView];
    
    //横线
    GrayLine* grayLine12 = [[GrayLine alloc]initWithFrame:CGRectMake(10, shipNameView.gjcf_bottom, CommonDimensStyle.screenWidth-20 , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [threeMainView addSubview:grayLine12];
    
    //船龄
    shipAgeView = [self BaseView:@"船龄" Content:@"" Y:grayLine12.gjcf_bottom];
    [threeMainView addSubview:shipAgeView];
    
    //横线
    GrayLine* grayLine13 = [[GrayLine alloc]initWithFrame:CGRectMake(0, shipAgeView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [threeMainView addSubview:grayLine13];
    
    //联系方式
    shipContactPhoneView = [self BaseView:@"联系电话" Content:@"" Y:grayLine13.gjcf_bottom];
    [threeMainView addSubview:shipContactPhoneView];
    
    //横线
    GrayLine* grayLine14 = [[GrayLine alloc]initWithFrame:CGRectMake(0, shipContactPhoneView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle RedColor]];
    [threeMainView addSubview:grayLine14];
    
    //起运地
    fromLocView = [self BaseView:@"起运地" Content:@"" Y:grayLine14.gjcf_bottom];
    [threeMainView addSubview:fromLocView];
    
    //横线
    GrayLine* grayLine15 = [[GrayLine alloc]initWithFrame:CGRectMake(0, fromLocView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [threeMainView addSubview:grayLine15];
    
    //目的地
    toLocView = [self BaseView:@"目的地" Content:@"" Y:grayLine15.gjcf_bottom];
    [threeMainView addSubview:toLocView];
    
    //横线
    GrayLine* grayLine16 = [[GrayLine alloc]initWithFrame:CGRectMake(0, toLocView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [threeMainView addSubview:grayLine16];
    
    //起运时间
    departureDateView = [self BaseViewNoLine:@"起运时间" Content:@"" Y:grayLine16.gjcf_bottom];
    [threeMainView addSubview:departureDateView];
    
    //横线
    GrayLine* grayLine17 = [[GrayLine alloc]initWithFrame:CGRectMake(0, departureDateView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [threeMainView addSubview:grayLine17];
    
    threeMainView.frame = CGRectMake(0, secondMainView.gjcf_bottom, scrollView.gjcf_width, grayLine17.gjcf_bottom);
    
    if (!self.IsShowDetail) {
        UITapGestureRecognizer *threeGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(threeMainViewclick:)];
        threeGesture.numberOfTapsRequired=1;
        threeMainView.userInteractionEnabled = YES;
        [threeMainView addGestureRecognizer:threeGesture];
    }
    
    //第四个
    fourMainView =[[UIView alloc]init ];
    [scrollView addSubview:fourMainView];
    
    UIView *fourView =[self TitleBaseView:@"保险信息" Y:0];
    [fourMainView addSubview:fourView];
    
    //横线
    GrayLine* grayLine18 = [[GrayLine alloc]initWithFrame:CGRectMake(0, fourView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [fourMainView addSubview:grayLine18];
    
    //保险金额
    insuredAmountFeeView = [self BaseView:@"保险金额" Content:@"" Y:grayLine18.gjcf_bottom];
    [fourMainView addSubview:insuredAmountFeeView];
    
    //横线
    GrayLine* grayLine19 = [[GrayLine alloc]initWithFrame:CGRectMake(0, insuredAmountFeeView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [fourMainView addSubview:grayLine19];
    
    //船龄
    baofeiView = [self BaseViewNoLine:@"保费" Content:@"" Y:grayLine19.gjcf_bottom];
    [fourMainView addSubview:baofeiView];
    
    //横线
    GrayLine* grayLine20 = [[GrayLine alloc]initWithFrame:CGRectMake(0, baofeiView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [fourMainView addSubview:grayLine20];
    
    
    fourMainView.frame = CGRectMake(0, threeMainView.gjcf_bottom, scrollView.gjcf_width, grayLine20.gjcf_bottom);
    
    if (!self.IsShowDetail) {
        UITapGestureRecognizer *fourGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourMainViewclick:)];
        fourGesture.numberOfTapsRequired=1;
        fourMainView.userInteractionEnabled = YES;
        [fourMainView addGestureRecognizer:fourGesture];
    }
    //第五个
    fiveMainView =[[UIView alloc]init ];
    [scrollView addSubview:fiveMainView];
    
    
    fiveView =[self TitleBaseView:@"发票信息" Y:0];
    [fiveMainView addSubview:fiveView];
    
    //横线
    GrayLine* grayLine30 = [[GrayLine alloc]initWithFrame:CGRectMake(0, fiveView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [fiveMainView addSubview:grayLine30];
    
    noReceiptView = [self BaseViewNoLine :@"无需发票" Content:@"" Y:grayLine30.gjcf_bottom];
    [fiveMainView addSubview:noReceiptView];
    
    
    //
    //有发票信息
    //
    receiptView = [self BaseViewNoLine:@"发票信息" Content:@"" Y:noReceiptView.gjcf_bottom];
    [fiveMainView addSubview:receiptView];
    
    //横线
    grayLine31 = [[GrayLine alloc]initWithFrame:CGRectMake(0, receiptView.gjcf_bottom, CommonDimensStyle.screenWidth , 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [fiveMainView addSubview:grayLine31];
    
    //有邮件地址
    emailAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine31.gjcf_bottom, SCREEN_WIDTH, 82)];
    emailAddressView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [fiveMainView addSubview:emailAddressView];
    
    
    AddressName = [[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 20, 60,14)];
    AddressName.textColor = [CommonFontColorStyle I3Color];
    AddressName.font =[CommonFontColorStyle SmallSizeFont];
    [emailAddressView addSubview:AddressName];
    
    AddressPhone = [[UILabel alloc]initWithFrame:CGRectMake(AddressName.gjcf_right+10, 20, 200,14)];
    
    AddressPhone.textColor = [CommonFontColorStyle I3Color];
    AddressPhone.font =[CommonFontColorStyle SmallSizeFont];
    
    [emailAddressView addSubview:AddressPhone];
    
    
    AddressfeeLabel = [[UILabel alloc]initWithFrame:CGRectMake((emailAddressView.gjcf_right - 100), 20, 50,14)];
    AddressfeeLabel.text = @"邮费:";
    AddressfeeLabel.textColor = [CommonFontColorStyle I3Color];
    AddressfeeLabel.font =[CommonFontColorStyle SmallSizeFont];
    [AddressfeeLabel sizeToFit];
    [emailAddressView addSubview:AddressfeeLabel];
    
    AddressfeeContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(AddressfeeLabel.gjcf_right, 20, 35,14)];
    AddressfeeContentLabel.textColor = [CommonFontColorStyle RedColor];
    AddressfeeContentLabel.font =[CommonFontColorStyle SmallSizeFont];
    
    [emailAddressView addSubview:AddressfeeContentLabel];
    
    AddressfeeUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(AddressfeeContentLabel.gjcf_right, 22, 35,14)];
    AddressfeeUnitLabel.text = @"元";
    AddressfeeUnitLabel.textColor = [CommonFontColorStyle I3Color];
    AddressfeeUnitLabel.font =[CommonFontColorStyle SmallSizeFont];
    [emailAddressView addSubview:AddressfeeUnitLabel];
    
    AddressAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, AddressName.gjcf_bottom+10, (SCREEN_WIDTH - 20),32)];
    AddressAddress.numberOfLines = 0;
    AddressAddress.textColor = [CommonFontColorStyle FontNormalColor];
    AddressAddress.font =[CommonFontColorStyle SmallSizeFont];
    [emailAddressView addSubview:AddressAddress];
    
    
    fiveMainView.frame = CGRectMake(0, fourMainView.gjcf_bottom, scrollView.gjcf_width, emailAddressView.gjcf_bottom);
    
    
    //横线
    //    GrayLine* grayLine22 = [[GrayLine alloc]initWithFrame:CGRectMake(0, fiveMainView.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    //    [fiveMainView addSubview:grayLine22];
    
    
    if (!self.IsShowDetail) {
        UITapGestureRecognizer *fiveGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fiveMainViewclick:)];
        fiveGesture.numberOfTapsRequired=1;
        fiveMainView.userInteractionEnabled = YES;
        [fiveMainView addGestureRecognizer:fiveGesture];
    }
    CGSize cgsize = CGSizeMake(SCREEN_WIDTH, (fiveMainView.gjcf_bottom));
    scrollView.contentSize = cgsize;
    // 隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    
    float baseColor = 239.0/255.0;
    for (float i=SCREEN_HEIGHT-60; i<(SCREEN_HEIGHT-50); i++) {
        float a1=(float)(i-SCREEN_HEIGHT+60)/10.0;
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, i, self.view.gjcf_width, 1)];
        view1.backgroundColor=[UIColor colorWithRed:baseColor green:baseColor blue:baseColor alpha:a1];
        //        view1.backgroundColor=[CommonFontColorStyle RedColor];
        [self.view addSubview:view1];
    }
    
    //底部
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview: bottomView];
    
    UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 0, 40, bottomView.gjcf_height)];
    totalLabel.text = @"合计:";
    totalLabel.textColor = [CommonFontColorStyle I3Color];
    totalLabel.font = [CommonFontColorStyle NormalSizeFont];
    [bottomView addSubview:totalLabel];
    
    UILabel *totalUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(totalLabel.gjcf_right, 0, 10, bottomView.gjcf_height)];
    totalUnitLabel.text = @"¥";
    totalUnitLabel.textColor = [CommonFontColorStyle RedColor];
    totalUnitLabel.font = [CommonFontColorStyle NormalSizeFont];
    [bottomView addSubview:totalUnitLabel];
    
    totalPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(totalUnitLabel.gjcf_right, 0, 100, bottomView.gjcf_height)];
    
    totalPriceLabel.textColor = [CommonFontColorStyle RedColor];
    totalPriceLabel.font = [CommonFontColorStyle NormalSizeFont];
    [bottomView addSubview:totalPriceLabel];
    
    if(self.IsShowDetail){
        UIView *hasPayView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 115, 0, 115, bottomView.gjcf_height)];
        hasPayView.backgroundColor = [CommonFontColorStyle EBF46Color];
        [bottomView addSubview:hasPayView];
        
        int imagepayWidth = 20;
        UIImageView *haspayImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, (hasPayView.gjcf_height - imagepayWidth)/2, imagepayWidth, imagepayWidth)];
        haspayImage.image = [UIImage imageNamed:@"ins_icon_gou2"];
        [hasPayView addSubview: haspayImage];
        
        haspayLabel = [[UILabel alloc]init];
        haspayLabel.text = @"已提交";
        haspayLabel.numberOfLines = 0;
        haspayLabel.textColor = [CommonFontColorStyle WhiteColor];
        haspayLabel.font = [CommonFontColorStyle BigSizeFont];
        [hasPayView addSubview:haspayLabel];
        [haspayLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(hasPayView).offset(haspayImage.gjcf_right+5);
            make.centerY.equalTo(hasPayView);
            make.size.equalTo(CGSizeMake(60, bottomView.gjcf_height));
        }];
    }else{
        UIButton *payBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 115, 0, 115, bottomView.gjcf_height)];
        [payBt setTitle:@"提交审核" forState:UIControlStateNormal];
        payBt.titleLabel.font = [CommonFontColorStyle BigSizeFont];
        payBt.titleLabel.textColor = [CommonFontColorStyle WhiteColor];
        [payBt setBackgroundImage:[UIImage singleColorImageRect:[CommonFontColorStyle WhiteVerCan] Width:payBt.gjcf_width Height:payBt.gjcf_height] forState:UIControlStateNormal];
        [bottomView addSubview:payBt];
        [payBt addTarget:self action:@selector(payMoneyClick) forControlEvents:UIControlEventTouchUpInside];
    }
    showZhiPiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 115 - 105, 0, 90, bottomView.gjcf_height)];
    showZhiPiaoLabel.text  = @"含发票邮费";
    showZhiPiaoLabel.textColor = [CommonFontColorStyle FontNormalColor];
    showZhiPiaoLabel.font = [CommonFontColorStyle SmallSizeFont];
    [bottomView addSubview:showZhiPiaoLabel];

    
    
    
    
    
    
}



-(UIView *)BaseView:(NSString *)title Content:(NSString *)content  Y:(int)y{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, 45)];
    view.backgroundColor = [CommonFontColorStyle WhiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 15, 50, 15)];
    titleLabel.text = title;
    titleLabel.textColor = [CommonFontColorStyle FontNormalColor];
    titleLabel.font = [CommonFontColorStyle NormalSizeFont];
    [view addSubview:titleLabel];
    [titleLabel sizeToFit];
    
    //后面内容
    UILabel *ContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, (SCREEN_WIDTH - titleLabel.gjcf_right- [CommonDimensStyle smallMargin]), view.gjcf_height)];
    ContentLabel.text = content;
    ContentLabel.tag =2;
    ContentLabel.textColor = [CommonFontColorStyle I3Color];
    ContentLabel.font = [CommonFontColorStyle NormalSizeFont];
    ContentLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:ContentLabel];
    
    GrayLine* grayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], view.gjcf_height-0.5, (view.gjcf_width - 2*[CommonDimensStyle smallMargin]), 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [view addSubview:grayLine1];
    return view;
}

-(UIView *)BaseViewNoLine:(NSString *)title Content:(NSString *)content  Y:(int)y{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, 45)];
    view.backgroundColor = [CommonFontColorStyle WhiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 15, 50, 15)];
    titleLabel.text = title;
    titleLabel.textColor = [CommonFontColorStyle FontNormalColor];
    titleLabel.font = [CommonFontColorStyle NormalSizeFont];
    [view addSubview:titleLabel];
    [titleLabel sizeToFit];
    
    //后面内容
    UILabel *ContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, (SCREEN_WIDTH - titleLabel.gjcf_right- [CommonDimensStyle smallMargin]), view.gjcf_height)];
    ContentLabel.text = content;
    ContentLabel.tag =2;
    ContentLabel.textColor = [CommonFontColorStyle I3Color];
    ContentLabel.font = [CommonFontColorStyle NormalSizeFont];
    ContentLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:ContentLabel];
    
    return view;
}

-(void)setContent:(NSString *)content View:(UIView *)mainView{
    for (UIView *item in mainView.subviews) {
        if ([item isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)item;
            if (label.tag == 2) {
                label.text = content;
                break;
            }
            
            
        }
    }
}
-(UIView *)TitleBaseView:(NSString *)title   Y:(int)y{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, 50)];
    view.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 0, SCREEN_WIDTH- 40, view.gjcf_height)];
    titleLabel.text = title;
    titleLabel.textColor = [CommonFontColorStyle B8CA0Color];
    titleLabel.font = [CommonFontColorStyle NormalSizeFont];
    [view addSubview:titleLabel];
    
    if (!self.IsShowDetail) {
        int imageWidth = 20;
        UIImageView *editImage = [[UIImageView alloc]initWithFrame: CGRectMake(SCREEN_WIDTH- 30,(view.gjcf_height - imageWidth)/2 , imageWidth, imageWidth)];
        editImage.image = [UIImage imageNamed:@"ins_icon_edit"];
        [view addSubview:editImage];
    }
    return view;
}

-(void)getInsurance{
    NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"access_token\":\"%@\"",self.InsuranceId,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetInsuranceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                
                haspayLabel.text = boatresult[@"data"][@"status_name"];
                
                insuranceModel = [InsuranceModel mj_objectWithKeyValues:[boatresult objectForKey:@"data"]];
                
                [self setContent:insuranceModel.holder_name View: holderNameView];
                [self setContent:insuranceModel.recognizee_name View: recognizeeNameView];
                [self setContent:insuranceModel.contact_person View: contactPersonView];
                [self setContent:insuranceModel.contact_phone View: contactPhoneView];
                //种类
                NSString *goodName = [NSString stringWithFormat:@"%@/%@",insuranceModel.goods_type.m_name,insuranceModel.goods_type.st_name];
                [self setContent:goodName View: goodsTypeCodeView];
                [self setContent:insuranceModel.goods_name View: goodsNameView];
                [self setContent:insuranceModel.goods_pack_qty View: goodsPackQtyView];
                [self setContent:insuranceModel.goods_pack_unit_show View: goodsPackUnitView];
                NSString *wayBillNo =insuranceModel.way_bill_no;
                if ([GJCFStringUitil stringIsNull:wayBillNo]) {
                    wayBillNo = @"";
                }
                [self setContent:wayBillNo View: wayBillNoView];
                
                NSString *insuranceRatio = [NSString stringWithFormat:@"%.3f",[GJCFStringUitil stringToDouble:insuranceModel.ratio]*100];
                while ([[insuranceRatio substringFromIndex:insuranceRatio.length - 1] isEqualToString:@"0"]) {
                    insuranceRatio =[insuranceRatio substringToIndex:(insuranceRatio.length - 1)];
                }
                
                [self setContent:[NSString stringWithFormat:@"%@%%",insuranceRatio] View: feelvView];
                
                [self setContent:insuranceModel.ship_name View: shipNameView];
                
                [self setContent:insuranceModel.ship_age View: shipAgeView];
                [self setContent:insuranceModel.ship_contact_phone View: shipContactPhoneView];
                [self setContent:insuranceModel.from_loc View: fromLocView];
                [self setContent:insuranceModel.to_loc View: toLocView];
                [self setContent:insuranceModel.departure_date_show View: departureDateView];
                if ([GJCFStringUitil stringIsNull:insuranceModel.insured_amount_fee]) {
                    insuranceModel.insured_amount_fee = @"0";
                }
                [self setContent:[NSString stringWithFormat:@"%@元",insuranceModel.insured_amount_fee] View: insuredAmountFeeView];
                [self setContent:[NSString stringWithFormat:@"%@元",insuranceModel.insured_fee] View: baofeiView];
                totalPriceLabel.text=insuranceModel.total_fee;
                
                InvoiceModel*invoiceModel= insuranceModel.invoice;
                Boolean invoiceIsNotNull = NO;
                if (![GJCFStringUitil stringIsNull:invoiceModel.recipient]) {
                    invoiceIsNotNull = YES;
                }
                
                if (invoiceIsNotNull) {
                    
                    NSString *fiaopiao = [insuranceModel.invoice.invoice_type isEqualToString:@"1" ]?@"增值税普通发票":@"增值税发票";
                    [self setContent:fiaopiao View: receiptView];
                    
                    NSString *localrecipient = insuranceModel.invoice.recipient;
                    if (localrecipient.length > 5) {
                        localrecipient = [NSString stringWithFormat:@"%@...",[localrecipient substringToIndex:5]];
                    }
                    
                    AddressName.text = localrecipient;
                    
                    [AddressName sizeToFit];
                    
                    AddressPhone.gjcf_left = AddressName.gjcf_right + 5;
                    AddressPhone.text = insuranceModel.invoice.recipient_mobile;
                    [AddressPhone sizeToFit];
                    
                    AddressfeeContentLabel.text = insuranceModel.invoice.fee;
                    [AddressfeeContentLabel sizeToFit];
                    
                    AddressfeeLabel.gjcf_left =emailAddressView.gjcf_width -AddressfeeContentLabel.gjcf_width - 60;
                    [AddressfeeLabel sizeToFit];
                    AddressfeeContentLabel.gjcf_left =AddressfeeLabel.gjcf_right;
                    AddressfeeUnitLabel.gjcf_left =AddressfeeContentLabel.gjcf_right;
                    
                    AddressAddress.text = [NSString stringWithFormat:@"%@ %@",insuranceModel.invoice.total_address,insuranceModel.invoice.address_detail];
                    AddressAddress.gjcf_width= (SCREEN_WIDTH - 20);
                    [AddressAddress sizeToFit];
                    emailAddressView.gjcf_height = AddressAddress.gjcf_bottom + 20;
                    
                    noReceiptView.gjcf_height = 0;
                    receiptView.gjcf_top = noReceiptView.gjcf_bottom;
                    receiptView.gjcf_height = 45;
                    receiptView.hidden = NO;
                    grayLine31.gjcf_top =receiptView.gjcf_bottom;
                    emailAddressView.gjcf_top = grayLine31.gjcf_bottom;
                    emailAddressView.hidden = NO;
                    fiveMainView.frame = CGRectMake(0, fourMainView.gjcf_bottom, scrollView.gjcf_width, emailAddressView.gjcf_bottom);
                    CGSize cgsize = CGSizeMake(SCREEN_WIDTH, (fiveMainView.gjcf_bottom));
                    scrollView.contentSize = cgsize;
                    showZhiPiaoLabel.hidden = NO;
                }else{
                    noReceiptView.gjcf_height = 45;
                    receiptView.gjcf_top = noReceiptView.gjcf_bottom;
                    receiptView.gjcf_height = 0;
                    receiptView.hidden = YES;
                    grayLine31.gjcf_top =receiptView.gjcf_bottom;
                    grayLine31.gjcf_height = 0;
                    emailAddressView.gjcf_top = grayLine31.gjcf_bottom;
                    emailAddressView.gjcf_height = 0;
                    emailAddressView.hidden = YES;
                    fiveMainView.frame = CGRectMake(0, fourMainView.gjcf_bottom, scrollView.gjcf_width, emailAddressView.gjcf_bottom);
                    CGSize cgsize = CGSizeMake(SCREEN_WIDTH, (fiveMainView.gjcf_bottom));
                    scrollView.contentSize = cgsize;
                    showZhiPiaoLabel.hidden = YES;
                    
                    if(self.IsShowDetail){
                        fiveView.hidden = YES;
                        noReceiptView.hidden = YES;
                        CGSize cgsize = CGSizeMake(SCREEN_WIDTH, (fourMainView.gjcf_bottom));
                        scrollView.contentSize = cgsize;
                        showZhiPiaoLabel.hidden = YES;
                        
                    }
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


-(void)payMoneyClick{
    if ([GJCFStringUitil stringIsNull:insuranceModel.goods_stype_code]) {
        [self.view makeToast:@"请填写信息完整" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if([GJCFStringUitil stringIsNull:insuranceModel.total_fee] ||[GJCFStringUitil stringToDouble:insuranceModel.total_fee] == 0){
        [self.view makeToast:@"保费应大于零" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\"",self.InsuranceId];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:CheckInsuranceParamByIdMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                
                [self commitBaodan];
                
            }else{
                
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
}

//提交保单
-(void)commitBaodan
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\"",self.InsuranceId];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:ChangeMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                
                MyInsurancesController * myInsuranceVc = [[MyInsurancesController alloc]init];
                myInsuranceVc.isInputOneVc = NO;
                [self.navigationController pushViewController:myInsuranceVc animated:YES];
                
            }else{
                
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}



//第一个点击
- (void)firstMainViewclick:(UITapGestureRecognizer *)sender{
    BaoxianViewController *insuranceInputOneController = [[BaoxianViewController alloc]init];
    insuranceInputOneController.insuranceId = self.InsuranceId;
    insuranceInputOneController.isEdit = YES;
    [self.navigationController pushViewController:insuranceInputOneController animated:YES];
}

//第二个点击
- (void)secondMainViewclick:(UITapGestureRecognizer *)sender{
    InsuranceInputTwoController *insuranceInputTwoController = [[InsuranceInputTwoController alloc]init];
    insuranceInputTwoController.InsuranceId = self.InsuranceId;
    insuranceInputTwoController.isEdit = YES;
    [self.navigationController pushViewController:insuranceInputTwoController animated:YES];
}

//第三个点击
- (void)threeMainViewclick:(UITapGestureRecognizer *)sender{
    InsuranceInputThreeController *insuranceInputThreeController = [[InsuranceInputThreeController alloc]init];
    insuranceInputThreeController.InsuranceId = self.InsuranceId;
    insuranceInputThreeController.isEdit = YES;
    [self.navigationController pushViewController:insuranceInputThreeController animated:YES];
}

//第四个点击
- (void)fourMainViewclick:(UITapGestureRecognizer *)sender{
    InsuranceInputFourEditController *insuranceInputFourController = [[InsuranceInputFourEditController alloc]init];
    insuranceInputFourController.InsuranceId = self.InsuranceId;
    [self.navigationController pushViewController:insuranceInputFourController animated:YES];
}

//第四个点击
- (void)fiveMainViewclick:(UITapGestureRecognizer *)sender{
    InsuranceReceiptDetailController *insuranceReceiptDetailController = [[InsuranceReceiptDetailController alloc]init];
    insuranceReceiptDetailController.InsuranceId = self.InsuranceId;
    [self.navigationController pushViewController:insuranceReceiptDetailController animated:YES];
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
    
    if (!self.IsShowDetail) {
        UIButton *sampleButton = [[UIButton alloc]initWithFrame:CGRectMake(head.gjcf_width-90, 0, 80, head.gjcf_height)];
        [sampleButton setTitle:@"保单样例" forState:UIControlStateNormal];
        [sampleButton setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
        sampleButton.titleLabel.font = [CommonFontColorStyle detailBigTitleFont];
        [sampleButton addTarget:self action:@selector(sampleClick) forControlEvents:UIControlEventTouchUpInside];
        [head addSubview:sampleButton];
    }
    
    //返回按钮
    UIView *backView =  [[UIView alloc]initWithFrame:CGRectMake(10, 0, 80, head.gjcf_height)];
    [head addSubview:backView];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 11, 14, 22)];
    backImage.image = [UIImage imageNamed:@"nav_arrow"];
    [backView addSubview:backImage];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake((backImage.gjcf_right), 0, 80, head.gjcf_height)];
    if(self.IsShowBack){
        backLabel.text = @"返回";
    }else{
        backLabel.text = @"我的保单";
    }
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
    InsuranceSampleController *insuranceSampleController = [[InsuranceSampleController alloc]init];
    [self.navigationController pushViewController:insuranceSampleController animated:YES];
}

-(void)exitevent:(id)sender{
    if (self.IsShowBack) {
        MyInsurancesController *myInsurancesController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        [self.navigationController popToViewController:myInsurancesController animated:YES];
    }else{
        MyInsurancesController *myInsurancesController = [[MyInsurancesController alloc]init];
        [self.navigationController pushViewController:myInsurancesController animated:YES];
    }
}


















































@end
