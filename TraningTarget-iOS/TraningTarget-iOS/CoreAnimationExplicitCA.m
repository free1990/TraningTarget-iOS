//
//  CoreAnimationDemoFourViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CoreAnimationExplicitCA.h"

@interface CoreAnimationExplicitCA ()

@end

@implementation CoreAnimationExplicitCA


- (id)init{
    if (self = [super init]) {
        self.className   = @"显式 动画";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
#pragma mark - 属性动画--分为两种：基础和关键帧
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [testBtn setFrame:CGRectMake(100, 500, 100, 30)];
    [testBtn setTitle:@"用力点我" forState:UIControlStateNormal];
    [testBtn setBackgroundColor:[UIColor redColor]];
    [testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testBtn addTarget:self
                action:@selector(performTransition)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testBtn];
//
//    
//    self.colorLayer = [CALayer layer];
//    self.colorLayer.frame = CGRectMake(100.0f, 150.0f, 100.0f, 100.0f);
//    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
//    //add it to our view
//    [self.view.layer addSublayer:self.colorLayer];
    
#pragma mark - 关键帧动画使用CGPath
//    //AKeyframeAnimation有另一种方式去指定动画，就是使用CGPath
//    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
//    
//    [bezierPath moveToPoint:CGPointMake(0, 150)];
//    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
//    
//    //draw the path using a CAShapeLayer
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    
//    pathLayer.path = bezierPath.CGPath;
//    pathLayer.fillColor = [UIColor clearColor].CGColor;
//    pathLayer.strokeColor = [UIColor redColor].CGColor;
//    pathLayer.lineWidth = 3.0f;
//    
//    [self.view.layer addSublayer:pathLayer];
//
//    //add the car
//    CALayer *carLayer = [CALayer layer];
//    
//    carLayer.frame = CGRectMake(0, 0, 64, 64);
//    carLayer.position = CGPointMake(0, 150);
//    carLayer.contents = (__bridge id)[UIImage imageNamed: @"car.png"].CGImage;
//    [self.view.layer addSublayer:carLayer];
//    
//    //create the keyframe animation
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    
//    animation.keyPath = @"position";
//    animation.duration = 4.0;
//    animation.path = bezierPath.CGPath;
//    
//    //图层将会根据曲线的切线自动旋转
//    animation.rotationMode = kCAAnimationRotateAuto;
//    
//    [carLayer addAnimation:animation forKey:nil];
    
#pragma mark -虚拟属性
    
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    
    shipLayer.frame = CGRectMake(0, 0, 50, 50);
    shipLayer.position = CGPointMake(150, 350);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Ship.png"].CGImage;
    
    [self.view.layer addSublayer:shipLayer];
    
//    //animate the ship rotation
//    CABasicAnimation *shipAnimation = [CABasicAnimation animation];
//    
//    shipAnimation.keyPath = @"transform";
//    shipAnimation.duration = 2.0;
//    //旋转180度
////    shipAnimation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0, 0, 1)];
//    
//    //没有做任何旋转，这是因为变换矩阵不能像角度值那样叠加
//    shipAnimation.byValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0, 0, 1)];
//    
//    [shipLayer addAnimation:shipAnimation forKey:nil];
    
    CABasicAnimation *shipAnimation = [CABasicAnimation animation];
    shipAnimation.keyPath = @"transform.rotation";
    
    shipAnimation.duration = 2.0;
    shipAnimation.repeatCount = 3;
    shipAnimation.byValue = @(M_PI * 2);
    [shipLayer addAnimation:shipAnimation forKey:nil];
    
#pragma mark - CAAnimationGroup
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    //add a colored layer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:colorLayer];
    
    //create the position animation
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    //create the color animation
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    //create group animation
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    //add the animation to the color layer
    [colorLayer addAnimation:groupAnimation forKey:nil];
    
}

- (void)performTransition
{
    //preserve the current view snapshot
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //insert snapshot view in front of this one
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    //update the view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //perform animation (anything you like)
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        //remove the cover view now we're finished with it
        [coverView removeFromSuperview];
    }];
}


- (void)click
{
//    //create a new random color
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    
//    //create a basic animation
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    
//    animation.keyPath = @"backgroundColor";
//    animation.toValue = (__bridge id)color.CGColor;
//    
//    animation.delegate = self;
    
//    animation.fromValue = (__bridge id)self.colorLayer.backgroundColor;
//    
//    self.colorLayer.backgroundColor = color.CGColor;
//    //apply animation to layer
//    [self.colorLayer addAnimation:animation forKey:nil];
    
//     [self applyBasicAnimation:animation toLayer:self.colorLayer];
    
    //create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    
    //开始和结束都是蓝色
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
}

- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CALayer *)layer
{
    
    //set the from value (using presentation layer if available)
    animation.fromValue = [layer.presentationLayer ?: layer valueForKeyPath:animation.keyPath];
    //update the property in advance
    //note: this approach will only work if toValue != nil
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [layer setValue:animation.toValue forKeyPath:animation.keyPath];
    [CATransaction commit];
    //apply animation to layer
    [layer addAnimation:animation forKey:nil];
}

//- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
//{
////    //set the backgroundColor property to match animation toValue
////    [CATransaction begin];
////    [CATransaction setDisableActions:YES];
////    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
////    [CATransaction commit];
//}

- (void)stop
{
    [self.colorLayer removeAnimationForKey:@"rotateAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //log that the animation stopped
    NSLog(@"The animation stopped (finished: %@)", flag? @"YES": @"NO");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
