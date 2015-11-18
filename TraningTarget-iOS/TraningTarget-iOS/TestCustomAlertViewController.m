//
//  CustomViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/16.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "TestCustomAlertViewController.h"
#import "JKUpdateAlertView.h"

@interface TestCustomAlertViewController ()

@end

@implementation TestCustomAlertViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Test Custom AlertView";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *alert = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [alert setTitle:@"自定义alert"
           forState:UIControlStateNormal];
    alert.frame = CGRectMake(0, 0, 100, 50);
    alert.center = self.view.center;
    [alert addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchDown];
    alert.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:alert];
}

- (void)alert{
    [JKUpdateAlertView initJKAlertWithTitle:@"test" message:@"content" cancelButtonTitle:@"canel" otherButtonTitles:@"ok"];
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
