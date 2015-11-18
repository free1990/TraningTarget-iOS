//
//  NSObject+GetintegerValue.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "NSObject+GetintegerValue.h"

@implementation NSObject (GetintegerValue)

- (NSInteger)getInterValue:(id)object
{
    NSInteger result = 0;
    if (! object) {
        result = 0;
    }else{
        if ([object performSelector:@selector(integerValue)]) {
            result = [object integerValue];
        }
    }
    return result;
}

@end
