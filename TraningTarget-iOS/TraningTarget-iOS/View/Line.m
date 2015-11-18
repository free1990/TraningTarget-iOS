//
//  Line.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "Line.h"

@implementation Line

-(void)drawInContext:(CGContextRef)context{
    
    //主要学习 CGContextAddLineToPoint 和 CGContextAddLines
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    
    //设置抗锯齿
    CGContextSetAllowsAntialiasing(context, true);
    
    //首先设置一个起点
    CGContextMoveToPoint(context, 10.0, 130.0);
    CGContextAddLineToPoint(context, 310.0, 130.0);
    CGContextStrokePath(context);
    
    //画连续的点
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 1.0, 1.0);
    CGPoint addLines[] =
    {
        CGPointMake(10.0, 190.0),
        CGPointMake(70.0, 160.0),
        CGPointMake(130.0, 190.0),
        CGPointMake(190.0, 160.0),
        CGPointMake(250.0, 190.0),
        CGPointMake(310.0, 160.0),
    };
    CGContextAddLines(context, addLines, sizeof(addLines)/sizeof(addLines[0]));
    CGContextStrokePath(context);
    
    //画间断的点
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 1.0, 1.0);
    CGPoint strokeSegments[] =
    {
        CGPointMake(10.0, 250.0),
        CGPointMake(70.0, 220.0),
        CGPointMake(130.0, 250.0),
        CGPointMake(190.0, 220.0),
        CGPointMake(250.0, 250.0),
        CGPointMake(310.0, 220.0),
    };
    
    CGContextStrokeLineSegments(context, strokeSegments, sizeof(strokeSegments)/sizeof(strokeSegments[0]));
    
    //---------------------------------
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, 20);
    
//    enum CGLineCap {
//        kCGLineCapButt,
//        kCGLineCapRound,
//        kCGLineCapSquare
//    };
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
    
    // Setup the horizontal line to demostrate caps
    CGContextMoveToPoint(context, 40.0, 330.0);
    CGContextAddLineToPoint(context, 280.0, 330.0);
    
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    // Set the line width & cap for the cap demo
    CGContextSetLineWidth(context, 30);
    
//    enum CGLineJoin {
//        kCGLineJoinMiter,
//        kCGLineJoinRound,
//        kCGLineJoinBevel
//    };
    
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 40.0, 390.0);
    CGContextAddLineToPoint(context, 160.0, 270.0);
    CGContextAddLineToPoint(context, 280.0, 390.0);

    CGContextStrokePath(context);
    
}



@end
