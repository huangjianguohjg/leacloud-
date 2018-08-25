//
//  InsuranceInputFourController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceInputFourController.h"
#import "InsuranceAddressModel.h"
#import "GrayLine.h"
#import "HeadView.h"
#import "InsurancePriceModel.h"
#import "InsuranceTiaoKuanViewController.h"
#import "InsuranceXuZhiViewController.h"
#import "InsuranceAddressListController.h"
#import "InsuranceAddAddressController.h"
#import "InsuranceReceiptController.h"
#import "InsuranceConfirmController.h"
@interface InsuranceInputFourController (){
    NSString *identifier;
    UIScrollView *scrollView;
    UITextField *insuredAmountFee;
    UILabel *applicantered;
    UITextField *contact;
    UITextField *contactMobile;
    UIButton *NextBt;
    
    
    UILabel *goodTypeCode;
    UILabel *goodsPackUnit;
    UITextField *wayBillNo;
    UILabel *feeLvValueLabel;
    
    ZYRadioButton *rb1;
    ZYRadioButton *rb2;
    
    int identy;
    UIView *downView;
    UIView *downTwoView;
    UIView *addressView;
    AFFNumericKeyboard *keyboard;
    UILabel *receiptNoContentLabel;
    UILabel *receiptContentLabel;
    UIView *noAddressView;
    InsuranceModel *thisInsuranceModel;
    GrayLine* grayLine6;
    UIView *TotaldressView;
    Boolean isHasFaPiao;
    UILabel *AddressfeeContentLabel;
    GrayLine* grayLine8;
    UILabel *AddressName;
    UILabel *AddressPhone;
    UILabel *AddressfeeUnitLabel;
    UILabel *AddressAddress;
    UILabel *AddressfeeLabel;
    UIImageView *receiptimage3;
    
    UIView *noReceiptView;//无发票信息
    UIView *receiptView;//有发票信息
    UIView *noEmailAddressView;//无邮件地址
    UIView *emailAddressView;//有邮件地址
    
    int fapiaoHeight;//发票信息高度
    int noAddressHeight;//没有邮件地址高度
    int addressHeight;//邮件地址高度
    
    int nowType;
    long isInvoice;
    
    InsuranceAddressModel *defaultInsuranceAddressModel;
    
    NSMutableArray *addressList;
    
    UIView *head;
    Boolean isfirst;
}

@end

@implementation InsuranceInputFourController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"填写保单";
    
    [self setUpUI];
    
}




-(void)setUpUI
{
    fapiaoHeight = 52;
    noAddressHeight = 52;
    addressHeight=89;
    isfirst = YES;
    
    keyboard = [[AFFNumericKeyboard alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 216)];
    keyboard.delegate = self;
    
    
    [self KeyBoardHidden];
    [self getEcsList];
    [self setShowContent:nowType];
    
    
    
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //设置显示
    if(self.isNeedFaPiao ||self.isNeedAddress){
        if (self.isNeedFaPiao) {
            receiptContentLabel.text = [self.invoice_type isEqualToString:@"1"]?@"增值税普通发票":@"增值税发票";
            if (nowType == 2||nowType == 4) {
                nowType = 4;
            }else{
                if(defaultInsuranceAddressModel != nil){
                    nowType = 4;
                }else{
                    nowType = 3;}
            }
            [ self setShowContent:nowType];
        }
        
        if(self.isNeedAddress){
            if ([GJCFStringUitil stringIsNull:self.addressId]) {
                if (nowType == 1||nowType == 2) {
                    nowType = 1;
                }else{
                    nowType = 3;
                }
                defaultInsuranceAddressModel = nil;
                self.addressId = @"";
                [self setShowContent:nowType];
            }else{
                NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\"",self.addressId];
                
                [SVProgressHUD show];
                
                [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetMailAddressInfoMethod parameters:parameterstring finished:^(id result) {
                    [SVProgressHUD dismiss];
                    
                    if (result != nil) {
                        NSDictionary *boatresult =[result objectForKey:@"result"];
                        
                        if ([[boatresult objectForKey:@"status"] boolValue]) {
                            InsuranceAddressModel *insuranceAddressModel =[InsuranceAddressModel mj_objectWithKeyValues:[boatresult objectForKey:@"info"]];
                            
                            
                            
                            AddressName.text = insuranceAddressModel.addressee;
                            [AddressName sizeToFit];
                            AddressPhone.text = insuranceAddressModel.mobile;
                            [AddressPhone sizeToFit];
                            AddressPhone.gjcf_left = AddressName.gjcf_right +10;
                            
                            
                            AddressfeeContentLabel.text = insuranceAddressModel.invoice_fee;
                            [AddressfeeContentLabel sizeToFit];
                            
                            AddressfeeLabel.gjcf_left =emailAddressView.gjcf_width - 10-AddressfeeContentLabel.gjcf_width - 65;
                            AddressfeeContentLabel.gjcf_left = AddressfeeLabel.gjcf_right;
                            AddressfeeUnitLabel.gjcf_left = AddressfeeContentLabel.gjcf_right;
                            AddressAddress.text = [NSString stringWithFormat:@"%@ %@",insuranceAddressModel.address,insuranceAddressModel.detail_address];
                            AddressAddress.gjcf_top =AddressName.gjcf_bottom +10;
                            AddressAddress.gjcf_width = SCREEN_WIDTH - 20;
                            [AddressAddress sizeToFit];
                            
                            emailAddressView.gjcf_height = AddressAddress.gjcf_bottom + 20;
                            receiptimage3.gjcf_top =(emailAddressView.gjcf_height- 13)/2;
                            if (nowType == 3||nowType == 4) {
                                nowType = 4;
                            }else{
                                nowType = 2;
                            }
                            
                        }else{
                            //需发票 发票信息无 邮件地址无 1
                            //需发票 发票信息无 邮件地址有 2
                            //需发票 发票信息有 邮件地址无 3
                            //需发票 发票信息有 邮件地址有 4
                            if (nowType == 1||nowType == 2) {
                                nowType = 1;
                            }else{
                                nowType = 3;
                            }
                            defaultInsuranceAddressModel = nil;
                            self.addressId = @"";
                        }
                        
                        [self setShowContent:nowType];
                    }
                    
                    
                    
                } errored:^(NSError *error) {
                    [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
                    
                    [SVProgressHUD dismiss];
                }];
                
            }
        }
        
    }
}


-(void)startView{
    
    //页面初始化
    [self initView];
    
    
}


-(void)initView{
    
    InvoiceModel*invoiceModel= thisInsuranceModel.invoice;
    Boolean invoiceIsNotNull = NO;
    if (![GJCFStringUitil stringIsNull:invoiceModel.recipient]) {
        invoiceIsNotNull = YES;
    }
    
    
    
    identifier = @"cell";
    
    int titleWidth = 70;
    // 1.创建UIScrollView
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, head.gjcf_bottom, SCREEN_WIDTH, ([CommonDimensStyle screenHeight]- head.gjcf_bottom) ); // frame中的size指UIScrollView的可视范围
    [self.view addSubview:scrollView];
    
    //导航条
    UIView *navView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) type:4];
    [scrollView addSubview:navView];
    
    if (self.isEdit) {
        navView.gjcf_height = 0;
    }
    
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, navView.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [scrollView addSubview:grayLine];
    
    //保险金额
    UIView *applicantview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    applicantview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:applicantview];
    
    UILabel *applicantNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicantview.gjcf_height)];
    applicantNameLabel.text= @"保险金额";
    applicantNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    applicantNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [applicantview addSubview:applicantNameLabel];
    
    insuredAmountFee = [[UITextField alloc]initWithFrame:CGRectMake((applicantNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 30-applicantNameLabel.gjcf_right -[CommonDimensStyle smallMargin]), applicantview.gjcf_height)];
    insuredAmountFee.textAlignment = NSTextAlignmentRight;
    insuredAmountFee.placeholder =@"1万-3000万";
    insuredAmountFee.textColor = [CommonFontColorStyle I3Color];
    insuredAmountFee.font =[CommonFontColorStyle MenuSizeFont];
    insuredAmountFee.inputView = keyboard;
    if (thisInsuranceModel != nil) {
        insuredAmountFee.text = thisInsuranceModel.insured_amount_fee;
    }
    [applicantview addSubview:insuredAmountFee];
    
    UILabel *insuredAmountFeeLabel = [[UILabel alloc]initWithFrame:CGRectMake(insuredAmountFee.gjcf_right, 0, 20, applicantview.gjcf_height)];
    insuredAmountFeeLabel.text= @"元";
    insuredAmountFeeLabel.textColor = [CommonFontColorStyle FontNormalColor];
    insuredAmountFeeLabel.font =[CommonFontColorStyle MenuSizeFont];
    insuredAmountFeeLabel.textAlignment = NSTextAlignmentRight;
    [applicantview addSubview:insuredAmountFeeLabel];
    
    //横线
    GrayLine* grayLine2 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], applicantview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine2];
    
    
    
    //保费
    UIView *applicanteredNameview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine2.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    applicanteredNameview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:applicanteredNameview];
    
    UILabel *applicanteredNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 35, applicanteredNameview.gjcf_height)];
    applicanteredNameLabel.text= @"保费";
    applicanteredNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    applicanteredNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [applicanteredNameview addSubview:applicanteredNameLabel];
    
    UILabel *applicanteredNamefuLabel = [[UILabel alloc]initWithFrame:CGRectMake(applicanteredNameLabel.gjcf_right, (applicanteredNameview.gjcf_height -14)/2, 80, 14)];
    NSString *ratioNstring = [NSString stringWithFormat:@"%f",[GJCFStringUitil stringToFloat:thisInsuranceModel.ratio]*100];
    
    while ([[ratioNstring substringFromIndex:ratioNstring.length - 1] isEqualToString:@"0"]) {
        ratioNstring =[ratioNstring substringToIndex:(ratioNstring.length - 1)];
    }
    applicanteredNamefuLabel.text= [NSString stringWithFormat:@"(费率%@%%)",ratioNstring ];
    applicanteredNamefuLabel.textColor = [CommonFontColorStyle FontSecondColor];
    applicanteredNamefuLabel.font =[CommonFontColorStyle SmallSizeFont];
    [applicanteredNamefuLabel sizeToFit];
    [applicanteredNameview addSubview:applicanteredNamefuLabel];
    
    
    
    applicantered = [[UILabel alloc]initWithFrame:CGRectMake((applicanteredNamefuLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 30-applicanteredNamefuLabel.gjcf_right -[CommonDimensStyle smallMargin]), applicanteredNameview.gjcf_height)];
    applicantered.textAlignment = NSTextAlignmentRight;
    applicantered.textColor = [CommonFontColorStyle RedColor];
    applicantered.font =[CommonFontColorStyle MenuSizeFont];
    applicantered.text =@"0.00";
    [applicanteredNameview addSubview:applicantered];
    if (thisInsuranceModel != nil) {
        applicantered.text = thisInsuranceModel.insured_fee;
    }
    
    UILabel *applicantereddanwieLabel = [[UILabel alloc]initWithFrame:CGRectMake(applicantered.gjcf_right, 0, 20, applicanteredNameview.gjcf_height)];
    applicantereddanwieLabel.text= @"元";
    applicantereddanwieLabel.textColor = [CommonFontColorStyle FontNormalColor];
    applicantereddanwieLabel.font =[CommonFontColorStyle MenuSizeFont];
    applicantereddanwieLabel.textAlignment = NSTextAlignmentRight;
    [applicanteredNameview addSubview:applicantereddanwieLabel];
    
    //横线
    GrayLine* grayLine3 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], applicanteredNameview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [scrollView addSubview:grayLine3];
    
    
    
    //免赔条件
    UIView *mianPeiTiaoJianview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine3.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    mianPeiTiaoJianview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:mianPeiTiaoJianview];
    
    UILabel *mianPeiTiaoJianLabel = [[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]), applicanteredNameview.gjcf_height)];
    mianPeiTiaoJianLabel.text= @"免赔条件：保险金额的0.3%";
    mianPeiTiaoJianLabel.textColor = [CommonFontColorStyle FontNormalColor];
    mianPeiTiaoJianLabel.font =[CommonFontColorStyle MenuSizeFont];
    mianPeiTiaoJianLabel.textAlignment = NSTextAlignmentRight;
    [mianPeiTiaoJianview addSubview:mianPeiTiaoJianLabel];
    
    //横线
    GrayLine* grayLine4 = [[GrayLine alloc]initWithFrame:CGRectMake(0, mianPeiTiaoJianview.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5)];
    [scrollView addSubview:grayLine4];
    
    //横线
    GrayLine* grayLine5 = [[GrayLine alloc]initWithFrame:CGRectMake(0, grayLine4.gjcf_bottom +[CommonDimensStyle smallMargin], CommonDimensStyle.screenWidth, 0.5)];
    [scrollView addSubview:grayLine5];
    
    UIView *twoview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine5.gjcf_bottom , CommonDimensStyle.screenWidth, [CommonDimensStyle inputHeight])];
    twoview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:twoview];
    
    //初始化单选按钮控件
    rb1 = [[ZYRadioButton alloc] initWithGroupId:@"ten" index:0 selectedImageName:@"form_choose_yes" unSelectedImageName:@"form_choose_no"];
    
    rb2 = [[ZYRadioButton alloc] initWithGroupId:@"ten" index:1 selectedImageName:@"form_choose_yes" unSelectedImageName:@"form_choose_no"];
    //设置Frame
    float start =(CommonDimensStyle.screenWidth-255)/2;
    rb1.frame = CGRectMake(start,(twoview.gjcf_height-22)/2,22,22);
    rb2.frame = CGRectMake((start+140),(twoview.gjcf_height-22)/2,22,22);
    //添加到视图容器
    [twoview addSubview:rb1];
    [twoview addSubview:rb2];
    
    //初始化第一个单选按钮的UILabel
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(rb1.gjcf_right+4, (twoview.gjcf_height-22)/2, 100, 20)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"无需发票";
    [twoview addSubview:label1];
    UITapGestureRecognizer *chuandongGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chuandongclick:)];
    chuandongGesture.numberOfTapsRequired=1;
    label1.userInteractionEnabled = YES;
    [label1 addGestureRecognizer:chuandongGesture];
    
    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(rb2.gjcf_right+4,(twoview.gjcf_height-22)/2, 100, 20)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"索要发票";
    [twoview addSubview:label2];
    
    UITapGestureRecognizer *huozhuGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(huozhuclick:)];
    huozhuGesture.numberOfTapsRequired=1;
    label2.userInteractionEnabled = YES;
    [label2 addGestureRecognizer:huozhuGesture];
    //按照GroupId添加观察者
    [ZYRadioButton addObserverForGroupId:@"ten" observer:self];
    
    
    //横线
    grayLine6 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], twoview.gjcf_bottom, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    grayLine6.backgroundColor = [UIColor redColor];
    [scrollView addSubview:grayLine6];
    
    
    
    //
    //无发票信息
    //
    noReceiptView = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine6.gjcf_bottom, SCREEN_WIDTH, fapiaoHeight)];
    noReceiptView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:noReceiptView];
    
    UILabel *noreceiptLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, noReceiptView.gjcf_height)];
    noreceiptLabel.text = @"发票信息";
    noreceiptLabel.textColor = [CommonFontColorStyle FontNormalColor];
    noreceiptLabel.font =[CommonFontColorStyle SmallSizeFont];
    [noReceiptView addSubview:noreceiptLabel];
    
    receiptNoContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(noreceiptLabel.gjcf_right +10, 0, (SCREEN_WIDTH - 10 - noreceiptLabel.gjcf_right - 29), noReceiptView.gjcf_height)];
    receiptNoContentLabel.text = @"添加发票信息";
    receiptNoContentLabel.textAlignment = NSTextAlignmentRight;
    receiptNoContentLabel.textColor = [CommonFontColorStyle FontSecondColor];
    receiptNoContentLabel.font =[CommonFontColorStyle SmallSizeFont];
    [noReceiptView addSubview:receiptNoContentLabel];
    
    UIImageView *receiptimage = [[UIImageView alloc]initWithFrame:CGRectMake((receiptNoContentLabel.gjcf_right + 9), (noReceiptView.gjcf_height- 13)/2, 13, 13)];
    receiptimage.image = [UIImage imageNamed:@"form_icon_arrow"];
    [noReceiptView addSubview:receiptimage];
    
    //
    //有发票信息
    //
    receiptView = [[UIView alloc]initWithFrame:CGRectMake(0, noReceiptView.gjcf_bottom, SCREEN_WIDTH, fapiaoHeight)];
    receiptView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:receiptView];
    
    UILabel *receiptLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, receiptView.gjcf_height)];
    receiptLabel.text = @"发票信息";
    receiptLabel.textColor = [CommonFontColorStyle FontNormalColor];
    receiptLabel.font =[CommonFontColorStyle SmallSizeFont];
    [receiptView addSubview:receiptLabel];
    
    receiptContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(receiptLabel.gjcf_right +10, 0, (SCREEN_WIDTH - 10 - receiptLabel.gjcf_right - 29), receiptView.gjcf_height)];
    receiptContentLabel.textAlignment = NSTextAlignmentRight;
    receiptContentLabel.textColor = [CommonFontColorStyle I3Color];
    receiptContentLabel.font =[CommonFontColorStyle SmallSizeFont];
    if(thisInsuranceModel.invoice != nil){
        receiptContentLabel.text = [thisInsuranceModel.invoice.invoice_type isEqualToString:@"1" ]?@"增值税普通发票":@"增值税发票";
    }
    [receiptView addSubview:receiptContentLabel];
    
    UIImageView *receiptimage2 = [[UIImageView alloc]initWithFrame:CGRectMake((receiptContentLabel.gjcf_right + 9), (receiptView.gjcf_height- 13)/2, 13, 13)];
    receiptimage2.image = [UIImage imageNamed:@"form_icon_arrow"];
    [receiptView addSubview:receiptimage2];
    
    //触摸事件
    UITapGestureRecognizer *noreceiptGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(receiptclick:)];
    [noReceiptView addGestureRecognizer:noreceiptGesture];
    UITapGestureRecognizer *receiptGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(receiptclick:)];
    [receiptView addGestureRecognizer:receiptGesture];
    
    //
    //横线
    //
    grayLine8 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], receiptView.gjcf_bottom, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    grayLine8.backgroundColor = [UIColor redColor];
    [scrollView addSubview:grayLine8];
    
    //
    //无邮件地址
    //
    noEmailAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine8.gjcf_bottom, SCREEN_WIDTH, noAddressHeight)];
    noEmailAddressView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:noEmailAddressView];
    
    UITapGestureRecognizer *noaddressGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressclick:)];
    noaddressGesture.numberOfTapsRequired=1;
    noEmailAddressView.userInteractionEnabled = YES;
    [noEmailAddressView addGestureRecognizer:noaddressGesture];
    
    UILabel *AddNewAddressTitle = [[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 0, 100,noEmailAddressView.gjcf_height)];
    AddNewAddressTitle.text = @"邮寄地址";
    AddNewAddressTitle.textColor = [CommonFontColorStyle FontNormalColor];
    AddNewAddressTitle.font =[CommonFontColorStyle SmallSizeFont];
    [noEmailAddressView addSubview:AddNewAddressTitle];
    
    UILabel *AddNewAddress = [[UILabel alloc]initWithFrame:CGRectMake(AddNewAddressTitle.gjcf_right +10, 0, (SCREEN_WIDTH - 10 - AddNewAddressTitle.gjcf_right - 29), noEmailAddressView.gjcf_height)];
    AddNewAddress.text = @"添加邮寄地址";
    AddNewAddress.textColor = [CommonFontColorStyle FontSecondColor];
    AddNewAddress.font =[CommonFontColorStyle SmallSizeFont];
    AddNewAddress.textAlignment = NSTextAlignmentRight;
    [noEmailAddressView addSubview:AddNewAddress];
    
    
    UIImageView *boatAgeimage = [[UIImageView alloc]initWithFrame:CGRectMake(AddNewAddress.gjcf_right+ 9, (noEmailAddressView.gjcf_height- 13)/2, 13, 13)];
    boatAgeimage.image = [UIImage imageNamed:@"form_icon_arrow"];
    [noEmailAddressView addSubview:boatAgeimage];
    
    //有邮件地址
    emailAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, noEmailAddressView.gjcf_bottom, SCREEN_WIDTH, addressHeight)];
    emailAddressView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:emailAddressView];
    
    UITapGestureRecognizer *addressGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressclick:)];
    addressGesture.numberOfTapsRequired=1;
    emailAddressView.userInteractionEnabled = YES;
    [emailAddressView addGestureRecognizer:addressGesture];
    
    AddressName = [[UILabel alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 20, 60,14)];
    AddressName.textColor = [CommonFontColorStyle I3Color];
    AddressName.font =[CommonFontColorStyle SmallSizeFont];
    if(invoiceIsNotNull){
        AddressName.text = thisInsuranceModel.invoice.recipient;
    }else if(![defaultInsuranceAddressModel isEqual:[NSNull null]]){
        AddressName.text = defaultInsuranceAddressModel.addressee;
    }
    
    [AddressName sizeToFit];
    [emailAddressView addSubview:AddressName];
    
    AddressPhone = [[UILabel alloc]initWithFrame:CGRectMake(AddressName.gjcf_right+10, 20, 200,14)];
    if(invoiceIsNotNull){
        AddressPhone.text = thisInsuranceModel.invoice.recipient_mobile;
    }else if(![defaultInsuranceAddressModel isEqual:[NSNull null]]){
        AddressPhone.text = defaultInsuranceAddressModel.mobile;
    }
    
    AddressPhone.textColor = [CommonFontColorStyle I3Color];
    AddressPhone.font =[CommonFontColorStyle SmallSizeFont];
    [AddressPhone sizeToFit];
    [emailAddressView addSubview:AddressPhone];
    
    
    AddressfeeLabel = [[UILabel alloc]initWithFrame:CGRectMake((emailAddressView.gjcf_right - 120), 20, 50,14)];
    AddressfeeLabel.text = @"邮费:";
    AddressfeeLabel.textColor = [CommonFontColorStyle I3Color];
    AddressfeeLabel.font =[CommonFontColorStyle SmallSizeFont];
    [AddressfeeLabel sizeToFit];
    [emailAddressView addSubview:AddressfeeLabel];
    
    AddressfeeContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(AddressfeeLabel.gjcf_right, 20, 35,14)];
    AddressfeeContentLabel.textColor = [CommonFontColorStyle RedColor];
    AddressfeeContentLabel.font =[CommonFontColorStyle SmallSizeFont];
    //    if(invoiceIsNotNull){
    //        AddressfeeContentLabel.text = thisInsuranceModel.invoice.fee;
    //    }else if(defaultInsuranceAddressModel != nil){
    //        AddressfeeContentLabel.text = defaultInsuranceAddressModel.invoice_fee;
    //
    //    }
    AddressfeeContentLabel.text = self.invoice_fee;
    [AddressfeeContentLabel sizeToFit];
    
    AddressfeeLabel.gjcf_left =emailAddressView.gjcf_width - 10-AddressfeeContentLabel.gjcf_width - 65;
    AddressfeeContentLabel.gjcf_left = AddressfeeLabel.gjcf_right;
    
    [emailAddressView addSubview:AddressfeeContentLabel];
    
    AddressfeeUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(AddressfeeContentLabel.gjcf_right, 22, 35,14)];
    AddressfeeUnitLabel.text = @"元";
    AddressfeeUnitLabel.textColor = [CommonFontColorStyle I3Color];
    AddressfeeUnitLabel.font =[CommonFontColorStyle SmallSizeFont];
    [emailAddressView addSubview:AddressfeeUnitLabel];
    
    AddressAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, AddressName.gjcf_bottom+10, (SCREEN_WIDTH - 20),30)];
    AddressAddress.numberOfLines = 0;
    AddressAddress.textAlignment = NSTextAlignmentNatural;
    if(invoiceIsNotNull){
        AddressAddress.text = thisInsuranceModel.invoice.total_address;
    }else if(defaultInsuranceAddressModel != nil){
        AddressAddress.text = [NSString stringWithFormat:@"%@ %@",defaultInsuranceAddressModel.address,defaultInsuranceAddressModel.detail_address];
    }
    
    AddressAddress.textColor = [CommonFontColorStyle FontNormalColor];
    AddressAddress.font =[CommonFontColorStyle SmallSizeFont];
    [AddressAddress sizeToFit];
    [emailAddressView addSubview:AddressAddress];
    
    emailAddressView.gjcf_height = AddressAddress.gjcf_bottom + 20;
    
    receiptimage3 = [[UIImageView alloc]initWithFrame:CGRectMake((emailAddressView.gjcf_right - 21), (emailAddressView.gjcf_height- 13)/2, 13, 13)];
    receiptimage3.image = [UIImage imageNamed:@"form_icon_arrow"];
    [emailAddressView addSubview:receiptimage3];
    
    //下面部分
    downTwoView = [[UIView alloc]initWithFrame:CGRectMake(0, emailAddressView.gjcf_bottom, SCREEN_WIDTH, 100)];
    downTwoView.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    [scrollView addSubview:downTwoView];
    
    //横线
    GrayLine* grayLine7 = [[GrayLine alloc]initWithFrame:CGRectMake(0, 0, CommonDimensStyle.screenWidth, 0.5)];
    grayLine7.backgroundColor = [UIColor redColor];
    [downTwoView addSubview:grayLine7];
    
    //    //下一步
    NextBt= [[UIButton alloc] initWithFrame:CGRectMake( CommonDimensStyle.smallMargin , (grayLine7.gjcf_bottom), (CommonDimensStyle.screenWidth - 2*CommonDimensStyle.smallMargin ), CommonDimensStyle.btHeight)];
    
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"2dabff") Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateNormal];
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"0f92ea") Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateHighlighted];
    
    [NextBt setBackgroundColor:XXJColor(27, 69, 138)];
    
    NextBt.layer.cornerRadius =CommonDimensStyle.smallCornerRadius;
    if (self.isEdit) {
        [NextBt setTitle:@"确认保存" forState:UIControlStateNormal];
    }else{
        [NextBt setTitle:@"同意以下条款，核对保单" forState:UIControlStateNormal];
    }
    NextBt.titleLabel.font =[CommonFontColorStyle ButtonTextFont];
    [NextBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    [NextBt addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [downTwoView addSubview:NextBt];
    
    UILabel *tiShiText = [[UILabel alloc]initWithFrame:CGRectMake(0, NextBt.gjcf_bottom+18, scrollView.gjcf_width, 14)];
    tiShiText.textAlignment = NSTextAlignmentCenter;
    tiShiText.text = @"投保即代表阅读和同意";
    tiShiText.font = [CommonFontColorStyle SmallSizeFont];
    tiShiText.textColor = [CommonFontColorStyle B8CA0Color];
    [downTwoView addSubview:tiShiText];
    
    UIButton *tiaokuanText = [[UIButton alloc]initWithFrame:CGRectMake(0, tiShiText.gjcf_bottom+6, 170, 14)];
    [tiaokuanText setTitle:@"《水路货物运输保险条款》" forState:UIControlStateNormal];
    tiaokuanText.titleLabel.font =[CommonFontColorStyle SmallSizeFont];
    [tiaokuanText setTitleColor:XXJColor(27, 69, 138) forState:UIControlStateNormal];
    [tiaokuanText sizeToFit];
    [tiaokuanText addTarget:self action:@selector(tiaoKuanClick) forControlEvents:UIControlEventTouchUpInside];
    [downTwoView addSubview:tiaokuanText];
    
    UIButton *xuZhiText = [[UIButton alloc]initWithFrame:CGRectMake(tiaokuanText.gjcf_right, tiShiText.gjcf_bottom+6, 120, 14)];
    [xuZhiText setTitle:@"《用户投保须知》" forState:UIControlStateNormal];
    xuZhiText.titleLabel.font =[CommonFontColorStyle SmallSizeFont];
    [xuZhiText setTitleColor:XXJColor(27, 69, 138) forState:UIControlStateNormal];
    [xuZhiText sizeToFit];
    [xuZhiText addTarget:self action:@selector(xuzhiClick) forControlEvents:UIControlEventTouchUpInside];
    [downTwoView addSubview:xuZhiText];
    
    tiaokuanText.gjcf_left  = (SCREEN_WIDTH - tiaokuanText.gjcf_width - xuZhiText.gjcf_width)/2;
    tiaokuanText.gjcf_top =tiShiText.gjcf_bottom+6;
    xuZhiText.gjcf_left =tiaokuanText.gjcf_left+tiaokuanText.gjcf_width;
    
    downTwoView.gjcf_height =xuZhiText.gjcf_bottom;
    //    downView.gjcf_height = downTwoView.gjcf_bottom;
    CGSize cgsize = CGSizeMake(SCREEN_WIDTH, (downTwoView.gjcf_bottom +10));
    scrollView.contentSize = cgsize;
    // 隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    
}

-(void)navigationInfo{
    
}

-(void)nextClick{
    NSString *insured_amount_fee =insuredAmountFee.text;
    if ([GJCFStringUitil stringIsNull:insured_amount_fee]) {
        
        [self.view makeToast:@"保险金额不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    //判断是否大于10000
    double price = [GJCFStringUitil stringToDouble:insured_amount_fee];
    if (price <10000 ||price >30000000) {
        [self.view makeToast:@"保险金额为1万到3000万之间" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    //[self saveFaPiaoInfo];
    
    [NextBt setUserInteractionEnabled:NO];
    if(isInvoice == 1){
        [self saveFaPiaoInfo];
    }else{
        //计算价格
        [self calPrice];
    }
    
}

//保存支付信息
-(void)saveInsuranceInfo:(NSString *)insured_fee TotalFee:(NSString *)total_fee{
    NSString *subparameterstring = [NSString stringWithFormat:@"\"id\":\"%@\",\"insured_fee\":\"%@\",\"total_fee\":\"%@\"",self.InsuranceId,insured_fee,total_fee];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:SaveInsuranceInfoMethod parameters:subparameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                if (self.isEdit) {
                    InsuranceConfirmController *insuranceConfirmController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                    insuranceConfirmController.InsuranceId = self.InsuranceId;
                    [self.navigationController popToViewController:insuranceConfirmController animated:YES];
                }else{
                    InsuranceConfirmController *insuranceConfirmController = [[InsuranceConfirmController alloc]init];
                    insuranceConfirmController.InsuranceId = self.InsuranceId;
                    [self.navigationController pushViewController:insuranceConfirmController animated:YES];
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

//保存发票
-(void)saveFaPiaoInfo{
    
    if(isInvoice ==1 ){
        
        [NextBt setUserInteractionEnabled:YES];
        if (nowType ==1 ||nowType ==2) {
            [self.view makeToast:@"请填写发票信息" duration:0.5 position:CSToastPositionCenter];
            return;
        }
        if(nowType == 3){
            
            [self.view makeToast:@"请填写邮件地址" duration:0.5 position:CSToastPositionCenter];
            return;
        }
        if (nowType == 0 && [GJCFStringUitil stringIsNull:self.title_type]) {
            
            [self.view makeToast:@"请填写发票信息" duration:0.5 position:CSToastPositionCenter];
            return;
        }
        
        [NextBt setUserInteractionEnabled:NO];
        NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"invoice_type\":\"%@\",\"title\":\"%@\",\"title_type\":\"%@\",\"recipient\":\"%@\",\"recipient_mobile\":\"%@\",\"recipient_address\":\"%@\",\"fee\":\"%@\",\"address_detail\":\"%@\",\"ec_id\":\"%@\"",self.InsuranceId,self.invoice_type, self.taitou_title,self.title_type, AddressName.text,AddressPhone.text,self.address,AddressfeeContentLabel.text,self.detail_address,self.expresscompany];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:SetInvoiceMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            if (result != nil) {
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    //计算价格
                    [self calPrice];
                }else{
                    [NextBt setUserInteractionEnabled:YES];
                    
                    [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
                }
                
                
            }
            
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
   
    }else{
        [self DeleteVoiceInfo];
    }
}

//代理方法
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    isInvoice = index;
    isHasFaPiao = isInvoice;
    if (index == 0) {
        [self setShowContent:0];
        
    }else{
        if (nowType == 0) {
            [self setShowContent:1];
        }else{
            [self setShowContent:nowType];
        }
        if(isfirst && [self.invoice_fee isEqualToString:@"0"]){
            isfirst = NO;
            
            [self.view makeToast:@"同一自然月内，相同地址只需支付一次快递费，由保险公司统一寄出。" duration:0.5 position:CSToastPositionCenter];
        }
    }
}

- (void)huozhuclick:(UITapGestureRecognizer *)sender{
    isInvoice= 1;
    isHasFaPiao = 1;
    if (nowType == 0) {
        [self setShowContent:1];
    }else{
        [self setShowContent:nowType];
    }
    
    if(isfirst && [self.invoice_fee isEqualToString:@"0"]){
        isfirst = NO;
        [self.view makeToast:@"同一自然月内，相同地址只需支付一次快递费，由保险公司统一寄出。" duration:0.5 position:CSToastPositionCenter];
    }
}

- (void)chuandongclick:(UITapGestureRecognizer *)sender{
    isInvoice=0;
    isHasFaPiao = 0;
    [self setShowContent:0];
}



- (void)receiptclick:(UITapGestureRecognizer *)sender{
    InsuranceReceiptController *insuranceReceiptController = [[InsuranceReceiptController alloc]init];
    insuranceReceiptController.holderName = thisInsuranceModel.holder_name;
    insuranceReceiptController.recognizeeName = thisInsuranceModel.recognizee_name;
    insuranceReceiptController.needselectTitle=self.taitou_title;
    insuranceReceiptController.invoiceType = self.invoice_type;
    insuranceReceiptController.isFour = YES;
    [self.navigationController pushViewController:insuranceReceiptController animated:YES];
}


//邮寄地址点击
- (void)addressclick:(UITapGestureRecognizer *)sender{
    [self closeAllShow];
    [self turnToAddress];
}

//关闭所有的弹出窗口
-(void)closeAllShow{
    [self.view endEditing:YES];
}

-(void)tiaoKuanClick{
    InsuranceTiaoKuanViewController *insuranceTiaoKuanViewController = [[InsuranceTiaoKuanViewController alloc]init];
    [self.navigationController pushViewController:insuranceTiaoKuanViewController animated:YES];
}

-(void)xuzhiClick{
    InsuranceXuZhiViewController *insuranceXuZhiViewController = [[InsuranceXuZhiViewController alloc]init];
    [self.navigationController pushViewController:insuranceXuZhiViewController animated:YES];
}


#pragma mark 保险金额自定义键盘
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
    
    if (insuredAmountFee.text.length != 0)
    {
        insuredAmountFee.text = [insuredAmountFee.text substringToIndex:insuredAmountFee.text.length -1];
        NSString *insuredAmountFeeString = insuredAmountFee.text;
        if ([GJCFStringUitil stringIsNull:insuredAmountFeeString]) {
            applicantered.text =@"0.00";
        }else{
            
            double thisradio = [GJCFStringUitil stringToDouble:thisInsuranceModel.ratio];
            
            double baofei = [GJCFStringUitil stringToDouble:insuredAmountFeeString] *thisradio;
            applicantered.text =[NSString stringWithFormat:@"%.2f",baofei];
        }
    }else{
        applicantered.text =@"0.00";
    }
    
}

- (void)numberKeyBoardFinish{
    [insuredAmountFee resignFirstResponder];
}

-(void)numberKeyboardInput:(NSInteger)number{
    int num = (int)number;
    insuredAmountFee.text = [insuredAmountFee.text stringByAppendingString:[NSString stringWithFormat:@"%d",num]];
    
    NSMutableString *textString = [[NSMutableString alloc]initWithFormat:@"%@",insuredAmountFee.text];
    NSString *regex = @"^(\\d{0,10}.{0,1}[0-9]{0,4})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = false;
    
    isMatch = [pred evaluateWithObject:textString];
    if (!isMatch) {
        if (textString.length >0) {
            insuredAmountFee.text = [textString substringToIndex:(textString.length -1)];
        }
    }else{
        insuredAmountFee.text = textString;
    }
    
    NSString *insuredAmountFeeString = insuredAmountFee.text;
    double baofei = [GJCFStringUitil stringToDouble:insuredAmountFeeString] *[GJCFStringUitil stringToDouble:thisInsuranceModel.ratio];
    applicantered.text =[NSString stringWithFormat:@"%.2f",baofei];
    
}


- (void)writeInRadixPoint{
    if (![insuredAmountFee.text containsString:@"."]) {
        insuredAmountFee.text = [insuredAmountFee.text stringByAppendingString:[NSString stringWithFormat:@"%@",@"."]];
    }
}



-(void)getInsuranceInfo{
    NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"access_token\":\"%@\"",self.InsuranceId,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetInsuranceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                thisInsuranceModel = [InsuranceModel mj_objectWithKeyValues:[boatresult objectForKey:@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //加载页面
                    [self startView];
                    //设置显示
                    InvoiceModel*invoiceModel= thisInsuranceModel.invoice;
                    Boolean invoiceIsNotNull = NO;
                    isInvoice =0;
                    if (![GJCFStringUitil stringIsNull:invoiceModel.recipient]) {
                        invoiceIsNotNull = YES;
                        isInvoice =1;
                    }
                    
                    if(invoiceIsNotNull){
                        nowType = 4;
                        isInvoice =1;
                        self.taitou_title = invoiceModel.title;
                        self.invoice_type = invoiceModel.invoice_type;
                    }else{
                        nowType = 0;
                    }
                    
                    [ self setShowContent:nowType];
                });
                
            }
            else
            {
                [self.view makeToast:boatresult[@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
}


//获取个人的发票地址列表
-(void)getEcsList{
    [SVProgressHUD show];
    
    NSString *userId =  [UseInfo shareInfo].uID;
    NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\",\"is_current\":\"%@\",\"uid\":\"%@\"",@"",@"Y",userId];
    
    [SVProgressHUD show];
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetMailAddressInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    defaultInsuranceAddressModel =[InsuranceAddressModel mj_objectWithKeyValues:[boatresult objectForKey:@"info"]];
                    self.addressId =defaultInsuranceAddressModel.id;
                    self.recipient = defaultInsuranceAddressModel.addressee;
                    self.mobile = defaultInsuranceAddressModel.mobile;
                    self.address = defaultInsuranceAddressModel.address;
                    self.detail_address = defaultInsuranceAddressModel.detail_address;
                    self.invoice_fee = defaultInsuranceAddressModel.invoice_fee;
                    self.expresscompany = defaultInsuranceAddressModel.express_company;
                    
                    NSString *proviceString =[self.address componentsSeparatedByString:@" "][0];
                    NSString *parameterstring = [NSString stringWithFormat:@"\"address\":\"%@\",\"ec_id\":\"%@\",\"address_detail1\":\"%@\",\"address_detail2\":\"%@\",\"uid\":\"%@\"",proviceString,self.expresscompany, self.address,self.detail_address, [UseInfo shareInfo].uID];
                    
                    [SVProgressHUD show];
                    
                    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetFeeWithAddressEcMethod parameters:parameterstring finished:^(id result) {
                        [SVProgressHUD dismiss];
                        
                        if (result != nil) {
                            NSDictionary *boatresult =[result objectForKey:@"result"];
                            if ([[boatresult objectForKey:@"status"] boolValue]) {
                                self.invoice_fee =[NSString stringWithFormat:@"%@", [boatresult objectForKey:@"fee"]];
                                
                                [self getInsuranceInfo];
                            }
                            
                        }
                        
                    } errored:^(NSError *error) {
                        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
                        
                        [SVProgressHUD dismiss];
                    }];
                    
                    
            
                    
                });
                
                
            }else{
                [self getInsuranceInfo];
            }
            
            
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
}



//计算价格
-(void)calPrice{
    //计算价格 fee    保费 has_invoice    是否需要发票  s_code    货物种类小类  ship_age_type    船龄
    NSString *hasInvoice =self.isNeedFaPiao?@"0":@"1";
    NSString *parameterstring = [NSString stringWithFormat:@"\"fee\":\"%@\",\"has_invoice\":\"%@\",\"s_code\":\"%@\",\"ship_age_type\":\"%@\",\"mail_fee\":\"%@\",\"ship_name\":\"%@\"",applicantered.text,hasInvoice,thisInsuranceModel.goods_stype_code,thisInsuranceModel.ship_age_type,AddressfeeContentLabel.text, thisInsuranceModel.ship_name];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:CalPriceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *data = [result objectForKey:@"result"];
            
            InsurancePriceModel *insurancePriceModel = [InsurancePriceModel mj_objectWithKeyValues:[data objectForKey:@"data"]];
            [self saveInsuranceInfo:insuredAmountFee.text TotalFee:insurancePriceModel.total_fee];
            
            
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}


//无需发票 0
//需发票 发票信息无 邮件地址无 1
//需发票 发票信息无 邮件地址有 2
//需发票 发票信息有 邮件地址无 3
//需发票 发票信息有 邮件地址有 4
-(void)setShowContent:(int)type{
    if (defaultInsuranceAddressModel != nil) {
        if (type == 1) {
            type =2;
        }else if(type == 3){
            type = 4;
        }
    }
    switch (type) {
        case 0:
            [rb1 setSelected];
            [rb2 setDisSelected];
            noReceiptView.gjcf_height = 0;
            receiptView.gjcf_height = 0;
            noEmailAddressView.gjcf_height = 0;
            emailAddressView.gjcf_height = 0;
            emailAddressView.hidden = YES;
            break;
        case 1:
            [rb1 setDisSelected];
            [rb2 setSelected];
            noReceiptView.gjcf_height = fapiaoHeight;
            receiptView.gjcf_height = 0;
            noEmailAddressView.gjcf_height = noAddressHeight;
            emailAddressView.gjcf_height = 0;
            emailAddressView.hidden = YES;
            break;
        case 2:
            [rb1 setDisSelected];
            [rb2 setSelected];
            noReceiptView.gjcf_height = fapiaoHeight;
            receiptView.gjcf_height = 0;
            noEmailAddressView.gjcf_height = 0;
            emailAddressView.gjcf_height = AddressAddress.gjcf_bottom + 20;
            emailAddressView.gjcf_height = emailAddressView.gjcf_height;
            emailAddressView.hidden = NO;
            break;
        case 3:
            [rb1 setDisSelected];
            [rb2 setSelected];
            noReceiptView.gjcf_height = 0;
            receiptView.gjcf_height = fapiaoHeight;
            noEmailAddressView.gjcf_height = noAddressHeight;
            emailAddressView.gjcf_height = 0;
            emailAddressView.hidden = YES;
            break;
        case 4:
            [rb1 setDisSelected];
            [rb2 setSelected];
            noReceiptView.gjcf_height = 0;
            receiptView.gjcf_height = fapiaoHeight;
            noEmailAddressView.gjcf_height = 0;
            emailAddressView.gjcf_height = AddressAddress.gjcf_bottom + 20;
            emailAddressView.gjcf_height = emailAddressView.gjcf_height;
            emailAddressView.hidden = NO;
            break;
        default:
            break;
    }
    
    receiptView.gjcf_top = noReceiptView.gjcf_bottom;
    grayLine8.gjcf_top = receiptView.gjcf_bottom;
    noEmailAddressView.gjcf_top = grayLine8.gjcf_bottom;
    emailAddressView.gjcf_top = noEmailAddressView.gjcf_bottom;
    downTwoView.gjcf_top = emailAddressView.gjcf_bottom+10;
    //    downView.gjcf_height = downTwoView.gjcf_bottom;
    CGSize cgsize = CGSizeMake(SCREEN_WIDTH, (downTwoView.gjcf_bottom +10));
    scrollView.contentSize = cgsize;
    
}



//删除发票
-(void)DeleteVoiceInfo{
    NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"Access_token\":\"%@\"",self.InsuranceId,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:DeleteVoiceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                //计算价格
                [self calPrice];
            }else{
                
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}



//邮件地址跳转
-(void)turnToAddress{
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"uid\":\"%@\"",[UseInfo shareInfo].uID];
    
    [SVProgressHUD show];
    
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetEcListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]]  &&[list count] >0){
                    
                    NSMutableArray *localaddressList = [[NSMutableArray alloc]init];
                    for(int i = 0; i < list.count;i ++){
                        InsuranceAddressModel *insuranceModel = [InsuranceAddressModel mj_objectWithKeyValues:(NSDictionary *)(list[i])];
                        [localaddressList addObject:insuranceModel];
                    }
                    
                    InsuranceAddressListController *insuranceAddressListController = [[InsuranceAddressListController alloc]init];
                    insuranceAddressListController.addressList =localaddressList;
                    insuranceAddressListController.InsuranceId = self.InsuranceId;
                    insuranceAddressListController.isFour = YES;
                    [self.navigationController pushViewController:insuranceAddressListController animated:YES];
                }else{
                    InsuranceAddAddressController *insuranceAddAddressController = [[InsuranceAddAddressController alloc]init];
                    insuranceAddAddressController.fromPage = 1;
                    [self.navigationController pushViewController:insuranceAddAddressController animated:YES];
                    
                }
            }

        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    

    
    
}






















































@end
