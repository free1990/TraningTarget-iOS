//
//  CoreAnimationCANiubilty.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "CoreAnimationCANiubilty.h"


#define WIDTH 10
#define HEIGHT 10
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500

@interface CoreAnimationCANiubilty ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CoreAnimationCANiubilty

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"CA效率";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //普通绘制
//    self.shapeDrawing = [[CAShapeLayerDrawing alloc] init];
//    
//    self.shapeDrawing.frame = self.view.frame;
//    [self.view addSubview:self.shapeDrawing];
    
    
//    self.drawingView = [[DrawingView alloc] initWithFrame:self.view.frame];
//    
//    [self.view addSubview:self.drawingView];
    
    
    CAShapeLayer *blueLayer = [CAShapeLayer layer];
    blueLayer.frame = CGRectMake(50, 150, 100, 100);
    blueLayer.fillColor = [UIColor blueColor].CGColor;
    blueLayer.path = [UIBezierPath bezierPathWithRoundedRect:
                      CGRectMake(0, 0, 100, 100) cornerRadius:20].CGPath;
   
    //add it to our view
    [self.view.layer addSublayer:blueLayer];
    
    //define path parameters
    CGRect rect = CGRectMake(50, 450, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];

    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.view.layer addSublayer:shapeLayer];
    
    //contensCenter,可伸缩图形
    CALayer *shenSuoLayer = [CALayer layer];
    shenSuoLayer.frame = CGRectMake(250, 350, 100, 100);
    shenSuoLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.0, 0.0);
    shenSuoLayer.contentsScale = [UIScreen mainScreen].scale;
    shenSuoLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    //add it to our view
    [self.view.layer addSublayer:shenSuoLayer];
    
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.frame;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING, (HEIGHT - 1)*SPACING);
    
    //set up perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;
    
    //create layers
    for (int z = DEPTH - 1; z >= 0; z--) {
        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) {
                //create layer
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING;
                //set background color
                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
                //attach to scroll view
                [self.scrollView.layer addSublayer:layer];
            }
        }
        
        NSLog(@"displayed: %i", DEPTH*HEIGHT*WIDTH);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
