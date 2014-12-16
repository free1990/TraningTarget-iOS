//
//  CustomViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/16.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "CustomAlertViewController.h"

@interface CustomAlertViewController ()

@end

@implementation CustomAlertViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if ([super init]) {
        self.className   = @"Property And Function";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *alert = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [alert setTitle:@"自定义alert"
           forState:UIControlStateNormal];
    alert.center = self.view.center;
    
    [self.view addSubview:alert];
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
