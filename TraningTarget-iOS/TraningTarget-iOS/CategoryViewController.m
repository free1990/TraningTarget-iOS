//
//  CategoryViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/24.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController


+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Category";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self showEmptyDataViewAtPosition:self.view.center];
    
    [self showReloadButtonAtPosition:self.view.center];
    [self addReloadButtonAction:@"test:"];
    
//    [self showHudInView:self.view hint:@"Test..."];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self hideHud];
//    });
    
}

- (void)test:(id)sender{
    NSLog(@"--->reload");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
