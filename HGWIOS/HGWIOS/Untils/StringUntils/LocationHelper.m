//
//  LocationHelper.m
//  haoyunhl
//
//  Created by lianghy on 17/10/9.
//  Copyright © 2017年 haoyunhanglian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationHelper.h"
#include <ifaddrs.h>
#include <arpa/inet.h>


static double latitudeValue;
static double longitudeValue;
static double horizontalAccuracyValue;
static NSString *locationNameValue;
@implementation LocationHelper

double pi = 3.1415926535897932384626;
double a = 6378245.0;
double ee = 0.00669342162296594323;

+(double)latitude{
    return latitudeValue;
}

+(double)longitude{
    return longitudeValue;
}

+(double)horizontalAccuracy{
    return horizontalAccuracyValue;
}

+(NSString *)locationName{
    return locationNameValue;
}

-(void)startInit{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;//定位精确度最好
    //设置定位的频率,这里我们设置精度为10,也就是10米定位一次
    
    CLLocationDistance distance=10;
    
    //给精度赋值
    self.locationManager.distanceFilter=distance;
    // 判断的手机的定位功能是否开启
    // 开启定位:设置 >隐私 >位置 > 定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
    } else {
        
    }
    if ([[[UIDevice currentDevice]systemVersion] doubleValue] >8.0)
    {
        // 设置定位权限仅iOS8以上有意义,而且iOS8以上必须添加此行代码
//        [self.locationManager requestWhenInUseAuthorization];//前台定位
         [self.locationManager requestAlwaysAuthorization];//前后台同时定位
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *newLocation = locations[0];
    // 位置反编码
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error){
        CLPlacemark *placemark = [placemarks objectAtIndex:(placemarks.count-1)];
        longitudeValue =placemark.location.coordinate.longitude;
        latitudeValue = placemark.location.coordinate.latitude;
        horizontalAccuracyValue = placemark.location.horizontalAccuracy;
        locationNameValue =  [placemark.administrativeArea stringByAppendingFormat:@" %@ %@",placemark.locality, placemark.subLocality];
        NSLog(@"%@",
              placemark.country);// 市
        NSLog(@"%@",
              placemark.administrativeArea);// 市
        NSLog(@"%@",
             placemark.locality);// 市
        NSLog(@"%@",
             placemark.subLocality);// 区
    }];
    [manager stopUpdatingLocation];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

//必须在有网的情况下才能获取手机的IP地址
+ (NSString *)deviceIPAdress {
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in  *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    
    return address;
}

@end
