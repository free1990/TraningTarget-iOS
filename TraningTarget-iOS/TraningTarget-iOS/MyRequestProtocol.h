//
//  MyRequestProtocol.h
//  TraningTarget-iOS
//
//  Created by John on 15/2/4.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRequestProtocol : NSURLProtocol<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLSession *session;

@end
