//
//  BaoxianViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "BaoxianViewController.h"
#import "GrayLine.h"
#import "HeadView.h"
#import "BoatNameViewCell.h"
#import "ContactorModel.h"
#import "InsuranceConfirmController.h"
#import "InsuranceInputTwoController.h"
#import "MyInsurancesController.h"

@interface BaoxianViewController (){
    NSString *identifier;
    UIScrollView *scrollView;
    UITextField *applicanter;
    UITextField *applicantered;
    UITextField *contact;
    UITextField *contactMobile;
    UIButton *NextBt;
    NSMutableArray *contactorList;
    AFFNumericHoriKeyboard *keyboard;
    UIView *youMingView;
}

@end

@implementation BaoxianViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXJColor(218, 218, 218);
    
    [self setUpNav];
    
    [self setUpUI];

}


-(void)setUpNav
{
    self.navigationItem.title = @"填写保单";
    
    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"arrow-appbar-left"] forState:UIControlStateNormal];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    if (self.isServeVC) {
        UIButton * rightButton = [[UIButton alloc]init];
        [rightButton addTarget:self action:@selector(rightItem) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:@"我的保单" forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
        [rightButton sizeToFit];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    }
    
    
    
    
}

-(void)leftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)rightItem
{
    MyInsurancesController * myInsuranceVc = [[MyInsurancesController alloc]init];
    myInsuranceVc.isInputOneVc = YES;
    [self.navigationController pushViewController:myInsuranceVc animated:YES];
}


-(void)setUpUI
{
    
    keyboard = [[AFFNumericHoriKeyboard alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 216)];
    keyboard.delegate = self;
    
    [self initView];
    [self KeyBoardHidden];
    //赋值
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
    self.collectionView.gjcf_height = 0;
    youMingView.gjcf_top = self.collectionView.gjcf_bottom;
    
}


-(void)initView{
    
    NSString *titleString = @"填写保单";
    if (self.isEdit) {
        titleString = @"投保信息";
    }
   
//    UIView *head = [self setHeadTitle:titleString];
//    [self.view addSubview:head];
    
    identifier = @"cell";
    
    int titleWidth = 70;
    // 1.创建UIScrollView
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREEN_WIDTH, SCREENWIDTH - kStatusBarHeight - kNavigationBarHeight ); // frame中的size指UIScrollView的可视范围
    [self.view addSubview:scrollView];
    
    //导航条
    UIView *navView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) type:1];
    [scrollView addSubview:navView];
    
//    if (self.isEdit) {
        navView.gjcf_height = 0;
//    }
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, navView.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [scrollView addSubview:grayLine];
    
    //投保人
    UIView *applicantview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    applicantview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [scrollView addSubview:applicantview];
    
    UILabel *applicantNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicantview.gjcf_height)];
    applicantNameLabel.text= @"投保人";
    applicantNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    applicantNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [applicantview addSubview:applicantNameLabel];
    
    applicanter = [[UITextField alloc]initWithFrame:CGRectMake((applicantNameLabel.gjcf_right +[CommonDimensStyle smallMargin]), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-applicantNameLabel.gjcf_right ), applicantview.gjcf_height)];
    applicanter.textAlignment = NSTextAlignmentRight;
    applicanter.textColor = [CommonFontColorStyle I3Color];
    applicanter.font =[CommonFontColorStyle MenuSizeFont];
    applicanter.tag = 10;
    applicanter.placeholder = @"填写投保人姓名";
    
    [applicantview addSubview:applicanter];
    applicanter.delegate = self;
    [applicanter addTarget:self action:@selector(applicanterChange:) forControlEvents:UIControlEventEditingChanged];
    //    applicanter.delegate = self;
    
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0.0f;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, applicantview.gjcf_bottom, SCREEN_WIDTH, 0) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.tag = 3;
    [scrollView addSubview:self.collectionView];
    //注册单元格
    [self.collectionView registerClass:[BoatNameViewCell class]forCellWithReuseIdentifier:identifier];
    self.collectionView.backgroundColor = [CommonFontColorStyle WhiteColor];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    youMingView = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.gjcf_bottom-0.5, CommonDimensStyle.screenWidth, 300)];
    [scrollView addSubview:youMingView];
    
    //横线
    GrayLine* grayLine2 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 0, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [youMingView addSubview:grayLine2];
    
    
    //被保险人
    UIView *applicanteredNameview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine2.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    applicanteredNameview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [youMingView addSubview:applicanteredNameview];
    
    UILabel *applicanteredNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    applicanteredNameLabel.text= @"被保险人";
    applicanteredNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    applicanteredNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [applicanteredNameview addSubview:applicanteredNameLabel];
    
    applicantered = [[UITextField alloc]initWithFrame:CGRectMake((applicanteredNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-applicanteredNameLabel.gjcf_right ), applicanteredNameview.gjcf_height)];
    applicantered.textAlignment = NSTextAlignmentRight;
    applicantered.delegate = self;
    applicantered.textColor = [CommonFontColorStyle I3Color];
    applicantered.font =[CommonFontColorStyle MenuSizeFont];
    applicantered.placeholder =@"填写被保险人姓名";
    [applicanteredNameview addSubview:applicantered];
    
    //横线
    GrayLine* grayLine3 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], applicanteredNameview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [youMingView addSubview:grayLine3];
    
    //联系人
    UIView *contactview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine3.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    contactview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [youMingView addSubview:contactview];
    
    UILabel *contactNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    contactNameLabel.text= @"联系人";
    contactNameLabel.textColor = [CommonFontColorStyle FontNormalColor];
    contactNameLabel.font =[CommonFontColorStyle MenuSizeFont];
    [contactview addSubview:contactNameLabel];
    
    contact = [[UITextField alloc]initWithFrame:CGRectMake((contactNameLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-contactNameLabel.gjcf_right ), contactview.gjcf_height)];
    contact.textAlignment = NSTextAlignmentRight;
    contact.textColor = [CommonFontColorStyle I3Color];
    contact.font =[CommonFontColorStyle MenuSizeFont];
    contact.placeholder =@"填写联系人姓名";
    contact.delegate = self;
    [contactview addSubview:contact];
    
    //横线
    GrayLine* grayLine4 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], contactview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [youMingView addSubview:grayLine4];
    
    //联系电话
    UIView *contactMobileview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine4.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    contactMobileview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [youMingView addSubview:contactMobileview];
    
    UILabel *contactMobileLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleWidth, applicanteredNameview.gjcf_height)];
    contactMobileLabel.text= @"联系电话";
    contactMobileLabel.textColor = [CommonFontColorStyle FontNormalColor];
    contactMobileLabel.font =[CommonFontColorStyle MenuSizeFont];
    [contactMobileview addSubview:contactMobileLabel];
    
    contactMobile = [[UITextField alloc]initWithFrame:CGRectMake((contactMobileLabel.gjcf_right +10), 0, (SCREEN_WIDTH - 2*[CommonDimensStyle smallMargin]-contactMobileLabel.gjcf_right ), contactMobileview.gjcf_height)];
    contactMobile.textAlignment = NSTextAlignmentRight;
    contactMobile.textColor = [CommonFontColorStyle I3Color];
    contactMobile.font =[CommonFontColorStyle MenuSizeFont];
    contactMobile.inputView = keyboard;
    contactMobile.placeholder =@"填写联系人电话";
    contactMobile.delegate = self;
    [contactMobileview addSubview:contactMobile];
    
    //横线
    GrayLine* grayLine5 = [[GrayLine alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], contactMobileview.gjcf_bottom-0.5, (CommonDimensStyle.screenWidth-2*[CommonDimensStyle smallMargin]), 0.5)];
    [youMingView addSubview:grayLine5];
    
    //联系人
    UIView *commentview = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine5.gjcf_bottom , SCREEN_WIDTH, [CommonDimensStyle inputHeight])];
    commentview.backgroundColor = [CommonFontColorStyle WhiteColor];
    [youMingView addSubview:commentview];
    
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - [CommonDimensStyle smallMargin]), commentview.gjcf_height)];
    commentLabel.text= @"注:被保险人不能为实际承运人";
    commentLabel.textColor = [CommonFontColorStyle RedColor];
    commentLabel.font =[CommonFontColorStyle SmallSizeFont];
    commentLabel.textAlignment = NSTextAlignmentRight;
    [commentview addSubview:commentLabel];
    
    //横线
    GrayLine* grayLine6 = [[GrayLine alloc]initWithFrame:CGRectMake(0, commentview.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5)];
    [youMingView addSubview:grayLine6];
    
    //    //下一步
    NextBt= [[UIButton alloc] initWithFrame:CGRectMake( CommonDimensStyle.smallMargin , (grayLine6.gjcf_bottom +CommonDimensStyle.topMargin), (CommonDimensStyle.screenWidth - 2*CommonDimensStyle.smallMargin ), CommonDimensStyle.btHeight)];
    
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"2dabff") Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateNormal];
//    [NextBt setBackgroundImage:[UIImage singleColorImage:DDColor(@"0f92ea") Width:NextBt.gjcf_width Height:NextBt.gjcf_height] forState:UIControlStateHighlighted];
    
    [NextBt setBackgroundColor:XXJColor(27, 69, 138)];
    
    NextBt.layer.cornerRadius =CommonDimensStyle.smallCornerRadius;
    if (self.isEdit) {
        [NextBt setTitle:@"确认保存" forState:UIControlStateNormal];
    }else{
        [NextBt setTitle:@"下一步(货物信息)" forState:UIControlStateNormal];
    }
    
    NextBt.titleLabel.font =[CommonFontColorStyle ButtonTextFont];
    [NextBt setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateNormal];
    [NextBt addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [youMingView addSubview:NextBt];
    
//    youMingView.backgroundColor = [UIColor redColor];
    youMingView.gjcf_height = NextBt.gjcf_bottom;
    
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
    return contactorList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, [CommonDimensStyle inputHeight]);
}
//设置元素内容
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BoatNameViewCell *boatNameViewCell = (BoatNameViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
    NSString *name =((ContactorModel *)contactorList[indexPath.row]).holder_name;
    [boatNameViewCell setName:name];
    return boatNameViewCell;
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //        [self closeAllShow];
    BoatNameViewCell * cell = (BoatNameViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *applicanterString =cell.contentLabel.text;
    
    
    for(int i = 0;i<contactorList.count ; i++){
        ContactorModel *contactorModel =(ContactorModel *)contactorList[i];
        if([contactorModel.holder_name isEqualToString:applicanterString]){
            
            [applicanter removeTarget:nil action:nil forControlEvents:UIControlEventEditingChanged];
            
            applicanter.text =contactorModel.holder_name;
            
            [applicanter addTarget:self action:@selector(applicanterChange:) forControlEvents:UIControlEventEditingChanged];
            applicantered.text =contactorModel.recognizee_name;
            contact.text =contactorModel.contact_person;
            contactMobile.text =contactorModel.contact_phone;
            break;
        }
    }
    self.collectionView.gjcf_height = 0;
    youMingView.gjcf_top = self.collectionView.gjcf_bottom;
    
}


-(void)startInsurance{
    NSString *parameterstring = [NSString stringWithFormat:@"\"uid\":\"%@\",\"source\":\"2\"",[UseInfo shareInfo].uID];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:StartInsuranceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            
            if ([result[@"result"] isEqual:[NSNull null]]) {
                return ;
            }
            
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if ([[boatresult objectForKey:@"status"] boolValue])
            {
                self.insuranceId = [boatresult objectForKey:@"id"];
                [self getInsuranceInfo];
            }
            else
            {

                 [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
            
            
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}



-(void)getRecentInsuranceUserList{
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"max\":\"10\"",[UseInfo shareInfo].access_token];
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetRecentInsuranceUserListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                contactorList = [[NSMutableArray alloc]init];
                NSArray *list = [boatresult objectForKey:@"data"];
                if( ![list isEqual:[NSNull null]]&&  list != nil &&[list count] >0){
                    for(int i = 0; i < list.count;i ++){
                        ContactorModel *contactorModel = [ContactorModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                        [contactorList addObject:contactorModel];
                    }
                    if (list.count<3) {
                        self.collectionView.gjcf_height = [CommonDimensStyle inputHeight]*list.count;
                    }else{
                        self.collectionView.gjcf_height = [CommonDimensStyle inputHeight]*3;
                    }
                }else {
                    self.collectionView.gjcf_height = 0;
                }
            }
            else {
                self.collectionView.gjcf_height = 0;
            }
        }
        else{
            self.collectionView.gjcf_height = 0;
        }
        
        youMingView.gjcf_top =self.collectionView.gjcf_bottom-0.5;
        //        [self scrollSize];
        [self.collectionView reloadData];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
}



-(void)nextClick{

    NSString *holder_name = applicanter.text;
    if([GJCFStringUitil stringIsNull:holder_name]){
        [self.view makeToast:@"投保人不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    NSString *contact_person =contact.text;
    if([GJCFStringUitil stringIsNull:contact_person]){
        [self.view makeToast:@"联系人不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    NSString *contact_phone =contactMobile.text;
    if([GJCFStringUitil stringIsNull:contact_phone]){
        
        [self.view makeToast:@"联系电话不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }else{
        
        NSString *regex = @"^(^0\\d{2}-?\\d{8}$)|(^0\\d{3}-?\\d{7,8}$)|(^\(0\\d{2}\)-?\\d{8}$)|(^\(0\\d{3}\)-?\d{7,8}$)|((\\+\\d+)?1\\d{10})$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = false;
        
        isMatch = [pred evaluateWithObject:contact_phone];
        if (!isMatch) {
            
            [self.view makeToast:@"联系电话格式不正确" duration:0.5 position:CSToastPositionCenter];
            return;
        }
        
    }
    NSString *recognizee_name =applicantered.text;
    if([GJCFStringUitil stringIsNull:recognizee_name]){
        [self.view makeToast:@"被保险人不能为空" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    [NextBt setUserInteractionEnabled:NO];
    NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\",\"holder_name\":\"%@\",\"contact_person\":\"%@\",\"contact_phone\":\"%@\",\"recognizee_name\":\"%@\"",self.insuranceId,holder_name,contact_person,contact_phone,recognizee_name];
    
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:SaveHolderInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                if (self.isEdit) {
                    InsuranceConfirmController *insuranceConfirmController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                    insuranceConfirmController.InsuranceId = self.insuranceId;
                    [self.navigationController popToViewController:insuranceConfirmController animated:YES];

                }else{
//
                    InsuranceInputTwoController *insuranceInputTwoController = [[InsuranceInputTwoController alloc]init];
                    insuranceInputTwoController.InsuranceId =self.insuranceId;
                    //                    insuranceInputTwoController.oldInsuranceModel = self.oldInsuranceModel;
                    [self.navigationController pushViewController:insuranceInputTwoController animated:YES];
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




-(void)applicanterChange:(id) sender {
    if (contactorList != nil && contactorList.count >0) {
        int j = 0;
        for (int i =0; i<contactorList.count; i++) {
            ContactorModel *contactorModel =(ContactorModel *)contactorList[i];
            if ([contactorModel.holder_name containsString:applicanter.text] ||[GJCFStringUitil stringIsNull:applicanter.text]) {
                j++;
            }
        }
        if (j == 0) {
            self.collectionView.gjcf_height = 0;
            
        }else{
            if (contactorList.count<3) {
                self.collectionView.gjcf_height = [CommonDimensStyle inputHeight]*contactorList.count;
            }else{
                self.collectionView.gjcf_height = [CommonDimensStyle inputHeight]*3;
            }
        }
        youMingView.gjcf_top = self.collectionView.gjcf_bottom;
        
        
    }
    
    applicantered.text =@"";
    contact.text =@"";
    contactMobile.text =@"";
}

#pragma mark 联系电话自定义键盘
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
    
    if (contactMobile.text.length != 0)
    {
        contactMobile.text = [contactMobile.text substringToIndex:contactMobile.text.length -1];
    }
    
}

- (void)numberKeyBoardFinish{
    [contactMobile resignFirstResponder];
}

-(void)numberKeyboardInput:(NSInteger)number{
    int num = (int)number;
    contactMobile.text = [contactMobile.text stringByAppendingString:[NSString stringWithFormat:@"%d",num]];
    
    NSMutableString *textString = [[NSMutableString alloc]initWithFormat:@"%@",contactMobile.text];
    NSString *regex = @"^(\\d{0,4}-{0,1}[0-9]{0,8})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = false;
    
    isMatch = [pred evaluateWithObject:textString];
    if (!isMatch) {
        if (textString.length >0) {
            contactMobile.text = [textString substringToIndex:(textString.length -1)];
        }
    }else{
        contactMobile.text = textString;
    }
}


- (void)writeInRadixPoint{
    if (![contactMobile.text containsString:@"-"]) {
        contactMobile.text = [contactMobile.text stringByAppendingString:[NSString stringWithFormat:@"%@",@"-"]];
    }
}

-(void)WriteContent{
    
    if(self.isEdit){
        [self getInsuranceInfo];
    }else{
        
        [self startInsurance];
    }
}



-(void)getInsuranceInfo{
    NSString *parameterstring = [NSString stringWithFormat:@"\"insurance_id\":\"%@\",\"access_token\":\"%@\"",self.insuranceId,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetInsuranceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                InsuranceModel *insuranceModel = [InsuranceModel mj_objectWithKeyValues:[boatresult objectForKey:@"data"]];
                self.oldInsuranceModel  = insuranceModel;
                //赋初值
                //\"id\":\"%@\",\"holder_name\":\"%@\",\"contact_person\":\"%@\",\"contact_phone\":\"%@\",\"recognizee_name\":\"%@\"
                
                applicanter.text = insuranceModel.holder_name;
                applicantered.text = insuranceModel.recognizee_name;
                contact.text = insuranceModel.contact_person;
                contactMobile.text = insuranceModel.contact_phone;
                
                
            }else{
                
                [self.view makeToast:[boatresult objectForKey:@"msg"] duration:0.5 position:CSToastPositionCenter];
            }
            
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 10) {
        [self getRecentInsuranceUserList];
    }else{
        self.collectionView.gjcf_height = 0;
        youMingView.gjcf_top = self.collectionView.gjcf_bottom-0.5;
    }
    
    return YES;
}

-(void)exitevent:(id)sender{
    if (self.isEdit) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

//关闭所有的弹出窗口
-(void)closeAllShow{
    [self.view endEditing:YES];
    self.collectionView.gjcf_height = 0;
    youMingView.gjcf_top = self.collectionView.gjcf_bottom-0.5;
}


@end
