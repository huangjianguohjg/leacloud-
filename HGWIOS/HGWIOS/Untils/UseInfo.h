//
//  UseInfo.h
//  funsole
//
//  Created by gagakj on 2018/1/22.
//  Copyright © 2018年 gagakj. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UseInfo : NSObject

+(instancetype _Nullable)shareInfo;

-(void)clearInfo;

-(void)clearHeTPath;

-(void)clearGetuiDict;

@property (nonatomic, copy) NSString * _Nullable imageUrl;

@property (nonatomic, assign) BOOL sex;

@property (nonatomic, copy) NSString * _Nullable access_token;

@property (nonatomic, copy) NSString * _Nullable uID;

@property (nonatomic, copy) NSString * _Nullable identity;

@property (nonatomic, copy) NSString * _Nullable nameApprove;
@property (nonatomic, copy) NSString * _Nullable companyApprove;
@property (nonatomic, copy) NSString * _Nullable joinCompanyApprove;

@property (nonatomic, copy) NSString * _Nullable cliendID;

@property (nonatomic, assign) BOOL is_admin;

@property (nonatomic, assign) NSString * _Nullable firstLogin;

@property (nonatomic, strong) NSDictionary * getuiDict;

@property (nonatomic, copy) NSString * _Nullable hetongPath;

@end
