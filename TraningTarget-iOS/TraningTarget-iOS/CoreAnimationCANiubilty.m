//
//  CoreAnimationCANiubilty.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CoreAnimationCANiubilty.h"

@interface CoreAnimationCANiubilty ()

@end

@implementation CoreAnimationCANiubilty

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"CA效率";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
