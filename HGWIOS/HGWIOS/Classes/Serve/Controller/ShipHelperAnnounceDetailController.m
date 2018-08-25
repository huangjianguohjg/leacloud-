//
//  ShipHelperAnnounceDetailController.m
//  HGWIOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipHelperAnnounceDetailController.h"
#import "ShipHelperWebDetailModel.h"
#import "DateHelper.h"
#import "NullContentView.h"
#define ANNOUNCE 1
#define WARNING 2
@interface ShipHelperAnnounceDetailController ()
@property (nonatomic, copy) NSString *data;
@property (nonatomic, weak) UIScrollView *scorllView;
@property (nonatomic, strong) ShipHelperWebDetailModel * cargoModel;
@end

@implementation ShipHelperAnnounceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [CommonFontColorStyle WhiteColor];
    
    self.navigationItem.title = @"通告详情";
    
    [self setUpUI];
    
    [self getDataContent];
}




-(void)setUpUI
{
    UIScrollView * scorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, [CommonDimensStyle screenWidth], [CommonDimensStyle screenHeight] - kStatusBarHeight - kNavigationBarHeight)];
    [self.view addSubview:scorllView];
    self.scorllView = scorllView;
}


-(void)initContent:(NSString *)title DateTime:(NSString *)dateTime Content:(NSString *)content{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, realH(20) , [CommonDimensStyle screenWidth]-20, 18)];
    [self.scorllView addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [CommonFontColorStyle F18BoldSizeFont];
    titleLabel.textColor= [CommonFontColorStyle FontNormalColor];
    
    CGSize size1 = [titleLabel sizeThatFits:CGSizeMake(titleLabel.frame.size.width, MAXFLOAT)];
    //    int needLine =   ceil( size1.height/18);
    CGRect frame1  =titleLabel.frame;
    frame1.size.height = size1.height;//   needLine * 18 +10;
    titleLabel.frame =frame1;
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLabel.gjcf_bottom +17, [CommonDimensStyle screenWidth]-20, 18)];
    [self.scorllView addSubview:timeLabel];
    timeLabel.text = dateTime;
    timeLabel.font = [CommonFontColorStyle SuperSmallFont];
    timeLabel.textColor= [CommonFontColorStyle BottomTextColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, timeLabel.gjcf_bottom + 13, [CommonDimensStyle screenWidth]- 20, 0.5)];;
    lineView.backgroundColor = [CommonFontColorStyle E1E6ECColor];
    [self.scorllView addSubview:lineView];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView.gjcf_bottom+ 17, [CommonDimensStyle screenWidth]-20, 100)];;
    contentLabel.font = [CommonFontColorStyle NormalSizeFont];
    contentLabel.textColor= [CommonFontColorStyle FontNormalColor];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.scorllView addSubview:contentLabel];
    
    while ([[content substringToIndex:1] isEqualToString:@"\n"]) {
        content = [content substringFromIndex:1];
    }
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                   [CommonFontColorStyle FontNormalColor],NSForegroundColorAttributeName,nil];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attributeDict];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    
    if (self.type == ANNOUNCE) {
        if([content containsString:@"电："]){
            NSArray *tempArray = [content componentsSeparatedByString:@"\n"];
            if (tempArray.count >1) {
                
                
                for (int j = 0; j<tempArray.count-1; j++) {
                    
                    if ([tempArray[j] containsString:@"电："]) {
                        long nowPosition = 0;
                        
                        nowPosition = [content componentsSeparatedByString:(NSString *)tempArray[j]][0].length;
                        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:16.0] range:NSMakeRange(nowPosition , ((NSString *)tempArray[j]).length)];
                        
                    }
                }
            }
            
        }
        if([content containsString:@"电:"]){
            NSArray *tempArray = [content componentsSeparatedByString:@"\n"];
            if (tempArray.count >1) {
                
                
                for (int j = 0; j<tempArray.count-1; j++) {
                    
                    if ([tempArray[j] containsString:@"电:"]) {
                        long nowPosition = 0;
                        nowPosition = [content componentsSeparatedByString:(NSString *)tempArray[j]][0].length;
                        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:16.0] range:NSMakeRange(nowPosition , ((NSString *)tempArray[j]).length)];
                        
                    }
                }
            }
            
            
        }
        
    }
    
    
    contentLabel.attributedText = attributedString;
    
    [contentLabel sizeToFit];
    
    CGSize size = CGSizeMake([CommonDimensStyle screenWidth], contentLabel.gjcf_bottom);
    self.scorllView.contentSize =size;
}


-(void)getDataContent{
    NSString *parameterstring = [NSString stringWithFormat:@"\"id\":\"%@\"",self.detailId];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetNoticeList URLMethod:GetNoticeDetailMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
     
        XXJLog(@"%@",result)
        
        if (result != nil) {
            NSDictionary *boatresult = result[@"result"];
            
            if (![boatresult isEqual:[NSNull null]] &&[boatresult[@"status"] boolValue])
            {
                _cargoModel = [ShipHelperWebDetailModel mj_objectWithKeyValues:(NSDictionary *)boatresult[@"info"]];
                
                [self initContent:_cargoModel.title DateTime:[DateHelper StringDateStampToString:_cargoModel.create_time] Content:_cargoModel.content];
                
            }
            else
            {
                NSArray *subViews =self.scorllView.subviews;
                for (int i =0 ; i<subViews.count; i++) {
                    [subViews[i] removeFromSuperview];
                }
                NullContentView *nullContentView = [[NullContentView alloc]initWithFrame:CGRectMake(0, 0, self.scorllView.gjcf_width, self.scorllView.gjcf_height) Title:@"暂时没有数据！"];
                [self.scorllView addSubview: nullContentView];
            }
            
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}






































@end
