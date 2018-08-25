//
//  ShipHelperWeatherDetailController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperWeatherDetailController.h"
#import "ShipHelperWeatherCell.h"
#import "ShipHelperWeatherDetailModel.h"
@interface ShipHelperWeatherDetailController (){
    NSString *identifier;
    NSMutableArray *dataList;
    UILabel *titleLabel;
    UIView *headview;
}

@end

@implementation ShipHelperWeatherDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"气象预告详情";
    
    [self setUpUI];
    
    [self getDataContent];
    
}



-(void)setUpUI
{
    identifier = @"ShipHelperWeatherCell";
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, headview.gjcf_bottom, self.view.frame.size.width, (self.view.frame.size.height-headview.gjcf_bottom))];
    [self.view addSubview:backGroundView];
    [backGroundView.layer addSublayer:[self shadowAsInverse]];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kStatusBarHeight + kNavigationBarHeight+18, [CommonDimensStyle screenWidth]-20, 15)];
    titleLabel.font = [CommonFontColorStyle F17BoldSizeFont];
    titleLabel.textColor = [CommonFontColorStyle WhiteColor];
    titleLabel.text = self.weathertitle;
    [self.view addSubview:titleLabel];
    
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0.0f;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, titleLabel.gjcf_bottom+18, [CommonDimensStyle screenWidth]-20, ([CommonDimensStyle screenHeight]-titleLabel.gjcf_bottom-10)) collectionViewLayout:flowLayout];
    self.collectionView.tag = 1;
    self.collectionView.layer.cornerRadius = 5;
    [self.view addSubview:self.collectionView];
    //注册单元格
    [self.collectionView registerClass:[ShipHelperWeatherCell class]forCellWithReuseIdentifier:identifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
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
    return dataList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([CommonDimensStyle screenWidth], 72);
}
//设置元素内容
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    identifier = @"ShipHelperWeatherCell";
    ShipHelperWeatherCell *shipHelperWeatherCell = (ShipHelperWeatherCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
    ShipHelperWeatherDetailModel *cargoModel = ( ShipHelperWeatherDetailModel *)dataList[indexPath.row];
    [shipHelperWeatherCell setContent:cargoModel.weatherID Place:cargoModel.place Remarks:cargoModel.remarks Weather:cargoModel.weather Temperature:cargoModel.temperature ImageOne:cargoModel.image_url ImageTwo:cargoModel.image_url_to];
    
    return shipHelperWeatherCell;
    
}


-(void)getDataContent{
    NSString *parameterstring = [NSString stringWithFormat:@"\"title\":\"%@\"",self.weathertitle];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetWeatherList URLMethod:GetWeatherDetailMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        dataList = [[NSMutableArray alloc]init];
        
        if (result != nil) {
            NSDictionary *boatresult = result[@"result"];
            if (![boatresult isEqual:[NSNull null]] &&[boatresult[@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]] &&[list count] >0){
                    for(int i = 0; i < list.count;i ++){
                        ShipHelperWeatherDetailModel *cargoModel = [ShipHelperWeatherDetailModel mj_objectWithKeyValues:(NSDictionary *)(list[i])];
                        [dataList addObject:cargoModel];
                    }
                }
                
            }
        }
        [self.collectionView reloadData];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}














- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    CGRect newGradientLayerFrame = CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height-headview.gjcf_bottom));
    gradientLayer.frame = newGradientLayerFrame;
    
    //添加渐变的颜色组合
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[[CommonFontColorStyle E6Color]colorWithAlphaComponent:1] CGColor],
                            (id)[[[CommonFontColorStyle C165189Color] colorWithAlphaComponent:1]CGColor],
                            nil];
    
    gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0],
                               [NSNumber numberWithFloat:1],
                               nil];
    
    gradientLayer.startPoint = CGPointMake(1,0);
    
    gradientLayer.endPoint = CGPointMake(1,1);
    return gradientLayer;
}


































@end
