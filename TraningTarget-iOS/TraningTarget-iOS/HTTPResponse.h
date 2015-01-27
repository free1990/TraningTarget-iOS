//
//  HTTPResponse.h
//  Teacher
//
//  Created by zhangkai on 9/24/14.
//  Copyright (c) 2014 FClassroom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPResponse : NSObject

@property (nonatomic, assign) int errorCode;
@property (nonatomic, assign) NSString *errorMsg;

- (void)parseResponse:(NSDictionary *)response;
- (BOOL)isSuccess;
- (BOOL)isExist:(id)val;

@end
