//
//  PathUtil.h
//  Template
//
//  Created by zhangkai on 9/3/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathUtil : NSObject

/**
 * 获取documents路径
 */
+ (NSString *)documentsDirectory;

/**
 * 获取caches路径
 */
+ (NSString *)cachesDirectory;

@end
