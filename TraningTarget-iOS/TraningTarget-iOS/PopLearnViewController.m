//
//  PopLearnViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/15.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "PopLearnViewController.h"
#import <pop/POP.h>

@interface PopLearnViewController ()

@end

@implementation PopLearnViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Pop Learn";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
