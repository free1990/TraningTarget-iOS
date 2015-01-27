//
//  HTTPResponse.m
//  Teacher
//
//  Created by zhangkai on 9/24/14.
//  Copyright (c) 2014 FClassroom. All rights reserved.
//

#import "HTTPResponse.h"

@implementation HTTPResponse

- (void)parseResponse:(NSDictionary *)response {
    self.errorCode = [[response objectForKey:@"error_code"] intValue];
    self.errorMsg = [response objectForKey:@"error_msg"];
}

- (BOOL)isSuccess {
    if (_errorCode == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isExist:(id)val {
    if (val && val != [NSNull null]) {
        if ([val isKindOfClass:[NSString class]]) {
            if ([[val lowercaseString] isEqualToString:@"null"]) {
                return NO;
            } else {
                return YES;
            }
        } else {
            return YES;
        }
    }
    return NO;
}

@end
