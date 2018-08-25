//
//  UseInfo.m
//  funsole
//
//  Created by gagakj on 2018/1/22.
//  Copyright © 2018年 gagakj. All rights reserved.
//

#import "UseInfo.h"

@interface UseInfo()

@property(nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation UseInfo

@synthesize imageUrl = _imageUrl;
@synthesize sex = _sex;
@synthesize access_token = _access_token;
@synthesize identity = _identity;
@synthesize nameApprove = _nameApprove;
@synthesize companyApprove = _companyApprove;
@synthesize joinCompanyApprove = _joinCompanyApprove;
@synthesize uID = _uID;
@synthesize is_admin = _is_admin;
@synthesize cliendID = _cliendID;
@synthesize firstLogin = _firstLogin;
@synthesize getuiDict = _getuiDict;
@synthesize hetongPath = _hetongPath;

+(instancetype)shareInfo
{
    static UseInfo * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UseInfo alloc]init];
        
    });
    return instance;
}

-(NSUserDefaults *)defaults{
    if(_defaults == nil){
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}


-(void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    [self.defaults setObject:imageUrl forKey:@"wechatHeadImageUrl"];
    [self.defaults synchronize];
    
}

-(NSString *)imageUrl
{
    if (_imageUrl == nil) {
        _imageUrl = [self.defaults objectForKey:@"wechatHeadImageUrl"];
    }
    return _imageUrl;
}



-(void)setAccess_token:(NSString *)access_token
{
    _access_token = access_token;
    
    [self.defaults setObject:access_token forKey:@"access_token"];
    [self.defaults synchronize];
}

-(NSString *)access_token
{
    if (_access_token == nil) {
        _access_token = [self.defaults objectForKey:@"access_token"];
    }
    return _access_token;
}




-(void)setSex:(BOOL)sex
{
    _sex = sex;
    
    [self.defaults setBool:sex forKey:@"sex"];
    [self.defaults synchronize];
}

-(BOOL)sex
{
    if (_sex != 0 || _sex != 1) {
        _sex = [self.defaults boolForKey:@"sex"];
    }
    return _sex;
}



-(void)setIdentity:(NSString *)identity
{
    _identity = identity;
    
    [self.defaults setObject:identity forKey:@"identity"];
    [self.defaults synchronize];
}

-(NSString *)identity
{
    if (_identity == nil) {
        _identity = [self.defaults objectForKey:@"identity"];
    }
    return _identity;
}



-(void)setNameApprove:(NSString *)nameApprove
{
    _nameApprove = nameApprove;
    
    [self.defaults setObject:nameApprove forKey:@"nameApprove"];
    [self.defaults synchronize];
}

-(NSString *)nameApprove
{
    if (_nameApprove == nil) {
        _nameApprove = [self.defaults objectForKey:@"nameApprove"];
    }
    return _nameApprove;
}



-(void)setCompanyApprove:(NSString *)companyApprove
{
    _companyApprove = companyApprove;
    
    [self.defaults setObject:companyApprove forKey:@"companyApprove"];
    [self.defaults synchronize];
    
}

-(NSString *)companyApprove
{
    if (_companyApprove == nil) {
        _companyApprove = [self.defaults objectForKey:@"companyApprove"];
    }
    return _companyApprove;
}

-(void)setJoinCompanyApprove:(NSString *)joinCompanyApprove
{
    _joinCompanyApprove = joinCompanyApprove;
    
    [self.defaults setObject:joinCompanyApprove forKey:@"joinCompanyApprove"];
    [self.defaults synchronize];
}

-(NSString *)joinCompanyApprove
{
    if (_joinCompanyApprove == nil) {
        _joinCompanyApprove = [self.defaults objectForKey:@"joinCompanyApprove"];
    }
    return _joinCompanyApprove;
}


-(void)setUID:(NSString *)uID
{
    _uID = uID;
    
    [self.defaults setObject:uID forKey:@"uID"];
    [self.defaults synchronize];
}


-(NSString *)uID
{
    if (_uID == nil) {
        _uID = [self.defaults objectForKey:@"uID"];
    }
    return _uID;
}

-(void)setCliendID:(NSString *)cliendID
{
    _cliendID = cliendID;
    
    [self.defaults setObject:cliendID forKey:@"cliendID"];
    [self.defaults synchronize];
}

-(NSString *)cliendID
{
    if (_cliendID == nil) {
        _cliendID = [self.defaults objectForKey:@"cliendID"];
    }
    return _cliendID;
}



-(void)setIs_admin:(BOOL)is_admin
{
    _is_admin = is_admin;
    
    [self.defaults setBool:is_admin forKey:@"is_admin"];
    [self.defaults synchronize];
}

-(BOOL)is_admin
{
    if (_is_admin != 0 || _is_admin != 1) {
        _is_admin = [self.defaults boolForKey:@"is_admin"];
    }
    return _is_admin;
}


-(void)setFirstLogin:(NSString *)firstLogin
{
    _firstLogin = firstLogin;
    
    [self.defaults setObject:firstLogin forKey:@"firstLogin"];
    [self.defaults synchronize];
}

-(NSString *)firstLogin
{
    if (_firstLogin == nil) {
        _firstLogin = [self.defaults objectForKey:@"firstLogin"];
    }
    return _firstLogin;
}


-(void)setGetuiDict:(NSDictionary *)getuiDict
{
    _getuiDict = getuiDict;
    [self.defaults setObject:getuiDict forKey:@"getuiDict"];
    [self.defaults synchronize];
}

-(NSDictionary *)getuiDict
{
    if (_getuiDict == nil) {
        _getuiDict = [self.defaults objectForKey:@"getuiDict"];
    }
    return _getuiDict;
}


-(void)setHetongPath:(NSString *)hetongPath
{
    _hetongPath = hetongPath;
    [self.defaults setObject:hetongPath forKey:@"hetongPath"];
    [self.defaults synchronize];
}

-(NSString *)hetongPath
{
    if (_hetongPath == nil) {
        _hetongPath = [self.defaults objectForKey:@"hetongPath"];
    }
    return _hetongPath;
}


-(void)clearGetuiDict
{
    [self.defaults removeObjectForKey:@"getuiDict"];
    self.getuiDict = nil;
}


-(void)clearHeTPath
{
    [self.defaults removeObjectForKey:@"hetongPath"];
    self.hetongPath = nil;
}




-(void)clearInfo
{
    [self.defaults removeObjectForKey:@"imageUrl"];
    [self.defaults removeObjectForKey:@"sex"];
    [self.defaults removeObjectForKey:@"access_token"];
    [self.defaults removeObjectForKey:@"identity"];
    [self.defaults removeObjectForKey:@"nameApprove"];
    [self.defaults removeObjectForKey:@"companyApprove"];
    [self.defaults removeObjectForKey:@"uID"];
    [self.defaults removeObjectForKey:@"is_admin"];
    [self.defaults removeObjectForKey:@"joinCompanyApprove"];
//    [self.defaults removeObjectForKey:@"cliendID"];
    
    
    self.imageUrl = nil;
    self.sex = nil;
    self.access_token = nil;
    self.identity = nil;
    self.nameApprove = nil;
    self.companyApprove = nil;
    self.is_admin = nil;
    self.uID = nil;
    self.joinCompanyApprove = nil;
//    self.cliendID = nil;
}


































@end
