//
//  PriticseViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/20.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "PracticeViewController.h"
#import "ScanTitleView.h"

@interface PracticeViewController ()

@end

@implementation PracticeViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Practice";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    ScanTitleView *temp = [[ScanTitleView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    
    [temp setCenter:self.view.center];
    
    [self.view addSubview:temp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
