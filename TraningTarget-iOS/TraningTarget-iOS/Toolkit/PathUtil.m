//
//  PathUtil.m
//  Template
//
//  Created by zhangkai on 9/3/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import "PathUtil.h"

@implementation PathUtil

+ (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

+ (NSString *)cachesDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

@end
