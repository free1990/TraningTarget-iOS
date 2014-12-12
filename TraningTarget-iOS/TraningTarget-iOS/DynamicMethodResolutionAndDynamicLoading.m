//
//  DynamicMethodResolutionAndDynamicLoading.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/12.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "DynamicMethodResolutionAndDynamicLoading.h"

@interface DynamicMethodResolutionAndDynamicLoading ()

@end

@implementation DynamicMethodResolutionAndDynamicLoading

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if ([super init]) {
        self.className   = @"Dynamic Method Resolution And Dynamic Loading";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
