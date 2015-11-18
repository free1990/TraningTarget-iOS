//
//  UploadHelper.h
//  TraningTarget-iOS
//
//  Created by John on 15/4/24.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface UploadHelper : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, readonly) AFNetworkReachabilityManager *reachabilityManager;

- (void)uploadOneFileWithDetailProgress:(void (^)(float percent, BOOL isUploaded))completion;


@end
