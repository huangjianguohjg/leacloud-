//
//  InsuranceAddressListController.m
//  HGWIOS
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "InsuranceAddressListController.h"
#import "InsuranceAddressCell.h"
#import "InsuranceAddressModel.h"
#import "InsuranceInputFourController.h"
#import "InsuranceReceiptDetailController.h"
#import "InsuranceAddAddressController.h"
@interface InsuranceAddressListController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString *identifier;
    NSString *youfei;
}

@end

@implementation InsuranceAddressListController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self initView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"添加邮寄地址";
    
    [self setUpUI];
    
    
    
}




-(void)setUpUI
{
    
    
    
}





-(void)initView{
    identifier = @"cell";
    
    
    
    //未支付
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0.0f;
    self.AddressCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight , SCREEN_WIDTH, (SCREEN_HEIGHT-kStatusBarHeight - kNavigationBarHeight))collectionViewLayout:flowLayout];
    self.AddressCollectionView.tag =1;
    
    //注册单元格
    [self.AddressCollectionView registerClass:[InsuranceAddressCell class]forCellWithReuseIdentifier:identifier];
    self.AddressCollectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
    
    //设置代理
    self.AddressCollectionView.delegate = self;
    
    self.AddressCollectionView.dataSource = self;
    
    [self.view addSubview:self.AddressCollectionView];
    
    
    //预约加油
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.AddressCollectionView.gjcf_bottom - 65, SCREEN_WIDTH, 65)];
    [self.view addSubview:bottom];
    
    bottom.backgroundColor = [CommonFontColorStyle WhiteColor];
    
    int btMargin = [CommonDimensStyle smallMargin];
    UIButton *resvOilBt = [[UIButton alloc]initWithFrame:CGRectMake(btMargin, btMargin, (SCREEN_WIDTH -2*btMargin), 45)];
    [bottom addSubview:resvOilBt];
    [resvOilBt setTitle:@"添加新地址" forState:UIControlStateNormal];
    [resvOilBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle FFEDDCColor] Width:(SCREEN_WIDTH -2*btMargin) Height:45] forState:UIControlStateNormal];
    [resvOilBt setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle F9E0C7Color] Width:(SCREEN_WIDTH -2*btMargin) Height:45] forState:UIControlStateHighlighted];
    
    resvOilBt.layer.borderColor = [CommonFontColorStyle FFA145Color].CGColor;
    resvOilBt.layer.borderWidth = 0.5;
    resvOilBt.layer.cornerRadius = 5;
    resvOilBt.titleLabel.font = [CommonFontColorStyle BigSizeFont];
    [resvOilBt addTarget:self action:@selector(resvBtOnclick) forControlEvents:UIControlEventTouchUpInside];
    [resvOilBt setTitleColor:[CommonFontColorStyle YellowColor] forState:UIControlStateNormal];
    
    float baseColor = 239.0/255.0;
    for (float i=self.AddressCollectionView.gjcf_bottom -10; i<self.AddressCollectionView.gjcf_bottom; i++) {
        float a1=(float)(i - self.AddressCollectionView.gjcf_bottom+10)/10.0;
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, i, self.view.gjcf_width, 1)];
        view1.backgroundColor=[UIColor colorWithRed:baseColor green:baseColor blue:baseColor alpha:a1];
        [self.view addSubview:view1];
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets top = {10,0,0,0};
    return top;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//每个分区上得元素个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1) {
        return self.addressList.count;
    }else{
        return 0;
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, 89);
}
//设置元素内容
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InsuranceAddressCell *insuranceAddressCell = (InsuranceAddressCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
    if (collectionView.tag == 1) {
        
        
        InsuranceAddressModel *insuranceAddressModel =((InsuranceAddressModel *)self.addressList[indexPath.row]);
        Boolean isCurrent = NO;
        if ([@"Y" isEqualToString:insuranceAddressModel.is_current]) {
            isCurrent = YES;
        }
        
        NSString *address= [NSString stringWithFormat:@"%@  %@",insuranceAddressModel.address,insuranceAddressModel.detail_address];
        [insuranceAddressCell initContent:insuranceAddressModel.addressee Mobile:insuranceAddressModel.mobile YouFei:insuranceAddressModel.invoice_fee Address:address Moren:isCurrent InsuranceId:insuranceAddressModel.id Express_company:insuranceAddressModel.express_company];
        
        UITapGestureRecognizer *imageeditGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageEditClick:)];
        imageeditGesture.numberOfTapsRequired=1;
        insuranceAddressCell.editView.userInteractionEnabled = YES;
        [insuranceAddressCell.editView addGestureRecognizer:imageeditGesture];
        
    }
    
    
    
    return insuranceAddressCell;
    
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    InsuranceAddressCell * cell = (InsuranceAddressCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:YES];
    
    
    NSString *name = cell.insuranceTitle;
    NSString *mobile = cell.MobileLabel.text;
    NSString *address = cell.insuranceAddressView.text;
    youfei = cell.YouFeiLabel.text;
    NSString *express_company = cell.express_company;
    
    NSString *bigaddress = @"";
    NSString *detail_address = @"";
    for(int i = 0; i< self.addressList.count; i++){
        InsuranceAddressModel *insuranceAddressModel =  (InsuranceAddressModel *)self.addressList[i];
        if ([insuranceAddressModel.addressee isEqualToString:name]) {
            bigaddress = insuranceAddressModel.address;
            detail_address = insuranceAddressModel.detail_address;
        }
    }
    
    NSString *proviceString =[bigaddress componentsSeparatedByString:@" "][0];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"address\":\"%@\",\"ec_id\":\"%@\",\"address_detail1\":\"%@\",\"address_detail2\":\"%@\",\"uid\":\"%@\"",proviceString,express_company, bigaddress,detail_address, [UseInfo shareInfo].uID];
    
    [SVProgressHUD show];
    [XXJNetManager requestPOSTURLString:StartInsurance URLMethod:GetFeeWithAddressEcMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        if (result != nil) {
            
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if ([[boatresult objectForKey:@"status"] boolValue]) {
                youfei =[NSString stringWithFormat:@"%@", [boatresult objectForKey:@"fee"]];
                if ([youfei isEqualToString:@"0"]) {
                    
                    [self.view makeToast:@"同一自然月内，相同地址只需支付一次快递费，由保险公司统一寄出" duration:0.5 position:CSToastPositionCenter];
                }
            }
        }
        if(self.isFour){
            InsuranceInputFourController *insuranceInputFourController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
            insuranceInputFourController.recipient = name;
            insuranceInputFourController.addressId =cell.insuranceId;
            insuranceInputFourController.mobile = mobile;
            insuranceInputFourController.address = bigaddress;
            insuranceInputFourController.detail_address = detail_address;
            insuranceInputFourController.invoice_fee = youfei;
            insuranceInputFourController.isNeedAddress = YES;
            insuranceInputFourController.InsuranceId = self.InsuranceId;
            insuranceInputFourController.expresscompany =express_company;
            [self.navigationController popToViewController:insuranceInputFourController animated:YES];
        }else{
            InsuranceReceiptDetailController *insuranceInputFourController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
            insuranceInputFourController.recipient = name;
            insuranceInputFourController.mobile = mobile;
            insuranceInputFourController.addressId =cell.insuranceId;
            insuranceInputFourController.address = bigaddress;
            insuranceInputFourController.detail_address = detail_address;
            insuranceInputFourController.invoice_fee = youfei;
            insuranceInputFourController.isNeedAddress = YES;
            insuranceInputFourController.InsuranceId = self.InsuranceId;
            insuranceInputFourController.express_company =express_company;
            [self.navigationController popToViewController:insuranceInputFourController animated:YES];
            
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
    
    
}

//UICollectionView没有选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    [cell setSelected:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    //    ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [CommonFontColorStyle DBE6EFColor];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    //    ShipAgeViewCell * cell = (ShipAgeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [CommonFontColorStyle WhiteColor];
}



-(void)resvBtOnclick{
    InsuranceAddAddressController *insuranceAddAddressController =[[InsuranceAddAddressController alloc]init];
    insuranceAddAddressController.fromPage = 2;
    [self.navigationController pushViewController:insuranceAddAddressController animated:YES];
}

- (void)imageEditClick:(UITapGestureRecognizer *)sender{
    InsuranceAddressCell *insuranceAddressCell= (InsuranceAddressCell *)(((UIImageView *)sender.view).superview);
    InsuranceAddAddressController *insuranceAddAddressController = [[InsuranceAddAddressController alloc]init];
    insuranceAddAddressController.insuranceId =self.InsuranceId;
    insuranceAddAddressController.addressId =insuranceAddressCell.insuranceId;
    [self.navigationController pushViewController:insuranceAddAddressController animated:YES];
}







@end
