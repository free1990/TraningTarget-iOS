//
//  CoreAnimationCACushion.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CoreAnimationCAMediaTimingFunction.h"

@interface CoreAnimationCAMediaTimingFunction ()

@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIImageView *ballView;

@end

@implementation CoreAnimationCAMediaTimingFunction


- (id)init{
    if (self = [super init]) {
        self.className   = @"缓 冲";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

#pragma mark - UIViewAnimationOptionCurveEaseOut
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    self.colorView = [[UIView alloc] init];
    self.colorView.bounds = CGRectMake(0, 0, 100, 100);
    self.colorView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 +100);
    self.colorView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.colorView];
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn, fn, fn];
    animation.repeatDuration = INFINITY;
    //自动恢复
//    animation.autoreverses = YES;
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
    
#pragma mark - CAMediaTimingFunction 两个控制点
    
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    //get control points
    CGPoint controlPoint1, controlPoint2;
    [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
    [function getControlPointAtIndex:2 values:(float *)&controlPoint2];
    
    //create curve
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1)
            controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    //scale the path up to a reasonable size for display
    [path applyTransform:CGAffineTransformMakeScale(100, 100)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [self.colorLayer addSublayer:shapeLayer];
    //flip geometry so that 0,0 is in the bottom-left
    self.colorLayer.geometryFlipped = YES;
    
#pragma mark - 球体自由下落（自定义的缓冲）
    UIImage *ballImage = [UIImage imageNamed:@"qq"];
    self.ballView = [[UIImageView alloc] initWithImage:ballImage];
    [self.view addSubview:self.ballView];
    //animate
    [self animate];
}

- (void)animate
{
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);
    //set up animation parameters
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    CFTimeInterval duration = 1.0;
    //generate keyframes
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        float time = 1/(float)numFrames * i;
        //apply easing
        time = bounceEaseOut(time);
        //add keyframe
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = frames;
    //apply animation
    [self.ballView.layer addAnimation:animation forKey:nil];
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}

//罗伯特·彭纳有一个网页关于缓冲函数（http://www.robertpenner.com/easing）
float quadraticEaseInOut(float t)
{
    return (t < 0.5)? (2 * t * t): (-2 * t * t) + (4 * t) - 1;
}

float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

//  //不好的死方法
//- (void)animate
//{
//    //reset ball to top of screen
//    self.ballView.center = CGPointMake(150, 32);
//    //create keyframe animation
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position";
//    animation.duration = 1.0;
//    animation.delegate = self;
//    animation.values = @[
//                         [NSValue valueWithCGPoint:CGPointMake(150, 32)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)]
//                         ];
//    
//    animation.timingFunctions = @[
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
//                                  ];
//    
//    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
//    //apply animation
//    self.ballView.layer.position = CGPointMake(150, 268);
//    [self.ballView.layer addAnimation:animation forKey:nil];
//}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self animate];
    
    [UIView animateWithDuration:1.0 delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         //set the position
                         self.colorView.center = [[touches anyObject] locationInView:self.view];
                     }
                     completion:NULL];

    
    //configure the transaction
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    //set the position
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    //commit transaction
    [CATransaction commit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
