//
//  LocationViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "LocationViewController.h"
#import "RefreshModel.h"
#import "NoneContentView.h"
#import "DynamicHistoryViewCell.h"
#import "DynamicBoatSearchModel.h"
#import "SearchBoatModel.h"
#import "ShipMapViewController.h"
#import "BoatModel.h"
#import "MyBoatModel.h"
@interface LocationViewController ()
{
    UIButton *authBt;
    UIButton *nextBt;
    int screenwidth;
    UIButton *searchButton;
    UITextField *inputtext;
    //搜索结果
    NSMutableArray *searchBoatModels;
    //历史纪录
    NSMutableArray *historyBoatModels;
    //弹出框
    UIView *searchResultView;
    NSInteger _currentRow;
    NSUInteger _rowMaxLines;
    BOOL isHidden;
    UIView *_overlayView;
    //船舶详细
    UIView *boatDetailView;
    UIImageView *boatimage;
    UILabel *boatName;
    UILabel *boatType;
    UIButton *lookPosition;
    //船舶id
    NSString *boatId;
    //历史纪录view
    UIView *historyView;
    UITextField *searchBar ;
    int selectedRow;
    NSString *mmsi;
    UILabel *nodate;
    NSString *identifier;
    NSMutableArray *searchList;
    RefreshModel *historyList;
    NoneContentView *noneContentView;
    
    UILabel *cleartitle;
    
    UILabel * chuanbotitle;
    
    UIScrollView * scrollView;
    
}
@end

@implementation LocationViewController

-(NSMutableArray *)chuanboArray
{
    if (_chuanboArray == nil) {
        _chuanboArray = [NSMutableArray array];
    }
    return _chuanboArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(218, 218, 218);
    

    self.navigationItem.title = @"船舶定位";
    
    [self setUpUI];
    
//    [self myShipRequest];
    
}




-(void)setUpUI
{
    
    historyList =[[RefreshModel alloc]init];
    historyList.datas = [[NSMutableArray alloc]init];
    historyList.pageIndex = 1;
    historyList.pageSize = 10;
    
    
    
    //加载页面信息
    [self initView];
    
    [self KeyBoardHidden];
    
    
    
    
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
    
    //判断是否登录
    NSString *token =  [UseInfo shareInfo].access_token;
    if ([GJCFStringUitil stringIsNull:token]) {
        self.searchcollectionView.hidden = NO;
        historyView.hidden = YES;
        
    }else{
        [self getReloadHistory];
    }
}

-(void)loadData{
    searchBar.text = @"";
    //判断是否登录
    NSString *token =  [UseInfo shareInfo].access_token;
    if ([GJCFStringUitil stringIsNull:token]) {
        self.searchcollectionView.hidden = NO;
        historyView.hidden = YES;
        
    }else{
        [self getReloadHistory];
        historyView.hidden = NO;
        self.searchcollectionView.hidden = YES;
    }
}


-(void)initView{
    identifier = @"cell";
    screenwidth= [CommonDimensStyle screenWidth];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.backgroundColor = XXJColor(218, 218, 218);
    [self.view addSubview:scrollView];
    
    
    UILabel * searchLable = [UILabel lableWithTextColor:[CommonFontColorStyle B8F3Color] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"本平台暂时只为已认证船舶提供定位服务"];
    [searchLable sizeToFit];
    [scrollView addSubview:searchLable];
    [searchLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(realW(20));
        make.top.equalTo(self.view).offset(realH(20) + kStatusBarHeight + kNavigationBarHeight);
    }];
    
    //搜索功能
    searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10, realH(36) + 25, ([CommonDimensStyle screenWidth] - 20),50)];
    UIFont *font = [CommonFontColorStyle BigSizeFont];
    searchBar.placeholder = @"请输入要搜索的船名";
    searchBar.font = font;
    searchBar.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.keyboardType = UIKeyboardTypeDefault;
    searchBar.backgroundColor=[UIColor whiteColor];
    searchBar.layer.cornerRadius = 5.0f;
    //searchBar.clearsOnBeginEditing = YES;
    searchBar.clearButtonMode = UITextFieldViewModeAlways;
    searchBar.returnKeyType =UIReturnKeySearch;
//    searchBar.backgroundColor = [UIColor colorWithRed:0 green:66.0/255 blue:125.0/255 alpha:0.3];
    searchBar.layer.borderColor = [[CommonFontColorStyle BlueColor] CGColor];
    searchBar.layer.borderWidth = 0.5f;
    searchBar.delegate = self;
    searchBar.tag = 10;
    [searchBar setValue:[CommonFontColorStyle B8F3Color] forKeyPath:@"_placeholderLabel.textColor"];
    UIView *leftBigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 43, 50)];
    UIImageView *leftView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
    [leftBigView addSubview:leftView];
    leftView.image= [UIImage imageNamed:@"dyna_icon_ser"];
    
    searchBar.leftView=leftBigView;
    searchBar.leftViewMode=UITextFieldViewModeAlways;
    [searchBar addTarget:self action:@selector(searchTextchange:) forControlEvents:UIControlEventEditingChanged];
    searchBar.textColor = [CommonFontColorStyle B8F3Color];
    [scrollView addSubview:searchBar];
    
    //历史纪录
    //([CommonDimensStyle screenHeight]- searchBar.gjcf_bottom- 130)
    historyView = [[UIView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], (searchBar.gjcf_bottom+10), (screenwidth - 2*[CommonDimensStyle smallMargin]), 20)];
    [scrollView addSubview:historyView];
    
    UILabel *historytitle = [[UILabel alloc]initWithFrame:CGRectMake(0,0,historyView.gjcf_width,15)];
    historytitle.text = @"搜索记录";
    historytitle.textColor = [CommonFontColorStyle B8F3Color];
    historytitle.font = [CommonFontColorStyle BigSizeFont];
    [historyView addSubview:historytitle];
    
    cleartitle = [[UILabel alloc]init];
    cleartitle.alpha = 0;
    cleartitle.userInteractionEnabled = YES;
    [cleartitle addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearTap)]];
    cleartitle.text = @"清空";
    cleartitle.textColor = [CommonFontColorStyle B8F3Color];
    cleartitle.font = [CommonFontColorStyle BigSizeFont];
    [cleartitle sizeToFit];
    [historyView addSubview:cleartitle];
    [cleartitle makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(searchBar.right);
        make.centerY.equalTo(historytitle);
    }];
    
    
    //历史纪录列表
    UICollectionViewFlowLayout * historyflowLayout =[[UICollectionViewFlowLayout alloc] init];
    [historyflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    historyflowLayout.minimumLineSpacing = 1.0f;
    
    self.historycollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, historytitle.gjcf_bottom+10, historyView.gjcf_width, historyView.gjcf_height- historytitle.gjcf_bottom - 10) collectionViewLayout:historyflowLayout];
    self.historycollectionView.tag = 1;
    self.historycollectionView.backgroundColor = [UIColor clearColor];
    //self.historycollectionView.backgroundColor = [UIColor greenColor];
    
    [historyView addSubview:self.historycollectionView];
    //注册单元格
    [self.historycollectionView registerClass:[DynamicHistoryViewCell class]forCellWithReuseIdentifier:identifier];
    
    self.historycollectionView.layer.cornerRadius = 5;
    //设置代理
    self.historycollectionView.delegate = self;
    self.historycollectionView.dataSource = self;
    
//    self.historyfootView = [MJRefreshFooterView footer];
//    self.historyfootView.scrollView = self.historycollectionView ;
//    self.historyfootView.delegate = self;
//    self.historyfootView.tag = 1;
    
    
    //搜索结果
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0.0f;
    self.searchcollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], searchBar.gjcf_bottom+10, (screenwidth - 2*[CommonDimensStyle smallMargin]), ([CommonDimensStyle screenHeight] - searchBar.gjcf_bottom - 130)) collectionViewLayout:flowLayout];
    self.searchcollectionView.backgroundColor = [UIColor whiteColor];
    self.searchcollectionView.tag = 2;
    
    [scrollView addSubview:self.searchcollectionView];
    //注册单元格
    [self.searchcollectionView registerClass:[DynamicHistoryViewCell class]forCellWithReuseIdentifier:identifier];
    
    //设置代理
    self.searchcollectionView.delegate = self;
    self.searchcollectionView.dataSource = self;
    
    self.searchcollectionView.layer.cornerRadius = 5;
    
    
    self.searchcollectionView.hidden = YES;
    
    noneContentView = [[NoneContentView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], searchBar.gjcf_bottom+10, (screenwidth - 2*[CommonDimensStyle smallMargin]), ([CommonDimensStyle screenHeight] - searchBar.gjcf_bottom - 130)) ImageName:@"blank_page_bg02" Top:50];
    noneContentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:noneContentView];
    noneContentView.hidden = YES;
    
    
    chuanbotitle = [[UILabel alloc]initWithFrame:CGRectMake(0,0,historyView.gjcf_width,15)];
    chuanbotitle.text = [[UseInfo shareInfo].identity isEqualToString:@"货主"] ? @"我的承运船舶" : @"我的船舶";
    chuanbotitle.textColor = [CommonFontColorStyle B8F3Color];
    chuanbotitle.font = [CommonFontColorStyle BigSizeFont];
    [chuanbotitle sizeToFit];
    [scrollView addSubview:chuanbotitle];
    [chuanbotitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(historyView.bottom).offset(realH(20));
        make.left.equalTo(self.view).offset([CommonDimensStyle smallMargin]);
    }];
    
    UICollectionViewFlowLayout * chuanboflowLayout =[[UICollectionViewFlowLayout alloc] init];
    [historyflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    historyflowLayout.minimumLineSpacing = 1.0f;
    
    self.chuanbocollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin], 0, historyView.gjcf_width, 0) collectionViewLayout:chuanboflowLayout];
    self.chuanbocollectionView.tag = 3;
    self.chuanbocollectionView.backgroundColor = [UIColor clearColor];
    //self.historycollectionView.backgroundColor = [UIColor greenColor];
    
    [scrollView addSubview:self.chuanbocollectionView];
    //注册单元格
    [self.chuanbocollectionView registerClass:[DynamicHistoryViewCell class]forCellWithReuseIdentifier:identifier];
    
    self.chuanbocollectionView.layer.cornerRadius = 5;
    //设置代理
    self.chuanbocollectionView.delegate = self;
    self.chuanbocollectionView.dataSource = self;
    
    
    
    
}


#pragma mark -- 清空
-(void)clearTap
{
    [SVProgressHUD show];
    //调用接口
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:DeleteShip URLMethod:clean_history parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            //展示结果
            NSDictionary *dict = [result objectForKey:@"result"];
            
            if (![dict isEqual:[NSNull null]] && dict.count > 0  && [[dict objectForKey:@"status"] boolValue]) {
                cleartitle.alpha = 0;
                [historyList.datas removeAllObjects];
                [self.historycollectionView reloadData];
                historyView.xxj_height = 20;
                
                self.chuanbocollectionView.xxj_y = (historyView.gjcf_bottom+40);
                [scrollView setContentSize:CGSizeMake(0, self.chuanbocollectionView.gjcf_bottom + 40)];
            }
            else
            {
                [self.view makeToast:@"清除失败" duration:1.0 position:CSToastPositionCenter];
            }
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
}



#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag ==1) {
        return 1;
    }
    else if (collectionView.tag ==2)
    {
        return 1;
    }
    else
    {
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
    return 1;
}

//每个分区上得元素个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1) {
        return historyList.datas.count;
    }
    else if (collectionView.tag == 2)
    {
        return searchList.count;
    }
    else
    {
        return self.chuanboArray.count;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([CommonDimensStyle screenWidth], 50);
}

//设置元素内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 2) {
        DynamicHistoryViewCell *dynamicSearchViewCell = (DynamicHistoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        DynamicBoatSearchModel *boatModel =(DynamicBoatSearchModel *)searchList[indexPath.row];
        [dynamicSearchViewCell initContent:boatModel.locationID BoatName:[boatModel.name stringByAppendingFormat:@" [MMSI:%@]",boatModel.mmsi] Time:@"" Mmsi:boatModel.mmsi];
        return dynamicSearchViewCell;
    }else if (collectionView.tag == 1){
        DynamicHistoryViewCell *dynamicHistoryViewCell = (DynamicHistoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        SearchBoatModel *searchBoatModel =(SearchBoatModel *)historyList.datas[indexPath.row];
        [dynamicHistoryViewCell initContent:searchBoatModel.searchID BoatName:searchBoatModel.name Time:searchBoatModel.time_standard Mmsi:searchBoatModel.mmsi];
        return dynamicHistoryViewCell;
    }
    else
    {
        DynamicHistoryViewCell *chuanboViewCell = (DynamicHistoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
        MyBoatModel * model = self.chuanboArray[indexPath.row];
        chuanboViewCell.BoatNameTitle.text = model.name;
        return chuanboViewCell;
    }
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicHistoryViewCell *dynamicSearchViewCell = (DynamicHistoryViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *boatid =  dynamicSearchViewCell.boatId;
    NSString *shipName =  dynamicSearchViewCell.BoatNameTitle.text;
    if(collectionView.tag == 2){
        NSRange range;
        range = [shipName rangeOfString:@"["];
        if (range.location != NSNotFound) {
            shipName = [shipName substringToIndex:range.location];
        }
    }
    
    //新的跳转
    ShipMapViewController *shipTrackNewController = [[ShipMapViewController alloc]init];
    if (collectionView.tag == 3) {
        MyBoatModel * model = self.chuanboArray[indexPath.row];
        shipTrackNewController.boatId = model.ship_id;
        shipTrackNewController.shipName = model.name;
        shipTrackNewController.mmsi =model.mmsi;
    }
    else
    {
        shipTrackNewController.boatId = boatid;
        shipTrackNewController.shipName = shipName;
        shipTrackNewController.mmsi =dynamicSearchViewCell.mmsi;
    }
    
    [self.navigationController pushViewController:shipTrackNewController animated:YES];
}

//UICollectionView没有选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


- ( void)scrollViewDidScroll:( UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)searchTextchange:(UITextField *)sender{
    UITextRange * selectedRange = sender.markedTextRange;
    if(selectedRange == nil || selectedRange.empty){
        [self searchBoatInfo];
    }
    chuanbotitle.alpha = 0;
    self.chuanbocollectionView.alpha = 0;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        chuanbotitle.alpha = 1;
        self.chuanbocollectionView.alpha = 1;
    }
    else
    {
        chuanbotitle.alpha = 0;
        self.chuanbocollectionView.alpha = 0;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        chuanbotitle.alpha = 1;
        self.chuanbocollectionView.alpha = 1;
    }
    self.chuanbocollectionView.xxj_y = (historyView.gjcf_bottom+40);
    [scrollView setContentSize:CGSizeMake(0, self.chuanbocollectionView.gjcf_bottom + 40)];
}

-(void)searchBoatInfo{
    NSString *text = searchBar.text;
    //没有内容
    if ([GJCFStringUitil stringIsNull:text]) {
//        NSString *userId =  [LocalData Get:[LocalModel ID]];
        NSString * userId = [UseInfo shareInfo].uID;
        if (![GJCFStringUitil stringIsNull:userId]) {
            [self getReloadHistory];
            historyView.hidden =  NO;
            self.searchcollectionView.hidden =YES;
            noneContentView.hidden = YES;
        }
    }else{
        historyView.hidden = YES;
        //        self.searchcollectionView.hidden = NO;
        NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\",\"access_token\":\"%@\"",text,[UseInfo shareInfo].access_token];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:GetShipPosition URLMethod:QueryShipByName parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            searchList = [NSMutableArray array];
            XXJLog(@"搜索记录%@",result)
            if (result != nil) {
                NSDictionary *dict = [result objectForKey:@"result"];
                
                if(![dict isEqual:[NSNull null]]){
                    if ([dict objectForKey:@"status"] != NULL && [[dict objectForKey:@"status"]boolValue]) {
                        //有数据
                        NSArray *list = [dict objectForKey:@"data"];
                        if(![list isEqual:[NSNull null]] &&[list count] >0){
                            for(int i = 0; i < list.count;i ++){
                                DynamicBoatSearchModel *boatModel = [DynamicBoatSearchModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                                [searchList addObject:boatModel];
                                
                            }
                        }
                    }
                }
            }
            if (searchList.count == 0) {
                if (searchBar.text.length == 0) {
                    [self ShowView:1];
                }else{
                    [self ShowView:3];
                }
                
            }else{
                if (searchBar.text.length == 0) {
                    [self ShowView:1];
                }else{
                    [self ShowView:2];
                }
                //                noneContentView.hidden = YES;
                //                self.searchcollectionView.hidden = NO;
                [self.searchcollectionView reloadData];
            }

            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];

    }
    
}


//1 历史记录      2搜索记录   3 没有内容
-(void)ShowView:(int)tag{
    switch (tag) {
        case 1:
        {
            if (searchList == 0) {
                historyView.hidden = YES;
                self.searchcollectionView.hidden =YES;
                noneContentView.hidden = NO;
            }else{
                historyView.hidden =  NO;
                self.searchcollectionView.hidden =YES;
                noneContentView.hidden = YES;
            }
        }
            break;
            
        case 2:
        {
            if (historyList.datas == 0) {
                historyView.hidden = YES;
                self.searchcollectionView.hidden =YES;
                noneContentView.hidden = NO;
            }else{
                historyView.hidden = YES ;
                self.searchcollectionView.hidden =NO;
                noneContentView.hidden = YES;
            }
        }
            break;
        case 3:
        {
            historyView.hidden = YES;
            self.searchcollectionView.hidden =YES;
            noneContentView.hidden = NO;
        }
            break;
        default:
            break;
    }
}


-(void)showSearchDetail:(BoatModel *)boatModel{
    
    [boatDetailView setHidden:NO];
    if ([GJCFStringUitil stringIsNull:boatModel.type_name]||[GJCFStringUitil stringIsNull:boatModel.image_url]) {
        NSString *parameterstring = [NSString stringWithFormat:@"\"ship_id\":\"%@\",\"access_token\":\"%@\"",boatModel.boatID,[UseInfo shareInfo].access_token];
        
        [XXJNetManager requestPOSTURLString:GetShipPosition URLMethod:GetShipInfoMethod parameters:parameterstring finished:^(id result) {
            [SVProgressHUD dismiss];
            
            if (result != nil) {
                //展示结果
                NSDictionary *dict =[result objectForKey:@"result"];
                
                if ([[dict objectForKey:@"status"]boolValue]) {
                    BoatModel *newBoatModel = [BoatModel mj_objectWithKeyValues:[dict objectForKey:@"ship"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [boatimage sd_setImageWithURL:[NSURL URLWithString:newBoatModel.image_url] placeholderImage:[UIImage imageNamed:@"defaultboat"]];
                        boatName.text =newBoatModel.name;
                        boatType.text = newBoatModel.type_name;
                        boatId = newBoatModel.boatID;
                    });
                }
            }
            
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
        
    }else{
        [boatimage sd_setImageWithURL:[NSURL URLWithString:boatModel.image_url] placeholderImage:[UIImage imageNamed:@"defaultboat"]];
        boatName.text =boatModel.name;
        boatType.text = boatModel.type_name;
        boatId = boatModel.boatID;
    }
}

//获得历史记录
-(void)getReloadHistory{
    
    [SVProgressHUD show];
    
    //    [self.view bringSubviewToFront:self.HUD];
    //    [self.HUD show:YES];
    //调用接口
    NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"\",\"access_token\":\"%@\",\"type\":\"locate\",\"length\":\"100\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetShipPosition URLMethod:QueryShipByName parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            //展示结果
            NSDictionary *dict =[result objectForKey:@"result"];
            
            if (![dict isEqual:[NSNull null]] && dict.count > 0  && [[dict objectForKey:@"status"]boolValue]) {
                NSArray *list = [dict objectForKey:@"data"];
                if(list != NULL &&[list count] >0){
                    historyList.datas = [[NSMutableArray alloc]init];
                    for(int i = 0; i < list.count;i ++){
                        SearchBoatModel *boatModel = [SearchBoatModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                        [historyList.datas addObject:boatModel];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (historyList.datas.count > 0) {
                            cleartitle.alpha = 1;
                        }
                        else
                        {
                            cleartitle.alpha = 0;
                        }
                        
                        self.historycollectionView.xxj_height = historyList.datas.count * 50;
                        historyView.xxj_height = historyList.datas.count * 50 + 20;
                        [self.historycollectionView reloadData];
                        
                        self.chuanbocollectionView.xxj_y = (historyView.gjcf_bottom+40);
                        [scrollView setContentSize:CGSizeMake(0, self.chuanbocollectionView.gjcf_bottom + 40)];
                        if (self.chuanboArray.count == 0) {
                            if ([[UseInfo shareInfo].identity isEqualToString:@"货主"]) {
                                [self relationShipRequest];
                            }
                            else
                            {
                                [self myShipRequest];
                            }
                            
                        }
                        
                    });
                }
                
            }
            else
            {
                self.chuanbocollectionView.xxj_y = (historyView.gjcf_bottom+40);
                [scrollView setContentSize:CGSizeMake(0, self.chuanbocollectionView.gjcf_bottom + 40)];
                if (self.chuanboArray.count == 0) {
                    if ([[UseInfo shareInfo].identity isEqualToString:@"货主"]) {
                        [self relationShipRequest];
                    }
                    else
                    {
                        [self myShipRequest];
                    }
                }
            }
        }
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}

-(void)boatDetailIsShow:(BOOL)isshow{
    if (isshow) {
        CGRect boatDetailframe =  boatDetailView.frame;
        boatDetailframe.size.height = 120;
        boatDetailView.frame = boatDetailframe;
        boatDetailView.hidden = NO;
        
        
        CGRect historyframe =  historyView.frame;
        historyframe.origin.y = boatDetailView.gjcf_bottom;
        historyView.frame = historyframe;
    }else{
        CGRect boatDetailframe =  boatDetailView.frame;
        boatDetailframe.size.height = 0;
        boatDetailView.frame = boatDetailframe;
        boatDetailView.hidden = YES;
        
        CGRect historyframe =  historyView.frame;
        historyframe.origin.y = boatDetailView.gjcf_bottom;
        historyView.frame = historyframe;
    }
}
//搜索事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    //新的跳转
    ShipMapViewController *shipTrackNewController = [[ShipMapViewController alloc]init];
    shipTrackNewController.shipName = textField.text;
    [self.navigationController pushViewController:shipTrackNewController animated:YES];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.searchcollectionView.hidden = YES;
    if (historyList.datas.count == 0) {
        noneContentView.hidden = NO;
        historyView.hidden = YES;
    }else{
        noneContentView.hidden = YES;
        historyView.hidden = NO;
        
    }
    
    self.chuanbocollectionView.xxj_y = (historyView.gjcf_bottom+40);
    
    [scrollView setContentSize:CGSizeMake(0, self.chuanbocollectionView.gjcf_bottom + 40)];
    
    return YES;
}



#pragma mark -- 请求我的船舶
-(void)myShipRequest
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"max\":\"%lu\",\"page\":\"%lu\"",[UseInfo shareInfo].access_token,(unsigned long)100,(unsigned long)1];
    
    [XXJNetManager requestPOSTURLString:MyShip URLMethod:MyShipMethod parameters:parameterstring finished:^(id result) {
        
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (![result[@"result"][@"status"] boolValue]) {
            
            [self.view makeToast:@"暂无数据" duration:0.5 position:CSToastPositionCenter];
            return ;
        }
        
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
        NSArray * listArray = resultDict[@"result"][@"list"];
        
        if (listArray != nil) {
            self.chuanboArray = [MyBoatModel mj_objectArrayWithKeyValuesArray:resultDict[@"result"][@"list"]];
        }
        
        self.chuanbocollectionView.xxj_y = (historyView.gjcf_bottom+40);
        self.chuanbocollectionView.xxj_height = 50 * self.chuanboArray.count;
        [scrollView setContentSize:CGSizeMake(0, self.chuanbocollectionView.gjcf_bottom + 40)];
        
        [self.chuanbocollectionView reloadData];
        
    } errored:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
    
    }];
}

#pragma mark -- 货主关联船舶
-(void)relationShipRequest
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:DeleteShip URLMethod:relation_ship parameters:parameterstring finished:^(id result) {
        
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (![result[@"result"][@"status"] boolValue]) {
            
            [self.view makeToast:@"暂无数据" duration:0.5 position:CSToastPositionCenter];
            return ;
        }
        
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
        NSArray * listArray = resultDict[@"result"][@"msg"];
        
        if (listArray != nil) {
            self.chuanboArray = [MyBoatModel mj_objectArrayWithKeyValuesArray:resultDict[@"result"][@"msg"]];
        }
        
        self.chuanbocollectionView.xxj_y = (historyView.gjcf_bottom+40);
        self.chuanbocollectionView.xxj_height = 50 * self.chuanboArray.count;
        [scrollView setContentSize:CGSizeMake(0, self.chuanbocollectionView.gjcf_bottom + 40)];
        
        [self.chuanbocollectionView reloadData];
        
    } errored:^(NSError *error) {
        
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        [SVProgressHUD dismiss];
    }];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    XXJLog(@"11111111")
}





@end
