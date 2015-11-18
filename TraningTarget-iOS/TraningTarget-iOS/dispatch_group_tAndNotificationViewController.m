//
//  dispatch_group_tAndNotificationViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/2.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "dispatch_group_tAndNotificationViewController.h"

@interface dispatch_group_tAndNotificationViewController ()

@end

@implementation dispatch_group_tAndNotificationViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"dispatch_group_t和NSNotificationCenter";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"-----%d",i);
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CapturedImage"
                                                            object:nil];
    });
}

- (void)beginRecognize{
    
    NSLog(@"通知发出来了");
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
