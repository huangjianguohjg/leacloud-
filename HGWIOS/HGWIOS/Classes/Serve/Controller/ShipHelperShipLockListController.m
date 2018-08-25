//
//  ShipHelperShipLockListController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperShipLockListController.h"
#import "NullContentView.h"
#import "ShipHelperBoatCell.h"
#import "AssistantSearchShipModel.h"
#import "AssistantSearchShipLockModel.h"
#import "GrayLine.h"
@interface ShipHelperShipLockListController (){
    NSString *identifier;
    UISearchBar *searchBar;
    NSMutableArray *searchList;
    NSMutableArray *shipLockList;
    UIScrollView *boatLockDetail;
    UILabel *boatLabel;
    UIView *showShipLockView;
    UIView *showShipLockHeadView;
    NullContentView *nullContentView;
}

@end

@implementation ShipHelperShipLockListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [CommonFontColorStyle WhiteColor];
    

    self.navigationItem.title = @"过闸信息详情";
    
    [self setUpUI];
    
    if (![self.shipName isEqual:[NSNull null]]) {
        [self searchLockList];
        [self AddRecordRequest];
    }else{
        [searchBar becomeFirstResponder];
    }
    
}


-(void)setUpUI
{
    identifier = @"ShipHelperBoatCell";
    
    UIView *boatView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, [CommonDimensStyle screenWidth], 60)];
    boatView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview:boatView];
    
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 12.5, [CommonDimensStyle screenWidth] - 20, 35)];
    
    NSString *placeTitle = @"请输入要查询的船名";
    searchBar.placeholder = placeTitle;
    
    UIImage* clearImg = [UIImage singleColorImageRect:[UIColor clearColor] Width:searchBar.gjcf_width Height:searchBar.gjcf_height];
    [searchBar setBackgroundImage:clearImg];
    
    UIImage* normalImg = [UIImage singleColorImage:[CommonFontColorStyle EEF1F6Color] Width:searchBar.gjcf_width Height:searchBar.gjcf_height];
    [searchBar setSearchFieldBackgroundImage:normalImg forState:UIControlStateNormal];
    
    searchBar.delegate = self;
    [boatView addSubview:searchBar];
    
    
    //船名
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0.0f;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, boatView.gjcf_bottom, [CommonDimensStyle screenWidth], ([CommonDimensStyle screenHeight]-kStatusBarHeight - kNavigationBarHeight)) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.tag = 1;
    [self.view addSubview:self.collectionView];
    //注册单元格
    [self.collectionView registerClass:[ShipHelperBoatCell class]forCellWithReuseIdentifier:identifier];
    self.collectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
//    self.footView = [MJRefreshFooterView footer];
//    self.footView.scrollView = self.collectionView ;
//    self.footView.delegate = self;
    
    //展示详情
    boatLockDetail = [[UIScrollView alloc]initWithFrame:CGRectMake(0, boatView.gjcf_bottom, [CommonDimensStyle screenWidth], [CommonDimensStyle screenHeight]-boatView.gjcf_bottom)];
    boatLockDetail.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    [self.view addSubview:boatLockDetail];
    boatLockDetail.hidden = YES;
    
    nullContentView = [[NullContentView alloc]initWithFrame:CGRectMake(0, boatView.gjcf_bottom, [CommonDimensStyle screenWidth], ([CommonDimensStyle screenHeight]- boatView.gjcf_bottom)) Title:@"未查询到此船的过闸信息！"];
    [self.view addSubview:nullContentView];
    nullContentView.hidden = YES;
    

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
    return searchList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([CommonDimensStyle screenWidth], 45);
}
//设置元素内容
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    identifier = @"ShipHelperBoatCell";
    ShipHelperBoatCell *shipHelperWarningCell = (ShipHelperBoatCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
    
    AssistantSearchShipModel *boatModel = (AssistantSearchShipModel*)searchList[indexPath.row];
    
    
    [shipHelperWarningCell setContent:boatModel.searchID Title:boatModel.ship_name];
    
    return shipHelperWarningCell;
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShipHelperBoatCell * cell = (ShipHelperBoatCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.shipName=cell.titleLabel.text;
    self.shipId = cell.cellId;
    [self searchLockList];
    
    [self AddRecordRequest];
    
    [self.view endEditing:YES];
}

-(void)AddRecordRequest{
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"name\":\"%@\"",[UseInfo shareInfo].access_token,self.shipName];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:AddRecord URLMethod:AddRecordMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}



-(void)searchLockList
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\"",[self.shipName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    [XXJNetManager requestPOSTURLString:AddRecord URLMethod:SearchShipLockByNameMethod parameters:parameterstring finished:^(id result) {
        
        XXJLog(@"%@",result)
        shipLockList = [[NSMutableArray alloc]init];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if (![boatresult isEqual:[NSNull null]] &&[[boatresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]] &&[list count] >0){
                    for(int i = 0; i < list.count;i ++){
                        AssistantSearchShipLockModel *assistantSearchShipLockModel = [AssistantSearchShipLockModel mj_objectWithKeyValues:list[i]];
                        [shipLockList addObject:assistantSearchShipLockModel];
                    }
                }
            }
        }
        
        //新的布局
        NSArray *subviews = [boatLockDetail subviews];
        for (int i = 0; i<subviews.count; i++) {
            [subviews[i] removeFromSuperview];
        }
        
        //横线
        GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, 0, CommonDimensStyle.screenWidth, 0.5)  Color:[CommonFontColorStyle C6D2DEColor]];
        [boatLockDetail addSubview:grayLine];
        
        boatLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, grayLine.gjcf_bottom, [CommonDimensStyle screenWidth]-20, 45)];
        [boatLockDetail addSubview:boatLabel];
        boatLabel.font = [CommonFontColorStyle NormalSizeFont];
        boatLabel.textColor = [CommonFontColorStyle I3Color];
        
        
        GrayLine* grayLine2 = [[GrayLine alloc]initWithFrame:CGRectMake(0, boatLabel.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5)  Color:[CommonFontColorStyle C6D2DEColor]];
        [boatLockDetail addSubview:grayLine2];
        
        showShipLockView = [[UIView alloc]initWithFrame:CGRectMake(0, grayLine2.gjcf_bottom, [CommonDimensStyle screenWidth], (boatLockDetail.gjcf_height - grayLine2.gjcf_bottom))];
        [boatLockDetail addSubview:showShipLockView];
        
        showShipLockHeadView = [self getHead];
        showShipLockHeadView.backgroundColor = [CommonFontColorStyle WhiteColor];
        [showShipLockView addSubview:showShipLockHeadView];
        
        boatLabel.text =self.shipName;
        int nowy =showShipLockHeadView.gjcf_bottom;
        for (int i=0 ; i<shipLockList.count; i++) {
            AssistantSearchShipLockModel *assistantSearchShipLockModel =(AssistantSearchShipLockModel *)shipLockList[i];
            //时间显示
            NSString *showTime ;
            NSArray *tempTime = [assistantSearchShipLockModel.s_time componentsSeparatedByString:@" "];
            if (tempTime.count ==2) {
                showTime =[NSString stringWithFormat: @"%@\n%@",tempTime[0],tempTime[1]];
            }else{
                showTime =[NSString stringWithFormat: @"%@\n%@",assistantSearchShipLockModel.date,assistantSearchShipLockModel.s_time];
            }
            
            UIView *itemView =[self getTableItem:assistantSearchShipLockModel.lock_name Gate:assistantSearchShipLockModel.gate Direct:assistantSearchShipLockModel.direct Stime:showTime Y:nowy];
            
            if (i%2 == 1) {
                itemView.backgroundColor = [CommonFontColorStyle F2F6FCColor];
            }else{
                itemView.backgroundColor = [CommonFontColorStyle F8FCFFColor];
            }
            
            nowy += itemView.gjcf_height;
            [showShipLockView addSubview:itemView];
        }
        
        showShipLockView.gjcf_height =nowy+50;
        
        CGSize scrollSize = CGSizeMake( [CommonDimensStyle screenWidth], showShipLockView.gjcf_height);
        boatLockDetail.contentSize = scrollSize;
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}


-(UIView *)getHead{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [CommonDimensStyle screenWidth], 45)];
    
    //船闸名称
    int firstWidth = [CommonDimensStyle screenWidth]/2;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, firstWidth*3/5, 45)];
    [self setContentLabel:titleLabel];
    titleLabel.font =[CommonFontColorStyle F14BoldSizeFont];
    titleLabel.text = @"船闸名称";
    [contentView addSubview:titleLabel];
    
    //闸次
    UILabel *lockMumLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, firstWidth*2/5, 45)];
    [self setContentLabel:lockMumLabel];
    lockMumLabel.text = @"闸次";
    lockMumLabel.font =[CommonFontColorStyle F14BoldSizeFont];
    [contentView addSubview:lockMumLabel];
    
    //航向
    UILabel *directionLabel = [[UILabel alloc]initWithFrame:CGRectMake(lockMumLabel.gjcf_right, 0, firstWidth*2/5, 45)];
    [self setContentLabel:directionLabel];
    directionLabel.text = @"航向";
    directionLabel.font =[CommonFontColorStyle F14BoldSizeFont];
    [contentView addSubview:directionLabel];
    
    //过闸时间
    UILabel *pastLockLabel = [[UILabel alloc]initWithFrame:CGRectMake(directionLabel.gjcf_right, 0, firstWidth*3/5, 45)];
    [self setContentLabel:pastLockLabel];
    pastLockLabel.text = @"过闸时间";
    pastLockLabel.font =[CommonFontColorStyle F14BoldSizeFont];
    [contentView addSubview:pastLockLabel];
    
    //划线
    UIView *headLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentView.gjcf_width, 0.25)];
    headLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:headLineView];
    
    UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, 0.5, 45)];
    oneLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:oneLineView];
    
    UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(lockMumLabel.gjcf_right, 0, 0.5, 45)];
    twoLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:twoLineView];
    
    UIView *threeLineView = [[UIView alloc]initWithFrame:CGRectMake(directionLabel.gjcf_right, 0, 0.5, 45)];
    threeLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:threeLineView];
    
    
    UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(0, titleLabel.gjcf_bottom-0.5, contentView.gjcf_width, 0.5)];
    fourLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:fourLineView];
    return  contentView;
}


-(UIView *)getTableItem:(NSString *)place Gate:(NSString *)gate Direct:(NSString *)direct Stime:(NSString *)s_time Y:(int)y{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, y, [CommonDimensStyle screenWidth], 50)];
    
    //船闸名称
    int firstWidth = [CommonDimensStyle screenWidth]/2;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, firstWidth*3/5, contentView.gjcf_height)];
    [self setContentLabel:titleLabel];
    titleLabel.text = place;
    [contentView addSubview:titleLabel];
    
    //闸次
    UILabel *lockMumLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, firstWidth*2/5, contentView.gjcf_height)];
    [self setContentLabel:lockMumLabel];
    lockMumLabel.text = gate;
    [contentView addSubview:lockMumLabel];
    
    //航向
    UILabel *directionLabel = [[UILabel alloc]initWithFrame:CGRectMake(lockMumLabel.gjcf_right, 0, firstWidth*2/5, contentView.gjcf_height)];
    [self setContentLabel:directionLabel];
    directionLabel.text = direct;
    [contentView addSubview:directionLabel];
    
    //过闸时间
    UILabel *pastLockLabel = [[UILabel alloc]initWithFrame:CGRectMake(directionLabel.gjcf_right, 0, firstWidth*3/5, contentView.gjcf_height)];
    [self setContentLabel:pastLockLabel];
    pastLockLabel.numberOfLines = 0;
    
    pastLockLabel.text = s_time;
    [contentView addSubview:pastLockLabel];
    
    //划线
    UIView *headLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentView.gjcf_width, 0.25)];
    headLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:headLineView];
    
    UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.gjcf_right, 0, 0.5, contentView.gjcf_height)];
    oneLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:oneLineView];
    
    UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(lockMumLabel.gjcf_right, 0, 0.5, contentView.gjcf_height)];
    twoLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:twoLineView];
    
    UIView *threeLineView = [[UIView alloc]initWithFrame:CGRectMake(directionLabel.gjcf_right, 0, 0.5, contentView.gjcf_height)];
    threeLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:threeLineView];
    
    
    UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(0, titleLabel.gjcf_bottom-0.5, contentView.gjcf_width, 0.5)];
    fourLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:fourLineView];
    return  contentView;
}



-(void)setContentLabel:(UILabel *)lable{
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [CommonFontColorStyle I3Color];
    lable.font =[CommonFontColorStyle SmallSizeFont];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //隐藏／展示
    [self showView:1];
    [self searchBoatInfo];
}


/**
 *  模糊搜索船舶信息
 */
-(void)searchBoatInfo{
    NSString *text = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (![text isEqual:[NSNull null]]) {
        NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\"",text];
        
        [SVProgressHUD show];
        
        [XXJNetManager requestPOSTURLString:GetListByShipName URLMethod:GetListByShipNameMethod parameters:parameterstring finished:^(id result) {
            
            [SVProgressHUD dismiss];
            
            searchList = [[NSMutableArray alloc]init];
            
            if (result != nil) {
                NSDictionary *dict =[result objectForKey:@"result"];
                
                if ([[dict objectForKey:@"status"]boolValue]) {
                    //有数据
                    
                    NSArray *list = [dict objectForKey:@"list"];
                    if(![list isEqual:[NSNull null]] &&[list count] >0){
                        for(int i = 0; i < list.count;i ++){
                            AssistantSearchShipModel *boatModel = [AssistantSearchShipModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                            [searchList addObject:boatModel];
                        }
                    }
                }
  
            }
            
            if (searchList.count > 0) {
                [self showView:1];
                [self.collectionView reloadData];
                
            }else{
                [self showView:3];
            }
            
        } errored:^(NSError *error) {
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            [SVProgressHUD dismiss];
        }];
        
        
        
        
        
        
        
    }
    
    
}

-(void)showView:(int)index{
    switch(index){
        case 1:{
            self.collectionView.hidden = NO;
            boatLockDetail.hidden = YES;
            nullContentView.hidden = YES;
        }
            break;
        case 2:{
            self.collectionView.hidden = YES;
            boatLockDetail.hidden = NO;
            nullContentView.hidden = YES;
        }
            break;
        case 3:{
            self.collectionView.hidden = YES;
            boatLockDetail.hidden = YES;
            nullContentView.hidden = NO;
        }
            break;
    }
}


//搜索事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self searchBoatInfo];
}

























































@end
