//
//  InsuranceInputFourEditController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceInputFourEditController.h"
#import "GrayLine.h"
#import "ZYRadioButton.h"
#import "InsuranceConfirmController.h"
#import "InsuranceTiaoKuanViewController.h"
#import "InsuranceXuZhiViewController.h"
#import "InsuranceAddressModel.h"
#import "InsuranceAddressListController.h"
#import "InsuranceAddAddressController.h"
#import "InsurancePriceModel.h"
@interface InsuranceInputFourEditController (){
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
    UIView *head;
}

@end

@implementation InsuranceInputFourEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"保险信息";
    
    [self setUpUI];
    
    
    
}



-(void)setUpUI
{
    keyboard = [[AFFNumericKeyboard alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 216)];
    keyboard.delegate = self;
    
    [self KeyBoardHidden];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getInsuranceInfo];
}


-(void)startView{
    
    //页面初始化
    [self initView];
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
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, 0, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
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
    
    
    //    //下一步
    NextBt= [[UIButton alloc] initWithFrame:CGRectMake( CommonDimensStyle.smallMargin , (grayLine4.gjcf_bottom +CommonDimensStyle.topMargin), (CommonDimensStyle.screenWidth - 2*CommonDimensStyle.smallMargin ), CommonDimensStyle.btHeight)];
    
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"2dabff") Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateNormal];
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"0f92ea") Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateHighlighted];
    
    [NextBt setBackgroundColor:XXJColor(27, 69, 138)];
    
    NextBt.layer.cornerRadius =CommonDimensStyle.smallCornerRadius;
    [NextBt setTitle:@"确认保存" forState:UIControlStateNormal];
    NextBt.titleLabel.font =[CommonFontColorStyle ButtonTextFont];
    [NextBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    [NextBt addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:NextBt];
    
    UILabel *tiShiText = [[UILabel alloc]initWithFrame:CGRectMake(0, NextBt.gjcf_bottom+17, scrollView.gjcf_width, 14)];
    tiShiText.textAlignment = NSTextAlignmentCenter;
    tiShiText.text = @"投保即代表阅读和同意";
    tiShiText.font = [CommonFontColorStyle SmallSizeFont];
    tiShiText.textColor = XXJColor(27, 69, 138);
    [scrollView addSubview:tiShiText];
    
    UIButton *tiaokuanText = [[UIButton alloc]initWithFrame:CGRectMake(0, tiShiText.gjcf_bottom+10, 180, 14)];
    [tiaokuanText setTitle:@"《水路货物运输保险条款》" forState:UIControlStateNormal];
    tiaokuanText.titleLabel.font =[CommonFontColorStyle SmallSizeFont];
    [tiaokuanText setTitleColor:XXJColor(27, 69, 138) forState:UIControlStateNormal];
    [tiaokuanText sizeToFit];
    [tiaokuanText addTarget:self action:@selector(tiaoKuanClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:tiaokuanText];
    
    UIButton *xuZhiText = [[UIButton alloc]initWithFrame:CGRectMake(tiaokuanText.gjcf_right, tiShiText.gjcf_bottom+10, 150, 14)];
    [xuZhiText setTitle:@"《用户投保须知》" forState:UIControlStateNormal];
    xuZhiText.titleLabel.font =[CommonFontColorStyle SmallSizeFont];
    [xuZhiText setTitleColor:XXJColor(27, 69, 138) forState:UIControlStateNormal];
    [xuZhiText sizeToFit];
    [xuZhiText addTarget:self action:@selector(xuzhiClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:xuZhiText];
    
    tiaokuanText.gjcf_left  = (SCREEN_WIDTH - tiaokuanText.gjcf_width - xuZhiText.gjcf_width)/2;
    xuZhiText.gjcf_left =tiaokuanText.gjcf_left+tiaokuanText.gjcf_width;
    
    CGSize cgsize = CGSizeMake(SCREEN_WIDTH, (xuZhiText.gjcf_bottom +10));
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
    
    [self calPrice];
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
                InsuranceConfirmController *insuranceConfirmController = [[InsuranceConfirmController alloc]init];
                insuranceConfirmController.InsuranceId = self.InsuranceId;
                [self.navigationController pushViewController:insuranceConfirmController animated:YES];
                
                
            }else{
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
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
            double baofei = [GJCFStringUitil stringToDouble:insuredAmountFeeString] *[GJCFStringUitil stringToDouble:thisInsuranceModel.ratio];
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
    
    double thisradio = [GJCFStringUitil stringToDouble:thisInsuranceModel.ratio];
    
    double baofei = [GJCFStringUitil stringToDouble:insuredAmountFeeString] *thisradio;
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
                });
                
                
            }
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}


//获取个人的发票地址列表
-(void)getEcsList{
    NSString *parameterstring = [NSString stringWithFormat:@"\"uid\":\"%@\"",[UseInfo shareInfo].uID];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetEcListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
//            NSLog(@"%@",[result objectForKey:@"result"] );
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]]  &&[list count] >0){
                    
                    NSMutableArray *addressList = [[NSMutableArray alloc]init];
                    for(int i = 0; i < list.count;i ++){
                        InsuranceAddressModel *insuranceModel = [InsuranceAddressModel mj_objectWithKeyValues:(NSDictionary *)(list[i])];
                        [addressList addObject:insuranceModel];
                    }
                    InsuranceAddressListController *insuranceAddressListController = [[InsuranceAddressListController alloc]init];
                    insuranceAddressListController.addressList =addressList;
                    insuranceAddressListController.InsuranceId = self.InsuranceId;
                    insuranceAddressListController.isFour = YES;
                    [self.navigationController pushViewController:insuranceAddressListController animated:YES];
                    
                }else{
                    InsuranceAddAddressController *insuranceAddAddressController = [[InsuranceAddAddressController alloc]init];
                    [self.navigationController pushViewController:insuranceAddAddressController animated:YES];
                }
                
                
            }else{
                InsuranceAddAddressController *insuranceAddAddressController = [[InsuranceAddAddressController alloc]init];
                [self.navigationController pushViewController:insuranceAddAddressController animated:YES];
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
    
    InvoiceModel*invoiceModel= thisInsuranceModel.invoice;
    Boolean invoiceIsNotNull = NO;
    if (![GJCFStringUitil stringIsNull:invoiceModel.recipient]) {
        invoiceIsNotNull = YES;
    }
    
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"fee\":\"%@\",\"has_invoice\":\"%@\",\"s_code\":\"%@\",\"ship_age_type\":\"%@\",\"mail_fee\":\"%@\",\"ship_name\":\"%@\"",applicantered.text,invoiceIsNotNull?@"0":@"1",thisInsuranceModel.goods_stype_code,thisInsuranceModel.ship_age_type,invoiceModel.fee, thisInsuranceModel.ship_name];
    
    
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




















@end
