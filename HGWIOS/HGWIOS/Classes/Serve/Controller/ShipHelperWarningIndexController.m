//
//  ShipHelperWarningIndexController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperWarningIndexController.h"
#import "RefreshModel.h"
#import "ShipHelperWarningCell.h"
#import "ShipHelperWarningModel.h"

#import "ShipHelperAnnounceDetailController.h"
@interface ShipHelperWarningIndexController ()

@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, assign) NSUInteger max;

@property (nonatomic, copy) NSString * identifier;

@property (nonatomic, strong) RefreshModel * dataList;

@property (nonatomic, copy) NSString * firstDay;

@end

@implementation ShipHelperWarningIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.max = 20;
    

    self.navigationItem.title = @"安全预警";
    
    [self initData];
    [self initView];
    [self getDataContent];
    
}



-(void)initData{
    _dataList = [[RefreshModel alloc]init];
    
    _dataList.datas = [[NSMutableArray alloc]init];
    _dataList.pageSize = 14;
    _dataList.pageIndex = 1;
}

-(void)initView{
    _identifier = @"ShipHelperWarningCell";
    
    
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0.0f;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, [CommonDimensStyle screenWidth], ([CommonDimensStyle screenHeight] - kStatusBarHeight - kNavigationBarHeight)) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.tag = 1;
    [self.view addSubview:self.collectionView];
    //注册单元格
    [self.collectionView registerClass:[ShipHelperWarningCell class]forCellWithReuseIdentifier:_identifier];
    self.collectionView.backgroundColor = [CommonFontColorStyle mainBackgroundColor];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf getDataContent];
    }];
//    
//    self.footView = [MJRefreshBackNormalFooter];
//    self.footView.scrollView = self.collectionView ;
//    self.footView.delegate = self;
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
    return _dataList.datas.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([CommonDimensStyle screenWidth], 72);
}
//设置元素内容
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _identifier = @"ShipHelperWarningCell";
    ShipHelperWarningCell *shipHelperWarningCell = (ShipHelperWarningCell *)[collectionView dequeueReusableCellWithReuseIdentifier:_identifier  forIndexPath:indexPath];
    ShipHelperWarningModel *portModel =((ShipHelperWarningModel *)_dataList.datas [indexPath.row]);
    
    [shipHelperWarningCell setContent:portModel.warningID Title:portModel.title Date:portModel.date];
    
    return shipHelperWarningCell;
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShipHelperWarningModel *portModel =(ShipHelperWarningModel *)_dataList.datas[indexPath.row];
    
    ShipHelperAnnounceDetailController *shipHelperAnnounceDetailController = [[ShipHelperAnnounceDetailController alloc]init];
    shipHelperAnnounceDetailController.detailId = portModel.warningID;
    shipHelperAnnounceDetailController.type = 2;
    [self.navigationController pushViewController:shipHelperAnnounceDetailController animated:YES];
    
}


-(void)getDataContent{
    NSString *parameterstring = [NSString stringWithFormat:@"\"Max\":\"%lu\",\"page\":\"%lu\"",(unsigned long)self.max,(unsigned long)self.page];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetWarningList URLMethod:GetWarningListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            NSDictionary * boatresult = result[@"result"];
            
            if (![boatresult isEqual:[NSNull null]] && [boatresult[@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"list"];
                
                if(![list isEqual:[NSNull null]] &&[list count] >0){
                    _dataList.pageIndex++;
                    for(int i = 0; i < list.count;i ++){
                        ShipHelperWarningModel *cargoModel = [ShipHelperWarningModel mj_objectWithKeyValues:(NSDictionary *)(list[i])];
                        if (i == 0) {
                            _firstDay =cargoModel.date;
                        }
                        [_dataList.datas addObject:cargoModel];
                    }
                }
            }
    
        }
        [self.collectionView reloadData];
        
//        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
        
//        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
    
}

























@end
