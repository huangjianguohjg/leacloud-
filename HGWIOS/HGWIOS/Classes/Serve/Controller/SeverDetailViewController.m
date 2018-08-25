//
//  SeverDetailViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "SeverDetailViewController.h"
#import "ServiceWaterModel.h"
#import "NullContentView.h"
#import "ShipHelperChangJiangController.h"
@interface SeverDetailViewController ()
@property (nonatomic, strong) NSMutableDictionary * dataDictionary;
@property (nonatomic, weak)  ServerWaterView * serverWeaterView;

@property (nonatomic, copy) NSString * firstDay;

@end

@implementation SeverDetailViewController

-(NSMutableDictionary *)dataDictionary
{
    if (_dataDictionary == nil) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = self.titleStr;
    
    [self setUpUI];
    
    [self getDataList];
    
}



-(void)setUpUI
{
    ServerWaterView * serveView = [[ServerWaterView alloc]initWithFrame:self.view.bounds];
    serveView.fromTag = self.navigationItem.title;
    serveView.delegate = self;
    serveView.trueDataDictionary = [[NSMutableDictionary alloc]init];
    self.view = serveView;
//    [self.view addSubview:serveView];
    self.serverWeaterView = serveView;
    
}




-(void)getDataList
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"time_length\":\"%@\"",@"100"];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetWeaterList URLMethod:GetWeaterListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result)
        
        NSMutableArray *orderArray = [[NSMutableArray alloc]init];
        
        if (result != nil) {
            if (![result[@"result"] isEqual:[NSNull null]] && [result[@"result"][@"status"] boolValue]) {
                NSDictionary *list = result[@"result"][@"list"];
                if (![list isEqual:[NSNull null]] && list.allKeys.count > 0) {
                    for(int i = 0; i < list.allKeys.count;i ++){
                        NSString *keyValue =list.allKeys[i];
                        NSArray *ValueList =[list objectForKey:keyValue];
                        if (![ValueList isEqual:[NSNull null]]) {
                            [orderArray addObject:keyValue];
                            NSMutableArray *itemArray = [[NSMutableArray alloc]init];
                            
                            [itemArray addObjectsFromArray:[ServiceWaterModel mj_objectArrayWithKeyValuesArray:ValueList]];
                            
                            
                            
                            [self.dataDictionary setObject:itemArray forKey:keyValue];
                        }
                    }
                }
                
            }
        }
        
        if (self.dataDictionary.allKeys.count == 0 )
        {
            NSArray *subViews =self.serverWeaterView.scrollView.subviews;
            for (int i =0 ; i<subViews.count; i++) {
                [subViews[i] removeFromSuperview];
            }
            NullContentView *nullContentView = [[NullContentView alloc]initWithFrame:CGRectMake(0, 0, self.serverWeaterView.scrollView.gjcf_width, self.serverWeaterView.scrollView.gjcf_height) Title:@"暂时没有数据！"];
            [self.serverWeaterView.scrollView addSubview:nullContentView];
        }
        else
        {
            int newY =0;
            
            [orderArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                NSString *str1=(NSString *)obj1;
                NSString *str2=(NSString *)obj2;
                
                return [str2 compare:str1];
            }];
            for (int i = 0 ; i < self.dataDictionary.allKeys.count; i++) {
                NSString *keyValue = orderArray[i];
                if (i == 0) {
                    _firstDay = keyValue;
                }
                NSMutableArray *ValueArray =[self.dataDictionary valueForKey:keyValue];
                if (![keyValue isEqual:[NSNull null]] &&![ValueArray isEqual:[NSNull null]] && ValueArray.count > 0 ) {
                    UIView *itemView = [self.serverWeaterView setContentItem:keyValue DataList:ValueArray Y:newY Flag:i];
                    
                    [self.serverWeaterView.scrollView addSubview:itemView];
                    
                    newY =itemView.gjcf_height + newY;
                }
                
            }
            
            CGSize cgSize = CGSizeMake([CommonDimensStyle screenWidth], newY);
            self.serverWeaterView.scrollView.contentSize =cgSize;
            
        }
                
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}






- (void)DDViewClick:(NSInteger)number{
    ServiceWaterModel *waterFlowModel  = (ServiceWaterModel *) [self.serverWeaterView.trueDataDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)number]];

    if ([waterFlowModel.type isEqualToString:@"1"]) {
        ShipHelperChangJiangController *shipHelperCanalController = [[ShipHelperChangJiangController alloc]init];
        shipHelperCanalController.fromTag = self.titleStr;
        shipHelperCanalController.date = waterFlowModel.date;
        shipHelperCanalController.type = waterFlowModel.type;
        shipHelperCanalController.changjiangTitle = waterFlowModel.title;
        [self.navigationController pushViewController:shipHelperCanalController animated:YES];
    }else{
//
//        ShipHelperCanalController *shipHelperCanalController = [[ShipHelperCanalController alloc]init];
//        shipHelperCanalController.date = waterFlowModel.date;
//        shipHelperCanalController.type = waterFlowModel.type;
//        shipHelperCanalController.cannaltitle = waterFlowModel.title;
//        [self.navigationController pushViewController:shipHelperCanalController animated:YES];
    }
    
}

















@end
