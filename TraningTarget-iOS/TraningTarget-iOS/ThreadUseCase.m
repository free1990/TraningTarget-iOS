//
//  ThreadUseCase.m
//  TraningTarget-iOS
//
//  Created by John on 15/5/7.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ThreadUseCase.h"
#import "FindMinMaxThread.h"

@interface ThreadUseCase ()

@end

@implementation ThreadUseCase

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    size_t const count = 1000000;
    
    // 使用随机数字填充 inputValues
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < count; ++i) {
        [mAry addObject:[NSNumber numberWithInt:arc4random()]];
    }
    
    NSMutableSet *threads = [NSMutableSet set];
    NSUInteger numberCount = [mAry count];
    NSUInteger threadCount = 4;
    for (NSUInteger i = 0; i < threadCount; i++) {
        NSUInteger offset = (count / threadCount) * i;
        NSUInteger count = MIN(numberCount - offset, numberCount / threadCount);
        NSRange range = NSMakeRange(offset, count);
        NSArray *subset = [mAry subarrayWithRange:range];
        FindMinMaxThread *thread = [[FindMinMaxThread alloc] initWithNumbers:subset];
        [threads addObject:thread];
        [thread start];
    }
    
    //四个Thread如果打算等待执行完成，再检测，怎么做？
    
    
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // 代码...
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
