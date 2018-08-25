//
//  InsuranceReceiptController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceReceiptController.h"
#import "GrayLine.h"
#import "InsuranceInputFourController.h"
#import "InsuranceReceiptDetailController.h"
@interface InsuranceReceiptController (){
    UIScrollView *scrollView;
    ZYRadioButton *rb1;
    ZYRadioButton *rb2;
    UIButton *SaveBt;
    UISegmentedControl *segmentedControl;
    UIView *showView;
    int sizeHeight;
    int imageWidth;
    UIView *normalReceiptView;
    UIView *addValueTaxReceiptView;
    UILabel *normalReceiptTitle;
    UIImageView *normalReceiptSelected;
    UILabel *addValueTaxTitle;
    UIImageView *addValueTaxSelected;
    Boolean isSelectHolder;//yes 为增值税普通发票  no 为增值税发票
    int showViewHeight;
    UIScrollView *scrollment;
    UIView *bottomView ;
    UIView *bottomBtView ;
}

@end

@implementation InsuranceReceiptController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"水路货物运输保险条款";
    
    [self setUpUI];
    
    
    
}




-(void)setUpUI
{
    sizeHeight = 14;
    imageWidth = 7;
    isSelectHolder =YES;
    
    [self initView];
    if ([GJCFStringUitil stringIsNull:self.invoiceType]) {
        
        [self setSelectedSegument:1];
        isSelectHolder = YES;
    }else{
        [self setSelectedSegument:[GJCFStringUitil stringToInt:self.invoiceType]];
        if([self.invoiceType isEqualToString:@"1"]){
            isSelectHolder = YES;
        }else{
            isSelectHolder = NO;
        }
    }
    
}

-(void)initView{
    
//    self.view.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
//    UIView *head = [self setHeadTitle:@"发票信息"];
//    [self.view addSubview:head];
    
    
    
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREEN_WIDTH, 106)];
    firstView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview: firstView];
    
    UILabel *receiptTitleHeadLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 41)];
    receiptTitleHeadLabel.text= @"发票类型";
    receiptTitleHeadLabel.textColor = [CommonFontColorStyle FontNormalColor];
    receiptTitleHeadLabel.font =[CommonFontColorStyle NormalSizeFont];
    [firstView addSubview:receiptTitleHeadLabel];
    
    //普通发票
    int receiptwidht = 125;
    int receiptheight = 35;
    normalReceiptView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - receiptwidht)/2, receiptTitleHeadLabel.gjcf_bottom, receiptwidht, receiptheight)];
    normalReceiptView.layer.borderColor = [CommonFontColorStyle BlueColor].CGColor;
    normalReceiptView.layer.borderWidth = 1;
    [firstView addSubview:normalReceiptView];
    
    UITapGestureRecognizer *normalReceiptGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(normalReceiptClick:)];
    normalReceiptGesture.numberOfTapsRequired=1;
    normalReceiptView.userInteractionEnabled = YES;
    [normalReceiptView addGestureRecognizer:normalReceiptGesture];
    
    normalReceiptTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, receiptwidht, receiptheight)];
    normalReceiptTitle.text = @"增值税普通发票";
    normalReceiptTitle.textColor = [CommonFontColorStyle BlueColor];
    normalReceiptTitle.textAlignment = NSTextAlignmentCenter;
    normalReceiptTitle.font = [CommonFontColorStyle NormalSizeFont];
    [normalReceiptView addSubview: normalReceiptTitle];
    int selectedImageWidth = 15;
    normalReceiptSelected = [[UIImageView alloc]initWithFrame:CGRectMake(receiptwidht - selectedImageWidth, receiptheight-selectedImageWidth, selectedImageWidth, selectedImageWidth)];
    normalReceiptSelected.image = [UIImage imageNamed:@"ins_choose_yes"];
    [normalReceiptView addSubview:normalReceiptSelected];
    
    addValueTaxReceiptView = [[UIView alloc]initWithFrame:CGRectMake(normalReceiptView.gjcf_right + 18, receiptTitleHeadLabel.gjcf_bottom, receiptwidht, receiptheight)];
    addValueTaxReceiptView.layer.borderColor = [CommonFontColorStyle BlueColor].CGColor;
    addValueTaxReceiptView.layer.borderWidth = 1;
    [firstView addSubview:addValueTaxReceiptView];
    addValueTaxReceiptView.hidden = YES;
    
    UITapGestureRecognizer *addValueTaxGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addValueTaxClick:)];
    addValueTaxGesture.numberOfTapsRequired=1;
    addValueTaxReceiptView.userInteractionEnabled = YES;
    [addValueTaxReceiptView addGestureRecognizer:addValueTaxGesture];
    
    addValueTaxTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 105, 35)];
    addValueTaxTitle.text = @"增值税发票";
    addValueTaxTitle.textColor = [CommonFontColorStyle BlueColor];
    addValueTaxTitle.textAlignment = NSTextAlignmentCenter;
    addValueTaxTitle.font = [CommonFontColorStyle NormalSizeFont];
    [addValueTaxReceiptView addSubview: addValueTaxTitle];
    
    addValueTaxSelected = [[UIImageView alloc]initWithFrame:CGRectMake(receiptwidht - selectedImageWidth, receiptheight-selectedImageWidth, selectedImageWidth, selectedImageWidth)];
    addValueTaxSelected.image = [UIImage imageNamed:@"ins_choose_yes"];
    [addValueTaxReceiptView addSubview:addValueTaxSelected];
    
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, firstView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [self.view addSubview:grayLine];
    
    scrollment = [[UIScrollView alloc]initWithFrame:CGRectMake(0, grayLine.gjcf_bottom, SCREEN_WIDTH, SCREEN_HEIGHT - firstView.gjcf_bottom)];
    [self.view addSubview:scrollment];
    
    
    
    showViewHeight =SCREEN_HEIGHT - grayLine.gjcf_bottom-13;
    showView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, showViewHeight)];
    [scrollment addSubview:showView];
    
    //下一步
    bottomBtView = [[UIView alloc]initWithFrame:CGRectMake(0,  SCREEN_HEIGHT - CommonDimensStyle.btHeight-20, SCREEN_WIDTH, CommonDimensStyle.btHeight+20)];
    bottomBtView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomBtView];
    
    float baseColor = 239.0/255.0;
    for (float i=0; i<10; i++) {
        float a1=(float)i/10.0;
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, i, self.view.gjcf_width, 1)];
        view1.backgroundColor=[UIColor colorWithRed:baseColor green:baseColor blue:baseColor alpha:a1];
        [bottomBtView addSubview:view1];
    }
    
    UIView *subbottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, CommonDimensStyle.btHeight+10)];
    subbottomView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [bottomBtView addSubview:subbottomView];
    UIButton *fuSaveBt= [[UIButton alloc] initWithFrame:CGRectMake( CommonDimensStyle.smallMargin , 5, (CommonDimensStyle.screenWidth - 2*CommonDimensStyle.smallMargin ), CommonDimensStyle.btHeight)];
    
//    [fuSaveBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle EB9EFColor] Width:fuSaveBt.gjcf_width Height:fuSaveBt.gjcf_height] forState:UIControlStateNormal];
//    [fuSaveBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle BlueColor] Width:fuSaveBt.gjcf_width Height:fuSaveBt.gjcf_height] forState:UIControlStateHighlighted];
    
    [fuSaveBt setBackgroundColor:XXJColor(27, 69, 138)];
    
    fuSaveBt.layer.cornerRadius =CommonDimensStyle.smallCornerRadius;
    [fuSaveBt setTitle:@"确认保存" forState:UIControlStateNormal];
    fuSaveBt.titleLabel.font =[CommonFontColorStyle ButtonTextFont];
    [fuSaveBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    [fuSaveBt addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [subbottomView addSubview:fuSaveBt];
    bottomBtView.hidden = NO;
}


-(void)setSelectedSegument:(long)selected{
    for (UIView *item in showView.subviews) {
        [item removeFromSuperview];
    }
    if (selected == 1) {
        
        UIView *oneSeguement =[self oneSegumentView];
        [showView addSubview:oneSeguement];
        showView.gjcf_height =oneSeguement.gjcf_height;
        
        normalReceiptView.layer.borderColor = [CommonFontColorStyle BlueColor].CGColor;
        addValueTaxReceiptView.layer.borderColor = [CommonFontColorStyle CECECEColor].CGColor;
        normalReceiptTitle.textColor =[CommonFontColorStyle BlueColor];
        normalReceiptSelected.hidden = NO;
        addValueTaxTitle.textColor = [CommonFontColorStyle FontNormalColor];
        addValueTaxSelected.hidden = YES;
        bottomView.gjcf_top =showView.gjcf_bottom;
        CGSize cgsize = CGSizeMake(SCREEN_WIDTH, oneSeguement.gjcf_height + 120+10+CommonDimensStyle.btHeight);
        scrollment.contentSize = cgsize;
        // 隐藏水平滚动条
        scrollment.showsHorizontalScrollIndicator = NO;
        scrollment.showsVerticalScrollIndicator = NO;
        bottomBtView.hidden = YES;
        
    }else{
        UIView *twoSeguement =[self twoSegumentView];
        //        twoSeguement.gjcf_height = showView.gjcf_height;
        [showView addSubview:twoSeguement];
        showView.gjcf_height =twoSeguement.gjcf_height;
        
        normalReceiptView.layer.borderColor = [CommonFontColorStyle CECECEColor].CGColor;
        addValueTaxReceiptView.layer.borderColor = [CommonFontColorStyle BlueColor].CGColor;
        normalReceiptTitle.textColor =[CommonFontColorStyle FontNormalColor];
        normalReceiptSelected.hidden = YES;
        addValueTaxTitle.textColor = [CommonFontColorStyle BlueColor];
        addValueTaxSelected.hidden = NO;
        
        bottomView.gjcf_top =showView.gjcf_bottom;
        CGSize cgsize = CGSizeMake(SCREEN_WIDTH, twoSeguement.gjcf_height + 130+30+CommonDimensStyle.btHeight);
        scrollment.contentSize = cgsize;
        // 隐藏水平滚动条
        scrollment.showsHorizontalScrollIndicator = NO;
        scrollment.showsVerticalScrollIndicator = NO;
        bottomBtView.hidden = NO;
    }
}
-(UIView *)oneSegumentView{
    UIView *segumentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, 0, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [segumentView addSubview:grayLine];
    
    //保险金额
    UIView *receiptTitleview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    receiptTitleview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [segumentView addSubview:receiptTitleview];
    
    UILabel *receiptTitleHeadLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, receiptTitleview.gjcf_height)];
    receiptTitleHeadLabel.text= @"发票抬头";
    receiptTitleHeadLabel.textColor = [CommonFontColorStyle FontNormalColor];
    receiptTitleHeadLabel.font =[CommonFontColorStyle NormalSizeFont];
    [receiptTitleview addSubview:receiptTitleHeadLabel];
    
    UILabel *receiptTitleBodyLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 260), 0, 250, receiptTitleview.gjcf_height)];
    receiptTitleBodyLabel.text= @"只能选择投保人或被保险人";
    receiptTitleBodyLabel.textAlignment = NSTextAlignmentRight;
    receiptTitleBodyLabel.textColor = [CommonFontColorStyle BottomTextColor];
    receiptTitleBodyLabel.font =[CommonFontColorStyle NormalSizeFont];
    [receiptTitleview addSubview:receiptTitleBodyLabel];
    
    //横线
    GrayLine* grayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], receiptTitleview.gjcf_bottom, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [segumentView addSubview:grayLine1];
    
    UIView *selectedOneview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine1.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    selectedOneview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [segumentView addSubview:selectedOneview];
    
    UITapGestureRecognizer *firstTaiTouGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstTaiTouclick:)];
    firstTaiTouGesture.numberOfTapsRequired=1;
    selectedOneview.userInteractionEnabled = YES;
    [selectedOneview addGestureRecognizer:firstTaiTouGesture];
    
    //初始化单选按钮控件
    int imageWidthL = 20;
    rb1 = [[ZYRadioButton alloc] initWithGroupId:@"second" index:1 selectedImageName:@"form_choose_yes" unSelectedImageName:@"form_choose_no"];
    rb1.frame = CGRectMake(25,(selectedOneview.gjcf_height - imageWidthL)/2,imageWidthL,imageWidthL);
    [selectedOneview addSubview:rb1];
    
    UILabel *oneName = [[UILabel alloc]initWithFrame:CGRectMake(rb1.gjcf_right + 10, 0, (SCREEN_WIDTH - rb1.gjcf_right - 10), selectedOneview.gjcf_height)];;
    oneName.textColor = [CommonFontColorStyle FontNormalColor];
    oneName.font =[CommonFontColorStyle NormalSizeFont];
    oneName.text = self.holderName;
    [selectedOneview addSubview:oneName];
    
    
    //横线
    GrayLine* grayLine2 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], selectedOneview.gjcf_bottom, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [segumentView addSubview:grayLine2];
    
    
    
    UIView *selectedTwoview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine2.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    selectedTwoview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [segumentView addSubview:selectedTwoview];
    
    UITapGestureRecognizer *secondTaiTouGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secondTaiTouclick:)];
    secondTaiTouGesture.numberOfTapsRequired=1;
    selectedTwoview.userInteractionEnabled = YES;
    [selectedTwoview addGestureRecognizer:secondTaiTouGesture];
    
    rb2 = [[ZYRadioButton alloc] initWithGroupId:@"second" index:2 selectedImageName:@"form_choose_yes" unSelectedImageName:@"form_choose_no"];
    rb2.frame = CGRectMake(25,(selectedTwoview.gjcf_height - imageWidthL)/2,imageWidthL,imageWidthL);
    [selectedTwoview addSubview:rb2];
    
    UILabel *twoName = [[UILabel alloc]initWithFrame:CGRectMake(rb2.gjcf_right + 10, 0, (SCREEN_WIDTH - rb2.gjcf_right - 10), selectedTwoview.gjcf_height)];;
    twoName.textColor = [CommonFontColorStyle FontNormalColor];
    twoName.font =[CommonFontColorStyle NormalSizeFont];
    twoName.text = self.recognizeeName;
    [selectedTwoview addSubview:twoName];
    
    segumentView.gjcf_height =selectedTwoview.gjcf_bottom;
    
    [ZYRadioButton addObserverForGroupId:@"second" observer:self];
    
    if (![GJCFStringUitil stringIsNull:self.needselectTitle]) {
        if ([self.needselectTitle isEqualToString:self.holderName]) {
            [rb1 setSelected];
            self.selectTitle = self.holderName;
        }else{
            [rb2 setSelected];
            self.selectTitle = self.recognizeeName;
        }
    }else{
        [rb1 setSelected];
        self.selectTitle = self.holderName;
    }
    
    
    //横线
    GrayLine* grayLine3 = [[GrayLine alloc]initWithFrame:CGRectMake(0, selectedTwoview.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [segumentView addSubview:grayLine3];
    
    //下一步
    UIButton *normalSaveBt= [[UIButton alloc] initWithFrame:CGRectMake( CommonDimensStyle.smallMargin , (grayLine3.gjcf_bottom +CommonDimensStyle.topMargin), (CommonDimensStyle.screenWidth - 2*CommonDimensStyle.smallMargin ), CommonDimensStyle.btHeight)];
    
//    [normalSaveBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle EB9EFColor] Width:normalSaveBt.gjcf_width Height:normalSaveBt.gjcf_height] forState:UIControlStateNormal];
//    [normalSaveBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle BlueColor] Width:normalSaveBt.gjcf_width Height:normalSaveBt.gjcf_height] forState:UIControlStateHighlighted];
    
    [normalSaveBt setBackgroundColor:XXJColor(27, 69, 138)];
    
    normalSaveBt.layer.cornerRadius =CommonDimensStyle.smallCornerRadius;
    [normalSaveBt setTitle:@"确认保存" forState:UIControlStateNormal];
    normalSaveBt.titleLabel.font =[CommonFontColorStyle ButtonTextFont];
    [normalSaveBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    [normalSaveBt addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [segumentView addSubview:normalSaveBt];
    
    segumentView.gjcf_height = normalSaveBt.gjcf_bottom;
    return segumentView;
}


-(UIView *)twoSegumentView{
    UIView *segumentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, showViewHeight)];
    
    segumentView.backgroundColor = [CommonFontColorStyle WhiteColor];
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, 0, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [segumentView addSubview:grayLine];
    
    //开头
    UILabel *receiptTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, grayLine.gjcf_bottom+20 , SCREEN_WIDTH-50, 50)];
    receiptTitleLabel.textAlignment = NSTextAlignmentLeft;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"如需开具增值税发票请提供以下信息，保险专员将第一时间联系您！"];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFontColorStyle FontNormalColor] range:NSMakeRange(0,17)];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFontColorStyle RedColor] range:NSMakeRange(17,13)];
    receiptTitleLabel.attributedText = str;
    receiptTitleLabel.numberOfLines = 0;
    receiptTitleLabel.font = [CommonFontColorStyle NormalSizeFont];
    receiptTitleLabel.backgroundColor = [CommonFontColorStyle FFFDF4Color];
    [segumentView addSubview:receiptTitleLabel];
    
    
    int leftWidth = 25;
    UIView *ContentView = [[UIView alloc]initWithFrame:CGRectMake(0, receiptTitleLabel.gjcf_bottom + 15, SCREEN_WIDTH, 23)];
    ContentView.backgroundColor = [CommonFontColorStyle F7F7F7Color];
    [segumentView addSubview:ContentView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(3.7+leftWidth, 19, 0.5, 216)];
    lineView.backgroundColor = [CommonFontColorStyle E2E2E2Color];
    [ContentView addSubview:lineView];
    
    UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(leftWidth, 12, ContentView.gjcf_width, sizeHeight)];
    [ContentView addSubview:oneView];
    [oneView addSubview:[self setPicture]];
    
    [oneView addSubview:[self setContent:@"纳税人姓名"]];
    
    UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(leftWidth, oneView.gjcf_bottom + 17, ContentView.gjcf_width, sizeHeight)];
    
    [twoView addSubview:[self setPicture]];
    
    [twoView addSubview:[self setContent:@"统一社会信用代码/纳税人识别号"]];
    [ContentView addSubview:twoView];
    
    UIView *threeView = [[UIView alloc]initWithFrame:CGRectMake(leftWidth, twoView.gjcf_bottom + 17, ContentView.gjcf_width, sizeHeight)];
    
    [threeView addSubview:[self setPicture]];
    
    [threeView addSubview:[self setContent:@"地址"]];
    [ContentView addSubview:threeView];
    
    UIView *fourView = [[UIView alloc]initWithFrame:CGRectMake(leftWidth, threeView.gjcf_bottom + 17, ContentView.gjcf_width, sizeHeight)];
    [fourView addSubview:[self setPicture]];
    [fourView addSubview:[self setContent:@"电话"]];
    [ContentView addSubview:fourView];
    
    UIView *fiveView = [[UIView alloc]initWithFrame:CGRectMake(leftWidth, fourView.gjcf_bottom + 17, ContentView.gjcf_width, sizeHeight)];
    [fiveView addSubview:[self setPicture]];
    [fiveView addSubview:[self setContent:@"开户银行名称"]];
    [ContentView addSubview:fiveView];
    
    UIView *sixView = [[UIView alloc]initWithFrame:CGRectMake(leftWidth, fiveView.gjcf_bottom + 17, ContentView.gjcf_width, sizeHeight)];
    [sixView addSubview:[self setPicture]];
    [sixView addSubview:[self setContent:@"开户银行帐号"]];
    [ContentView addSubview:sixView];
    
    UIView *sevenView = [[UIView alloc]initWithFrame:CGRectMake(leftWidth, sixView.gjcf_bottom + 17, ContentView.gjcf_width, sizeHeight)];
    [sevenView addSubview:[self setPicture]];
    [sevenView addSubview:[self setContent:@"是否为增值税一般纳税人"]];
    [ContentView addSubview:sevenView];
    
    UIView *eightView = [[UIView alloc]initWithFrame:CGRectMake(leftWidth, sevenView.gjcf_bottom + 17, ContentView.gjcf_width, sizeHeight)];
    [eightView addSubview:[self setPicture]];
    [eightView addSubview:[self setContent:@"是否需要开具增值税专用发票"]];
    [ContentView addSubview:eightView];
    
    ContentView.gjcf_height =eightView.gjcf_bottom + 12;
    
    UITextView *zhuTextView = [[UITextView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], ContentView.gjcf_bottom + 15, scrollment.gjcf_width - 2*[CommonDimensStyle smallMargin], 28)];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[CommonFontColorStyle F13SizeFont],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    zhuTextView.attributedText = [[NSAttributedString alloc] initWithString:@"注：如果您的企业是“增值税一般纳税人”，请提供《税务登记证》副本复印件及增值税一般纳税人证明文件复印件。" attributes:attributes];
    
    zhuTextView.textColor = [CommonFontColorStyle BottomTextColor];
    [zhuTextView sizeToFit];
    [segumentView addSubview:zhuTextView];
    
    segumentView.gjcf_height = zhuTextView.gjcf_bottom;
    
    return segumentView;
}

-(UIView *)setContent:(NSString *)content{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(22, 0,SCREEN_WIDTH - 57, sizeHeight)];
    label.textColor = [CommonFontColorStyle FontNormalColor];
    label.font = [CommonFontColorStyle SmallSizeFont];
    label.text = content;
    return label;
}

-(UIView *)setPicture{
    UIImageView *oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, (sizeHeight - imageWidth)/2, imageWidth, imageWidth)];
    oneImage.image = [UIImage imageNamed:@"ins_icon_lx"];
    return oneImage;
}

- (void)normalReceiptClick:(UITapGestureRecognizer *)sender{
    [self setSelectedSegument:1];
    isSelectHolder  = YES;
}


- (void)addValueTaxClick:(UITapGestureRecognizer *)sender{
    [self setSelectedSegument:2];
    isSelectHolder  = false;
}

-(void)nextClick{
    if (isSelectHolder && [GJCFStringUitil stringIsNull:self.selectTitle]) {
        
        [self.view makeToast:@"请选择发票抬头" duration:0.1 position:CSToastPositionCenter];
        return;
    }
    
    NSString *titleType = @"";
    if(isSelectHolder){
        if ([self.selectTitle isEqualToString:self.holderName]) {
            titleType =@"holder_name";
        }else{
            titleType =@"recognizee_name";
        }
    }
    if (self.isFour) {
        InsuranceInputFourController *insuranceInputFourController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        
        insuranceInputFourController.invoice_type =isSelectHolder?@"1":@"2";
        insuranceInputFourController.taitou_title =self.selectTitle;
        insuranceInputFourController.title_type =titleType;
        insuranceInputFourController.isNeedFaPiao = YES;
        [self.navigationController popToViewController:insuranceInputFourController animated:YES];
    }else{
        InsuranceReceiptDetailController *insuranceInputFourController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        
        insuranceInputFourController.invoice_type =isSelectHolder?@"1":@"2";
        insuranceInputFourController.taitou_title =self.selectTitle;
        insuranceInputFourController.title_type =titleType;
        insuranceInputFourController.isNeedFaPiao = YES;
        [self.navigationController popToViewController:insuranceInputFourController animated:YES];
    }
    
}


//代理方法
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    if (index ==1) {
        self.selectTitle = self.holderName;
    }else{
        self.selectTitle = self.recognizeeName;
    }
}

- (void)firstTaiTouclick:(UITapGestureRecognizer *)sender{
    self.selectTitle = self.holderName;
    [rb1 setSelected];
    [rb2 setDisSelected];
}

- (void)secondTaiTouclick:(UITapGestureRecognizer *)sender{
    self.selectTitle = self.recognizeeName;
    [rb2 setSelected];
    [rb1 setDisSelected];
}

































































































@end
