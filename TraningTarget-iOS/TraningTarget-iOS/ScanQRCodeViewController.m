//
//  ScanQRCodeViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/18.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ScanQRCodeViewController.h"

@implementation ScanQRCodeViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Scan QRCode";
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
