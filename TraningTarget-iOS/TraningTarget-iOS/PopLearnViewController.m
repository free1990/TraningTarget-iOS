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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *cat = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    [cat setCenter:self.view.center];
    [cat setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:cat];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        POPSpringAnimation *basicAnimation = [POPSpringAnimation animation];
        
        basicAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        basicAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(100, 200, 90, 190)];
        basicAnimation.name = @"kPOPLayerScaleXY";
        basicAnimation.delegate = self;
        
        [cat pop_addAnimation:basicAnimation forKey:@"kPOPLayerScaleXY"];
    });
    
    NSLog(@"-------pop");
    
    NSLog(@"test------in office");
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
