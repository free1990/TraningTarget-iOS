//
//  ZYNavigationBarDemo.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/19.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ZYNavigationBarDemo.h"
#import "UINavigationBar+Awesome.h"

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
    
    //设置背景为透明
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    //_UINavigationBarBackground
    //UINavigationItemView
    //_UINavigationBarBackIndicatorView
//    for (UIView *temp in [self.navigationController.navigationBar subviews]) {
//        NSLog(@"temp== -->  %@", temp);
//        temp.alpha = 0;
//    }
    
//    //设置Navbar为透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    
//    for (UIView *subview in [self.navigationController.navigationBar subviews]) {
//        subview.alpha = 0.5;
//    }
    
    //testing
    //BackgroundImage
    //ShadowImage
    //backIndicatorImage
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
