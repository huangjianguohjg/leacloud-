//
//  ShipHelperLockIndexController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperLockIndexController.h"
#import "GrayLine.h"
#import "AssistRecordListModel.h"
#import "ShipHelperShipLockListController.h"
#import "ShipHelperLockDetailController.h"
@interface ShipHelperLockIndexController (){
    NSMutableArray *lockNameList;
    NSMutableArray *assistRecordList;
    UIView *lockListView;
    UILabel *historyLabel;
    UIView *historyView;
    UIView *boatView;
    UIView *planView;
}

@end

@implementation ShipHelperLockIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    

    self.navigationItem.title = @"过闸信息";
    
    [self setUpUI];
    
    [self getLockNameList];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getAssistRecordListList];
}







-(void)setUpUI
{
    boatView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight + 10, [CommonDimensStyle screenWidth], 125)];
    boatView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview:boatView];
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, 0, CommonDimensStyle.screenWidth, 0.5)  Color:[CommonFontColorStyle C6D2DEColor]];
    [boatView addSubview:grayLine];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 12.5, [CommonDimensStyle screenWidth], 35)];
    
    NSString *placeTitle = @"请输入要查询的船名";
    searchBar.placeholder = placeTitle;
    
    UIImage* clearImg = [UIImage singleColorImageRect:[UIColor clearColor] Width:searchBar.gjcf_width Height:searchBar.gjcf_height];
    [searchBar setBackgroundImage:clearImg];
    
    UIImage* normalImg = [UIImage singleColorImage:[CommonFontColorStyle EEF1F6Color] Width:searchBar.gjcf_width Height:searchBar.gjcf_height];
    [searchBar setSearchFieldBackgroundImage:normalImg forState:UIControlStateNormal];
    
    searchBar.delegate = self;
    [boatView addSubview:searchBar];
    
    historyView = [[UIView alloc]initWithFrame:CGRectMake(10,searchBar.gjcf_bottom+15, [CommonDimensStyle screenWidth]-20, 52)];
    [boatView addSubview:historyView];
    
    historyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 12)];
    historyLabel.text = @"历史记录";
    historyLabel.font = [CommonFontColorStyle SuperSmallFont];
    historyLabel.textColor = [CommonFontColorStyle A3ADColor];
    [historyView addSubview:historyLabel];
    
    planView = [[UIView alloc]initWithFrame:CGRectMake(0, boatView.gjcf_bottom, CommonDimensStyle.screenWidth, 187.5)];
    [self.view addSubview:planView];
    
    //横线
    GrayLine* grayLine1 = [[GrayLine alloc]initWithFrame:CGRectMake(0, 0, CommonDimensStyle.screenWidth, 0.5) Color:[CommonFontColorStyle C6D2DEColor]];
    [planView addSubview:grayLine1];
    
    UILabel *planLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, grayLine1.gjcf_bottom+10, [CommonDimensStyle screenWidth]-20, 12)];
    planLabel.text = @"当前最新过闸计划";
    planLabel.font = [CommonFontColorStyle SuperSmallFont];
    planLabel.textColor = [CommonFontColorStyle A3ADColor];
    [planView addSubview:planLabel];
    
    lockListView = [[UIView alloc]initWithFrame:CGRectMake(0, planLabel.gjcf_bottom+10, [CommonDimensStyle screenWidth], 165)];
    [planView addSubview:lockListView];
}


-(UIButton *)addButton:(NSString *)id Title:(NSString *)title Index :(int )index{
    int x = index%4;
    int y = index /4;
    
    int itemWidth = ([CommonDimensStyle screenWidth]+2)/4;
    int itemHeight = 55;
    
    int startX = x*itemWidth-(2*x-1)*0.5;
    if(x ==0){
        startX = 0;
    }
    int startY = y*itemHeight -(2*y-1)*0.5;
    if(y ==0){
        startY = 0;
    }
    
    UIButton *oneButton = [[UIButton alloc]initWithFrame:CGRectMake(startX, startY, itemWidth,itemHeight)];
    [oneButton setTitle:title forState:UIControlStateNormal];
    [oneButton setTitleColor:[CommonFontColorStyle I3Color] forState:UIControlStateNormal];
    oneButton.backgroundColor = [CommonFontColorStyle WhiteColor];
    oneButton.layer.borderColor = [CommonFontColorStyle C6D2DEColor].CGColor;
    oneButton.layer.borderWidth = 0.5;
    oneButton.tag = index;
    oneButton.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
    [oneButton addTarget:self action:@selector(planClick:) forControlEvents:UIControlEventTouchUpInside];
    return oneButton;
}



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    ShipHelperShipLockListController *shipHelperLockDetailController = [[ShipHelperShipLockListController alloc]init];
    [self.navigationController pushViewController:shipHelperLockDetailController animated:YES];
    return false;
}


-(void)planClick:(UIButton *)sender{
    NSString *planName =  lockNameList[sender.tag];
    ShipHelperLockDetailController *shipHelperLockDetailController =[[ShipHelperLockDetailController alloc]init];
    shipHelperLockDetailController.place = planName;
    [self.navigationController pushViewController:shipHelperLockDetailController animated:YES];
}


#pragma mark -- 获取最新过闸计划
-(void)getLockNameList
{
    [SVProgressHUD show];
    [XXJNetManager requestPOSTURLString:GetPlaceList URLMethod:GetPlaceListMethod parameters:nil finished:^(id result) {
        [SVProgressHUD dismiss];
        lockNameList = [[NSMutableArray alloc]init];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            if (![boatresult isEqual:[NSNull null]] &&[[boatresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]] &&[list count] >0){
                    for(int i = 0; i < list.count;i ++){
                        
                        [lockNameList addObject:list[i]];
                        
                    }
                    
                }
            }
            
        }
        
        
        for (int i =0; i<lockNameList.count; i++) {
            UIView *view = [self addButton:@"" Title:lockNameList[i] Index:i];
            [lockListView addSubview:view];
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}

/**
 *  获取查询记录
 */
-(void)getAssistRecordListList
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"length\":\"5\",\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetHistoryList URLMethod:GetHistoryListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        assistRecordList = [[NSMutableArray alloc]init];
        
        if (result != nil) {
            NSDictionary *boatresult =[result objectForKey:@"result"];
            
            if (![boatresult isEqual:[NSNull null]] &&[[boatresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]] &&[list count] >0){
                    for(int i = 0; i < list.count;i ++){
                        AssistRecordListModel *assistRecordListModel = [AssistRecordListModel mj_objectWithKeyValues:list[i]];
                        [assistRecordList addObject:assistRecordListModel];
                        
                    }
                    
                }
            }
            
            
        }
        if (assistRecordList.count > 0) {
            for (long i =(historyView.subviews.count-1) ; i>-1; i--) {
                [historyView.subviews[i] removeFromSuperview];
            }
            
            historyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 12)];
            historyLabel.text = @"历史记录";
            historyLabel.font = [CommonFontColorStyle SuperSmallFont];
            historyLabel.textColor = [CommonFontColorStyle A3ADColor];
            [historyView addSubview:historyLabel];
            
            for (int i =0; i<assistRecordList.count; i++) {
                UIButton *oneButton = [[UIButton alloc]initWithFrame:CGRectMake(i*110, historyLabel.gjcf_bottom+10, 100,30)];
                AssistRecordListModel *assistRecordListModel = (AssistRecordListModel *)assistRecordList[i];
                [oneButton setTitle:assistRecordListModel.ship_name forState:UIControlStateNormal];
                [oneButton setTitleColor:[CommonFontColorStyle BottomTextColor] forState:UIControlStateNormal];
                oneButton.titleLabel.font = [CommonFontColorStyle SuperSmallFont];
                oneButton.layer.borderColor = [CommonFontColorStyle E3E3E3Color].CGColor;
                oneButton.layer.borderWidth = 0.5;
                oneButton.tag = i;
                [oneButton addTarget:self action:@selector(lookBoatLockList:) forControlEvents:UIControlEventTouchUpInside];
                [historyView addSubview:oneButton];
            }
            historyView.gjcf_height = 52;
            boatView.gjcf_height = 125;
            planView.gjcf_top = boatView.gjcf_bottom;
            
        }else{
            historyView.gjcf_height = 0;
            boatView.gjcf_height =60;
            historyLabel.hidden = YES;
            planView.gjcf_top = boatView.gjcf_bottom;
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
}

-(void)lookBoatLockList:(UIButton *)sender{
    NSInteger buttonTag = sender.tag;
//    AssistRecordListModel *assistRecordListModel =  (AssistRecordListModel*) assistRecordList[buttonTag];
//    ShipHelperShipLockListController *shipHelperShipLockListController = [[ShipHelperShipLockListController alloc]init];
//    shipHelperShipLockListController.shipName = assistRecordListModel.s_name;
//    //shipHelperShipLockListController.shipId = assistRecordListModel.
//    [self.navigationController pushViewController:shipHelperShipLockListController animated:YES];
}





@end
