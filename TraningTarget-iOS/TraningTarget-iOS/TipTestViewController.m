//
//  TipTestViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/28.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "TipTestViewController.h"
#import "UIViewController+AbnormalDisplay.h"

@interface TipTestViewController ()

@end

@implementation TipTestViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"AbnormalDisplay demo";
    }
    return self;
}

//-(void)showEmptyDataViewAtPosition:(CGPoint)point;
//-(void)hideEmptyDataView;
//
//-(void)showReloadButtonAtPosition:(CGPoint)point;
//-(void)addReloadButtonAction:(NSString *)selectorString;
//-(void)hideReloadButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *temp = [[UIView alloc] initWithFrame:self.view.frame];
    
    [temp setBackgroundColor:[UIColor blueColor]];
    
    [self.view addSubview:temp];
    
    [self showEmptyDataViewAtPosition:self.view.center];
    
    UIView *temp2 = [[UIView alloc] initWithFrame:self.view.frame];
    
    [temp2 setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:temp2];
    
    [self showEmptyDataViewAtPosition:self.view.center];
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
