//
//  ShipHelperLockDetailController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperLockDetailController.h"
#import "GrayLine.h"
#import "AssistantSearchShipLockModel.h"
#import "NullContentView.h"
#import "XXJNetworkTools.h"
@interface ShipHelperLockDetailController (){
    NSMutableDictionary *LockList;
    UILabel *boatLabel;
    UIView *showShipLockView;
    UIView *headview;
    UIScrollView *scrollView ;
    UILabel *subTitleLabel;
}

@end

@implementation ShipHelperLockDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [CommonFontColorStyle WhiteColor];
    

    self.navigationItem.title = @"过闸信息详情";
    
    [self setUpUI];
    
    [self searchBoatInfo];
}




-(void)setUpUI
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, [CommonDimensStyle screenWidth], ([CommonDimensStyle screenHeight]-kStatusBarHeight - kNavigationBarHeight))];
    [self.view addSubview:scrollView];
    
    UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, [CommonDimensStyle screenWidth]-20, 15)];
    [scrollView addSubview:TitleLabel];
    TitleLabel.font = [CommonFontColorStyle NormalSizeFont];
    TitleLabel.textColor = [CommonFontColorStyle I3Color];
    TitleLabel.text = [NSString stringWithFormat:@"%@过闸计划",self.place];
    
    subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, TitleLabel.gjcf_bottom+15, [CommonDimensStyle screenWidth]-20, 45)];
    [scrollView addSubview:subTitleLabel];
    subTitleLabel.font = [CommonFontColorStyle SmallSizeFont];
    subTitleLabel.textColor = [CommonFontColorStyle FontNormalColor];
}


-(UIView *)setLockView:(NSString *)lockname Y:(int)y{
    //展示详情
    UIView * boatLockDetail = [[UIView alloc]initWithFrame:CGRectMake(0, y, [CommonDimensStyle screenWidth], 10)];
    boatLockDetail.backgroundColor = [CommonFontColorStyle ebBackgroudColor];
    
    
    //横线
    GrayLine* grayLine = [[GrayLine alloc]initWithFrame:CGRectMake(0, 0, CommonDimensStyle.screenWidth, 0.5)  Color:[CommonFontColorStyle C6D2DEColor]];
    [boatLockDetail addSubview:grayLine];
    
    boatLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, grayLine.gjcf_bottom, [CommonDimensStyle screenWidth]-20, 45)];
    [boatLockDetail addSubview:boatLabel];
    boatLabel.font = [CommonFontColorStyle NormalSizeFont];
    boatLabel.textColor = [CommonFontColorStyle E6Color];
    boatLabel.text = lockname;
    
    GrayLine* grayLine2 = [[GrayLine alloc]initWithFrame:CGRectMake(0, boatLabel.gjcf_bottom, CommonDimensStyle.screenWidth, 0.5)  Color:[CommonFontColorStyle C6D2DEColor]];
    [boatLockDetail addSubview:grayLine2];
    
    
    UIView *showShipLockHeadView = [self getHead];
    [boatLockDetail addSubview:showShipLockHeadView];
    
    //详情
    int newY =showShipLockHeadView.gjcf_bottom;
    NSMutableArray *valueList = (NSMutableArray*)  [LockList objectForKey:lockname];
    for (int i =0; i<valueList.count; i++) {
        AssistantSearchShipLockModel *assistantSearchShipLockModel = (AssistantSearchShipLockModel *)valueList[i];
        UIView *itemview = [self getTableItem:assistantSearchShipLockModel.ships Gate:assistantSearchShipLockModel.gate Direct:assistantSearchShipLockModel.direct Stime:assistantSearchShipLockModel.s_time Y:newY];
        if (i%2 == 1) {
            itemview.backgroundColor = [CommonFontColorStyle F2F6FCColor];
        }else{
            itemview.backgroundColor = [CommonFontColorStyle F8FCFFColor];
        }
        newY +=itemview.gjcf_height;
        [boatLockDetail addSubview:itemview];
    }
    
    boatLockDetail.gjcf_height =newY;
    return boatLockDetail;
}


-(UIView *)getHead{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, [CommonDimensStyle screenWidth], 45)];
    
    
    //闸次
    UILabel *lockMumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 45)];
    [self setContentLabel:lockMumLabel];
    lockMumLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    lockMumLabel.text = @"闸次";
    [contentView addSubview:lockMumLabel];
    
    //航向
    UILabel *directionLabel = [[UILabel alloc]initWithFrame:CGRectMake(lockMumLabel.gjcf_right, 0, 60, 45)];
    [self setContentLabel:directionLabel];
    directionLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    directionLabel.text = @"航向";
    [contentView addSubview:directionLabel];
    
    //过闸时间
    UILabel *pastLockLabel = [[UILabel alloc]initWithFrame:CGRectMake(directionLabel.gjcf_right, 0, 100, 45)];
    [self setContentLabel:pastLockLabel];
    pastLockLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    pastLockLabel.text = @"过闸时间";
    [contentView addSubview:pastLockLabel];
    
    //过闸船舶
    UILabel *boatsLabel = [[UILabel alloc]initWithFrame:CGRectMake(pastLockLabel.gjcf_right, 0, ([CommonDimensStyle screenWidth]-pastLockLabel.gjcf_right), 45)];
    [self setContentLabel:boatsLabel];
    boatsLabel.font = [CommonFontColorStyle F14BoldSizeFont];
    boatsLabel.text = @"过闸船舶";
    [contentView addSubview:boatsLabel];
    
    //划线
    UIView *headLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentView.gjcf_width, 0.25)];
    headLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:headLineView];
    
    
    
    UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(lockMumLabel.gjcf_right, 0, 0.5, 45)];
    oneLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:oneLineView];
    
    UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(directionLabel.gjcf_right, 0, 0.5, 45)];
    twoLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:twoLineView];
    
    UIView *threeLineView = [[UIView alloc]initWithFrame:CGRectMake(pastLockLabel.gjcf_right, 0, 0.5, 45)];
    threeLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:threeLineView];
    
    UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(0, lockMumLabel.gjcf_bottom-0.5, contentView.gjcf_width, 0.5)];
    fourLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:fourLineView];
    return  contentView;
}


-(UIView *)getTableItem:(NSString *)ships Gate:(NSString *)gate Direct:(NSString *)direct Stime:(NSString *)s_time Y:(int)y{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, y, [CommonDimensStyle screenWidth], 45)];
    
    
    //闸次
    UILabel *lockMumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 45)];
    [self setContentLabel:lockMumLabel];
    lockMumLabel.text = gate;
    [contentView addSubview:lockMumLabel];
    
    //航向
    UILabel *directionLabel = [[UILabel alloc]initWithFrame:CGRectMake(lockMumLabel.gjcf_right, 0, 60, 45)];
    [self setContentLabel:directionLabel];
    directionLabel.text = direct;
    [contentView addSubview:directionLabel];
    
    //过闸时间
    UILabel *pastLockLabel = [[UILabel alloc]initWithFrame:CGRectMake(directionLabel.gjcf_right, 0, 100, 45)];
    [self setContentLabel:pastLockLabel];
    
    NSArray *tempTime = [s_time componentsSeparatedByString:@" "];
    if (tempTime.count ==2) {
        s_time =[NSString stringWithFormat: @"%@\n%@",tempTime[0],tempTime[1]];
    }
    pastLockLabel.text = s_time;
    pastLockLabel.numberOfLines = 0;
    [contentView addSubview:pastLockLabel];
    
    //船闸名称
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(pastLockLabel.gjcf_right+5, 0, ([CommonDimensStyle screenWidth]-pastLockLabel.gjcf_right-10), 45)];
    [self setContentLabel:titleLabel];
    
    ships = [ships stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    
    titleLabel.text = ships;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [CommonFontColorStyle SmallSizeFont];
    titleLabel.textColor = [CommonFontColorStyle I3Color];
    [contentView addSubview:titleLabel];
    
    
    
    CGSize size = [titleLabel sizeThatFits:CGSizeMake(titleLabel.frame.size.width, MAXFLOAT)];
    int needLine =   ceil( size.height/14);
    CGRect frame  =titleLabel.frame;
    frame.size.height = needLine * 15 +10;
    titleLabel.frame =frame;
    
    contentView.gjcf_height = frame.size.height;
    lockMumLabel.gjcf_height = frame.size.height;
    directionLabel.gjcf_height = frame.size.height;
    pastLockLabel.gjcf_height = frame.size.height;
    
    //划线
    UIView *headLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentView.gjcf_width, 0.25)];
    headLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:headLineView];
    
    UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(lockMumLabel.gjcf_right, 0, 0.5, contentView.gjcf_height)];
    oneLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:oneLineView];
    
    UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(directionLabel.gjcf_right, 0, 0.5, contentView.gjcf_height)];
    twoLineView.backgroundColor = [CommonFontColorStyle C6D2DEColor];
    [contentView addSubview:twoLineView];
    
    UIView *threeLineView = [[UIView alloc]initWithFrame:CGRectMake(pastLockLabel.gjcf_right, 0, 0.5, contentView.gjcf_height)];
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


/**
 *  获取闸口当天详情
 */
-(void)searchBoatInfo
{
    if (![self.place isEqual:[NSNull null]]) {
        NSString *parameterstring = [NSString stringWithFormat:@"\"place\":\"%@\"",self.place];
        [SVProgressHUD show];
        
//        [XXJNetManager requestPOSTURLString:GetInfoByLockName URLMethod:GetInfoByLockNameMethod parameters:parameterstring finished:^(id result) {
//
//            XXJLog(@"%@",result)
//
//        } errored:^(NSError *error) {
//
//        }];
        
        
        
        [[XXJNetworkTools shareTools] request:POST URLString:GetInfoByLockName URLMethod:GetInfoByLockNameMethod parameters:parameterstring finished:^(id result, NSError *error) {
            
            if (error == nil) {
                [SVProgressHUD dismiss];
                
                if (result == nil) {
                    return ;
                }
                
                NSDictionary * resultDict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableLeaves error:nil];

                LockList = [[NSMutableDictionary alloc]init];
                NSMutableArray *orderArray = [[NSMutableArray alloc]init];
                if (resultDict != nil)
                {
                    NSMutableDictionary *dict =[resultDict objectForKey:@"result"];

                    if ([[dict objectForKey:@"status"]boolValue])
                    {
                        //有数据
                        NSMutableDictionary *list = [dict objectForKey:@"list"];

                        if(![list isEqual:[NSNull null]] &&list.count>0){
                            for(int i = 0; i < list.allKeys.count;i ++){
                                NSString *itemKey =list.allKeys[i];
                                [orderArray addObject:itemKey];
                                NSArray *itemValue = (NSArray *)[list objectForKey:itemKey];
                                NSMutableArray *trueItemValue = [[NSMutableArray alloc]init];
                                if (itemValue.count >0) {
                                    for (int j =0; j<itemValue.count; j++) {
                                        AssistantSearchShipLockModel *assistantSearchShipLockModel = [AssistantSearchShipLockModel mj_objectWithKeyValues:itemValue[j]];
                                        [trueItemValue addObject:assistantSearchShipLockModel];
                                    }
                                }

                                [LockList setObject:trueItemValue forKey:itemKey];
                            }
                        }
                    }

                }

                if (LockList.allKeys.count == 0 ) {
                    NSArray *subViews =scrollView.subviews;
                    for (int i =0 ; i<subViews.count; i++) {
                        [subViews[i] removeFromSuperview];
                    }
                    NullContentView *nullContentView = [[NullContentView alloc]initWithFrame:CGRectMake(0, 0, scrollView.gjcf_width, scrollView.gjcf_height) Title:@"该船闸暂未公布当前过闸船舶信息"];
                    [scrollView addSubview:nullContentView];
                }else{
                    //副标题

                    int newY =45;
                    @try {
                        NSString *subTitle =((AssistantSearchShipLockModel *)(((NSMutableArray*)[LockList objectForKey:orderArray[0]])[0])).title_tmp;
                        if (![GJCFStringUitil stringIsNull:subTitle]) {
                            subTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                            subTitleLabel.numberOfLines = 0;
                            subTitleLabel.text =subTitle;

                            CGSize size = [subTitleLabel sizeThatFits:CGSizeMake(subTitleLabel.frame.size.width, MAXFLOAT)];
                            CGRect frame  =subTitleLabel.frame;
                            frame.size.height = size.height;
                            subTitleLabel.frame =frame;
                            newY =subTitleLabel.gjcf_bottom+15;
                        }
                    } @catch (NSException *exception) {

                    } @finally {

                        //获得先后顺序



                        NSString *responseString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];

                        NSString *hanziString = [self replaceUnicode:responseString];
                        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]init];
                        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
                        for(int i =0 ;i <  orderArray.count; i++){
                            NSString *vlaue =(NSString *)orderArray[i];
                            NSRange range =[hanziString rangeOfString:vlaue];
                            long position =range.location;
                            [tempDictionary setValue:orderArray[i] forKey:[NSString stringWithFormat:@"%ld",position]];
                            [tempArray addObject:[NSString stringWithFormat:@"%ld",position]];

                        }

                        [tempArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                            NSNumber *number1 = [NSNumber numberWithInteger:((NSString *)obj1).floatValue];
                            NSNumber *number2 = [NSNumber numberWithInteger:((NSString *)obj2).floatValue];

                            return  [number1 compare:number2];
                        }];


                        for (int i=0 ; i<LockList.allKeys.count; i++) {
                            UIView *itemView = [self setLockView:[tempDictionary objectForKey: tempArray[i]] Y:newY];
                            itemView.backgroundColor = [CommonFontColorStyle WhiteColor];
                            newY += itemView.gjcf_height;
                            [scrollView addSubview:itemView];

                        }
                        CGSize scrollSize = CGSizeMake([CommonDimensStyle screenWidth], newY);
                        scrollView.contentSize = scrollSize;
                    }

                }

            }
            else
            {
                [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
                
                [SVProgressHUD dismiss];
            }
        }];

    }
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}




@end
