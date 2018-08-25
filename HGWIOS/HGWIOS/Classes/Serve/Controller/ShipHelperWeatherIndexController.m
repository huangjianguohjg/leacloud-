//
//  ShipHelperWeatherIndexController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperWeatherIndexController.h"
#import "DottedLineView.h"
#import "ShipHelperWeatherModel.h"
#import "NullContentView.h"
#import "ShipHelperWeatherDetailController.h"

//#import "ShipHelperCanalController.h"
@interface ShipHelperWeatherIndexController (){
    NSMutableDictionary *viewDataDictionary;
    NSMutableArray *dataList;//原始数据
    NSMutableDictionary *trueDataDictionary;//整理过的数据
    UIScrollView *scrollView ;
    UIView *headView;
    NSString *firstDay;
}


//@property (nonatomic, strong) NSMutableDictionary *viewDataDictionary;
//@property (nonatomic, strong) NSMutableArray *dataList;//原始数据
//@property (nonatomic, strong) NSMutableDictionary *trueDataDictionary;//整理过的数据
//@property (nonatomic, weak) UIScrollView *scrollView;
//@property (nonatomic, copy) NSString *firstDay;
@end

@implementation ShipHelperWeatherIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    viewDataDictionary = [[NSMutableDictionary alloc]init];
    trueDataDictionary= [[NSMutableDictionary alloc]init];
    

    self.navigationItem.title = @"气象预告";
    
    [self setUpUI];
    
    [self getDataContent];
}



-(void)setUpUI
{
    scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, headView.gjcf_bottom, [CommonDimensStyle screenWidth], ([CommonDimensStyle screenHeight] - headView.gjcf_bottom))];
    [self.view addSubview:scrollView];

}

-(void)newPagehelper{
//    ShipHelperCanalController *addBoatController = [[ShipHelperCanalController alloc]init];
//    [self.navigationController pushViewController:addBoatController animated:YES];
}


/**
 *  展示模块单元
 *
 *  @param time     时间
 *  @param dataList 内容
 *  @param y        模块开始高度
 *  @param flag     标志  1、开始   2、中间   3、结束
 *
 *  @return 模块单元视图
 */
-(UIView *)setContentItem:(NSString *)time DataList:(NSMutableArray *)datalist Y:(int)y Flag:(int)flag{
    UIView *contentView;
    if (![datalist isEqual:[NSNull null]] &&datalist.count > 0) {
        long listCount = datalist.count;
        long viewHeight = listCount *45 + 10;
        contentView = [[UIView alloc]initWithFrame:CGRectMake(0, y, [CommonDimensStyle screenWidth], viewHeight)];
        contentView.backgroundColor = [CommonFontColorStyle WhiteColor];
        
        //时间
        time = [NSString stringWithFormat:@"%@年\n%@月%@日",[time componentsSeparatedByString:@"-"][0],[time componentsSeparatedByString:@"-"][1],[time componentsSeparatedByString:@"-"][2]];
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 68, 40)];
        timeLabel.font = [CommonFontColorStyle NormalSizeFont];
        timeLabel.textColor = [CommonFontColorStyle E6Color];
        timeLabel.text = time;
        timeLabel.numberOfLines = 0;
        [contentView addSubview:timeLabel];
        
        //圆圈
        int circleImageWidth = 12;
        UIImageView *circleImage = [[UIImageView alloc]initWithFrame:CGRectMake(timeLabel.gjcf_right, (45-circleImageWidth)/2, circleImageWidth, circleImageWidth)];
        circleImage.image = [UIImage imageNamed:@"aide_line_time"];
        [contentView addSubview:circleImage];
        
        //下拉线
        //上面高度
        if (flag != 0) {
            DottedLineView *dottedLinetopView = [[DottedLineView alloc]initWithFrame:CGRectMake(timeLabel.gjcf_right+5.5, 0, 1, circleImage.gjcf_top)];
            dottedLinetopView.lineColor = [CommonFontColorStyle E6Color];
            [contentView addSubview:dottedLinetopView];
        }
        
        DottedLineView *dottedLineView = [[DottedLineView alloc]initWithFrame:CGRectMake(timeLabel.gjcf_right+5.5, circleImage.gjcf_bottom, 1, contentView.gjcf_height-27)];
        dottedLineView.lineColor = [CommonFontColorStyle E6Color];
        [contentView addSubview:dottedLineView];
        
        //内容
        int contentStartX =circleImage.gjcf_right + 20;
        for (int i = 0; i<listCount; i++) {
            ShipHelperWeatherModel *waterFlowModel  = (ShipHelperWeatherModel *) datalist[i];
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom ];
            view.frame = CGRectMake(contentStartX, i*45, [CommonDimensStyle screenWidth]- contentStartX, 45);
            
            view.tag = y+i;
            [trueDataDictionary setObject:waterFlowModel forKey:[NSString stringWithFormat:@"%d",y+i]];
            //            [viewDataDictionary setValue:waterFlowModel forUndefinedKey:[NSString stringWithFormat:@"%d",y+i]];
            [view addTarget:self action:@selector(viewClick:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *viewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.gjcf_width - 33, view.gjcf_height)];
            viewLabel.textColor = [CommonFontColorStyle FontNormalColor];
            viewLabel.font = [CommonFontColorStyle NormalSizeFont];
            
            NSString *title =waterFlowModel.title;
            if ([title containsString:@"日"]) {
                title = [title componentsSeparatedByString:@"日"][1];
            }
            
            viewLabel.text = title;
            [view addSubview:viewLabel];
            
            UIImageView *viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(viewLabel.gjcf_right +10, 16, 13, 13)];
            viewImage.image =[UIImage imageNamed:@"arrow01_gray"];
            [view addSubview:viewImage];
            
            UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, view.gjcf_width, 0.5)];
            viewLine.backgroundColor = [CommonFontColorStyle E4E5E9Color];
            [view addSubview:viewLine];
            [contentView addSubview:view];
        }
    }
    return contentView;
}


-(void)viewClick:(UIButton *)sender{
    long buttontag = sender.tag;
    ShipHelperWeatherModel *waterFlowModel  =  (ShipHelperWeatherModel *)[trueDataDictionary objectForKey:[NSString stringWithFormat:@"%ld",buttontag]];
    ShipHelperWeatherDetailController *shipHelperAnnounceDetailController = [[ShipHelperWeatherDetailController alloc]init];
    shipHelperAnnounceDetailController.weathertitle = waterFlowModel.title;
    [self.navigationController pushViewController:shipHelperAnnounceDetailController animated:YES];
    
}


-(void)getDataContent{
    NSString *parameterstring = [NSString stringWithFormat:@"\"time_length\":\"%@\"",@"100"];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetWeatherList URLMethod:GetWeatherListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        viewDataDictionary = [[NSMutableDictionary alloc]init];
        NSMutableArray *orderArray = [[NSMutableArray alloc]init];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            NSDictionary *boatresult = result[@"result"];
            if (![boatresult isEqual:[NSNull null]] &&[[boatresult objectForKey:@"status"] boolValue]) {
                NSDictionary *list = [boatresult objectForKey:@"list"];
                if(![list isEqual:[NSNull null]] &&[list.allKeys count] >0){
                    for(int i = 0; i < list.allKeys.count;i ++){
                        NSString *keyValue =list.allKeys[i];
                        [orderArray addObject:keyValue];
                        NSArray *ValueList =[list objectForKey:keyValue];
                        NSMutableArray *itemArray = [[NSMutableArray alloc]init];
                        if (![ValueList isEqual:[NSNull null]]) {
                            for (int j = 0;  j < ValueList.count; j++) {
                                ShipHelperWeatherModel *cargoModel = [ShipHelperWeatherModel mj_objectWithKeyValues:(NSDictionary *)ValueList[j]];
                                [itemArray addObject:cargoModel];
                            }
                            
                            [viewDataDictionary setObject:itemArray forKey:keyValue];
                        }
                    }
                }
            }
        }
        
        if (viewDataDictionary.allKeys.count == 0 ) {
            NSArray *subViews =scrollView.subviews;
            for (int i =0 ; i<subViews.count; i++) {
                [subViews[i] removeFromSuperview];
            }
            NullContentView *nullContentView = [[NullContentView alloc]initWithFrame:CGRectMake(0, 0, scrollView.gjcf_width, scrollView.gjcf_height) Title:@"暂时没有数据！"];
            [scrollView addSubview:nullContentView];
        }else{
            int newY =0;
            
            
            [orderArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                NSString *str1=(NSString *)obj1;
                NSString *str2=(NSString *)obj2;
                
                return [str2 compare:str1];
            }];
            
            
            for (int i = 0 ; i<viewDataDictionary.allKeys.count; i++) {
                NSString *keyValue = orderArray[i];
                if(i == 0){
                    firstDay = keyValue;
                }
                NSMutableArray *ValueArray =[viewDataDictionary valueForKey:keyValue];
                if (![keyValue isEqual:[NSNull null]] &&![ValueArray isEqual:[NSNull null]] && ValueArray.count > 0 ) {
                    UIView *itemView = [self setContentItem:keyValue DataList:ValueArray Y:newY Flag:i];
                    [scrollView addSubview:itemView];
                    
                    newY =itemView.gjcf_height + newY;
                }
            }
            CGSize size = CGSizeMake([CommonDimensStyle screenWidth], newY);
            scrollView.contentSize =size;
        }
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}






































@end
