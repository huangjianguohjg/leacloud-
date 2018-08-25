//
//  ShipHelperChangJiangController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperChangJiangController.h"

#import "ShipHelperChangJiangView.h"

#import "ServiceWaterDetailModel.h"

#import "NullContentView.h"

#import "ServiceWaterDetailModel.h"

#define STAGE 1
#define FLOW 2

@interface ShipHelperChangJiangController ()

@property (nonatomic, weak) ShipHelperChangJiangView * shipHelperChangJiangView;

@property (nonatomic, strong) NSMutableArray * dataList;

@property (nonatomic, strong) NSMutableArray * flowdataList;

@end

@implementation ShipHelperChangJiangController

-(NSMutableArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

-(NSMutableArray *)flowdataList
{
    if (_flowdataList == nil) {
        _flowdataList = [NSMutableArray array];
    }
    return _flowdataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = [NSString stringWithFormat:@"%@情况",self.fromTag];
    
    [self setUpUI];
    
    [self getDataList];
}



-(void)setUpUI
{
    ShipHelperChangJiangView * shipHelperChangJiangView = [[ShipHelperChangJiangView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    shipHelperChangJiangView.delegate = self;
    self.view = shipHelperChangJiangView;
    self.shipHelperChangJiangView = shipHelperChangJiangView;
}



-(void)getDataList
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"date\":\"%@\",\"type\":\"%@\",\"title\":\"%@\"",self.date,self.type,self.changjiangTitle];
    
    [XXJNetManager requestPOSTURLString:GetWaterDetail URLMethod:GetWaterDetailMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            if (![result[@"result"] isEqual:[NSNull null]] &&[result[@"result"][@"status"] boolValue])
            {
                NSArray *list = result[@"result"][@"list"];
                if (![list isEqual:[NSNull null]] && list.count > 0) {
                    
                    for (NSDictionary * dict in list) {
                        ServiceWaterDetailModel *cargoModel = [ServiceWaterDetailModel mj_objectWithKeyValues:dict];
                        if ([GJCFStringUitil stringIsNull:cargoModel.level] ) {
                            [self.flowdataList addObject:cargoModel];
                        }else{
                            [self.dataList addObject:cargoModel];
                        }
                    }
                    
                }
                
                
            }
        }
        
        
//        self.shipHelperChangJiangView.stagescrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.shipHelperChangJiangView.navView.gjcf_bottom, [CommonDimensStyle screenWidth], [CommonDimensStyle screenHeight]-self.shipHelperChangJiangView.navView.gjcf_bottom)];
        
        self.shipHelperChangJiangView.stagescrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, [CommonDimensStyle screenWidth], [CommonDimensStyle screenHeight]-kStatusBarHeight - kNavigationBarHeight)];
        
        [self.view addSubview:self.shipHelperChangJiangView.stagescrollView];
        
        if (self.dataList.count == 0 ) {
            NullContentView *nullContentView = [[NullContentView alloc]initWithFrame:CGRectMake(0, 0, self.shipHelperChangJiangView.stagescrollView.gjcf_width, self.shipHelperChangJiangView.stagescrollView.gjcf_height) Title:@"暂时没有数据！"];
            [self.shipHelperChangJiangView.stagescrollView addSubview:nullContentView];
        }
        else
        {
            UIView *headScrollView = [self.shipHelperChangJiangView getHead];
            [self.shipHelperChangJiangView.stagescrollView addSubview:headScrollView];
            
            int newY =headScrollView.gjcf_bottom;
            //添加数据
            for (int i = 0; i<self.dataList.count; i++) {
                ServiceWaterDetailModel *cargoModel =  (ServiceWaterDetailModel *)self.dataList[i];
                UIView *contentOneView = [self.shipHelperChangJiangView getTableItem:cargoModel.place Stage:cargoModel.level Change:cargoModel.level_rise Y:newY];
                if (i%2 ==1) {
                    contentOneView.backgroundColor = [CommonFontColorStyle F2F6FCColor];
                }else{
                    contentOneView.backgroundColor = [CommonFontColorStyle F8FCFFColor];
                }
                [self.shipHelperChangJiangView.stagescrollView addSubview:contentOneView];
                newY +=contentOneView.gjcf_height;
            }
            
            CGSize stageSize = CGSizeMake([CommonDimensStyle screenWidth], newY);
            self.shipHelperChangJiangView.stagescrollView.contentSize =stageSize;
            
        }
        
        
//        self.shipHelperChangJiangView.flowscrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.shipHelperChangJiangView.navView.gjcf_bottom, [CommonDimensStyle screenWidth], [CommonDimensStyle screenHeight]-self.shipHelperChangJiangView.navView.gjcf_bottom)];
        
        self.shipHelperChangJiangView.flowscrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, [CommonDimensStyle screenWidth], [CommonDimensStyle screenHeight]-kStatusBarHeight-kNavigationBarHeight)];
        
        [self.view addSubview:self.shipHelperChangJiangView.flowscrollView];
        
        if (self.flowdataList.count == 0 ) {
            NullContentView *nullContentView = [[NullContentView alloc]initWithFrame:CGRectMake(0, 0, self.shipHelperChangJiangView.stagescrollView.gjcf_width, self.shipHelperChangJiangView.stagescrollView.gjcf_height) Title:@"暂时没有数据！"];
            [self.shipHelperChangJiangView.flowscrollView addSubview:nullContentView];
        }
        else
        {
            
            UIView *headflowScrollView = [self.shipHelperChangJiangView getflowHead];
            [self.shipHelperChangJiangView.flowscrollView addSubview:headflowScrollView];
            
            int newflowY =headflowScrollView.gjcf_bottom;
            //添加数据
            for (int i = 0; i<self.flowdataList.count; i++) {
                ServiceWaterDetailModel *cargoModel =  (ServiceWaterDetailModel *)self.flowdataList[i];
                UIView *contentOneView = [self.shipHelperChangJiangView getTableItem:cargoModel.place Stage:cargoModel.flow Change:cargoModel.flow_rise Y:newflowY];
                if (i%2 ==1) {
                    contentOneView.backgroundColor = [CommonFontColorStyle F2F6FCColor];
                }else{
                    contentOneView.backgroundColor = [CommonFontColorStyle F8FCFFColor];
                }
                [self.shipHelperChangJiangView.flowscrollView addSubview:contentOneView];
                newflowY +=contentOneView.gjcf_height;
            }
            
            CGSize flowSize = CGSizeMake([CommonDimensStyle screenWidth], newflowY);
            self.shipHelperChangJiangView.flowscrollView.contentSize =flowSize;
            
        }
        if ([self.fromTag isEqualToString:@"长江水位"]) {
            [self setOnSelectedView:1];
        }
        else
        {
            [self setOnSelectedView:2];
        }
//        [self setOnSelectedView:STAGE];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}

- (void)DDStageViewClick:(NSInteger)number{
    [self setOnSelectedView:STAGE];
}
- (void)DDFlowViewClick:(NSInteger)number{
    [self setOnSelectedView:FLOW];
}

-(void)setOnSelectedView:(int)index{
    if (index == STAGE) {
        self.shipHelperChangJiangView.stageLable.textColor = [CommonFontColorStyle E6Color];;
        self.shipHelperChangJiangView.stageBlueView.hidden = NO;
        self.shipHelperChangJiangView.flowLable.textColor = [CommonFontColorStyle FontNormalColor];
        self.shipHelperChangJiangView.flowBlueView.hidden = YES;
        self.shipHelperChangJiangView.stagescrollView.hidden = NO;
        self.shipHelperChangJiangView.flowscrollView.hidden = YES;
    }else{
        self.shipHelperChangJiangView.stageLable.textColor = [CommonFontColorStyle FontNormalColor];
        self.shipHelperChangJiangView.stageBlueView.hidden = YES;
        self.shipHelperChangJiangView.flowLable.textColor = [CommonFontColorStyle E6Color];
        self.shipHelperChangJiangView.flowBlueView.hidden = NO;
        self.shipHelperChangJiangView.stagescrollView.hidden = YES;
        self.shipHelperChangJiangView.flowscrollView.hidden = NO;
    }
}















@end
