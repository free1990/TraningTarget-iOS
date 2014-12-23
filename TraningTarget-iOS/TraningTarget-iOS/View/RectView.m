//
//  RectView.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/23.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "RectView.h"

@implementation RectView

-(void)drawInContext:(CGContextRef)context{
    
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    
    CGContextSetLineWidth(context, 2);
    
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    
    CGContextAddRect(context, CGRectMake(100, 100, 100, 100));
    
    CGContextStrokePath(context);
    
    //更简洁的写法，path和stroke一起用
    CGContextStrokeRect(context, CGRectMake(125, 125, 50, 50));
    
    CGContextStrokeRectWithWidth(context, CGRectMake(150, 150, 10, 10), 3);
    
    CGRect rects[] =
    {
        CGRectMake(120.0, 230.0, 60.0, 60.0),
        CGRectMake(120.0, 320.0, 60.0, 60.0),
        CGRectMake(120.0, 410.0, 60.0, 60.0),
    };
    // Bulk call to add rects to the current path.
    CGContextAddRects(context, rects, sizeof(rects)/sizeof(rects[0]));
    CGContextStrokePath(context);
    
    CGContextAddRect(context, CGRectMake(210.0, 130.0, 60.0, 60.0));
    CGContextFillPath(context);
    
    //简便写法
    CGContextFillRect(context, CGRectMake(210.0, 320.0, 60.0, 60.0));
    
    CGContextSaveGState(context);
    
    //fill
    CGContextAddRect(context, CGRectMake(100, 300, 100, 100));
    
    CGContextAddRect(context, CGRectMake(125, 325, 50, 50));
    
    //常见的使用
//    CGContextEOFillPath(context);
    
//    CGContextFillPath(context);
    
//    CGContextStrokePath(context);
    
   //还有draw的几种模式
    
//    enum CGPathDrawingMode {
//        kCGPathFill,
//        kCGPathEOFill,
//        kCGPathStroke,
//        kCGPathFillStroke,
//        kCGPathEOFillStroke
//    };
//    typedef enum CGPathDrawingMode CGPathDrawingMode;
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

@end
