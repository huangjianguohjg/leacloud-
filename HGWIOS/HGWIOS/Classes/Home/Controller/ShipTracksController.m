//
//  ShipTracksController.m
//  HGWIOS
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipTracksController.h"
#import "ShipTrackModel.h"
#import "DateHelper.h"
@interface ShipTracksController ()
{
    BMKMapView* mapView;
    
    int screenWidh ;
    int screenHeight;
    UIView *loadingView;
    UIButton *zoomOutBtn;
    UIButton *zoomInBtn;
    UIView  *dateView;
    BMKPinAnnotationView *newAnnotation;
    NSMutableArray *degrees;
    NSMutableArray *shipTracksModels;//船行轨迹
    long nowDegree;
    int imageflag;//图标标志 0小船  1箭头
    NSString *nowDateT;
}
@end

@implementation ShipTracksController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载页面信息
    [self initView];
    nowDegree =0;
    imageflag = 0;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [mapView viewWillAppear];
    mapView.delegate = self;
    [self SetMapInit];
    
}




-(void)initView{
    screenWidh = [CommonDimensStyle screenWidth];
    screenHeight = [CommonDimensStyle screenHeight];
    
    //地图
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, screenWidh, screenHeight)];
    [self.view addSubview: mapView];
    
    CGFloat topmargin = 0;
    if (isIPHONEX) {
        topmargin = 20;
    }
    
    //后退按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 30 + topmargin, 40, 40)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_map"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backOnclick) forControlEvents:UIControlEventTouchDown];
    
    //查询日期
    CGFloat margin = 0;
    if (isIPHONEX) {
        margin = 34;
    }
    
    //底部背景
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, (screenHeight - 70 - margin), screenWidh, 70 + margin)];
    bottomView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview:bottomView];
    
    
    
    
    int dateStartY =(screenHeight - 60 - margin);
    dateView = [[UIView alloc]initWithFrame:CGRectMake(0, dateStartY, screenWidh, 60)];
    [self.view addSubview:dateView];
    //当前日期
    UIButton *today =[self getDateButton:@"今天" Rank:0];
    today.tag = 100;
    
    
    [dateView addSubview: today];
    [today addTarget:self action:@selector(todayOnClick) forControlEvents:UIControlEventTouchDown];
    //近2天
    UIButton *twodays =[self getDateButton:@"近3天" Rank:1];
    twodays.tag = 101;
    [dateView addSubview: twodays];
    [twodays addTarget:self action:@selector(twoDaysOnClick) forControlEvents:UIControlEventTouchDown];
    //近5天
    UIButton *fiveDays =[self getDateButton:@"近7天" Rank:2];
    fiveDays.tag = 102;
    [dateView addSubview: fiveDays];
    [fiveDays addTarget:self action:@selector(fivedaysOnClick) forControlEvents:UIControlEventTouchDown];
    
    
    
    //页面加载中图片
    loadingView = [[UIView alloc] init];
    loadingView.frame = CGRectMake(0, 0, screenWidh, ([CommonDimensStyle screenHeight]- [[UIApplication sharedApplication]statusBarFrame].origin.y - [[UIApplication sharedApplication]statusBarFrame].size.height) );
    loadingView.backgroundColor = [CommonFontColorStyle colorFromHexString:@"4D000000"];
    loadingView.hidden = YES;
    [self.view addSubview:loadingView];
    
    //地图放大缩小按钮
    zoomOutBtn =[[UIButton alloc]initWithFrame:CGRectMake((screenWidh - 60),( dateView.gjcf_top -60), 40, 40)];
    [zoomOutBtn setBackgroundImage:[UIImage imageNamed:@"small_btn_map"] forState:UIControlStateNormal];
    [self.view addSubview:zoomOutBtn];
    [zoomOutBtn addTarget:self action:@selector(ZoomOutClick) forControlEvents:UIControlEventTouchDown];
    
    zoomInBtn = [[UIButton alloc]initWithFrame:CGRectMake((screenWidh - 60),( zoomOutBtn.gjcf_top -60), 40, 40)];
    [zoomInBtn setBackgroundImage:[UIImage imageNamed:@"big_btn_map"] forState:UIControlStateNormal];
    [self.view addSubview:zoomInBtn];
    [zoomInBtn addTarget:self action:@selector(ZoomInClick) forControlEvents:UIControlEventTouchDown];
    
}

-(void)ZoomInClick{
    float zoomLevel =  [mapView getMapStatus].fLevel;
    
    if(zoomLevel<=18){
        [mapView zoomIn];
        [zoomInBtn setEnabled:true];
    }else{
//        [self showErrorMessage:@"已经放至最大！"];
        [self.view makeToast:@"已经放至最大" duration:0.5 position:CSToastPositionCenter];
        [zoomInBtn setEnabled:false];
    }
}

-(void)ZoomOutClick{
    float zoomLevel =  [mapView getMapStatus].fLevel;
    
    if(zoomLevel>=3){
        [mapView zoomOut];
        [zoomOutBtn setEnabled:true];
    }else{
//        [self showErrorMessage:@"已经缩至最小！"];
        [self.view makeToast:@"已经缩至最小" duration:0.5 position:CSToastPositionCenter];
        [zoomOutBtn setEnabled:false];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"调用willdisappear方法");
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时，置nil
}

-(void)SetMapCenter:(double)lat longtitude:(double)lot type:(int) t{
    CLLocationCoordinate2D coor;
    coor.latitude = lat;
    coor.longitude = lot;
    
    [mapView clearsContextBeforeDrawing];
    
    //定位
    BMKMapStatus *mMapStatus = [[BMKMapStatus alloc]init];
    mMapStatus.targetGeoPt = coor;
    mMapStatus.fLevel = 12;
    [mapView setMapStatus:mMapStatus];
    
    
    
}

-(void) setEveryPoint:(int )type latitude:(double)lat longitude:(double)lot{
    CLLocationCoordinate2D coor;
    coor.latitude = lat;
    coor.longitude = lot;
    // 设置坐标
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coor;
    [mapView addAnnotation:annotation];
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    // 设置颜色
    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
    ((BMKPinAnnotationView*)newAnnotation).selected = NO;
    
    ((BMKPinAnnotationView*)newAnnotation).canShowCallout = YES;
    
    // 设置可拖拽
    ((BMKPinAnnotationView*)newAnnotation).draggable = YES;
    //设置大头针图标
    [self setBMKIcon:(BMKPinAnnotationView*)newAnnotation Degree: (int)nowDegree];
    
    
    
    
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 135, 30)];
    //设置弹出气泡图片
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map_k_n"]];
    image.frame = CGRectMake(0, 0, 135, 30);
    [popView addSubview:image];
    //自定义显示的内容
    [popView addSubview:[self getSelfLabel:nowDateT x:10 y:3]];
    
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
    pView.frame = CGRectMake(0, 0, 135, 30);
    ((BMKPinAnnotationView*)newAnnotation).paopaoView = nil;
    ((BMKPinAnnotationView*)newAnnotation).paopaoView = pView;
    
    return newAnnotation;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
//    [self showSuccessMessage:@"成功"];
    [self.view makeToast:@"成功" duration:0.5 position:CSToastPositionCenter];
}

-(UILabel *)getSelfLabel:(NSString *)content x:(int)x y:(int)y{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 240, 20)];
    label.text = content;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [CommonFontColorStyle FontNormalColor];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
    
}

-(void) setBMKIcon:(BMKPinAnnotationView *)view Degree:(int)degree{
    
    UIImage *image;
    if (imageflag == 0) {
        image = [UIImage imageNamed:@"ship_track_icon"];
    }else{
        image = [UIImage imageNamed:@"arrow_map"];
    }
    CGPoint cgpoint ;
    cgpoint.x = 0.5;
    cgpoint.y = 0.5;
    view.centerOffset =cgpoint;
    if (degree == 0) {
        ((BMKPinAnnotationView*)newAnnotation).image = image;
    }else{
        UIImage *newPic;
        if (imageflag == 0) {
            newPic =[self imageRotatedByDegrees:image Degree:degree IsScale:YES];
        }else{
            newPic =[self imageRotatedByDegrees:image Degree:degree IsScale:NO];
        }
        
        //        (BMKPinAnnotationView*)newAnnotation.userInteractionEnabled = YES;
        ((BMKPinAnnotationView*)newAnnotation).image = newPic;
    }
}

- (UIImage *)imageRotatedByDegrees:(UIImage *)image Degree:(CGFloat)degreesT IsScale:(BOOL)isScale
{
    int phonescale = 1;
    if (isScale) {
        phonescale = [PhoneStyle phoneScale];
    }
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,phonescale*image.size.width, phonescale*image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degreesT);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, degreesT * M_PI / 180);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-phonescale* image.size.width/2 , -phonescale *image.size.height/2, phonescale*image.size.width, phonescale*image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//- (void)applicationWillResignActive:(UIApplication *)application {
//    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
//}
-(UIButton *)getDateButton:(NSString *)text Rank:(int)rank{
    int width = (screenWidh -40)/3;
    UIButton *dateButton = [[UIButton alloc ]initWithFrame:CGRectMake((10+ rank *(width+10)), 10, width, 40)];
    [dateButton setTitle:text forState:UIControlStateNormal];
    dateButton.titleLabel.font = [CommonFontColorStyle NormalSizeFont];
    
    //未选中状态
    [dateButton setTitleColor:[CommonFontColorStyle BlueColor] forState:UIControlStateNormal];
    [dateButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [dateButton setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle BlueColor] Width:width Height:40] forState:UIControlStateHighlighted];
    [dateButton setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle WhiteColor] Width:width Height:40] forState:UIControlStateNormal];
    [dateButton setBackgroundImage:[UIImage singleColorImage:[CommonFontColorStyle BlueColor] Width:width Height:40] forState:UIControlStateSelected];
    [dateButton setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateHighlighted];
    [dateButton setTitleColor:[CommonFontColorStyle WhiteColor] forState:UIControlStateSelected];
    
    dateButton.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 64.0/255, 151.0/255, 230.0/255, 1 });
    [dateButton.layer setBorderColor:colorref];//边框颜色
    
    dateButton.layer.cornerRadius = 5;
    
    [dateButton addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return dateButton;
}

-(void)BtnClick:(UIButton *)btn
{
    for(int i=100 ;i<103;i++)
    {
        UIButton *button =(UIButton  *)[ self.view viewWithTag:i];
        button.selected = NO;
    }
    btn.selected = YES;
}


/**********************************/

-(void)getShipTrack:(NSDate *)startTime EndTime :(NSDate *)endTime{
    
//    [self.view bringSubviewToFront:self.HUD];
//    [self.HUD show:YES];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if(self.shipId == nil){
//        [self showErrorMessage:@"没有数据"];
        [self.view makeToast:@"没有数据" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    NSString *mmsiLocal = @"";
    if (self.mmsi != nil) {
        mmsiLocal =self.mmsi;
    }
    
    NSString *ipAddress = @"";
    double client_lng = LocationHelper.longitude;
    double client_lat =LocationHelper.latitude;
    NSString *parameterstring = [NSString stringWithFormat:@"\"ship_id\":\"%@\",\"mmsi\":\"%@\",\"startTime\":\"%@\",\"endTime\":\"%@\",\"access_token\":\"%@\",\"ip_address\":\"%@\",\"client_lng\":\"%f\",\"client_lat\":\"%f\"",self.shipId,mmsiLocal,[formatter stringFromDate:startTime],[formatter stringFromDate:endTime],[UseInfo shareInfo].access_token,ipAddress,client_lng,client_lat];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:GetShipPosition URLMethod:QueryShipTrack parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if ([result isEqual:[NSNull null]]) {
            return ;
        }
        
        if (result != nil) {
            NSDictionary *shipTrackresult =[result objectForKey:@"result"];
  
            if ([shipTrackresult isEqual:[NSNull null]]) {
                return;
            }
            
            if ([[shipTrackresult objectForKey:@"status"] boolValue]) {
                NSArray *list = [shipTrackresult objectForKey:@"data"];
    
//               NSArray * list =   @[
//                  @{
//                      @"course" : @"172.7",//角度
//                      @"speed" : @"5.2",
//                      @"postime" : @"1507598348",
//                      @"longitude" : @"117.9726",
//                      @"latitude" : @"31.5087"
//                  },
//                  @{
//                      @"course" : @"172.7",//角度
//                      @"speed" : @"5.2",
//                      @"postime" : @"1507598348",
//                      @"longitude" : @"116.9726",
//                      @"latitude" : @"32.5887"
//                      },
//                  @{
//                      @"course" : @"172.7",//角度
//                      @"speed" : @"5.2",
//                      @"postime" : @"1507598348",
//                      @"longitude" : @"115.2726",
//                      @"latitude" : @"33.4087"
//                      },
//                  @{
//                      @"course" : @"172.7",//角度
//                      @"speed" : @"5.2",
//                      @"postime" : @"1507598348",
//                      @"longitude" : @"114.8726",
//                      @"latitude" : @"34.9087"
//                      },
//                  @{
//                      @"course" : @"172.7",//角度
//                      @"speed" : @"5.2",
//                      @"postime" : @"1507598348",
//                      @"longitude" : @"113.6726",
//                      @"latitude" : @"35.4087"
//                      },
//
//                  ];
    
                
                if(list != NULL &&[list count] >0){
                    shipTracksModels = [[NSMutableArray alloc]init];
                    for(int i = 0; i < list.count;i ++){
                        ShipTrackModel *shipTrackModel = [ShipTrackModel mj_objectWithKeyValues:(NSDictionary *)list[i]];
                        [shipTracksModels addObject:shipTrackModel];
                    }
                    if (shipTracksModels != nil && shipTracksModels.count >0) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self showPoints];
                        });
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self showErrorMessage:@"没有数据"];
                            [self.view makeToast:@"没有数据" duration:1.0 position:CSToastPositionCenter];
                        });
                    }
                    
                }else{
//                    [self showErrorMessage:@"没有数据"];
                    [self.view makeToast:@"没有数据" duration:1.0 position:CSToastPositionCenter];
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"没有返回数据");
                    [self.view makeToast:[shipTrackresult objectForKey:@"msg"] duration:1.0 position:CSToastPositionCenter];
                });
            }
    
        }
    
        
        

    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
}


-(void)showPoints{
    [mapView removeOverlays:mapView.overlays];
    [mapView removeAnnotations:mapView.annotations];
    
    
    //获取坐标列表
    NSMutableArray *points = [[NSMutableArray alloc]init];
    
    for (int i= 0; i<shipTracksModels.count; i++) {
        CLLocationCoordinate2D coor;
        NSString *latitudet =((ShipTrackModel *)shipTracksModels[i]).latitude;
        coor.latitude =GJCFStringToDouble(latitudet);
        NSString *longitudet =((ShipTrackModel *)shipTracksModels[i]).longitude;
        coor.longitude =  GJCFStringToDouble(longitudet);
        NSValue *value = nil;
        value = [NSValue valueWithBytes:&coor objCType:@encode(CLLocationCoordinate2D)];
        [points addObject:value];
    }
    
    
    //读取
    double x1 =GJCFStringToDouble(((ShipTrackModel *)shipTracksModels[0]).latitude);
    double y1 =GJCFStringToDouble(((ShipTrackModel *)shipTracksModels[0]).longitude);
    double x2 =GJCFStringToDouble(((ShipTrackModel *)shipTracksModels[0]).latitude);
    double y2 =GJCFStringToDouble(((ShipTrackModel *)shipTracksModels[0]).longitude);
    for (NSValue *value in points) {
        
        CLLocationCoordinate2D coor;
        [value getValue:&coor];
        
        if (coor.latitude < x1) {
            x1 =coor.latitude;
        }
        if (coor.latitude > x2) {
            x2 =coor.latitude;
        }
        if (coor.longitude < y1) {
            y1 =coor.longitude;
        }
        if (coor.longitude > y2) {
            y2 =coor.longitude;
        }
    }
    
    //设置中心点
    CLLocationCoordinate2D coor;
    coor.latitude =(x1 +x2)/2;
    coor.longitude = (y1 +y2)/2;
    
    BMKMapStatus *mMapStatus = [[BMKMapStatus alloc]init];
    mMapStatus.targetGeoPt = coor;
//    [self hideLoading];
    //放大缩小倍数
    double longdistance  = [self getDistance:y1 Lot2:y2 Lat1:x1 Lat2:x2];
    if (longdistance <500) {
        mMapStatus.fLevel = 13;
        [mapView setMapStatus:mMapStatus];
        
        // 设置坐标
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = coor;
        nowDegree  =[GJCFStringUitil stringToInt:((ShipTrackModel *)shipTracksModels[0]).course] ;
        nowDateT  =[DateHelper StringDateStampToMinitesString:((ShipTrackModel *)shipTracksModels[0]).postime] ;
        imageflag = 0;
        [mapView addAnnotation:annotation];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self hideLoading];
            
        });
    }else{
        int zoomnumber = 10;
        if (longdistance < 200) {
            zoomnumber = 19;
        } else if (200. < longdistance && longdistance < 500) {
            zoomnumber = 18;
        } else if (500 < longdistance && longdistance < 1000) {
            zoomnumber = 17;
        } else if (1000 < longdistance && longdistance < 2000) {
            zoomnumber = 16;
        } else if (2000 < longdistance && longdistance < 5000) {
            zoomnumber = 13;
        } else if (5000 < longdistance && longdistance < 10000) {
            zoomnumber = 15;
        } else if (10000 < longdistance && longdistance < 20000) {
            zoomnumber = 14;
        } else if (20000 < longdistance && longdistance < 25000) {
            zoomnumber = 13;
        } else if (25000 < longdistance && longdistance < 50000) {
            zoomnumber = 12;
        } else if (50000 < longdistance && longdistance < 100000) {
            zoomnumber = 11;
        } else if (100000 < longdistance && longdistance < 200000) {
            zoomnumber = 10;
        } else if (200000 < longdistance && longdistance < 500000) {
            zoomnumber = 9;
        } else if (500000 < longdistance && longdistance < 1000000) {
            zoomnumber = 8;
        } else if (1000000 < longdistance) {
            zoomnumber = 7;
        }
        mMapStatus.fLevel = zoomnumber;
        [mapView setMapStatus:mMapStatus];
        
        //直角坐标划线
        CLLocationCoordinate2D * temppoints =(CLLocationCoordinate2D *) (malloc([shipTracksModels count] * sizeof(CLLocationCoordinate2D)));
        for (NSInteger i = 0; i < [shipTracksModels count]; i++) {
            ShipTrackModel* itemshipTrackModel = [shipTracksModels objectAtIndex:i];
            
            CLLocationCoordinate2D item;
            item.latitude = GJCFStringToDouble(itemshipTrackModel.latitude);
            item.longitude = GJCFStringToDouble(itemshipTrackModel.longitude);
            temppoints[i] = item;
            
        }
        
        BMKPolyline *myPolyline = [BMKPolyline polylineWithCoordinates:temppoints count:[shipTracksModels count]];
        [mapView addOverlay:myPolyline];
        
        
        //设置坐标
        //设置起点
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        ShipTrackModel *shipTrackModel =(ShipTrackModel *)shipTracksModels[0];
        CLLocationCoordinate2D coor0;
        coor0.latitude =[GJCFStringUitil stringToDouble:shipTrackModel.latitude];
        coor0.longitude = [GJCFStringUitil stringToDouble:shipTrackModel.longitude];
        annotation.coordinate = coor0;
        nowDegree  =[GJCFStringUitil stringToInt:shipTrackModel.course] ;
        nowDateT  =[DateHelper StringDateStampToMinitesString:shipTrackModel.postime] ;
        imageflag = 0;
        [mapView addAnnotation:annotation];
        
        for (int i = 1; i<(shipTracksModels.count -1); i++) {
            BMKPointAnnotation* itemannotation = [[BMKPointAnnotation alloc]init];
            ShipTrackModel *itemshipTrackModel =(ShipTrackModel *)shipTracksModels[i];
            CLLocationCoordinate2D itemcoor;
            itemcoor.latitude =[GJCFStringUitil stringToDouble:itemshipTrackModel.latitude];
            itemcoor.longitude = [GJCFStringUitil stringToDouble:itemshipTrackModel.longitude];
            itemannotation.coordinate = itemcoor;
            
            //绘制角度
            ShipTrackModel *nextshipTrackModel =(ShipTrackModel *)shipTracksModels[i+1];
            double nextlongitude =[GJCFStringUitil stringToDouble:nextshipTrackModel.longitude];
            double nextlatitude =[GJCFStringUitil stringToDouble:nextshipTrackModel.latitude];
            
            double xie = sqrt((nextlongitude - itemcoor.longitude) * (nextlongitude - itemcoor.longitude) + (nextlatitude - itemcoor.latitude) * (nextlatitude - itemcoor.latitude));
            //            if (xie >0){
            nowDateT  =[DateHelper StringDateStampToMinitesString:nextshipTrackModel.postime] ;
            nowDegree = asin((nextlongitude - itemcoor.longitude) / xie) * 180 /M_PI ;
            //            }
            if ((nextlatitude - itemcoor.latitude) < 0) {
                nowDegree = 540 - nowDegree;
            }
            if(nowDegree <0){
                nowDegree = nowDegree + 360;
            }
            else if(nowDegree >360){
                nowDegree = nowDegree - 360;
            }
            imageflag = 1;
            
            [mapView addAnnotation:itemannotation];
        }
        //设置终点
        BMKPointAnnotation* lastannotation = [[BMKPointAnnotation alloc]init];
        ShipTrackModel *lastshipTrackModel =(ShipTrackModel *)shipTracksModels[shipTracksModels.count -1];
        CLLocationCoordinate2D lastcoor;
        lastcoor.latitude =[GJCFStringUitil stringToDouble:lastshipTrackModel.latitude];
        lastcoor.longitude = [GJCFStringUitil stringToDouble:lastshipTrackModel.longitude];
        lastannotation.coordinate = lastcoor;
        nowDateT  =[DateHelper StringDateStampToMinitesString:lastshipTrackModel.postime] ;
        nowDegree  =[GJCFStringUitil stringToInt:lastshipTrackModel.course] ;
        imageflag = 0;
        [mapView addAnnotation:lastannotation];
    }
    
    
}

// Override
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 2.0;
        
        return polylineView;
    }
    return nil;
}

-(double)getDistance:(double)lot1 Lot2:(double)lot2 Lat1:(double)lat1 Lat2:(double)lat2{
    //    double x,y,distance;
    double R = 6371229;//地球半径
    //    x = (lot2-lot1)*M_PI*R*cos(((lat1+lat2)/2)*M_PI/180)/180;
    //    y = (lat2 - lat1)*M_PI*R /180;
    //    distance = hypot(x, y);
    
    
    double radLat1 = [self rad:lat1];
    double radLat2 = [self rad:lat2];
    double a = radLat1 - radLat2;
    double b = [self rad:lot1] - [self rad:lot2];
    
    double s = 2 * asin(sqrt(pow(sin(a/2),2) +
                             cos(radLat1)*cos(radLat2)*pow(sin(b/2),2)));
    s = s * R;
    s = round(s * 10000) / 10000;
    return s;
}

-(double) rad:(double) d
{
    return d * M_PI / 180.0;
}

-(void)todayOnClick{
    //    [self showLoading];
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth  | NSCalendarUnitDay |NSCalendarUnitWeekday| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:nowDate];
    long day=[comps day];//获取日期对应的长整形字符串
    long year=[comps year];//获取年对应的长整形字符串
    long month=[comps month];//获取月对应的长整形字符串
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    NSCalendar *calendarT = NSCalendar.currentCalendar;
    NSDate *headDate = [calendarT dateFromComponents:dateComponents];
    [self getShipTrack:headDate EndTime:nowDate];
    
    
    //    [NSDate ]
}

-(void)twoDaysOnClick{
    //    [self showLoading];
    NSDate *nowDate = [NSDate date];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-4*24*60*60 sinceDate:nowDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth  | NSCalendarUnitDay |NSCalendarUnitWeekday| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:lastDay];
    long day=[comps day];//获取日期对应的长整形字符串
    long year=[comps year];//获取年对应的长整形字符串
    long month=[comps month];//获取月对应的长整形字符串
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    NSCalendar *calendarT = NSCalendar.currentCalendar;
    NSDate *headDate = [calendarT dateFromComponents:dateComponents];
    [self getShipTrack:headDate EndTime:nowDate];
}

-(void)fivedaysOnClick{
    //    [self showLoading];
    NSDate *nowDate = [NSDate date];
    NSDate *lastfiveDay = [NSDate dateWithTimeInterval:-8*24*60*60 sinceDate:nowDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth  | NSCalendarUnitDay |NSCalendarUnitWeekday| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:lastfiveDay];
    long day=[comps day];//获取日期对应的长整形字符串
    long year=[comps year];//获取年对应的长整形字符串
    long month=[comps month];//获取月对应的长整形字符串
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    NSCalendar *calendarT = NSCalendar.currentCalendar;
    NSDate *headDate = [calendarT dateFromComponents:dateComponents];
    [self getShipTrack:headDate EndTime:nowDate];
}

-(void)backOnclick{
    [self.navigationController popViewControllerAnimated:YES];
    //    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)SetMapInit{
    CLLocationCoordinate2D coor;
    coor.latitude = [GJCFStringUitil stringToDouble:self.lat];
    coor.longitude = [GJCFStringUitil stringToDouble:self.lot];
    
    [mapView removeOverlays:mapView.overlays];
    
    //定位
    BMKMapStatus *mMapStatus = [[BMKMapStatus alloc]init];
    mMapStatus.targetGeoPt = coor;
    mMapStatus.fLevel = 12;
    [mapView setMapStatus:mMapStatus];
    
    
    // 设置坐标
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coor;
    [mapView addAnnotation:annotation];
}











@end
