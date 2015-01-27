//
//  DebugUtil.m
//  Template
//
//  Created by zhangkai on 9/4/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#import "DebugUtil.h"
#import "objc/runtime.h"

@implementation DebugUtil

+ (NSDictionary *)userDefaultsInfo {
    return [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
}

+ (NSString *)describeObject:(NSObject *)object {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"%@, ", [object description]];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:propName];
        [description appendFormat:@"%@: %@, ", propertyName, [object valueForKey:propertyName]];
    }
    [description deleteCharactersInRange:NSMakeRange(description.length - 2, 2)];
    return description;
}

+ (NSString *)hierarchyOfView:(UIView *)view {
#ifdef DEBUG
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    return [view performSelector:@selector(recursiveDescription)];
    #pragma clang diagnostic pop
#else
    return nil;
#endif
}

@end
