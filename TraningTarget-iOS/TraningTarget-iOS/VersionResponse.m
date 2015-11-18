//
//  VersionResponse.m
//  Teacher
//
//  Created by John on 14-11-13.
//  Copyright (c) 2014年 FClassroom. All rights reserved.
//

#import "VersionResponse.h"

@implementation VersionResponse

- (void)parseResponse:(NSDictionary *)response {
    [super parseResponse:response];
    
    if (self.isSuccess) {
        NSDictionary *data = [response objectForKey:@"data"];
        self.versionName = [data objectForKey:@"versionName"];
        self.oldStatus = [[data objectForKey:@"oldStatus"] integerValue];
    }
}


@end
