//
//  ShipHelperAnnounceIndexView.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperAnnounceIndexController.h"
#import "ShipHelperAnnounceIndexView.h"
#import "ShipHelperNoticeListModel.h"
#import "NullContentView.h"

#import "ShipHelperAnnounceDetailController.h"
@interface ShipHelperAnnounceIndexController ()

@property (nonatomic, strong) NSMutableDictionary * viewDataDictionary;
@property (nonatomic, strong) NSMutableArray * dataList;
@property (nonatomic, copy) NSString * firstDay;
@property (nonatomic, weak) ShipHelperAnnounceIndexView * shipHelperAnnounceIndexView;
@end

@implementation ShipHelperAnnounceIndexController

-(NSMutableDictionary *)viewDataDictionary
{
    if (_viewDataDictionary == nil) {
        _viewDataDictionary = [NSMutableDictionary dictionary];
    }
    return _viewDataDictionary;
}

-(NSMutableArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"航道通告";
    
    [self setUpUI];
    
    [self getDataContent];
}



-(void)setUpUI
{
    ShipHelperAnnounceIndexView * shipHelperAnnounceIndexView = [[ShipHelperAnnounceIndexView alloc]initWithFrame:self.view.bounds];
    shipHelperAnnounceIndexView.delegate = self;
    shipHelperAnnounceIndexView.trueDataDictionary= [[NSMutableDictionary alloc]init];
    self.view = shipHelperAnnounceIndexView;
    self.shipHelperAnnounceIndexView = shipHelperAnnounceIndexView;
}

-(void)getDataContent
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"time_length\":\"%@\"",@"100"];
    
    [XXJNetManager requestPOSTURLString:GetNoticeList URLMethod:GetNoticeListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            NSDictionary *boatresult = result[@"result"];
            
            if (![boatresult isEqual:[NSNull null]] && [boatresult[@"status"] boolValue]) {
                NSArray *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]] &&[list count] >0){
                    for(int i = 0; i < list.count;i ++){
                    
                        ShipHelperNoticeListModel *cargoModel = [ShipHelperNoticeListModel mj_objectWithKeyValues:(NSDictionary *)(list[i])];
                        [self.dataList addObject:cargoModel];
                    }
                    
                    
                }
            }
            
            
            if (self.dataList.count == 0 ) {
                NSArray *subViews =self.shipHelperAnnounceIndexView.scrollView.subviews;
                for (int i =0 ; i<subViews.count; i++) {
                    [subViews[i] removeFromSuperview];
                }
                NullContentView *nullContentView = [[NullContentView alloc]initWithFrame:CGRectMake(0, 0, self.shipHelperAnnounceIndexView.scrollView.gjcf_width, self.shipHelperAnnounceIndexView.scrollView.gjcf_height) Title:@"暂时没有数据！"];
                [self.shipHelperAnnounceIndexView.scrollView addSubview:nullContentView];
            }
            else
            {
                
                int newY =0;
                for (int i = 0 ; i<self.dataList.count; i++) {
                    NSString *keyValue = ((ShipHelperNoticeListModel *)self.dataList[i]).date_format;
                    if (i == 0) {
                        self.firstDay =keyValue;
                    }
                    NSMutableArray *ValueArray =((ShipHelperNoticeListModel *)self.dataList[i]).list;
                    UIView *itemView = [self.shipHelperAnnounceIndexView setContentItem:keyValue DataList:ValueArray Y:newY Flag:i];
                    [self.shipHelperAnnounceIndexView.scrollView addSubview:itemView];
                    
                    newY =itemView.gjcf_height + newY;
                    self.shipHelperAnnounceIndexView.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, newY);
                }
            }
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}

- (void)DDViewClick:(NSInteger)number{
    NSDictionary *waterFlowModel  = (NSDictionary *) [self.shipHelperAnnounceIndexView.trueDataDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)number]];
    ShipHelperAnnounceDetailController *shipHelperAnnounceDetailController = [[ShipHelperAnnounceDetailController alloc]init];
    shipHelperAnnounceDetailController.detailId =  [waterFlowModel objectForKey:@"id"];
    shipHelperAnnounceDetailController.type = 1;
    [self.navigationController pushViewController:shipHelperAnnounceDetailController animated:YES];
}


@end
