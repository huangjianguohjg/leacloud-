//
//  ZKAlertController.m
//  ZKAlertController
//
//  Created by 张日奎 on 16/10/14.
//  Copyright © 2016年 bestdew. All rights reserved.
//

#import "HLPhoneInfoController.h"
#import "HttpHelper.h"
#import "LogRemarkModel.h"
@interface HLPhoneInfoController ()
{
    NSString *mRemark;
    NSMutableArray *remarkList;
}
@end

@implementation HLPhoneInfoController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCancelView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getFeedRemarkList];
    
}


-(void)getCancelView{
    int baseWidth = 305;
    int baseHeight = 450;
    int leftMargin = (SCREENWIDTH -baseWidth)/2;
    int topMargin = (SCREENHEIGHT -baseHeight)/2;
    
        self.cancleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        self.cancleView.backgroundColor = [CommonFontColorStyle LoadingColor];
//    self.cancleView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
        UIView *mainContentView = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, topMargin + 60, baseWidth, 320)];
        mainContentView.backgroundColor = DDColor(@"ffffff");
        [self.cancleView addSubview:mainContentView];
        
        UIImageView *topImage = [[UIImageView alloc]init];
        topImage.frame = CGRectMake(0, 0, baseWidth, 108);
        topImage.image = [UIImage imageNamed:@"cargo_ship_qx_"];
        [mainContentView addSubview:topImage];
        
        //货主图片
        int imageWidth = 90;
        self.fahuoImageView  = [[UIImageView alloc]initWithFrame:CGRectMake((baseWidth-imageWidth)/2, 65, imageWidth, imageWidth)];
        self.fahuoImageView .layer.masksToBounds = true;
        self.fahuoImageView.layer.cornerRadius = 45;
        self.fahuoImageView.layer.borderWidth = 0;
        self.fahuoImageView.image = [UIImage imageNamed:@"phoneback"];
        self.fahuoImageView.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0].CGColor;
        
        [mainContentView addSubview:self.fahuoImageView];
        
        UILabel *showWarnText = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, baseWidth, 18)];
        showWarnText.text = @"致电对方结果如何？";
        showWarnText.font = DDFont(18);
        showWarnText.textColor = DDColor(@"666666");
        showWarnText.textAlignment = NSTextAlignmentCenter;
        showWarnText.backgroundColor = DDColor(@"ffffff");
        [mainContentView addSubview:showWarnText];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, showWarnText.gjcf_bottom + 15, baseWidth, 0.5)];
        lineView.backgroundColor = DDColor(@"e2e2e2");
        [mainContentView addSubview:lineView];
        
        //取消理由
        UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0.0f;
        
        self.cancelCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, lineView.gjcf_bottom, baseWidth, 195) collectionViewLayout:flowLayout];
        self.cancelCollection.backgroundColor = [UIColor whiteColor];
        self.cancelCollection.tag = 10;
        self.cancelCollection.delegate = self;
        self.cancelCollection.dataSource = self;
        [mainContentView addSubview:self.cancelCollection];
        
        //注册单元格
        [self.cancelCollection registerClass:[CargoCancelCell class]forCellWithReuseIdentifier:@"cell"];
        
        int btWidth = 40;
        self.closeBt = [[UIButton alloc]initWithFrame:CGRectMake((SCREENWIDTH - btWidth)/2, mainContentView.gjcf_bottom+20, btWidth, btWidth)];
        [self.closeBt setBackgroundImage:[UIImage imageNamed:@"cargo_ship_close"] forState:UIControlStateNormal];
        self.closeBt.hidden = NO;
        [self.cancleView addSubview:self.closeBt];
         [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.cancleView];
}

#pragma mark -- 反馈
-(void)feedbackRequest
{
    
    [SVProgressHUD show];
    //deal_id  运单id  access_token  score 评价分数
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"log_id\":\"%ld\",\"remark\":\"%@\"",[UseInfo shareInfo].access_token,(long)self.logId,mRemark];
    
    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:FeedBackMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result);
        
        NSDictionary * boatresult = result;
        
        if ([boatresult[@"result"][@"status"] boolValue]) {
            [self.view makeToast:@"提交成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
        }
        else
        {
            [self.view makeToast:@"提交失败，请重试" duration:0.5 position:CSToastPositionCenter];
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}



-(void)submitBtClick{
    
//    //deal_id  运单id  access_token  score 评价分数
//     NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"log_id\":\"%ld\",\"remark\":\"%@\"",[self GetAccessToken],(long)self.logId,mRemark];
//    [HttpHelper post:ApppLogClass RequestMethod:UpdateAppLogRemarkMethod RequestStringParams:parameterstring FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//        NSDictionary * boatdict = [self NSDataToNSDictionary:data];
//        if (boatdict != nil) {
//            NSDictionary *boatresult =[boatdict objectForKey:@"result"];
//            if (![QuickUtil isNullObject:boatresult] &&[[boatresult objectForKey:@"status"] boolValue]) {
//                [self showSuccessMessage:@"提交成功！"];
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }
//        }
//
//    }];
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
    return remarkList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(305, 60);
}

//设置元素内容
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CargoCancelCell *cargoCancelCell = (CargoCancelCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell"  forIndexPath:indexPath];
    
    LogRemarkModel *logRemarkModel =((LogRemarkModel *)remarkList[indexPath.row]);
    [cargoCancelCell setContent:logRemarkModel.key Desc:logRemarkModel.remark];
    return cargoCancelCell;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CargoCancelCell * cell = (CargoCancelCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:YES];
    mRemark =cell.showContent.text;
    //    tempKey = cell.cellkey;
    //    tempDesc = cell.showContent.text;
    [self feedbackRequest];
}

//UICollectionView没有选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    CargoCancelCell * cell = (CargoCancelCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:NO];
}




#pragma mark -- 获取反馈列表
-(void)getFeedRemarkList
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"event\":\"%d\"",self.appLogEvent];
    
    [XXJNetManager requestPOSTURLString:FeedBackURL URLMethod:GetAppLogRemarkMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result);
        
        NSDictionary * boatresult = result;
        remarkList = [[NSMutableArray alloc]init];
        if ([boatresult[@"result"][@"status"] boolValue]) {
            //            NSArray * lsitArray = boatresult[@"result"][@"data"];
            
            for (NSDictionary * dict in boatresult[@"result"][@"data"]) {
                LogRemarkModel *logRemarkModel = [LogRemarkModel mj_objectWithKeyValues:dict];
                [remarkList addObject:logRemarkModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cancelCollection reloadData];
            });
            
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}





//-(void) getRemarkList{
//
//    NSString *parameterstring = [NSString stringWithFormat:@"\"event\":\"%d\"",self.appLogEvent];
//    [HttpHelper post:ApppLogClass RequestMethod:GetAppLogRemarkMethod RequestStringParams:parameterstring FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//        remarkList = [[NSMutableArray alloc]init];
//        NSDictionary * boatdict = [self NSDataToNSDictionary:data];
//        if (boatdict != nil) {
//            NSDictionary *boatresult =[boatdict objectForKey:@"result"];
//            if (![QuickUtil isNullObject:boatresult] &&[[boatresult objectForKey:@"status"] boolValue]) {
//                NSArray *list = [boatresult objectForKey:@"data"];
//                if(![QuickUtil isNullObject:list] &&[list count] >0){
//                    for(int i = 0; i < list.count;i ++){
//                        LogRemarkModel *logRemarkModel = [[LogRemarkModel alloc] initWithDictionary:(NSDictionary *)(list[i]) ];
//                        [remarkList addObject:logRemarkModel];
//                    }
//                }
//
//            }else{
//                [self showErrorMessage:[boatresult objectForKey:@"msg"]];
//            }
//        }
//      dispatch_async(dispatch_get_main_queue(), ^{
//        [self.cancelCollection reloadData];
//      });
//    }];
//}

-(void)closeBtClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
