//
//  TestArrayOrderViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/17.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "TestArrayOrderViewController.h"

@implementation TestArrayOrderViewController


+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Test Array Order ";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray* arr = [NSMutableArray arrayWithObjects:@"C", @"A", @"H", @"I", @"B", @"D", @"J", @"E", @"F", @"G", @"K", nil];
    
    // 升序
    // A --> K
    [arr sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        NSString *str1=(NSString *)obj1;
        NSString *str2=(NSString *)obj2;
        return [str1 compare:str2];
    }];
    
    NSLog(@"%@", [arr debugDescription]);
    
    // 降序
    // K --> A
    [arr sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        NSString *str1=(NSString *)obj1;
        NSString *str2=(NSString *)obj2;
        return [str2 compare:str1];
    }];
    NSLog(@"%@", [arr debugDescription]);
}


@end
