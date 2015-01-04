//
//  CoreAnimationDemoViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/4.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CoreAnimationDemoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CoreAnimationDemoViewController ()

@end

@implementation CoreAnimationDemoViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Core Animation Demo";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    
    _layerView.backgroundColor = [UIColor greenColor];
    _layerView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    [self.view addSubview:_layerView];
    
    
//    //添加一个layer
//    CALayer *addLayer = [CALayer layer];
//    
//    addLayer.backgroundColor = [UIColor blueColor].CGColor;
//    addLayer.frame = CGRectMake(25, 25, 50, 50);
//    
//    addLayer.borderColor = [UIColor redColor].CGColor;
//    addLayer.borderWidth = 3;
//    
//    addLayer.cornerRadius = 5;
//    //position, anchorPoint, shawdow
//    
//    [_layerView.layer addSublayer:addLayer];
    
    
    
    UIImage *image = [UIImage imageNamed:@"demo"];
    
    _layerView.layer.contentsGravity = kCAGravityCenter;
    
    _layerView.layer.contents = (__bridge id)(image.CGImage);
    
    //用来去确定是否是高清屏幕，然后进行绘制
    _layerView.layer.contentsScale = [UIScreen mainScreen].scale;
    
    //如果出界就截取类似与UIView的clipToBound
    _layerView.layer.masksToBounds = YES;
    
//    _layerView.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.25, 0.25);
    
//    _layerView.layer.contentsScale = image.scale;
    
    
    //contentsRect是安单位来进行计算的，也就是0-1，表示0-全部
//    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.view.layer];
    
    
    
    //CALayerDelegate 用法
    //尽管我们没有用masksToBounds属性，绘制的那个圆仍然沿边界被裁剪了。这是因为当你使用CALayerDelegate绘制寄宿图的时候，并没有对超出边界外的内容提供绘制支持。
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(10.0f, 80.0f, 100.0f, 200.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //set controller as layer delegate
    blueLayer.delegate = self;
    
    //ensure that layer backing image uses correct scale
    blueLayer.contentsScale = [UIScreen mainScreen].scale; //add layer to our view
    [self.view.layer addSublayer:blueLayer];
    
    //force layer to redraw
    [blueLayer display];
    
    //判断点击的点，是否在layer的区域内
    _blueLayerTouch = [CALayer layer];
    _blueLayerTouch.frame = CGRectMake(50.0f, 450.0f, 100.0f, 100.0f);
    _blueLayerTouch.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.view.layer addSublayer:_blueLayerTouch];
    
    
    //mask 裁剪图片
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = _blueLayerTouch.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"Ship.png"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    //apply mask to image layer￼
    _blueLayerTouch.mask = maskLayer;
    
//    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
//    _blueLayerTouch.affineTransform = transform;
//    
//    CGAffineTransform transformTwo = CGAffineTransformIdentity; //scale by 50%
//    transformTwo = CGAffineTransformScale(transform, 0.5, 0.5); //rotate by 30 degrees
//    transformTwo = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0); //translate by 200 points
//    _blueLayerTouch.affineTransform = transformTwo;
    
//    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
//    _blueLayerTouch.transform = transform;
    
    CATransform3D transform = CATransform3DIdentity;
    //apply perspective
    transform.m34 = - 1.0 / 500.0;
    //rotate by 45 degrees along the Y axis
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    //apply to layer
    _blueLayerTouch.transform = transform;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    //判断触摸的区域在layer的范围内
//    //get touch position relative to main view
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    //convert point to the white layer's coordinates
//    point = [self.view.layer convertPoint:point fromLayer:self.view.layer];
//    //get layer using containsPoint:
//    if ([self.view.layer containsPoint:point]) {
//        //convert point to blueLayer’s coordinates
//        point = [_blueLayerTouch convertPoint:point fromLayer:self.view.layer];
//        if ([_blueLayerTouch containsPoint:point]) {
//            [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
//                                        message:nil
//                                       delegate:nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil] show];
//        } else {
//            [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
//                                        message:nil
//                                       delegate:nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil] show];
//        }
//    }
    
    //判断触摸的是否是当前的layer,或者是self.view.layer.是否被点击，和zPosition有管
    //get touch position
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //get touched layer
    CALayer *layer = [self.view.layer hitTest:point];
    //get layer using hitTest
    if (layer == _blueLayerTouch) {
        [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else if (layer == self.view.layer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    
    
}

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer //set image
{
    //2D游戏引擎入Cocos2D使用了拼合技术，它使用OpenGL来显示图片。不过我们可以使用拼合在一个普通的UIKit应用中，对！就是使用contentsRect
    layer.contents = (__bridge id)image.CGImage;
    
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    //set contentsRect
    layer.contentsRect = rect;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
