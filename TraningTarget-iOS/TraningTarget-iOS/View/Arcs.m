//
//  Arcs.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "Arcs.h"

@implementation Arcs

- (void)drawInContext:(CGContextRef)context{
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    
    //参数依次是：context、圆心x、圆心y、半径、开始的角度、结束的角度、1是顺时针，0逆时针
    //但是UI的坐标系是相反的
    //我们画个笑脸玩玩
    CGContextAddArc(context, 100.0, 160.0, 30.0, 0.0, 2*M_PI/2.0, 0);
    CGContextStrokePath(context);
    
    CGContextAddArc(context, 180.0, 160.0, 30.0, 0.0, 2*M_PI/2.0, 0);
    CGContextStrokePath(context);
    
    CGContextAddArc(context, 140.0, 220.0, 10.0, 0.0, 2*M_PI/2.0, 0);
    CGContextStrokePath(context);
    
    CGContextAddArc(context, 140.0, 240.0, 30.0, 0.0, 2*M_PI/2.0, 0);
    CGContextStrokePath(context);
    
    CGContextAddArc(context, 140.0, 200.0, 100.0, 0.0, 2*M_PI, true);
    CGContextStrokePath(context);
    
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    //先把点移动要即将要画弧形的点上，然后提供和这个方向切线上的控制点，另外一点是结束点
    CGPoint p[3] =
    {
        CGPointMake(210.0, 330.0),
        CGPointMake(210.0, 360.0),
        CGPointMake(240.0, 360.0),
    };
    CGContextMoveToPoint(context, p[0].x, p[0].y);
    CGContextAddArcToPoint(context, p[1].x, p[1].y, p[2].x, p[2].y, 30.0);
    CGContextStrokePath(context);
    
    //椭圆和圆形
    CGContextAddEllipseInRect(context, CGRectMake(0, 300, 200, 100));
    CGContextStrokePath(context);
    
    CGContextStrokeEllipseInRect(context, CGRectMake(0, 300, 100, 50));
    
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, CGRectMake(30.0, 430.0, 160.0, 60.0));
    
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    CGContextFillEllipseInRect(context, CGRectMake(30.0, 430.0, 160.0, 60.0));
    
    //弧形
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGRect rrect = CGRectMake(210.0, 90.0, 60.0, 60.0);
    CGFloat radius = 10.0;
    
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    
    // Start at 1
    CGContextMoveToPoint(context, minx, midy);
    // Add an arc through 2 to 3
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    // Add an arc through 4 to 5
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    // Add an arc through 6 to 7
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    // Add an arc through 8 to 9
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    // Close the path
    CGContextClosePath(context);
    
    // Fill & stroke the path
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //画贝塞尔曲线，需要两个控制点，以及起点终点
    CGPoint s = CGPointMake(30.0, 120.0);
    CGPoint e = CGPointMake(300.0, 120.0);
    CGPoint cp1 = CGPointMake(120.0, 30.0);
    CGPoint cp2 = CGPointMake(210.0, 210.0);
    CGContextMoveToPoint(context, s.x, s.y);
    CGContextAddCurveToPoint(context, cp1.x, cp1.y, cp2.x, cp2.y, e.x, e.y);
    CGContextStrokePath(context);
    
    // 展示控制点
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(context, s.x, s.y);
    CGContextAddLineToPoint(context, cp1.x, cp1.y);
    CGContextMoveToPoint(context, e.x, e.y);
    CGContextAddLineToPoint(context, cp2.x, cp2.y);
    CGContextStrokePath(context);
    
    // Draw a quad curve with end points s,e and control point cp1
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    s = CGPointMake(30.0, 300.0);
    e = CGPointMake(270.0, 300.0);
    cp1 = CGPointMake(150.0, 180.0);
    CGContextMoveToPoint(context, s.x, s.y);
    CGContextAddQuadCurveToPoint(context, cp1.x, cp1.y, e.x, e.y);
    CGContextStrokePath(context);
    
    // Show the control point.
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(context, s.x, s.y);
    CGContextAddLineToPoint(context, cp1.x, cp1.y);
    CGContextStrokePath(context);
    
}

@end
