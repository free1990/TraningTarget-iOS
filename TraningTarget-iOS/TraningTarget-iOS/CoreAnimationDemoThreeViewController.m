//
//  CoreAnimationDemoThreeViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/4.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CoreAnimationDemoThreeViewController.h"

@interface CoreAnimationDemoThreeViewController ()

@end

@implementation CoreAnimationDemoThreeViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Core Animation Demo Three";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _colorLayer = [CALayer layer];
    
    _colorLayer.frame = CGRectMake(50.0f, 150.0f, 100.0f, 100.0f);
    _colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:_colorLayer];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [testBtn setFrame:CGRectMake(100, 260, 100, 50)];
    [testBtn setTitle:@"用力点我" forState:UIControlStateNormal];
    [testBtn setBackgroundColor:[UIColor blueColor]];
    [testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testBtn addTarget:self
                action:@selector(click)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testBtn];
    
    
}

- (void)click{
    
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:1.0];
//    
//    [CATransaction setCompletionBlock:^{
//        //rotate the layer 90 degrees
//        CGAffineTransform transform = _colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI_2);
//        _colorLayer.affineTransform = transform;
//    }];
//    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    _colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
//    
//    [CATransaction commit];
    
     self.view.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
