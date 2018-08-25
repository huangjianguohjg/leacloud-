//
//  InsuranceReceiptDetailController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceReceiptDetailController.h"
#import "GrayLine.h"
#import "InsuranceModel.h"
#import "InsuranceAddressModel.h"
#import "InsuranceReceiptController.h"
@interface InsuranceReceiptDetailController ()
{
    ZYRadioButton *rb1;
    ZYRadioButton *rb2;
    
    UIView *downView;
    GrayLine *grayLine6;
    UIView *TotaldressView;
    UILabel *receiptNoContentLabel;
    UILabel *receiptContentLabel;
    UILabel *AddressfeeContentLabel;
    UIButton *SaveBt;
    InsuranceModel *thisInsuranceModel;
    NSUInteger identy;
    UIView *ContentView ;
    UILabel *AddressName;
    UILabel *AddressPhone;
    UILabel *AddressfeeUnitLabel;
    UILabel *AddressAddress;
    GrayLine* grayLine8;
    UILabel *AddressfeeLabel;
    
    UIView *noReceiptView;//无发票信息
    UIView *receiptView;//有发票信息
    UIView *noEmailAddressView;//无邮件地址
    UIView *emailAddressView;//有邮件地址
    
    NSMutableArray *addressList;
    
    InsuranceAddressModel *defaultInsuranceAddressModel;
    
    int fapiaoHeight;//发票信息高度
    int noAddressHeight;//没有邮件地址高度
    int addressHeight;//邮件地址高度
    
    int nowType;
    long isInvoice;
    UIView *headview;
}
@end

@implementation InsuranceReceiptDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"发票信息";
    
    [self setUpUI];
    
    
    
}




-(void)setUpUI
{
    fapiaoHeight = 52;
    noAddressHeight = 52;
    addressHeight=89;
    
    self.view.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    
    
    [self getEcsList];
    [ self setShowContent:nowType];
    
    
    
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
                nowType = 3;
            }
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
                            if (nowType == 3||nowType == 4) {
                                nowType = 4;
                            }else{
                                nowType = 2;
                            }
                            
                        }else{
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
        [ self setShowContent:nowType];
    }
    
}

-(void)initView{
    InvoiceModel*invoiceModel= thisInsuranceModel.invoice;
    Boolean invoiceIsNotNull = NO;
    if (![GJCFStringUitil stringIsNull:invoiceModel.recipient]) {
        invoiceIsNotNull = YES;
    }
    
    
    UIView *twoview = [[UIView alloc]initWithFrame:CGRectMake(0, headview.gjcf_bottom + 10, CommonDimensStyle.screenWidth, [CommonDimensStyle inputHeight])];
    twoview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview:twoview];
    
    //初始化单选按钮控件
    rb1 = [[ZYRadioButton alloc] initWithGroupId:@"first" index:0 selectedImageName:@"form_choose_yes" unSelectedImageName:@"form_choose_no"];
    
    rb2 = [[ZYRadioButton alloc] initWithGroupId:@"first" index:1 selectedImageName:@"form_choose_yes" unSelectedImageName:@"form_choose_no"];
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
    [ZYRadioButton addObserverForGroupId:@"first" observer:self];
    
    
    if([thisInsuranceModel.is_invoice isEqualToString:@"Y"]){
        [rb2 setSelected];
    }else{
        [rb1 setSelected];
    }
    
    
    
    //横线
    grayLine6 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], twoview.gjcf_bottom, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [self.view addSubview:grayLine6];
    
    //加载详细信息
    
    //
    //无发票信息
    //
    noReceiptView = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine6.gjcf_bottom, SCREEN_WIDTH, fapiaoHeight)];
    noReceiptView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview:noReceiptView];
    
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
    [self.view addSubview:receiptView];
    
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
    [self.view addSubview:grayLine8];
    
    //
    //无邮件地址
    //
    noEmailAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine8.gjcf_bottom, SCREEN_WIDTH, noAddressHeight)];
    noEmailAddressView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview:noEmailAddressView];
    
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
    [self.view addSubview:emailAddressView];
    
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
    
    
    AddressfeeLabel = [[UILabel alloc]initWithFrame:CGRectMake((emailAddressView.gjcf_right - 100), 20, 50,14)];
    AddressfeeLabel.text = @"邮费:";
    AddressfeeLabel.textColor = [CommonFontColorStyle I3Color];
    AddressfeeLabel.font =[CommonFontColorStyle SmallSizeFont];
    [AddressfeeLabel sizeToFit];
    [emailAddressView addSubview:AddressfeeLabel];
    
    AddressfeeContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(AddressfeeLabel.gjcf_right, 20, 35,14)];
    AddressfeeContentLabel.textColor = [CommonFontColorStyle RedColor];
    AddressfeeContentLabel.font =[CommonFontColorStyle SmallSizeFont];
    if(invoiceIsNotNull){
        AddressfeeContentLabel.text = thisInsuranceModel.invoice.fee;
    }else if(defaultInsuranceAddressModel != nil){
        AddressfeeContentLabel.text = defaultInsuranceAddressModel.invoice_fee;
    }
    [AddressfeeContentLabel sizeToFit];
    [emailAddressView addSubview:AddressfeeContentLabel];
    
    AddressfeeUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(AddressfeeContentLabel.gjcf_right, 22, 35,14)];
    AddressfeeUnitLabel.text = @"元";
    AddressfeeUnitLabel.textColor = [CommonFontColorStyle I3Color];
    AddressfeeUnitLabel.font =[CommonFontColorStyle SmallSizeFont];
    [emailAddressView addSubview:AddressfeeUnitLabel];
    
    AddressfeeLabel.gjcf_left =emailAddressView.gjcf_width - 10-AddressfeeContentLabel.gjcf_width - 65;
    AddressfeeContentLabel.gjcf_left = AddressfeeLabel.gjcf_right;
    AddressfeeUnitLabel.gjcf_left = AddressfeeContentLabel.gjcf_right;
    
    AddressAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, AddressName.gjcf_bottom+10, (SCREEN_WIDTH - 20),30)];
    AddressAddress.numberOfLines = 0;
    if(invoiceIsNotNull){
        AddressAddress.text = [NSString stringWithFormat:@"%@ %@",thisInsuranceModel.invoice.total_address,thisInsuranceModel.invoice.address_detail];
    }else if(defaultInsuranceAddressModel != nil){
        AddressAddress.text = [NSString stringWithFormat:@"%@ %@",defaultInsuranceAddressModel.address,defaultInsuranceAddressModel.detail_address];
    }
    
    AddressAddress.textColor = [CommonFontColorStyle FontNormalColor];
    AddressAddress.font =[CommonFontColorStyle SmallSizeFont];
    [AddressAddress sizeToFit];
    [emailAddressView addSubview:AddressAddress];
    
    emailAddressView.gjcf_height = AddressAddress.gjcf_bottom + 20;
    UIImageView *receiptimage3 = [[UIImageView alloc]initWithFrame:CGRectMake((emailAddressView.gjcf_right - 21), (emailAddressView.gjcf_height- 13)/2, 13, 13)];
    receiptimage3.image = [UIImage imageNamed:@"form_icon_arrow"];
    [emailAddressView addSubview:receiptimage3];
    
    
    //下一步
    SaveBt= [[UIButton alloc] initWithFrame:CGRectMake( CommonDimensStyle.smallMargin , (emailAddressView.gjcf_bottom +CommonDimensStyle.topMargin), (CommonDimensStyle.screenWidth - 2*CommonDimensStyle.smallMargin ), CommonDimensStyle.btHeight)];
    
//    [SaveBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle EB9EFColor] Width:SaveBt.gjcf_width Height:SaveBt.gjcf_height] forState:UIControlStateNormal];
//    [SaveBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle BlueColor] Width:SaveBt.gjcf_width Height:SaveBt.gjcf_height] forState:UIControlStateHighlighted];
    
    [SaveBt setBackgroundColor:XXJColor(27, 69, 138)];
    
    SaveBt.layer.cornerRadius =CommonDimensStyle.smallCornerRadius;
    [SaveBt setTitle:@"确认保存" forState:UIControlStateNormal];
    SaveBt.titleLabel.font =[CommonFontColorStyle ButtonTextFont];
    [SaveBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    [SaveBt addTarget:self action:@selector(saveFaPiaoInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SaveBt];
    
}

-(void)nextClick{
//    InsuranceConfirmController *insuranceConfirmController = [[InsuranceConfirmController alloc]init];
//    insuranceConfirmController.InsuranceId = self.InsuranceId;
//    [self.navigationController pushViewController:insuranceConfirmController animated:YES];
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
                    self.invoice_type = invoiceModel.invoice_type;
                    Boolean invoiceIsNotNull = NO;
                    if (![GJCFStringUitil stringIsNull:invoiceModel.recipient]) {
                        invoiceIsNotNull = YES;
                    }
                    
                    if(invoiceIsNotNull){
                        nowType = 4;
                        isInvoice =1;
                    }else{
                        nowType = 0;
                    }
                    
                    [ self setShowContent:nowType];
                });
            }
        }
   
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
}

-(void)startView{
    
    //页面初始化
    [self initView];
}

//代理方法
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    isInvoice = index;
    
    if (index == 1) {
        if (nowType == 0) {
            [self setShowContent:1];
        }else{
            [self setShowContent:nowType];
        }
    }else{
        [self setShowContent:0];
    }
}

- (void)huozhuclick:(UITapGestureRecognizer *)sender{
    isInvoice = 1;
    if (nowType == 0) {
        [self setShowContent:1];
    }else{
        [self setShowContent:nowType];
    }
}

- (void)chuandongclick:(UITapGestureRecognizer *)sender{
    isInvoice = 0;
    [self setShowContent:0];
}

//抬头触摸事件
- (void)receiptclick:(UITapGestureRecognizer *)sender{
    InsuranceReceiptController *insuranceReceiptController = [[InsuranceReceiptController alloc]init];
    insuranceReceiptController.holderName = thisInsuranceModel.holder_name;
    insuranceReceiptController.recognizeeName = thisInsuranceModel.recognizee_name;
    insuranceReceiptController.needselectTitle = self.taitou_title;
    insuranceReceiptController.invoiceType = self.invoice_type;
    [self.navigationController pushViewController:insuranceReceiptController animated:YES];
}

//邮寄地址点击
- (void)addressclick:(UITapGestureRecognizer *)sender{
    [self turnToAddress];
}


//获取个人的发票地址列表
-(void)getEcsList{
    
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
                    self.express_company = defaultInsuranceAddressModel.express_company;
                });
            }
        }
        
        [self getInsuranceInfo];
        
        
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
                self.isNeedAddress = YES;
                NSArray *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]]  &&[list count] >0){
                    
                    addressList = [[NSMutableArray alloc]init];
                    for(int i = 0; i < list.count;i ++){
                        InsuranceAddressModel *insuranceModel = [InsuranceAddressModel mj_objectWithKeyValues:(NSDictionary *)(list[i])];
                        
                        [addressList addObject:insuranceModel];
                    }
                    
//                    InsuranceAddressListController *insuranceAddressListController = [[InsuranceAddressListController alloc]init];
//                    insuranceAddressListController.addressList =addressList;
//                    insuranceAddressListController.InsuranceId = self.InsuranceId;
//                    insuranceAddressListController.isFour = NO;
//                    [self.navigationController pushViewController:insuranceAddressListController animated:YES];
                    
                } else {
//                    InsuranceAddAddressController *insuranceAddAddressController = [[InsuranceAddAddressController alloc]init];
//                    insuranceAddAddressController.fromPage = 3;
//                    [self.navigationController pushViewController:insuranceAddAddressController animated:YES];
                }
            }
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
    SaveBt.gjcf_top = emailAddressView.gjcf_bottom+10;
    
}


//保存发票
-(void)saveFaPiaoInfo{
    if(isInvoice ==1 ){
        if (nowType ==1 ||nowType ==2) {
            
            [self.view makeToast:@"请填写发票信息" duration:0.5 position:CSToastPositionCenter];
            return;
        }
        if(nowType == 3 && defaultInsuranceAddressModel == nil){
            
            [self.view makeToast:@"请填写邮件地址" duration:0.5 position:CSToastPositionCenter];
            return;
        }
        if (nowType == 0 && [GJCFStringUitil stringIsNull:self.title_type]) {
            
            [self.view makeToast:@"请填写发票信息" duration:0.5 position:CSToastPositionCenter];
            return;
        }
        //insurance_id    保单id     为空代表增加 title    抬头 recipient    收件人 recipient_mobile    收件人号码 recipient_address    所在区域 fee    运费 address_detail    详情地址 ec_id    邮寄公司ID
        NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"invoice_type\":\"%@\",\"title\":\"%@\",\"title_type\":\"%@\",\"recipient\":\"%@\",\"recipient_mobile\":\"%@\",\"recipient_address\":\"%@\",\"fee\":\"%@\",\"address_detail\":\"%@\",\"ec_id\":\"%@\"",self.InsuranceId,self.invoice_type, self.taitou_title,self.title_type, AddressName.text,AddressPhone.text,self.address,AddressfeeContentLabel.text,self.detail_address,self.express_company];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:SetInvoiceMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            if (result != nil) {
                
                NSDictionary *boatresult =[result objectForKey:@"result"];
                if ([[boatresult objectForKey:@"status"] boolValue]) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
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

//删除发票
-(void)DeleteVoiceInfo{
    NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"Access_token\":\"%@\"",self.InsuranceId,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:DeleteVoiceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}




@end
