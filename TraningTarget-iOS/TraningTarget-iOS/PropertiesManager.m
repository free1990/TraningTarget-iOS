//
//  PropertiesManager.m
//  Template
//
//  Created by work on 9/4/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import "PropertiesManager.h"
#import "Macros.h"
#import "Config.h"

@implementation PropertiesManager

#pragma mark - Initialization

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static PropertiesManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[PropertiesManager alloc] init];
    });
    return sharedManager;
}

- (id)init {
	if (self = [super init]) {
        DLOGINFO();
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        self.appHasSetup = [defaults boolForKey:kUserDefaultsKeyAppHasSetup];
        self.deviceToken = [defaults stringForKey:kUserDefaultsKeyDeviceToken];
        self.accessToken = [defaults stringForKey:kUserDefaultsKeyAccessToken];
        self.tokenExpiresDate = [defaults doubleForKey:kUserDefaultsKeyTokenExpiresDate];
        self.refreshToken = [defaults stringForKey:kUserDefaultsKeyRefreshToken];
	}
	return self;
}

#pragma mark - Accessor methods

- (void)setAppHasSetup:(BOOL)appHasSetup {
    _appHasSetup = appHasSetup;
    
    [[NSUserDefaults standardUserDefaults] setBool:_appHasSetup forKey:kUserDefaultsKeyAppHasSetup];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setDeviceToken:(NSString *)deviceToken {
    _deviceToken = deviceToken;
    
    [[NSUserDefaults standardUserDefaults] setObject:_deviceToken forKey:kUserDefaultsKeyDeviceToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setAccessToken:(NSString *)accessToken {
    _accessToken = accessToken;
    
    [[NSUserDefaults standardUserDefaults] setObject:_accessToken forKey:kUserDefaultsKeyAccessToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTokenExpiresDate:(NSTimeInterval)tokenExpiresDate {
    _tokenExpiresDate = tokenExpiresDate;
    
    [[NSUserDefaults standardUserDefaults] setDouble:_tokenExpiresDate forKey:kUserDefaultsKeyTokenExpiresDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setRefreshToken:(NSString *)refreshToken {
    _refreshToken = refreshToken;
    
    [[NSUserDefaults standardUserDefaults] setObject:_refreshToken forKey:kUserDefaultsKeyRefreshToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setReceiveNewExam:(BOOL)receiveNewExam {
    _receiveNewExam = receiveNewExam;
    
    [[NSUserDefaults standardUserDefaults] setBool:_receiveNewExam forKey:kUserDefaultsKeyReceiveNewExam];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setReceiveNewMessage:(BOOL)receiveNewMessage {
    _receiveNewMessage = receiveNewMessage;
    
    [[NSUserDefaults standardUserDefaults] setBool:_receiveNewMessage forKey:kUserDefaultsKeyReceiveNewMessage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Memory management

- (void)dealloc {
    DLOGINFO();
    abort();
}

@end
