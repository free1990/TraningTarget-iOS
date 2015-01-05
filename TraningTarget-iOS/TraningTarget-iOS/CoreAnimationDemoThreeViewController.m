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
    
    _colorLayer.frame = CGRectMake(150.0f, 150.0f, 100.0f, 100.0f);
    _colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:_colorLayer];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [testBtn setFrame:CGRectMake(0, 260, 100, 30)];
    [testBtn setTitle:@"用力点我" forState:UIControlStateNormal];
    [testBtn setBackgroundColor:[UIColor redColor]];
    [testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testBtn addTarget:self
                action:@selector(click)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testBtn];
    
    NSLog(@"Outside: %@", [self.view actionForLayer:self.view.layer forKey:@"backgroundColor"]);
    //begin animation block
    [UIView beginAnimations:nil context:nil];
    //test layer action when inside of animation block
    NSLog(@"Inside: %@", [self.view actionForLayer:self.view.layer forKey:@"backgroundColor"]);
    //end animation block
    [UIView commitAnimations];
    
    
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 150, 150)];
    
    [self.layerView setBackgroundColor:[UIColor blueColor]];
    
    [self.view addSubview:self.layerView];
    
    
//    self.colorLayer = [CALayer layer];
//    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 50.0f, 50.0f);
//    self.colorLayer.backgroundColor = [UIColor yellowColor].CGColor;
//    
//    //add a custom action
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    
//    //定义的action
//    self.colorLayer.actions = @{@"backgroundColor": transition};
//    //add it to our view
//    
//    [self.layerView.layer addSublayer:self.colorLayer];

    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 50.0f, 50.0f);
    self.colorLayer.backgroundColor = [UIColor yellowColor].CGColor;
    
    //add a custom action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    //定义的action
    self.colorLayer.actions = @{@"backgroundColor": transition};
    //add it to our view
    
    [self.view.layer addSublayer:self.colorLayer];
    
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
    
     self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //check if we've tapped the moving layer
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
        //otherwise (slowly) move the layer to new position
        [CATransaction begin];
        [CATransaction setAnimationDuration:2.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
