//
//  CoreAnimationDemoTwoViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/4.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CoreAnimationDemoTwoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <AVFoundation/AVFoundation.h>

@interface CoreAnimationDemoTwoViewController ()

@end

@implementation CoreAnimationDemoTwoViewController


- (id)init{
    if (self = [super init]) {
        self.className   = @"Core Animation Demo Two";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //专有图层
    //https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques/blob/master/6-%E4%B8%93%E6%9C%89%E5%9B%BE%E5%B1%82/6-%E4%B8%93%E6%9C%89%E5%9B%BE%E5%B1%82.md
    
#pragma mark ----CAShapeLayer------
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    
//    [path moveToPoint:CGPointMake(175, 100)];
//    
//    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(150, 125)];
//    [path addLineToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(125, 225)];
//    [path moveToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(175, 225)];
//    [path moveToPoint:CGPointMake(100, 150)];
//    [path addLineToPoint:CGPointMake(200, 150)];
//    
//    //create shape layer
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineWidth = 5;
//    shapeLayer.lineJoin = kCALineJoinRound;
//    shapeLayer.lineCap = kCALineCapRound;
//    shapeLayer.path = path.CGPath;
//    //add it to our view
//    [self.view.layer addSublayer:shapeLayer];
    
#pragma mark ----贝塞尔圆角------
//    //define path parameters
//    CGRect rect = CGRectMake(50, 150, 100, 100);
//    CGSize radii = CGSizeMake(20, 20);
//    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
//    //create path
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
//    
//    //create shape layer
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineWidth = 5;
//    shapeLayer.lineJoin = kCALineJoinRound;
//    shapeLayer.lineCap = kCALineCapRound;
//    shapeLayer.path = path.CGPath;
//    //add it to our view
//    [self.view.layer addSublayer:shapeLayer];
    
#pragma mark ----CATextLayer------
//    //create a text layer
//    CATextLayer *textLayer = [CATextLayer layer];
//    textLayer.frame = CGRectMake(60, 200, 200, 200);
//    [self.view.layer addSublayer:textLayer];
//    
//    //set text attributes
//    textLayer.foregroundColor = [UIColor blackColor].CGColor;
//    textLayer.alignmentMode = kCAAlignmentJustified;
//    textLayer.wrapped = YES;
//    
//    //choose a font
//    UIFont *font = [UIFont systemFontOfSize:15];
//    
//    //set layer font
//    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
//    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
//    
//    textLayer.font = fontRef;
//    textLayer.fontSize = font.pointSize;
//    CGFontRelease(fontRef);
//    
//    //choose some text
//    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
//    
//    //set layer text
//    textLayer.string = text;
//    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    //富文本
    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(60, 200, 200, 200);
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc \ elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    
    //create attributed string
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    
    //convert UIFont to a CTFont
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    //set text attributes
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    
    //release the CTFont we created earlier
    CFRelease(fontRef);
    
    //set layer text
    textLayer.string = string;
    
#pragma mark ----CATransformLayer------(3D变换)
    
//    //set up the perspective transform
//    CATransform3D pt = CATransform3DIdentity;
//    pt.m34 = -1.0 / 500.0;
//    self.view.layer.sublayerTransform = pt;
//    
//    //set up the transform for cube 1 and add it
//    CATransform3D c1t = CATransform3DIdentity;
//    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
//    CALayer *cube1 = [self cubeWithTransform:c1t];
//    [self.view.layer addSublayer:cube1];
//    
//    //set up the transform for cube 2 and add it
//    CATransform3D c2t = CATransform3DIdentity;
//    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
//    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
//    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
//    CALayer *cube2 = [self cubeWithTransform:c2t];
//    [self.view.layer addSublayer:cube2];
    
#pragma mark ----CATransformLayer------(基础渐变)
    
//    CAGradientLayer *gradenLayer = [CAGradientLayer layer];
//    gradenLayer.frame = CGRectMake(100, 400, 100, 100);
//    [self.view.layer addSublayer:gradenLayer];
//    
//    gradenLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
//                           (__bridge id)[UIColor yellowColor].CGColor,
//                           (__bridge id)[UIColor blueColor].CGColor
//                           ];
//    
//    gradenLayer.startPoint = CGPointMake(0.5, 0);
//    gradenLayer.endPoint = CGPointMake(0.5, 1);
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(100, 400, 100, 100);
//    [self.view.layer addSublayer:gradientLayer];
//    
//    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
//                           (__bridge id)[UIColor yellowColor].CGColor,
//                           (__bridge id)[UIColor blueColor].CGColor
//                           ];
//    
//    //set locations
//    gradientLayer.locations = @[@0.0, @0.25, @0.5];
//
//    //set gradient start and end points
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 1);
    
#pragma mark ----CAReplicatorLayer------(重复图层--高效生成许多相似的图层)
    //CAReplicatorLayer真正应用到实际程序上的场景比如：一个游戏中导弹的轨迹云，或者粒子爆炸（尽管iOS 5已经引入了CAEmitterLayer，它更适合创建任意的粒子效果）。除此之外，还有一个实际应用是：反射。
    
//    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
//    replicator.frame = CGRectMake(0, 300, 320, 100);
//    [self.view.layer addSublayer:replicator];
//    
//    //configure the replicator
//    replicator.instanceCount = 10;
//    
//    //apply a transform for each instance
//    CATransform3D transform = CATransform3DIdentity;
//    transform = CATransform3DTranslate(transform, 0, 200, 0);
//    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
//    transform = CATransform3DTranslate(transform, 0, -200, 0);
//    replicator.instanceTransform = transform;
//    
//    //apply a color shift for each instance
//    replicator.instanceBlueOffset = -0.1;
//    replicator.instanceGreenOffset = -0.1;
//    
//    //create a sublayer and place it inside the replicator
//    CALayer *layer = [CALayer layer];
//    layer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
//    layer.backgroundColor = [UIColor whiteColor].CGColor;
//    [replicator addSublayer:layer];
    
#pragma mark ----CATiledLayer------(把大图裁剪成小图来进行读入内存)
    
    
#pragma mark ----CAEmitterLayer------(粒子效果)
    //create particle emitter layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = CGRectMake(100, 500, 60, 60);
    [self.view.layer addSublayer:emitter];
    
    //configure emitter
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"fire"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor whiteColor].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    //add particle template to emitter
    emitter.emitterCells = @[cell];
    
#pragma mark ----CAEAGLLayer------(OpenGL杀手锏)
    
#pragma mark ----AVPlayerLayer------(AVPlayerLayer)
    //最后一个图层类型是AVPlayerLayer。尽管它不是Core Animation框架的一部分（AV前缀看上去像），AVPlayerLayer是有别的框架（AVFoundation）提供的，它和Core Animation紧密地结合在一起，提供了一个CALayer子类来显示自定义的内容类型。
    
    //AVPlayerLayer是用来在iOS上播放视频的。他是高级接口例如MPMoivePlayer的底层实现，提供了显示视频的底层控制。AVPlayerLayer的使用相当简单：你可以用+playerLayerWithPlayer:方法创建一个已经绑定了视频播放器的图层，或者你可以先创建一个图层，然后用player属性绑定一个AVPlayer实例。
    
    //get video URL
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"Ship" withExtension:@"mp4"];
    
    //create player and player layer
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    //set player layer frame and attach it to our view
    playerLayer.frame = CGRectMake(100, 500, 60, 60);
    [self.view.layer addSublayer:playerLayer];
    
    //play the video
    [player play];
    
    //transform layer
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    playerLayer.transform = transform;
    
    //add rounded corners and border
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 20.0;
    playerLayer.borderColor = [UIColor redColor].CGColor;
    playerLayer.borderWidth = 5.0;
    
    //play the video
    [player play];
    
}

- (CALayer *)faceWithTransform:(CATransform3D)transform
{
    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    //apply the transform and return
    face.transform = transform;
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //center the cube layer within the container
    CGSize containerSize = self.view.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    
    //apply the transform and return
    cube.transform = transform;
    return cube;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
