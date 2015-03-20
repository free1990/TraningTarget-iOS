//
//  ScanView.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/18.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ScanView.h"

#define kAnimationKeyPath @"position"
#define kCornerLength 20.0f

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ScanView() {
    CALayer *scanLineLayer_;
}
@property (assign, nonatomic) CGRect scanFrame;

@end

@implementation ScanView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    float scanFrameWidth  = SCREEN_WIDTH  * 2.0f / 3.0f;
    float scanFrameheight = SCREEN_WIDTH  * 2.0f / 3.0f;
    CGRect bounds = self.bounds;
    
    CGRect scanFrame = CGRectMake((bounds.size.width - scanFrameWidth) / 2.0f, (bounds.size.height - scanFrameheight) / 2.0f, scanFrameWidth, scanFrameheight);
    
    scanLineLayer_ = [CALayer layer];
    scanLineLayer_.frame = CGRectMake(0, 0, scanFrame.size.width - 10, 12);
    scanLineLayer_.contents = (id)[UIImage imageNamed:@"QRScanLine"].CGImage;
    scanLineLayer_.position = CGPointMake(CGRectGetMidX(scanFrame), CGRectGetMinY(scanFrame));;
    
    [self.layer addSublayer:scanLineLayer_];
    self.scanFrame = scanFrame;
}

- (void)startScanAnimation
{
    [self stopScanAnimation];
    
    CGPoint scanLineStartPosition, scanLineEndPosition;
    scanLineStartPosition = CGPointMake(CGRectGetMidX(self.scanFrame), CGRectGetMinY(self.scanFrame));
    scanLineEndPosition = CGPointMake(CGRectGetMidX(self.scanFrame), CGRectGetMaxY(self.scanFrame));
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kAnimationKeyPath];
    [animation setFromValue:[NSValue valueWithCGPoint:scanLineStartPosition]];
    [animation setToValue:[NSValue valueWithCGPoint:scanLineEndPosition]];
    [animation setDuration:2.50f];
    [animation setRepeatCount:100000];
    [scanLineLayer_ addAnimation:animation forKey:kAnimationKeyPath];
}

- (void)stopScanAnimation
{
    if ([scanLineLayer_ animationForKey:kAnimationKeyPath]) {
        [scanLineLayer_ removeAnimationForKey:kAnimationKeyPath];
    }
}

- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor whiteColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
//    UIColor *color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//    [color set];
//    UIRectFill(self.bounds);
    
//    UIColor *clearColor = [UIColor clearColor];
//    [clearColor set];
//    UIRectFill(self.scanFrame);
    
    //画边框
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextStrokeRectWithWidth(context, CGRectInset(self.scanFrame, -1, -1), 1.0);
    
    //画边角
    CGPoint leftUp = self.scanFrame.origin;
    CGPoint rightUp = CGPointMake(CGRectGetMaxX(self.scanFrame), leftUp.y);
    CGPoint rightDown = CGPointMake(rightUp.x, CGRectGetMaxY(self.scanFrame));
    //左上角
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, leftUp.x, leftUp.y + kCornerLength);
    CGPathAddLineToPoint(path, NULL, leftUp.x, leftUp.y);
    CGPathAddLineToPoint(path, NULL, leftUp.x + kCornerLength, leftUp.y);
    //右上角
    CGPathMoveToPoint(path, NULL, rightUp.x - kCornerLength, rightUp.y);
    CGPathAddLineToPoint(path, NULL, rightUp.x, rightUp.y);
    CGPathAddLineToPoint(path, NULL, rightUp.x, rightUp.y + kCornerLength);
    //右下角
    CGPathMoveToPoint(path, NULL, rightDown.x, rightDown.y - kCornerLength);
    CGPathAddLineToPoint(path, NULL, rightDown.x, rightDown.y);
    CGPathAddLineToPoint(path, NULL, rightDown.x - kCornerLength, rightDown.y);
    //左下角
    CGPathMoveToPoint(path, NULL, leftUp.x, rightDown.y - kCornerLength);
    CGPathAddLineToPoint(path, NULL, leftUp.x, rightDown.y);
    CGPathAddLineToPoint(path, NULL, leftUp.x + kCornerLength, rightDown.y);
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, 4.0);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    
    CGMutablePathRef divPath = CGPathCreateMutable();
    
    CGFloat divWidth = self.bounds.size.width/3;
    
    for (int i = 1; i < 3; i++) {
        
        
        CGPathMoveToPoint(divPath, NULL, divWidth * i, 0 );
        CGPathAddLineToPoint(divPath, NULL, divWidth * i, 0 );
        CGPathAddLineToPoint(divPath, NULL, divWidth * i, self.bounds.size.height);
    }
    
    for (int i = 0; i < self.bounds.size.height/divWidth ; i++) {
        
        CGPathMoveToPoint(divPath, NULL, 0, divWidth * i );
        CGPathAddLineToPoint(divPath, NULL, 0, divWidth * i);
        CGPathAddLineToPoint(divPath, NULL, self.bounds.size.width, divWidth * i);
    }
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextAddPath(context, divPath);
    CGContextStrokePath(context);
    
    CGContextSaveGState(context);
    
    CGPathRelease(path);
    
    CGPathRelease(divPath);
}


@end
