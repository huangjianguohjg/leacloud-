//
//  ShipMapViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ShipMapViewController.h"
#import "ShipPositionModel.h"
#import "ShipTracksController.h"
@interface ShipMapViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,UITextFieldDelegate>

@property (nonatomic, weak) BMKMapView* mapView;

@property (nonatomic, weak) UIButton * zoomInButton;

@property (nonatomic, weak) UIButton * zoomOutButton;

@property (nonatomic, weak) UIView * showView;

@property (nonatomic, strong) UITextField *invideCodeText;

@property (nonatomic, strong) ShipPositionModel * shipPositionModel;

@property (nonatomic, assign) double latitudeT;
@property (nonatomic, assign) double longitudeT;


@property(nonatomic,strong) UILabel *titleLabel;//船名
@property(nonatomic,strong) UILabel *boatSpeedContentLabel;//船速
@property(nonatomic,strong) UILabel *boatUpdateTimeContentLabel;//轨迹向
@property(nonatomic,strong) UILabel *boatTrackContentLabel;//轨迹向

@property(nonatomic,strong) BMKPinAnnotationView *annotation;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;

@property (nonatomic, copy) NSString *nowLocation;

@end

@implementation ShipMapViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
        _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [BMKMapView enableCustomMapStyle:YES];
    
    self.locationHelper = [LocationHelper new];
    [self.locationHelper startInit];
    
    [self getBoatInfo:self.shipName];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.navigationItem.title = @"化运网";
    
    [self setUpUI];
    
    _locService = [[BMKLocationService alloc]init];//定位功能的初始化
    _locService.delegate = self;//设置代理位self
    //启动LocationService
    [_locService startUserLocationService];//启动定位服务
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _geocodesearch.delegate = self;//设置代理为self
    
    [self getBoatInfo:self.shipName];
    [self getBoatInfo:self.shipName];
}




-(void)setUpUI
{
    BMKMapView * mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
//    mapView.delegate = self;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    annotation.coordinate = CLLocationCoordinate2DMake(39.915, 116.404);
//    annotation.title = @"这里是北京";
//    [_mapView addAnnotation:annotation];
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 170/255, 170/255, 170/255, 0.2 });
//    CGFloat margin = 0;
//    if (isIPHONEX) {
//        margin = 34;
//    }
    CGFloat w = (SCREEN_WIDTH - realW(20) * 3) / 2;
    CGFloat h = realH(120);
    
    //航行轨迹
    UIButton *  trackButton = [[UIButton alloc]init];
    [trackButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [trackButton setTitle:@"航行轨迹" forState:UIControlStateNormal];
    [trackButton setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
    trackButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [trackButton setBackgroundImage:[UIImage imageNamed:@"package_bg"] forState:UIControlStateNormal];
    [trackButton setImage:[UIImage imageNamed:@"gps_map"] forState:UIControlStateNormal];
    [trackButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(20)];
    trackButton.layer.borderColor = colorref;
    trackButton.layer.borderWidth = realW(1);
    trackButton.layer.cornerRadius = realW(5);
    trackButton.clipsToBounds = YES;
    [self.view addSubview:trackButton];
    [trackButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(realW(20));
        make.bottom.equalTo(self.view).offset( - realH(80));
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - realW(40), h));
    }];
    
    
    //视频监控
    UIButton *  videoButton = [[UIButton alloc]init];
    videoButton.alpha = 0;
    [videoButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [videoButton setTitle:@"视频监控" forState:UIControlStateNormal];
    [videoButton setTitleColor:[CommonFontColorStyle FontNormalColor] forState:UIControlStateNormal];
    videoButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [videoButton setBackgroundImage:[UIImage imageNamed:@"package_bg"] forState:UIControlStateNormal];
    [videoButton setImage:[UIImage imageNamed:@"monitor_map"] forState:UIControlStateNormal];
    [videoButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(20)];
    videoButton.layer.borderColor = colorref;
    videoButton.layer.borderWidth = realW(1);
    videoButton.layer.cornerRadius = realW(5);
    videoButton.clipsToBounds = YES;
    [self.view addSubview:videoButton];
    [videoButton makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.centerX).offset(realW(10));
        make.left.equalTo(self.view).offset(realW(20));
        make.bottom.equalTo(self.view).offset( - realH(80));
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - realW(40), h));
    }];
    
    
    //缩小
    UIButton * zoomOutButton = [[UIButton alloc]init];
    [zoomOutButton addTarget:self action:@selector(outClick) forControlEvents:UIControlEventTouchUpInside];
    [zoomOutButton setBackgroundImage:[UIImage imageNamed:@"small_btn_map"] forState:UIControlStateNormal];
    [self.view addSubview:zoomOutButton];
    [zoomOutButton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(videoButton.top).offset(realH(-40));
        make.right.equalTo(self.view).offset(realW(-40));
        make.size.equalTo(CGSizeMake(realW(80), realH(80)));
    }];
    self.zoomOutButton = zoomOutButton;
    
    //放大
    UIButton * zoomInButton = [[UIButton alloc]init];
    [zoomInButton addTarget:self action:@selector(inClick) forControlEvents:UIControlEventTouchUpInside];
    [zoomInButton setBackgroundImage:[UIImage imageNamed:@"big_btn_map"] forState:UIControlStateNormal];
    [self.view addSubview:zoomInButton];
    [zoomInButton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(zoomOutButton.top).offset(realH(-40));
        make.right.equalTo(self.view).offset(realW(-40));
        make.size.equalTo(CGSizeMake(realW(80), realH(80)));
    }];
    self.zoomInButton = zoomInButton;
    
    
    UIView * showView = [[UIView alloc]initWithFrame:CGRectMake([CommonDimensStyle smallMargin],((SCREENHEIGHT - 200)/2-80), (SCREENWIDTH - 2*[CommonDimensStyle smallMargin]), 200)];
    showView.alpha = 0;
    showView.layer.cornerRadius = [CommonDimensStyle normalCornerRadius];
    showView.backgroundColor = [CommonFontColorStyle WhiteColor];
    [self.view addSubview:showView];
    self.showView = showView;
}


-(void)buttonClick:(UIButton *)button
{
    if ([button.currentTitle isEqualToString:@"航行轨迹"]) {
        ShipTracksController *shipTracksController = [[ShipTracksController alloc]init];
        shipTracksController.shipId = self.boatId;
        shipTracksController.mmsi = self.mmsi;
        shipTracksController.lat =[NSString stringWithFormat:@"%f",_latitudeT];
        shipTracksController.lot =[NSString stringWithFormat:@"%f",_longitudeT];
        [self.navigationController pushViewController:shipTracksController animated:YES];
    }
    else
    {
        //视频监控
        [self getHasMonitor];
    }
}



#pragma mark -- 缩小
-(void)outClick
{
    float zoomLevel = [self.mapView getMapStatus].fLevel;
    if(zoomLevel>=5){
        [self.mapView zoomOut];
        [self.zoomInButton setEnabled:true];
    }else{
        [self.view makeToast:@"已经缩至最小！" duration:0.5 position:CSToastPositionCenter];
        [self.zoomOutButton setEnabled:false];
    }
}

#pragma mark -- 放大
-(void)inClick
{
    float zoomLevel = [self.mapView getMapStatus].fLevel;
    if(zoomLevel<=18){
        [self.mapView zoomIn];
        [self.zoomOutButton setEnabled:true];
    }else{
        [self.view makeToast:@"已经放至最大！" duration:0.5 position:CSToastPositionCenter];
        [self.zoomInButton setEnabled:false];
    }
}


/**
 *  获得船舶信息
 *
 *  @param shipName 船名
 */
-(void)getBoatInfo:(NSString *)shipName
{
    NSString *accesstokenT = [UseInfo shareInfo].access_token;
    NSString *ipAddress = @"";
    double client_lng = LocationHelper.longitude;
    double client_lat =LocationHelper.latitude;
    double client_accuracy =  LocationHelper.horizontalAccuracy;

    NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\",\"mmsi\":\"%@\",\"access_token\":\"%@\",\"source\":\"2\",\"ip_address\":\"%@\",\"client_lng\":\"%f\",\"client_lat\":\"%f\",\"client_speed\":\"0\",\"client_accuracy\":\"%f\"",self.shipName,@"",accesstokenT,ipAddress,client_lng,client_lat,client_accuracy];

    [SVProgressHUD show];

    [XXJNetManager requestPOSTURLString:GetShipPosition URLMethod:GetShipPositionMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];

        if (result != nil) {

            //展示结果

            NSDictionary * dict =[result objectForKey:@"result"];
    
//             NSDictionary * dict = @{
//                     @"status" : @"1",
//                     @"mmsi" : @"413996873",
//                     @"longitude" : @"117.9726",
//                     @"latitude" : @"31.5087",
//                     @"navStatus" : @"在航(主机推动)",
//                     @"speed" : @"3.04",
//                     @"heading" : @"511",
//                     @"course" : @"172.7",
//                     @"postime" : @"1507598348",
//                     @"fromLocation" : @"来自港口网",
//                     @"has_monitor" : @"",
//                     @"ship_id" : @"",
//                     @"fangxiang" : @"",
//
//                     };
    
            
            dispatch_async(dispatch_get_main_queue(), ^{
    
                if ([[dict objectForKey:@"status"]boolValue]) {
                    _shipPositionModel =[ShipPositionModel mj_objectWithKeyValues:dict];
                    
                    self.boatSpeedContentLabel.text =[_shipPositionModel.speed stringByAppendingString:@"节"];
                    
                    self.boatTrackContentLabel.text= _shipPositionModel.heading;//轨
                    
                    
                    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    self.boatUpdateTimeContentLabel.text =[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_shipPositionModel.postime longLongValue]]];
                    
                    //船编号
                    double latitude = GJCFStringToDouble(_shipPositionModel.latitude);
                    double longitude =  GJCFStringToDouble(_shipPositionModel.longitude);
                    
                    _latitudeT = latitude;
                    _longitudeT = longitude;
                    
                    if (![GJCFStringUitil stringIsNull:_shipPositionModel.mmsi]) {
                        self.mmsi = _shipPositionModel.mmsi;
                    }
                    
                    [self SetMapCenter:latitude longtitude:longitude type:2];
                }else{
                    [self.view makeToast:[dict objectForKey:@"msg"] duration:1.0 position:CSToastPositionCenter];
                    NSString *token =  [UseInfo shareInfo].access_token;
                    
                    if([GJCFStringUitil stringIsNull:token]){
                        [self.view makeToast:@"请先登录" duration:1.0 position:CSToastPositionCenter];

                    }
                }
            });


        }




    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}


/**
 *  设置船的指示图标
 *
 *  @param lat 经度
 *  @param lot 纬度
 *  @param t   类型
 */
-(void)SetMapCenter:(double)lat longtitude:(double)lot type:(int) t{
    CLLocationCoordinate2D coor;
    coor.latitude = lat;
    coor.longitude = lot;
    
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    //    [mapView clearsContextBeforeDrawing];
    
    //定位
    BMKMapStatus *mMapStatus = [[BMKMapStatus alloc]init];
    mMapStatus.targetGeoPt = coor;
    mMapStatus.fLevel = 12;
    [self.mapView setMapStatus:mMapStatus];
    
    
    // 设置坐标
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coor;
    [self.mapView addAnnotation:annotation];
}


/**
 *  根据anntation生成对应的View
 *
 *  @param mapView    地图
 *  @param annotation annotation
 *
 *  @return 生成的弹出图
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    self.annotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    // 设置颜色
    ((BMKPinAnnotationView*)self.annotation).pinColor = BMKPinAnnotationColorPurple;
    ((BMKPinAnnotationView*)self.annotation).selected = YES;
    // 设置可拖拽
    ((BMKPinAnnotationView*)self.annotation).draggable = YES;
    //设置大头针图标
    
    [self setBMKIcon:(BMKPinAnnotationView*)self.annotation Degree: (int)GJCFStringToDouble(_shipPositionModel.course)];
    //    ((BMKPinAnnotationView*)newAnnotation).image = [UIImage imageNamed:@"dw_icon"];
    
    self.popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 110)];
    
    
    
    //设置弹出气泡图片
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map_k_n"]];
    image.frame = CGRectMake(0, 0, 260, 110);
    [self.popView addSubview:image];
    //自定义显示的内容
    //船名
    [self.popView addSubview:[self getSelfLabel:[NSString stringWithFormat:@"船名：%@",self.shipName] x:10 y:3]];
    
    //船速
    double shipSpeed =[GJCFStringUitil stringToDouble:_shipPositionModel.speed];
    NSString *boatspeed =[NSString stringWithFormat:@"%.1f", shipSpeed];
    if ([[boatspeed substringFromIndex:boatspeed.length-2] isEqualToString:@".0"]) {
        boatspeed = [boatspeed substringToIndex:boatspeed.length-2];
    }
    
    double kmShipSpeed =shipSpeed *1.852;
    NSString *kmboatspeed =[NSString stringWithFormat:@"%.1f", kmShipSpeed];
    if ([[kmboatspeed substringFromIndex:kmboatspeed.length-2] isEqualToString:@".0"]) {
        kmboatspeed = [kmboatspeed substringToIndex:kmboatspeed.length-2];
    }
    
    [self.popView addSubview:[self getSelfLabel:[NSString stringWithFormat:@"航速：%@节·%@km/h   航向：%@度",boatspeed,kmboatspeed,_shipPositionModel.course] x:10 y:25]];
    
    
    [self ReverseGeocode:_latitudeT lon:_longitudeT];
    
    
    
    //最后上报时间
    long uploadtime = [_shipPositionModel.postime longLongValue];
    NSDate *data = [NSDate dateWithTimeIntervalSince1970:uploadtime];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [self.popView addSubview:[self getSelfLabel:[NSString stringWithFormat:@"最后上报时间：%@",[formatter stringFromDate:data]] x:10 y:70]];
    
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:self.popView];
    pView.frame = CGRectMake(0, 0, 260, 110);
    ((BMKPinAnnotationView*)self.annotation).paopaoView = nil;
    ((BMKPinAnnotationView*)self.annotation).paopaoView = pView;
    return self.annotation;
}


/**
 *  生成有角度的icon
 *
 *  @param view   地图的图片
 *  @param degree 角度
 */
-(void) setBMKIcon:(BMKPinAnnotationView *)view Degree:(int)degree{
    
    UIImage *image = [UIImage imageNamed:@"ship_track_icon"];
    if (degree == 0) {
        ((BMKPinAnnotationView*)self.annotation).image = image;
    }else{
        UIImage *newPic =[self imageRotatedByDegrees:image Degree:degree IsScale:YES];
        ((BMKPinAnnotationView*)self.annotation).image = newPic;
    }
}

/**
 *  生成弹出的label
 *
 *  @param content label的内容
 *  @param x       label的x
 *  @param y       label的y
 *
 *  @return label视图
 */
-(UILabel *)getSelfLabel:(NSString *)content x:(int)x y:(int)y{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 250, 20)];
    label.text = content;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [CommonFontColorStyle FontNormalColor];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
    
}

/**
 *  生成有角度的图片
 *
 *  @param image   原始的图片
 *  @param degrees 旋转角度
 *  @param isScale 图片是否放缩
 *
 *  @return 旋转角度后的图片
 */
- (UIImage *)imageRotatedByDegrees:(UIImage *)image Degree:(CGFloat)degrees IsScale:(BOOL)isScale
{
    int phonescale = 1;
    if (isScale) {
        phonescale = [PhoneStyle phoneScale];
    }
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,phonescale*image.size.width, phonescale*image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-phonescale* image.size.width/2 , -phonescale *image.size.height/2, phonescale*image.size.width, phonescale*image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(void)ReverseGeocode:(double)lat lon:(double)lon  //发送反编码请求的.
{
    
    NSLog(@"定位的经度:%f,定位的纬度:%f",_locService.userLocation.location.coordinate.longitude,_locService.userLocation.location.coordinate.latitude);
    
    NSLog(@"发送的经度:%f,定位的纬度:%f",lat,lon);
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){lat, lon};//初始化
    
    BMKReverseGeoCodeSearchOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeSearchOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.location = pt;//设置反编码的店为pt
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    
    if (error == 0) {
        
        _nowLocation = [NSString stringWithFormat:@"%@ %@ %@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district];
        
        UILabel * lable = [self getSelfLabel:[NSString stringWithFormat:@"位置：%@ %@ %@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district] x:10 y:47];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.popView addSubview:lable];
        });
        
        
    }
}


















#pragma mark -- 视频监控点击
-(void)getHasMonitor
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"ship_id\":\"%@\",\"access_token\":\"%@\"",self.boatId,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:MonitorClass URLMethod:GetMonitorListMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            NSDictionary * dict =[result objectForKey:@"result"];
            if ([dict isEqual:[NSNull null]]) {
                return ;
            }
            if ([[dict objectForKey:@"status"]boolValue]) {
                NSArray *resultArray = [result allKeys];
                @try {
                    if ([resultArray containsObject:@"0"]) {
                        [self isCanMonitor];
                    }else{
                        //弹出购买设备
                        [self showWarn:2];
                    }
                } @catch (NSException *ex) {
                    
                }
                
            }else{
                
                [self.view makeToast:[dict objectForKey:@"msg"] duration:1.0 position:CSToastPositionCenter];
            }
            
            
            
            
            
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}



//是否需要输入邀请码
-(void)isCanMonitor{
    NSString *parameterstring = [NSString stringWithFormat:@"\"ship_id\":\"%@\",\"access_token\":\"%@\",\"view_from\":\"%@\",\"source\":\"2\"",self.boatId,[UseInfo shareInfo].access_token,@""];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:MonitorClass URLMethod:CheckMonitorRights parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *dict =[result objectForKey:@"result"];
            
            if ([[dict objectForKey:@"status"]boolValue]) {
                
                [self getMonitorList];
                
            }else{
                if ([dict objectForKey:@"code"] != nil) {
                    
                    NSString *codeString =[NSString stringWithFormat:@"%@",[result objectForKey:@"code"]];
                    
                    long code =[GJCFStringUitil stringToInt:codeString];
                    //弹出有几人正在观看
                    if (code == 6102) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.view makeToast:[dict objectForKey:@"msg"] duration:1.0 position:CSToastPositionCenter];
                        });
                        
                    }else{
                        //弹出输入邀请码
                        [self showWarn:1];
                    }
                }else{
                    //弹出输入邀请码
                    [self showWarn:1];
                }
            }
        }
  
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}



/**
 *  获得通道列表
 */
-(void)getMonitorList
{
    NSString *parameterstring = [NSString stringWithFormat:@"\"ship_id\":\"%@\",\"access_token\":\"%@\"",self.boatId,[UseInfo shareInfo].access_token];
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:MonitorClass URLMethod:GetMonitorListMethod parameters:parameterstring finished:^(id result) {
        
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *dict =[result objectForKey:@"result"];
            if ([[dict objectForKey:@"status"]boolValue]) {
                NSArray *resultArray = [result allKeys];
                
                if (resultArray.count -1 == 0) {
                    [self.view makeToast:@"没有监控设备" duration:1.0 position:CSToastPositionCenter];
                }else{
                    [self turnVideoList];
                    
                }
            }
        }
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}



-(void)turnVideoList{
//    MonitorListController *shipTracksController = [[MonitorListController alloc]init];
//    shipTracksController.shipId = self.boatId;
//    shipTracksController.mmsi = self.mmsi;
//    shipTracksController.boatName =self.boatName;
//    [self.navigationController pushViewController:shipTracksController animated:YES];
}


-(void)showWarn:(int)number
{
    NSArray *subviews =  [self.showView subviews ];
    if (subviews.count > 0) {
        for(UIView *subview in subviews)
        {
            [subview removeFromSuperview];
        }
    }
    
    self.showView.alpha = 1;
    
    int buttonWidh = (SCREENWIDTH - 5*[CommonDimensStyle smallMargin])/2;
    
    switch (number) {
            //邀请码
        case 1:{
            UILabel *invidecodeLabel = [[UILabel alloc]init];
            invidecodeLabel.frame = CGRectMake(0, [CommonDimensStyle smallMargin], self.showView.frame.size.width, 40) ;
            invidecodeLabel.text = @"邀请码";
            invidecodeLabel.font = [CommonFontColorStyle superSizeFont];
            invidecodeLabel.textAlignment = NSTextAlignmentCenter;
            [self.showView addSubview:invidecodeLabel];
            
            
            self.invideCodeText = [[UITextField alloc]initWithFrame: CGRectMake([CommonDimensStyle smallMargin], (invidecodeLabel.gjcf_bottom + [CommonDimensStyle smallMargin]), (SCREENWIDTH - 4*[CommonDimensStyle smallMargin]), [CommonDimensStyle inputHeight])];
            self.invideCodeText.placeholder = @"请输入邀请码查看监控";
            self.invideCodeText.textColor = [CommonFontColorStyle FontImportColor];
            self.invideCodeText.delegate = self;
            [self.invideCodeText addTarget:self action:@selector(invideCodeTextDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            [self.invideCodeText  setKeyboardType:UIKeyboardTypeDecimalPad];
            self.invideCodeText.font = [CommonFontColorStyle InputTextFont];
            
            self.invideCodeText.borderStyle = UITextBorderStyleRoundedRect;
            [self.showView addSubview:self.invideCodeText];
            
            UIButton *closeButton = [UIButton getNormalButton:@"关闭" X:[CommonDimensStyle smallMargin] Y:(self.invideCodeText.gjcf_bottom+[CommonDimensStyle topMargin]) Width:buttonWidh Height:[CommonDimensStyle inputHeight] type:1];
            [self.showView addSubview:closeButton];
            [closeButton addTarget:self action:@selector(closeshowView) forControlEvents:UIControlEventTouchDown];
            
            UIButton *confirmButton = [UIButton getNormalButton:@"确认" X:(2*[CommonDimensStyle smallMargin]+buttonWidh) Y:(self.invideCodeText.gjcf_bottom+[CommonDimensStyle topMargin]) Width:buttonWidh Height:[CommonDimensStyle inputHeight] type:0];
            [confirmButton addTarget:self action:@selector(inputInvidecode) forControlEvents:UIControlEventTouchDown];
            [self.showView addSubview:closeButton];
            [self.showView addSubview:confirmButton];
            //            [self.view bringSubviewToFront:backgroudView];
            //            [self.view bringSubviewToFront:showView];
            [self.invideCodeText becomeFirstResponder];
            break;
        }
            //购买设备
        case 2:{
            UIImageView *equipImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.showView.frame.size.width - 40)/2, [CommonDimensStyle normalMargin], 50, 50)];
            equipImageView.image = [UIImage imageNamed:@"camera_icon_p"];
            [self.showView addSubview:equipImageView];
            
            UILabel *equipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (equipImageView.gjcf_bottom+[CommonDimensStyle normalMargin]), self.showView.gjcf_width, 30)];
            equipLabel.text = @"该船舶未安装监控设备";
            equipLabel.font = [CommonFontColorStyle superSizeFont];
            equipLabel.textAlignment = NSTextAlignmentCenter;
            [self.showView addSubview:equipLabel];
            
            UIButton *equipcloseButton = [UIButton getNormalButton:@"关闭" X:[CommonDimensStyle smallMargin] Y:(equipLabel.gjcf_bottom+[CommonDimensStyle topMargin]) Width:buttonWidh Height:[CommonDimensStyle inputHeight] type:1];
            [self.showView addSubview:equipcloseButton];
            [equipcloseButton addTarget:self action:@selector(closeshowView) forControlEvents:UIControlEventTouchDown];
            
            UIButton *dinggouButton = [UIButton getNormalButton:@"订购咨询" X:(2*[CommonDimensStyle smallMargin]+buttonWidh) Y:(equipLabel.gjcf_bottom+[CommonDimensStyle topMargin]) Width:buttonWidh Height:[CommonDimensStyle inputHeight] type:0];
            [dinggouButton addTarget:self action:@selector(dinggouclick) forControlEvents:UIControlEventTouchDown];
            [self.showView addSubview:equipcloseButton];
            [self.showView addSubview:dinggouButton];
            
            break;
        }
    }

}


//邀请码输入事件
- (void) invideCodeTextDidChange:(UITextField *) TextField{
    NSString *name = TextField.text;
    if (name.length > 8) {
        name =[name substringToIndex:8];
        TextField.text = name;
    }
}


-(void)closeshowView{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.showView.alpha = 0;
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    });
}


-(void)inputInvidecode{
    
    [self closeshowView];
    //    [self showLoading];
    
    NSString *invideCode =  self.invideCodeText.text;
    
    NSString *parameters = [NSString stringWithFormat:@"\"ship_id\":\"%@\",\"monitor_code\":\"%@\",\"access_token\":\"%@\",\"source\":\"2\"",self.boatId,invideCode,[UseInfo shareInfo].access_token];
    
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:MonitorClass URLMethod:CheckMonitorCodeMethod parameters:parameters finished:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result != nil) {
            NSDictionary *dict =[result objectForKey:@"result"];
            
            
            if ([[dict objectForKey:@"status"]boolValue]) {
                [self isCanMonitor];
                //                [self loginHandle];
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.view makeToast:[dict objectForKey:@"msg"] duration:1.0 position:CSToastPositionCenter];
                });
            }
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
    
    
}



//订购咨询
-(void)dinggouclick{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否拨打客服热线" message:@"025-85326660" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
//    alertView.delegate = self;
//    [alertView show];
    
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"025-85326660"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}


















@end
