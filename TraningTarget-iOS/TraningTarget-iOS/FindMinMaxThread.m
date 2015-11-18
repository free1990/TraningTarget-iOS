//
//  FindMinMaxThread.m
//  TraningTarget-iOS
//
//  Created by John on 15/5/7.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "FindMinMaxThread.h"

@implementation FindMinMaxThread {
    NSArray *_numbers;
}

- (instancetype)initWithNumbers:(NSArray *)numbers
{
    self = [super init];
    if (self) {
        _numbers = numbers;
    }
    return self;
}

- (void)main
{
    NSUInteger min;
    NSUInteger max;
    // 进行相关数据的处理
    self.min = min;
    self.max = max;
}
@end