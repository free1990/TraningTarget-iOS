//
//  ZYNavigationBarDemo.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/19.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ZYNavigationBarDemo.h"

@implementation ZYNavigationBarDemo

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Play Navigatio nBar";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
