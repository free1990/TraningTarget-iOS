//
//  CoreAnimationCAMediaTiming.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CoreAnimationCAMediaTiming.h"

@interface CoreAnimationCAMediaTiming ()

@end

@implementation CoreAnimationCAMediaTiming

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"图层时间";
    }
    return self;
}

//CAMediaTiming协议定义了在一段动画内用来控制逝去时间的属性的集合，CALayer和CAAnimation都实现了这个协议，所以时间可以被任意基于一个图层或者一段动画的类控制。
//duration和repeatCount默认都是0。但这不意味着动画时长为0秒，或者0次，这里的0仅仅代表了“默认”，也就是0.25秒和1次，你可以用一个简单的测试来尝试为这两个属性赋多个值，如清单9.1，图9.1展示了程序的结果。

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - repeatDuration && autoreverses
    
//    CALayer *doorLayer = [CALayer layer];
//    
//    doorLayer.frame = CGRectMake(0, 0, 128, 256);
//    doorLayer.position = CGPointMake(150 - 64, 250);
//    doorLayer.anchorPoint = CGPointMake(0, 0.5);
//    doorLayer.contents = (__bridge id)[UIImage imageNamed: @"door.png"].CGImage;
//    
//    [self.view.layer addSublayer:doorLayer];
//    
//    //apply perspective transform
//    CATransform3D perspective = CATransform3DIdentity;
//    perspective.m34 = -1.0 / 500.0;
//    self.view.layer.sublayerTransform = perspective;
//    //apply swinging animation
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform.rotation.y";
//    animation.toValue = @(-M_PI_2);
//    animation.duration = 2.0;
//    animation.repeatDuration = INFINITY;
//    animation.autoreverses = YES;
//    [doorLayer addAnimation:animation forKey:nil];
//    
//    
//    
//    self.bezierPath = [[UIBezierPath alloc] init];
//    [self.bezierPath moveToPoint:CGPointMake(0, 150)];
//    [self.bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
//    //draw the path using a CAShapeLayer
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    pathLayer.path = self.bezierPath.CGPath;
//    pathLayer.fillColor = [UIColor clearColor].CGColor;
//    pathLayer.strokeColor = [UIColor redColor].CGColor;
//    pathLayer.lineWidth = 3.0f;
//    [self.view.layer addSublayer:pathLayer];
//    //add the ship
//    self.shipLayer = [CALayer layer];
//    self.shipLayer.frame = CGRectMake(0, 0, 64, 64);
//    self.shipLayer.position = CGPointMake(0, 150);
//    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Ship.png"].CGImage;
//    [self.view.layer addSublayer:self.shipLayer];
//    
//    CAKeyframeAnimation *newAnimation = [CAKeyframeAnimation animation];
//    newAnimation.keyPath = @"position";
//    newAnimation.timeOffset = 2;
//    newAnimation.speed = 5;
//    newAnimation.duration = 10.0;
//    newAnimation.path = self.bezierPath.CGPath;
//    newAnimation.rotationMode = kCAAnimationRotateAuto;
//    
//    newAnimation.removedOnCompletion = NO;
//    
//    //动画结束时候图层树的状态,默认是kCAFillModeRemoved
//    //这就对避免在动画结束的时候急速返回提供另一种方案（见第八章）。但是记住了，当用它来解决这个问题的时候，需要把removeOnCompletion设置为NO，另外需要给动画添加一个非空的键，于是可以在不需要动画的时候把它从图层上移除。
//    newAnimation.fillMode = kCAFillModeBackwards;
//    
//    [self.shipLayer addAnimation:newAnimation forKey:@"slide"];
    
//    //通过对全局的窗口进行进行调整速度实现控制前进暂停后退
//    self.window.layer.speed = 100;
    
    //通过speed和timeoffset来控制指定动画的深度
    self.doorLayer = [CALayer layer];
    self.doorLayer.frame = CGRectMake(0, 0, 128, 256);
    self.doorLayer.position = CGPointMake(150 - 64, 250);
    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"door.png"].CGImage;
    [self.view.layer addSublayer:self.doorLayer];
    
    //apply perspective transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.view.layer.sublayerTransform = perspective;
    
    //add pan gesture recognizer to handle swipes
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    //pause all layer animations
    self.doorLayer.speed = 0.0;
    
    //apply swinging animation (which won't play because layer is paused)
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
    [self.doorLayer addAnimation:animation forKey:nil];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    //get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.view].x;
    //convert from points to animation duration //using a reasonable scale factor
    x /= 200.0f;
    
    //update timeOffset and clamp result
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    
    self.doorLayer.timeOffset = timeOffset;
    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
