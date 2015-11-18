//
//  JSONUtil.m
//  Template
//
//  Created by zhangkai on 9/3/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import "JSONUtil.h"

@implementation JSONUtil

+ (id)jsonObjectWithData:(NSData *)data {
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error == nil) {
        return object;
    } else {
        DLOG(@"%@", error);
    }
    return nil;
}

+ (NSData *)jsonDataWithObject:(id)obj {
    if ([NSJSONSerialization isValidJSONObject:obj]) {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:&error];
        if (error == nil) {
            return data;
        } else {
            DLOG(@"%@", error);
        }
    }
    return nil;
}

+ (NSString *)jsonStringWithObject:(id)obj {
    NSData *data = [self jsonDataWithObject:obj];
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (id)jsonObjectWithString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self jsonObjectWithData:data];
}

@end
