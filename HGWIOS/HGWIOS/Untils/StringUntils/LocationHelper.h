//
//  LocationHelper.h
//  haoyunhl
//
//  Created by lianghy on 17/10/9.
//  Copyright © 2017年 haoyunhanglian. All rights reserved.
//

#ifndef LocationHelper_h
#define LocationHelper_h


#endif /* LocationHelper_h */
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <math.h>

@interface LocationHelper : NSObject<CLLocationManagerDelegate>
+(double)latitude;
+(double)longitude;
+(double)horizontalAccuracy;
+(nullable NSString *)locationName;
+ (nullable NSString *)deviceIPAdress;



@property (nonatomic, strong,nonnull)CLLocationManager *locationManager;
-(void)startInit;
@end
