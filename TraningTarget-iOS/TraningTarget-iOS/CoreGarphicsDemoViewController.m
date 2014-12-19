//
//  CoreGarphicsDemoViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/19.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "CoreGarphicsDemoViewController.h"

@interface CoreGarphicsDemoViewController ()

@end

@implementation CoreGarphicsDemoViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Core Garphics Demo";
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
