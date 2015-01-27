//
//  PropertiesManager.h
//  Template
//
//  Created by zhangkai on 9/4/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserDefaultsKeyAppHasSetup             @"kAppHasSetup" // 是否首次启动
#define kUserDefaultsKeyDeviceToken             @"kDeviceToken" // 用于iOS设备接收通知
#define kUserDefaultsKeyAccessToken             @"kAccessToken"
#define kUserDefaultsKeyTokenExpiresDate        @"kTokenExpiresDate"
#define kUserDefaultsKeyRefreshToken            @"kRefreshToken"
#define kUserDefaultsKeyReceiveNewExam          @"kReceiveNewExam" // 是否接收最新考试通知
#define kUserDefaultsKeyReceiveNewMessage       @"kReceiveNewMessage" // 是否接收最新留言通知


@interface PropertiesManager : NSObject

@property (nonatomic, assign) BOOL appHasSetup;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, assign) NSTimeInterval tokenExpiresDate;
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, assign) BOOL receiveNewExam;
@property (nonatomic, assign) BOOL receiveNewMessage;

+ (instancetype)sharedManager;

@end
