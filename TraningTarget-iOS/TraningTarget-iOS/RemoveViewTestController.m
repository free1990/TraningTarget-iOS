//
//  RemoveViewTestController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/17.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "RemoveViewTestController.h"

@interface RemoveViewTestController ()

@end

@implementation RemoveViewTestController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Remove View Test";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableViewController
    
    _testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _testView.center = self.view.center;
    _testView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_testView];
    
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchDown];
    [removeBtn setTitle:@"remove" forState:UIControlStateNormal];
    [removeBtn setFrame:CGRectMake(100, 120, 100, 50)];
    [removeBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:removeBtn];
}

- (void)remove{
    
    [_testView removeFromSuperview];
    NSLog(@"--->%@", _testView);
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
