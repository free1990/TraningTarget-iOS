//
//  NSObject+JudgeNil.m
//  TraningTarget-iOS
//
//  Created by John on 15/5/25.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "NSObject+JudgeNil.h"
#include <objc/runtime.h>

@implementation NSObject (JudgeNil)

- (void) checkObjectPropertyNil:(id) object
{
    id objectClass = [object class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(objectClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        id value = [object valueForKey:propName];
        if (!value) {
            printf("<%s> = nil\r\n", property_getName(property));
        }
    }
}

@end
