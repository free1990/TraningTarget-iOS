//
//  VVStack.m
//  TraningTarget-iOS
//
//  Created by John on 15/5/20.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "VVStack.h"

@implementation VVStack
- (id)init {
    if (self = [super init]) {
        _numbers = [NSMutableArray new];
    }
    return self;
}

- (void)push:(double)num {
    [self.numbers addObject:@(num)];
}

- (double)top {
    return [[self.numbers lastObject] doubleValue];
} @end
