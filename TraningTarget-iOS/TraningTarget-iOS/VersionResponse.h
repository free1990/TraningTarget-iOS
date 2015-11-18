//
//  VersionResponse.h
//  Teacher
//
//  Created by John on 14-11-13.
//  Copyright (c) 2014年 FClassroom. All rights reserved.
//

#import "HTTPResponse.h"

@interface VersionResponse : HTTPResponse

@property (strong, nonatomic) NSString *versionName;
@property (assign, nonatomic) NSInteger *oldStatus;

@end
